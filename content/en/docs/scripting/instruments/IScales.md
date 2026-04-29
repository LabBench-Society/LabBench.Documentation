---
title: Scales
description: Instructions on how to install LabBench
weight: 20
---

Represents a composite rating device that provides access to multiple rating scales simultaneously.

**Availability:**

```python id="q8t3vm"
context.Instruments.<ScalesName>
```

## Properties

| Name     | Type                 | Description                                                                                                                                   |
| -------- | -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| `Scales` | `List[IRatingScale]` | Collection of rating scale instances available on the device. Each element implements a specific scale type (e.g., ratio, interval, ordinal). |

## Methods

| Name               | Signature                     | Description                                                                                                |
| ------------------ | ----------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `InitializeRating` | `InitializeRating()` → `None` | Initializes or resets all contained rating scales. Typically prepares the device for a new rating session. |

## Typical usage example

```python id="aq9z0c"
scales = context.Instruments.Scales

# Initialize all scales
scales.InitializeRating()

# Access individual scales
for scale in scales.Scales:
    # Use scale depending on its type
    pass
```

## Notes / gotchas

* The specific type of each scale in `Scales` depends on the experimental setup.
* Access to scale-specific methods requires knowledge of the concrete scale type.
* `InitializeRating()` should typically be called before collecting responses.
