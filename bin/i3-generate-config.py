#!/usr/bin/env python3

import os
import re
from pprint import pprint


def compile_config(source, target):
    variables = {}
    for line in source:
        match_obj = re.match(r'\s*set\s+\$(\w+)\s+(?:"(.*?)"|(.*?))\s*$', line)
        if match_obj is not None:
            name, raw_value = filter(None, match_obj.groups())
            value = expand_value(variables, raw_value)
            variables[name] = value
            line = f"set ${name} {value}\n"
        else:
            line = expand_value(variables, line)
        print(line, file=target, end="")


def expand_value(variables, raw_value):
    return re.sub(r'\$(\w+)', lambda m: variables.get(m.group(1), m.group()), raw_value)


def main():
    config_source = os.path.expanduser(os.environ.get('i3_config_source', "~/.config/i3/i3.config"))
    config_target = os.path.expanduser(os.environ.get('i3_config_target', "~/.config/i3/config"))
    try:
        with open(config_source, 'r') as source, open(config_target, 'w+') as target:
            compile_config(source, target)
    except FileNotFoundError as e:
        exit(e)


if __name__ == '__main__':
    main()
