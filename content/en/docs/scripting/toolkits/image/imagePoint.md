---
title: ImagePoint
description: A point
weight: 110
---

Represents a 2D point in pixel coordinates, typically used for positions, geometry, and layout calculations in drawing operations.

**Availability:**

```python 
point = rect.TopLeft
```

## Properties

| Name | Type    | Description                      |
| ---- | ------- | -------------------------------- |
| `X`  | `float` | Horizontal coordinate in pixels. |
| `Y`  | `float` | Vertical coordinate in pixels.   |

## Methods

| Name       | Signature                                | Description                               |
| ---------- | ---------------------------------------- | ----------------------------------------- |
| `From`     | `From(x: float, y: float) -> ImagePoint` | Creates a point from numeric coordinates. |
| `ToString` | `ToString() -> str`                      | Returns a string representation `(x, y)`. |

## Typical usage example

```python id="y9z7rs"
rect = canvas.Sprite(400, 300, image_bytes)

p = rect.TopLeft

canvas.Color("#00FF00")
canvas.Point(p.X, p.Y)
```

## Notes / gotchas

* Coordinates are in canvas pixel space (origin at top-left).
* Primarily used as a convenience wrapper for geometry returned from other APIs.
* Can be constructed directly or obtained from objects such as `ImageRectangle`.
* Internal conversions to underlying drawing types are handled automatically.
