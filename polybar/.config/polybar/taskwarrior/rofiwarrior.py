#!/usr/bin/env python3

import sys

import dateutil.parser

from rofi import Rofi
from taskw import TaskWarrior

class RofiWarrior:
    def __init__(self):
        self.rofi = Rofi()
        self.taskw = TaskWarrior()

        self.keybinds = {
                "key1": ('Alt+t','list todo'),
                "key2": ('Alt+a','add todo'),
                "key3": ('Alt+d','done task'),
                "key4": ('Alt+s','toggle todo'),
                }

        self.actions = [
                self.toggle_quit_todo,
                self.list_todo,
                self.add_todo,
                self.done_todo,
                self.toggle_todo,
                sys.exit
                ]

    def list_todo(self, tasks=None):
        if not tasks:
            tasks = self.taskw.load_tasks()["pending"]
        items = []
        for i in tasks:
            desc = i["description"]
            if "annotations" in i and i["annotations"][len(i["annotations"]) - 1]["description"] == "Started task":
                desc += " --> Started"
            items.append(desc)
        l = self._callback(items)

    def toggle_todo(self, id):
        tasks = self.taskw.load_tasks()["pending"]
        task = tasks[id]
        for i in tasks:
            if i["id"] != task["id"] and "annotations" in i and i["annotations"][len(i["annotations"]) - 1]["description"] == "Started task":
                print("tasks: "+id)
                self.taskw._execute("stop", i["id"])
        if "annotations" in task and task["annotations"][len(task["annotations"]) - 1]["description"] == "Started task":
            print(task["id"])
            self.taskw._execute("stop", task["id"])
        else:
            self.taskw._execute("start", task["id"])
        self.list_todo()

    def toggle_quit_todo(self, id):
        tasks = self.taskw.load_tasks()["pending"]
        task = tasks[id]
        for i in tasks:
            if i["id"] != task["id"] and "annotations" in i and i["annotations"][len(i["annotations"]) - 1]["description"] == "Started task":
                self.taskw._execute("stop", i["id"])
        if "annotations" in task and task["annotations"][len(task["annotations"]) - 1]["description"] == "Started task":
            self.taskw._execute("stop", task["id"])
        else:
            self.taskw._execute("start", task["id"])

    def add_todo(self):
        task = self.rofi.text_entry("Add task: ")
        if not task:
            self.list_todo()
        self.taskw._execute("add", *task.split())

    def list_tasks_due(self):
        tasks = self.taskw.load_tasks()
        date_items = {}
        items = []

        # Wow, such horrible
        for i in tasks["pending"]:
            if "due" in i.keys():
                date = dateutil.parser.parse(i["due"])
                date = str(date).split("+")[0]
                if date_items.get(date):
                    date_items[date].append(i)
                else:
                    date_items[date] = [i]

        items = sorted(date_items.keys())
        ret = self._callback(items)
        tasks = date_items[items[ret]]
        self.list_todo(tasks)

    def done_todo(self, id):
        rid = id + 1
        self.taskw.task_done(id=rid)
        self.list_todo()

    def _callback(self, items=[], prompt=">> "):
        index, key = self.rofi.select(prompt, items, **self.keybinds)
        f = self.actions[key]
        if f:
            id_functions = ["toggle_todo", "toggle_quit_todo", "done_todo"]
            if f.__name__ in id_functions:
                f(index)
            else:
                f()
        else:
            return index

    def run(self):
        self.list_todo()


if __name__ == '__main__':
    rw = RofiWarrior()
    rw.run()
