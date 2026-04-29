---
title: ImageRectangle
description: A rectangle
weight: 100
---

Represents a rectangular region in pixel coordinates, typically returned from drawing operations (e.g. `Sprite`) to describe the rendered bounds.

**Availability:**

```python
rect = canvas.Sprite(...)
```

## Properties

| Name          | Type         | Description                               |
| ------------- | ------------ | ----------------------------------------- |
| `Left`        | `float`      | Left edge of the rectangle (pixels).      |
| `Top`         | `float`      | Top edge of the rectangle (pixels).       |
| `Right`       | `float`      | Right edge of the rectangle (pixels).     |
| `Bottom`      | `float`      | Bottom edge of the rectangle (pixels).    |
| `Width`       | `float`      | Width of the rectangle (`Right - Left`).  |
| `Height`      | `float`      | Height of the rectangle (`Bottom - Top`). |
| `CenterX`     | `float`      | Horizontal center of the rectangle.       |
| `CenterY`     | `float`      | Vertical center of the rectangle.         |
| `TopLeft`     | `ImagePoint` | Top-left corner as a point.               |
| `BottomRight` | `ImagePoint` | Bottom-right corner as a point.           |

## Methods

| Name       | Signature           | Description                                                                  |
| ---------- | ------------------- | ---------------------------------------------------------------------------- |
| `ToString` | `ToString() -> str` | Returns a string representation `[left, top, right, bottom] (W=..., H=...)`. |

## Typical usage example

```python
rect = canvas.Sprite(400, 300, image_bytes, width=200)

# Use geometry for layout or alignment
cx = rect.CenterX
cy = rect.CenterY

canvas.Color("#FF0000")
canvas.Circle(cx, cy, 10)
```

## Notes / gotchas

* Coordinates are in canvas pixel space (origin at top-left).
* Rectangle values reflect the **final rendered position**, including alignment and scaling.
* Useful for layout calculations after drawing operations (e.g. centering overlays, hit-testing).
* Implicit conversion to underlying drawing types is handled internally; not exposed in Python.

