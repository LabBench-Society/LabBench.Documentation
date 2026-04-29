---
title: Image Display
description: Visual output device in LabBench, enabling precise presentation of raster images, access to display dimensions, fiducial marking, and deterministic visual stimulus delivery.
weight: 20
---

Provides visual stimulus presentation by displaying images on a screen with optional timing and fiducial marking.

**Availability:**

```python
context.Instruments.ImageDisplay
```

### Properties

| Name     | Type  | Description                      |
| -------- | ----- | -------------------------------- |
| `Width`  | `int` | Width of the display in pixels.  |
| `Height` | `int` | Height of the display in pixels. |

### Methods

| Name      | Signature                                       | Description                                                                                                  |
| --------- | ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------ |
| `Default` | `Default(image)` → `None`                       | Sets the default image shown when the display is cleared.                                                    |
| `Display` | `Display(image, fiducial=False)` → `None`       | Displays an image immediately. If `fiducial=True`, marks the frame for synchronization.                      |
| `Display` | `Display(image, time, fiducial=False)` → `None` | Displays an image for a fixed duration (`time` in milliseconds). Optionally marks the frame with a fiducial. |
| `Clear`   | `Clear()` → `None`                              | Clears the current image and restores the default image (if defined).                                        |

## Typical usage example

```python
display = context.Instruments.ImageDisplay

# Query display size
width = display.Width
height = display.Height

# Set default background
display.Default(background_image)

# Show stimulus
display.Display(stimulus_image, 200, fiducial=True)

# Clear display
display.Clear()
```

## Notes / gotchas

* Image format (`LabBenchImage`) must match the expected format of the instrument (not validated here).
* `time` is specified in milliseconds.
* Fiducial marking is typically used for synchronization with external devices.
* `Clear()` restores the default image if one has been set; otherwise behavior depends on the device.
* Display calls are immediate; timing precision depends on the underlying hardware and system.
