#!/usr/bin/env python

import re
import os
import subprocess
from datetime import datetime, timezone
from dateutil import parser
from notmuch import Database, Query


class Message:
    def __init__(self, msg):
        self.msg = msg

    @property
    def subject(self):
        return self.msg.get_header("subject")

    @property
    def from_(self):
        from_field = self.msg.get_header("from")
        return re.match(r'(.+)\s+(<.*?>)?', from_field).group(1).replace('"', '')

    @property
    def date(self):
        return pretty_date(parser.parse(self.msg.get_header("date")))

    def __getattr__(self, name):
        return getattr(self.msg, name)


class SeenMail:
    def __init__(self):
        self.seen = set()

    def __enter__(self):
        if os.path.exists("/tmp/seen_mail"):
            with open("/tmp/seen_mail", 'r') as fin:
                for line in fin:
                    self.seen.add(line.strip())
        self._seen_file = open("/tmp/seen_mail", "w+")
        return self

    def add(self, msg):
        filename = msg.get_filename()
        if filename not in self.seen:
            self.seen.add(filename)
            return True
        return False

    def __exit__(self, *args):
        for filename in self.seen:
            print(filename, file=self._seen_file)
        self._seen_file.close()


def notify(msg):
    body = f"<b>From:</b> {msg.from_}\n<b>Date:</b> {msg.date}"
    subprocess.run(["notify-send", msg.subject, body])


def pretty_date(time=False):
    """
    Get a datetime object or a int() Epoch timestamp and return a
    pretty string like 'an hour ago', 'Yesterday', '3 months ago',
    'just now', etc
    """
    now = datetime.now(timezone.utc)
    diff = now - time
    second_diff = diff.seconds
    day_diff = diff.days

    if day_diff < 0:
        return ''
    if day_diff == 0:
        if second_diff < 10:
            return "just now"
        if second_diff < 60:
            return f"{int(second_diff)} seconds ago"
        if second_diff < 120:
            return "a minute ago"
        if second_diff < 3600:
            return f"{int(second_diff / 60)} minutes ago"
        if second_diff < 7200:
            return "an hour ago"
        if second_diff < 86400:
            return  f"{int(second_diff / 3600)} hours ago"
    if day_diff == 1:
        return "Yesterday"
    if day_diff < 7:
        return f"{int(day_diff)} days ago"
    if day_diff < 31:
        return f"{int(day_diff / 7)} weeks ago"
    if day_diff < 365:
        return f"{int(day_diff / 30)} months ago"

    return f"{int(day_diff / 365)} years ago"


def main():
    subprocess.run(["notmuch", "new"], check=True)
    db = Database(None)
    msgs = Query(db, "tag:unread").search_messages()
    with SeenMail() as seen_mail:
        for msg in filter(seen_mail.add, map(Message, msgs)):
            notify(msg)


if __name__ == '__main__':
    main()

