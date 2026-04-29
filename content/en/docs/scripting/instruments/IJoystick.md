---
title: Joystick
description: Instructions on how to install LabBench
weight: 20
---

Provides access to a joystick input device, allowing continuous sampling of its position along one or more axes.

**Availability:**

```python
context.Instruments.<JoystickName>
```

## Properties

*No public properties.*

## Methods

| Name   | Signature                     | Description                                                                                  |
| ------ | ----------------------------- | -------------------------------------------------------------------------------------------- |
| `Read` | `Read()` → `JoystickPosition` | Returns the current joystick position as a `JoystickPosition` object containing axis values. |

## JoystickPosition

Represents the current position of the joystick.

### Properties

| Name | Type    | Description                                                           |
| ---- | ------- | --------------------------------------------------------------------- |
| `X`  | `float` | Position along the X-axis (horizontal).                               |
| `Y`  | `float` | Position along the Y-axis (vertical).                                 |
| `Z`  | `float` | Position along the Z-axis (e.g., rotation or throttle, if available). |

## Typical usage example

```python
joystick = context.Instruments.Joystick

pos = joystick.Read()

x = pos.X
y = pos.Y
z = pos.Z
```

## Notes / gotchas

* Axis ranges and scaling are device-dependent (no normalization guaranteed).
* `Z` may not be meaningful on all devices.
* Sampling is pull-based; call `Read()` each time a new value is needed.
