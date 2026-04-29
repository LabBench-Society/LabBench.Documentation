---
title: Trigger Detector
description: Detection of trigger signals.
weight: 20
---

Detects incoming trigger events and provides information about trigger state, timing, and count.

**Availability:**

```python
context.Instruments.<TriggerDetectorName>
```

## Properties

| Name          | Type    | Description                                                                                    |
| ------------- | ------- | ---------------------------------------------------------------------------------------------- |
| `IsTriggered` | `bool`  | Indicates whether a trigger event has been detected.                                           |
| `Latency`     | `float` | Latency associated with the detected trigger (unit depends on device, typically milliseconds). |
| `Count`       | `int`   | Number of detected trigger events since last reset.                                            |

## Methods

| Name    | Signature          | Description                                                             |
| ------- | ------------------ | ----------------------------------------------------------------------- |
| `Reset` | `Reset()` → `None` | Resets the trigger detector state, clearing trigger flags and counters. |

## Typical usage example

```python
detector = context.Instruments.TriggerDetector

# Check trigger state
if detector.IsTriggered:
    print("Trigger detected with latency:", detector.Latency)

# Read number of triggers
count = detector.Count

# Reset between trials
detector.Reset()
```

## Notes / gotchas

* `Reset()` should typically be called between trials to clear previous trigger events.
* `Latency` is only meaningful when a trigger has been detected.
* Trigger detection depends on correct hardware configuration and signal routing.
