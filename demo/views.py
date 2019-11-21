from django.http import JsonResponse
from django.shortcuts import render
from .tasks import double_a_integer

import json
from datetime import datetime, timezone, timedelta
from celery.result import AsyncResult


def index(request):
    return render(request, "index.html")


def calc(request):
    if request.is_ajax() and request.method == "POST":
        data = json.loads(request.body)
        number = int(data["number"])
        # convert to utc+8
        event_time = datetime.strptime(data["eventTime"],
                                       "%a, %d %b %Y %H:%M:%S %Z") \
            .replace(tzinfo=timezone.utc) \
            .astimezone(timezone(timedelta(hours=8)))

        task = double_a_integer.apply_async((number, event_time), countdown=5)
        context = {"task_id": task.task_id}
        return JsonResponse(context)


def check_status(request):
    task_id = request.GET.get("task_id")
    if task_id:
        result = AsyncResult(task_id)
        if result.status == "SUCCESS":
            event_time, processing_time, finish_time, data = result.get(timeout=10)
            res = {
                "task_id": task_id,
                "status": result.status,
                "eventTime": event_time,
                "processingTime": processing_time,
                "finishTime": finish_time,
                "result": data
            }
            return JsonResponse(res)
        else:
            return JsonResponse({"status": result.status})
    else:
        return JsonResponse({"status": "NOT FOUND"})
