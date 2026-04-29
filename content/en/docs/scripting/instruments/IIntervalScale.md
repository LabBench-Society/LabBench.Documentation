---
title: Interval Scale
description: Instructions on how to install LabBench
weight: 20
---

Represents a numerical rating scale with discrete, equally spaced values. Used to collect interval-based responses such as Likert or numerical rating scales.

**Availability:**

```python
context.Instruments.<IntervalScaleName>
```

## Properties

| Name      | Type  | Description                 |
| --------- | ----- | --------------------------- |
| `Maximum` | `int` | Maximum value of the scale. |
| `Minimum` | `int` | Minimum value of the scale. |

## Methods

| Name                | Signature                                 | Description                                                                     |
| ------------------- | ----------------------------------------- | ------------------------------------------------------------------------------- |
| `GetCurrentRating`  | `GetCurrentRating()` → `int`              | Returns the current rating selected on the scale.                               |
| `GetIntervalRating` | `GetIntervalRating()` → `int`             | Returns the current rating value (same scale domain as `Minimum` to `Maximum`). |
| `SetIntervalRating` | `SetIntervalRating(rating: int)` → `None` | Sets the current rating on the scale. Updates the device state.                 |

## Typical usage example

```python
scale = context.Instruments.IntervalScale

# Read current rating
rating = scale.GetCurrentRating()

# Set rating programmatically
scale.SetIntervalRating(5)

# Access scale bounds
min_val = scale.Minimum
max_val = scale.Maximum
```

## Notes / gotchas

* Valid rating values are within `[Minimum, Maximum]`; behavior outside this range is undefined.
* `SetIntervalRating` directly modifies the device state and may affect participant interaction.
* `GetCurrentRating` and `GetIntervalRating` return integer values; no fractional ratings are supported.
