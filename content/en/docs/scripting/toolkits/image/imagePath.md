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


## Utility functions


### Close()

Closes the current subpath by drawing a straight line back to its starting point.

This is typically used when constructing closed shapes such as polygons or outlines intended for filling.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

#### Return Value

This function does not return a value.


## Basic Path Construction

These functions add complete geometric subpaths or manage the overall state of the path. They are typically used to define shapes directly, rather than building them segment by segment.


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


### AddCircle(x, y, r)

Adds a complete circular subpath centered at the specified position.

This is equivalent to constructing a closed circular outline and is suitable for both stroked and filled rendering.

| Name | Type | Description |
|------|------|-------------|
| `x` | `float` | X-coordinate of the circle center in pixels. |
| `y` | `float` | Y-coordinate of the circle center in pixels. |
| `r` | `float` | Radius of the circle in pixels. |

**Return value:** none.


### `AddRectangle(x1, y1, x2, y2)`

Adds a rectangular subpath defined by two corner coordinates.

The rectangle is added as a closed path and can be stroked or filled when rendered.

| Name | Type | Description |
|------|------|-------------|
| `x1` | `float` | Left edge of the rectangle in pixels. |
| `y1` | `float` | Top edge of the rectangle in pixels. |
| `x2` | `float` | Right edge of the rectangle in pixels. |
| `y2` | `float` | Bottom edge of the rectangle in pixels. |

**Return value:** none.


### `AddRoundedRectangle(x1, y1, x2, y2, rx, ry)`

Adds a rectangle with rounded corners as a single closed subpath.

Corner curvature is controlled independently in the horizontal and vertical directions.

| Name | Type | Description |
|------|------|-------------|
| `x1` | `float` | Left edge of the rectangle in pixels. |
| `y1` | `float` | Top edge of the rectangle in pixels. |
| `x2` | `float` | Right edge of the rectangle in pixels. |
| `y2` | `float` | Bottom edge of the rectangle in pixels. |
| `rx` | `float` | Horizontal corner radius in pixels. |
| `ry` | `float` | Vertical corner radius in pixels. |

**Return value:** none.


### `Reset()`

Clears all geometry from the path, returning it to an empty state.

This allows the same `ImagePath` instance to be reused for constructing new geometry.

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

**Return value:** none.

### `Contains(x, y)`

Tests whether a point lies inside the filled region of the path.

This function evaluates the path as a closed region and is primarily intended for hit-testing or validation logic rather than rendering.

| Name | Type | Description |
|------|------|-------------|
| `x` | `float` | X-coordinate of the test point in pixels. |
| `y` | `float` | Y-coordinate of the test point in pixels. |

**Return value:**  
Returns `bool`, indicating whether the point lies inside the path.


## Curves

Curve functions allow smooth, continuous geometry to be constructed beyond straight-line segments. These are essential for trajectories, smooth contours, and naturalistic shapes.

### `Quad(cx, cy, x, y)`

Adds a quadratic curve segment from the current point to an absolute endpoint, using a single control point.

| Name | Type | Description |
|------|------|-------------|
| `cx` | `float` | X-coordinate of the control point. |
| `cy` | `float` | Y-coordinate of the control point. |
| `x` | `float` | X-coordinate of the curve endpoint. |
| `y` | `float` | Y-coordinate of the curve endpoint. |

**Return value:** none.


### `RelativeQuad(cx, cy, x, y)`

Adds a quadratic curve using offsets relative to the current point.

| Name | Type | Description |
|------|------|-------------|
| `cx` | `float` | Horizontal offset to the control point. |
| `cy` | `float` | Vertical offset to the control point. |
| `x` | `float` | Horizontal offset to the endpoint. |
| `y` | `float` | Vertical offset to the endpoint. |

**Return value:** none.


### `Cubic(cx1, cy1, cx2, cy2, x, y)`

Adds a cubic curve segment defined by two control points and an absolute endpoint.

Cubic curves allow finer control over curvature and are well suited for complex trajectories.

| Name | Type | Description |
|------|------|-------------|
| `cx1` | `float` | X-coordinate of the first control point. |
| `cy1` | `float` | Y-coordinate of the first control point. |
| `cx2` | `float` | X-coordinate of the second control point. |
| `cy2` | `float` | Y-coordinate of the second control point. |
| `x` | `float` | X-coordinate of the curve endpoint. |
| `y` | `float` | Y-coordinate of the curve endpoint. |

**Return value:** none.


### `RelativeCubic(cx1, cy1, cx2, cy2, x, y)`

Adds a cubic curve using offsets relative to the current point.

| Name | Type | Description |
|------|------|-------------|
| `cx1` | `float` | Horizontal offset to the first control point. |
| `cy1` | `float` | Vertical offset to the first control point. |
| `cx2` | `float` | Horizontal offset to the second control point. |
| `cy2` | `float` | Vertical offset to the second control point. |
| `x` | `float` | Horizontal offset to the endpoint. |
| `y` | `float` | Vertical offset to the endpoint. |

**Return value:** none.

### `Arc(x1, y1, x2, y2, startAngle, sweepAngle)`

Adds an arc segment defined by an oval bounding box and angular parameters.

The arc is appended to the current subpath and does not implicitly close the shape.

| Name | Type | Description |
|------|------|-------------|
| `x1` | `float` | Left edge of the bounding box. |
| `y1` | `float` | Top edge of the bounding box. |
| `x2` | `float` | Right edge of the bounding box. |
| `y2` | `float` | Bottom edge of the bounding box. |
| `startAngle` | `float` | Starting angle in degrees. |
| `sweepAngle` | `float` | Angular extent of the arc in degrees. |

**Return value:** none.

## Transforms

Transform functions modify the geometry of the path after it has been constructed. These operations affect all existing segments and subpaths.

Transforms are powerful but should be used with care in experimental contexts, as they can obscure the original coordinate meaning.

### `Translate(dx, dy)`

Translates the entire path by a fixed offset.

| Name | Type | Description |
|------|------|-------------|
| `dx` | `float` | Horizontal translation in pixels. |
| `dy` | `float` | Vertical translation in pixels. |

**Return value:** none.


### `Scale(sx, sy)`

Scales the path geometry relative to the origin.

| Name | Type | Description |
|------|------|-------------|
| `sx` | `float` | Horizontal scale factor. |
| `sy` | `float` | Vertical scale factor. |

**Return value:** none.


### `Rotate(degrees)`

Rotates the path around the origin by the specified angle.

| Name | Type | Description |
|------|------|-------------|
| `degrees` | `float` | Rotation angle in degrees. Positive values rotate clockwise. |

**Return value:** none.


### `Rotate(degrees, cx, cy)`

Rotates the path around a specified pivot point.

| Name | Type | Description |
|------|------|-------------|
| `degrees` | `float` | Rotation angle in degrees. |
| `cx` | `float` | X-coordinate of the rotation center. |
| `cy` | `float` | Y-coordinate of the rotation center. |

**Return value:** none.

