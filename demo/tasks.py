from celery import shared_task
from datetime import datetime, timezone, timedelta
from time import sleep


@shared_task
def double_a_integer(n, event_time):
    processing_time = datetime.utcnow().replace(tzinfo=timezone.utc) \
        .astimezone(timezone(timedelta(hours=8)))
    sleep(5)
    finish_time = datetime.utcnow().replace(tzinfo=timezone.utc) \
        .astimezone(timezone(timedelta(hours=8)))
    return event_time, processing_time, finish_time, 2 * n
