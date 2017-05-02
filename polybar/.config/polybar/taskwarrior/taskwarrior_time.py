#!/usr/bin/env python3

import sys

import dateutil.parser

from rofi import Rofi
from taskw import TaskWarrior

from datetime import datetime, timedelta


class TaskTime:
    def __init__(self):
        self.rofi = Rofi()
        self.taskw = TaskWarrior()

    def getActiveTask(self):
        tasks = self.taskw.load_tasks()["pending"]
        for i in tasks:
            if "annotations" in i and i["annotations"][len(i["annotations"]) - 1]["description"] == "Started task":
                return i
        return None

    def getTimeStarted(self, task):
        if "annotations" in task and task["annotations"][len(task["annotations"]) - 1]["description"] == "Started task":
            datestart = task["annotations"][len(task["annotations"]) - 1]["entry"]
            #datestart = dateutil.parser.parse(datestart, tzinfos=tzutc()).strftime("%s")
            datestart = datetime.strptime(datestart, "%Y%m%dT%H%M%SZ").strftime("%s")
            #datestart = datetime.utcfromtimestamp(int(datestart))
            now = datetime.utcnow().strftime("%s")
            diff = int(now) - int(datestart)
            return str(timedelta(seconds=diff))

if __name__ == '__main__':
    tt = TaskTime()
    task = tt.getActiveTask()
    if task == None:
        print("No active tasks")
    else:
        elapsed = tt.getTimeStarted(task)
        print(task["description"] + " --> " + elapsed)