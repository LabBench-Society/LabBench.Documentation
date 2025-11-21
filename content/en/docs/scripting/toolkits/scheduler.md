---
title: Scheduler
description: Schedule tasks to run in the background
weight: 20
---

{{% pageinfo %}}

The scheduling toolkit allows you to run tasks in the background while your protocol is running. Running tasks in the background makes it possible, for example, to update visual stimuli on a LabBench DISPLAY asynchronously with precise timing during tests such as `<sequential>` or `<sequence>` tests.

{{% /pageinfo %}}



## Scheduler

### Function: `Create()`

Returns a new created `Schedule` which can be used to create a schedule of tasks that can later be run with the Run function.

*Parameters:*

None

*Returns*

* An object of type Schedule.

### Function: `Run(schedule)`

Runs a `Schedule` that has previously been created wih the `Create()` function.

*Parameters:*

* `schedule`: an object of type `Schedule` that can be created with the `Create()` function.

*Returns*

* None


## Schedule

### Function: `Add(duration: int, lambda -> None)`

### Function: `Add(lamda -> int)`