#include <glib.h>
#include <libnotify/notify.h>
#include <pulse/pulseaudio.h>

#include <math.h>
#include <string.h>

#define ID            1000
#define APP_NAME      "percent-notify"
#define MAX_BARS      20
#define MAX_CONTENT   100

typedef struct _NotifyNotificationPrivate {
    guint32     id;
    char       *app_name;
    char       *summary;
    char       *body;
    char       *icon_name;
    gint        timeout;
    GSList     *actions;
    GHashTable *action_map;
    GHashTable *hints;
    gboolean    has_nondefault_actions;
    gboolean    updates_pending;
    gulong      proxy_signal_handler;
    gint        closed_reason;
} _NotifyNotificationPrivate;

char *draw_content(char *content, char *icon, int percentage) {
    int bar_percentage = percentage;
    if (bar_percentage < 0)         bar_percentage = 0;
    else if (bar_percentage > 100)  bar_percentage = 100;

    int n_bars = round(bar_percentage / 5);

    snprintf(
        content, MAX_CONTENT,
        "%-4s%*s%*s%4d%%",
        icon,
        n_bars*3, "",
        MAX_BARS-n_bars, "",
        percentage
    );

    for (int i = 0; i < n_bars; ++i)
        strcpy(content+4+i*3, "─");
    content[4 + n_bars * 3] = ' ';

    return content;
}

void notify(int id, char *summary, char *icon, int percentage) {
    char content[MAX_CONTENT];
    draw_content(content, icon, percentage);
    GError *err = NULL;
    NotifyNotification *n;
    n = notify_notification_new(summary, content, NULL);
    n->priv->id = id;
    notify_notification_show(n, &err);
    g_object_unref(G_OBJECT (n));
}

int main(int argc, char *argv[]) {
    notify_init(APP_NAME);

    int exit_code = 0;
    if (argc > 3)
        notify(ID, argv[1], argv[2], atoi(argv[3]));
    else
        exit_code = 1;

    if (notify_is_initted())
        notify_uninit();

    return exit_code;
}
