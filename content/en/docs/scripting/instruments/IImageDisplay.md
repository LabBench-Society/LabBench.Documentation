---
title: Image Display
description: Visual output device in LabBench, enabling precise presentation of raster images, access to display dimensions, fiducial marking, and deterministic visual stimulus delivery.
weight: 20
---

The `IImageDisplay` interface exposes a visual output instrument to LabBench’s scripting environment, allowing experiments to present raster-based visual stimuli with precise control over what is shown and when it appears. From scripting, it provides access to the display’s pixel dimensions, supports immediate or time-limited presentation of images supplied as byte arrays, allows designation of fiducial frames for synchronization or timing validation, and enables clearing or restoring default visuals. This interface is designed for deterministic, low-latency stimulus presentation and tight integration with LabBench’s .NET execution model, making it suitable for controlled visual stimulation in psychophysical and neuroscience experiments.

This document describes the Image Display interface. These interfaces allow experiments to present bitmap-based visual stimuli, control timing precisely, and construct dynamic image sequences suitable for psychophysics and neuroscience experiments.

The interfaces documented here are typically accessed through an instrument instance defined in the protocol and exposed to scripting via its instrument ID.

`ImageDisplay` represents a visual output instrument capable of displaying raster images (byte arrays) on a screen or display surface.

### Properties

- **Width** → `int`: The width of the display in pixels.
- **Height** → `int`: The height of the display in pixels.

These properties are read-only and can be used to generate or validate image buffers before display.

Example:
```python
w = Display.Width
h = Display.Height
```

### Methods

#### Default(image)

Sets the default image.

- `image` (`byte[]`): Image data encoded as a byte array.

Example:

```python
tc.Instruments.ImageDisplay.Default(background_image)
```

#### Display(image, fiducial=False)

Immediately displays an image.

- `image` (`byte[]`): Image data to display.
- `fiducial` (`bool`, optional): If `True`, the image is marked with a fiducial (e.g. for synchronization or timing validation).

Example:

```python
tc.Instruments.ImageDisplay.Display(stimulus_image)
```

#### Display(image, time, fiducial=False)

Displays an image for a fixed duration.

- `image` (`byte[]`):  Image data to display.
- `time` (`int`): Display duration in milliseconds.
- `fiducial` (`bool`, optional): Marks the image with a fiducial.

Example:

```python
tc.Instruments.ImageDisplay.Display(stimulus_image, 200)
```

#### Clear()

Clears the display and displays the default image (if set), removing any currently shown image.

Example:

```python
tc.Instruments.ImageDisplay.Clear()
```