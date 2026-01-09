---
title: Image Path
description: A path that can be drawn on an `ImageCanvas`
weight: 30
---

`ImagePath` represents a mutable vector path used to construct complex geometric shapes, trajectories, and outlines that can later be rendered onto an `ImageCanvas`. It is a thin, controlled wrapper around Skia’s path primitive, exposed to Python in a way that supports deterministic stimulus construction and safe resource management.

An `ImagePath` does **not** draw anything by itself. Instead, it records a sequence of path commands (moves and lines) that define geometry. The completed path is rendered explicitly using `ImageCanvas.Draw(path)`. This makes `ImagePath` particularly suitable for trajectories, contours, outlines, and stimuli defined algorithmically rather than as simple primitives.

`ImagePath` owns unmanaged graphics resources and **must be disposed** after use. In Python scripts, the recommended pattern is to use the `with` statement to ensure deterministic cleanup.

```python
with canvas.CreatePath() as path:
    path.Move(100, 100)
    path.Line(200, 100)
    path.Line(200, 200)
    path.Line(100, 200)
    path.Close()

    canvas.Draw(path)
```

Once disposed, a path must not be used again.


## Functions

### Move(x, y)

Moves the current point of the path to an absolute position without drawing a line.

This establishes a new starting point for subsequent line segments.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `x` | `float` | Absolute x-coordinate in pixels. |
| `y` | `float` | Absolute y-coordinate in pixels. |

#### Return Value

This function does not return a value.


### RelativeMove(x, y)

Moves the current point by a relative offset without drawing a line.

The new position is computed relative to the current path position.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `x` | `float` | Horizontal offset in pixels. |
| `y` | `float` | Vertical offset in pixels. |

#### Return Value

This function does not return a value.


### Line(x, y)

Draws a straight line from the current point to an absolute position.

If no prior `Move` has been issued, the line implicitly starts at `(0, 0)`.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `x` | `float` | Absolute x-coordinate of the line endpoint. |
| `y` | `float` | Absolute y-coordinate of the line endpoint. |

#### Return Value

This function does not return a value.

### RelativeLine(x, y)

Draws a straight line from the current point using a relative offset.

This is useful for constructing paths incrementally without manually tracking absolute coordinates.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `x` | `float` | Horizontal offset in pixels. |
| `y` | `float` | Vertical offset in pixels. |

#### Return Value

This function does not return a value.

### Close()

Closes the current subpath by drawing a straight line back to its starting point.

This is typically used when constructing closed shapes such as polygons or outlines intended for filling.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

#### Return Value

This function does not return a value.

