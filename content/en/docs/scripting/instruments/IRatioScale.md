---
title: Ratio Scale
description: Instructions on how to install LabBench
weight: 20
---

Represents a continuous rating scale (e.g., Visual Analog Scale) where responses are given as a real-valued position along a defined length.

**Availability:**

```python
context.Instruments.<RatioScaleName>
```

## Properties

| Name     | Type    | Description                                                           |
| -------- | ------- | --------------------------------------------------------------------- |
| `Length` | `float` | Total length of the scale. Defines the maximal possible rating value. |

## Methods

| Name               | Signature                                | Description                                                              |
| ------------------ | ---------------------------------------- | ------------------------------------------------------------------------ |
| `GetCurrentRating` | `GetCurrentRating()` → `float`           | Returns the current rating value on the scale.                           |
| `GetRatioRating`   | `GetRatioRating()` → `float`             | Returns the current rating value (same scale domain as `0` to `Length`). |
| `SetRatioRating`   | `SetRatioRating(rating: float)` → `None` | Sets the current rating on the scale. Updates the device state.          |

## Typical usage example

```python
scale = context.Instruments.RatioScale

# Read current rating
rating = scale.GetCurrentRating()

# Set rating programmatically
scale.SetRatioRating(5.0)

# Access scale length
max_val = scale.Length
```

## Notes / gotchas

* Valid rating values are typically within `[0, Length]`; behavior outside this range is undefined.
* Ratings are continuous (floating-point), unlike interval or ordinal scales.
* `SetRatioRating` directly modifies the device state and may affect participant interaction.
* `GetCurrentRating` and `GetRatioRating` return equivalent values.
