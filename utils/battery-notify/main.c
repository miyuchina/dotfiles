#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <errno.h>
#include <unistd.h>
#include <libnotify/notify.h>

#define BATTERY_FILE "/sys/class/power_supply/BAT0/capacity"

int get_capacity() {
    FILE *file;
    char capacity_str[4];
    int capacity;
    size_t bytes;

    if ((file = fopen(BATTERY_FILE, "r")) == NULL) {
        perror("Error opening battery capacity file");
        exit(EXIT_FAILURE);
    }

    if ((bytes = fread(capacity_str, sizeof(capacity_str), 1, file)) < 0) {
        perror("Error reading battery capacity");
        exit(EXIT_FAILURE);
    }

    capacity = atoi(capacity_str);
    fclose(file);

    return capacity;
}

void notify(NotifyNotification *notification,
                const char *summary,
                const char *body,
                NotifyUrgency urgency) {
    GError *error = NULL;

    notify_notification_update(notification, summary, body, "");
    notify_notification_set_urgency(notification, urgency);
    notify_notification_set_timeout(notification, NOTIFY_EXPIRES_NEVER);
    if (notify_notification_show(notification, &error) == FALSE) {
        fprintf(stderr, "Error displaying notification: %s\n", error->message);
        g_error_free(error);
        exit(EXIT_FAILURE);
    }
}

int main(int argc, char *argv[]) {
    int opt;
    int capacity;
    enum report { critical = 5, low = 15, normal = 100 };
    enum report report_level = normal;
    NotifyNotification *notification;
    bool daemon = false;

    while ((opt = getopt(argc, argv, "b")) != -1) {
        switch (opt) {
            case 'b':
                daemon = true;
                break;

            default:
                fprintf(stderr, "Usage: %s [-b]\n", argv[0]);
                exit(EXIT_FAILURE);
        }
    }

    if (daemon && fork() != 0) {
        return 0;
    }

    if (notify_init("battery-notify") == FALSE) {
        fprintf(stderr, "Failed to initialize notification.\n");
        exit(EXIT_FAILURE);
    }

    notification = notify_notification_new("", "", "");

    while (true) {
        capacity = get_capacity();
        if (capacity <= critical && report_level > critical) {
            notify(notification,
                    "Battery level critical",
                    "Your computer will turn off soon.",
                    NOTIFY_URGENCY_CRITICAL);
            report_level = critical;
        } else if (capacity <= low && report_level > low) {
            notify(notification,
                    "Low battery",
                    "Battery level too low.",
                    NOTIFY_URGENCY_NORMAL);
            report_level = low;
        } else if (capacity > low && report_level <= low) {
            report_level = normal;
        }
        sleep(60);
    }

    notify_uninit();
    return 0;
}
