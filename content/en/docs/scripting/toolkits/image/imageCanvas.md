---
title: Image Canvas
description: A drawing canvas for creating images.
weight: 10
---

{{% pageinfo %}}
`ImageCanvas` is a lightweight, stateful 2D drawing surface used in LabBench protocols to construct precise and reproducible visual stimuli. It provides an immediate-mode graphics API that separates styling, geometry, text, and image export, allowing complex stimuli to be built procedurally with clear intent. The canvas maintains an internal drawing state that applies consistently across operations and can be exported seamlessly as image data or LabBench assets.
{{% /pageinfo %}}

An `ImageCanvas` can be created with one of the `GetCanvas()` functions in the Image toolkit. Below is an example, where an `ImageCanvas` is created to generate and display a visual stimulus for the Stroop Task:

```python
def StroopStimulate(tc, x):
    with tc.Image.GetCanvas(tc.Instruments.ImageDisplay) as canvas:
        canvas.AlignCenter()
        canvas.AlignMiddle()
        canvas.Font("Roboto")
        canvas.TextSize(200)
        canvas.Color(tc.StroopColors[tc.StimulusName[0]])
        canvas.Write(display.Width/2, display.Height/2, tc.StroopWords[tc.StimulusName[1]])

        tc.Instruments.ImageDisplay.Display(canvas, tc.StroopDisplayTime, True)
        
    return True
```

This example use the Resource Acquisition Is Initialization (`with ... as ...`) programming paradigm, which means that a resource is aquired at construction and released at destruction. This programming paradigm garantees that the resources held by the `ImageCanvas` is released when the `ImageCanvas` object goes out of scope. Whenever possible it is recommended to use this programming paradigm when creating an `ImageCanvas`.

## Properties

The `ImageCanvas` has the following properties:

| Attribute     | Type        | Specification                             |
|---------------|-------------|-------------------------------------------|
| `Width`       | int         | The width of the `ImageCanvas` in pixels.  |
| `Height`      | int         | The height of the `ImageCanvas` in pixels. |
| `TextHeight`  | double      | Height of the currently selected font and font size. |
| `FontMetrics` | FontMetrics | |

## Image functions

The image functions of `ImageCanvas` are responsible for **extracting and exporting** the rendered contents of the canvas for use outside the drawing API. An `ImageCanvas` accumulates drawing commands into an internal image buffer. Image functions provide controlled access to this buffer by encoding it into standard image representations, without altering the canvas state. This design allows the same canvas to be rendered, inspected, and exported multiple times during protocol execution.

`ImageCanvas` supports implicit conversion to a byte array representing a PNG-encoded image. This implicit conversion means that any LabBench function or API expecting a `byte[]` image parameter can receive an `ImageCanvas` instance directly, without explicitly calling `GetImage()`.

This design simplifies protocol code and reinforces the idea that a canvas *is* an image once rendering is complete, while still allowing drawing operations to remain expressive and stateful.

### GetImage()

Encodes the current contents of the canvas into a PNG image and returns it as a byte array.

This function captures a snapshot of the canvas at the moment it is called, including all previously drawn elements, and encodes it using lossless PNG compression. The returned byte array can be stored, transmitted, or passed directly to other LabBench components that consume image data.

Calling this function does not modify the canvas and can be done multiple times to retrieve intermediate or final rendering states.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

#### Return Value

Returns a `bytes` object containing the PNG-encoded image data representing the current canvas contents.


### GetAsset()

Wraps the current canvas image in a LabBench image asset and returns it as an `IAsset`.

This function converts the rendered canvas into a memory-backed image asset that can be used directly by LabBench components expecting assets. The image data is generated from the current canvas state at the time the asset is created.

Calling this function does not modify the canvas and can be done multiple times to retrieve intermediate or final rendering states.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

#### Return Value

Returns an `IAsset` representing the current canvas image, suitable for use wherever LabBench image assets are required.


## Style functions

The styling and layout functions of `ImageCanvas` control **how** graphical primitives, text, and sprites are rendered, without directly producing visual output. These functions modify the canvas's internal drawing state, which is then applied consistently to all subsequent drawing operations. This design follows a **state-based rendering model**, meaning instead of passing styling parameters to every drawing call, the canvas maintains a mutable drawing state that includes: 1) stroke appearance (cap style, width),2) fill vs. stroke mode, 3) color and transparency, 4) typeface and text size, and 5) horizontal and vertical alignment.

This approach reduces visual clutter in drawing code and makes experimental protocols easier to read, modify, and audit. Once a styling function is called, its effect **persists** until explicitly changed. For example, setting a stroke width or color affects all subsequent lines, shapes, text, and sprites until another call overrides it. Previously drawn elements are never retroactively modified. This persistence is intentional and mirrors how visual stimuli are often constructed: by grouping related drawing commands under a shared visual configuration.

Horizontal and vertical alignment functions do not merely shift pixels; they redefine the semantic meaning of coordinates, meaning: 1) horizontal alignment determines how the x-coordinate relates to the text or sprite width, and 2) vertical alignment determines how the y-coordinate relates to text baselines and sprite heights.

Alignment functions allow experimental code to express intent (e.g., *center this label here*) rather than manually computing offsets, reducing error-prone geometry calculations.

By separating styling from geometry:
- Drawing functions remain minimal and focused on *what* is drawn
- Styling functions define *how* it appears

This separation supports cleaner code. 


### RoundStrokeCap()

Sets the stroke cap style to **round** for all subsequent stroke-based drawing operations on the canvas.

When this mode is enabled, the ends of stroked primitives (such as lines, paths, and outlines of shapes) are rendered with a rounded termination. This is particularly useful for smooth-looking line drawings, trajectories, or circular markers where sharp edges would be visually distracting or misleading.

This function affects only **stroked** drawing operations. If the paint style is set to `Fill`, the stroke cap has no effect.

**Parameters:**

| Name | Type | Description |
|-----|------|-------------|
| — | — | This function takes no parameters. |

**Return value:**

This function does not return a value. It modifies the current drawing state of the canvas.


### SquareStrokeCap()

Sets the stroke cap style to **square** for all subsequent stroke-based drawing operations on the canvas.

With a square stroke cap, the ends of lines and paths are rendered with a flat edge that extends half a stroke width beyond the endpoint. This is useful when precise geometric appearance is desired, such as grid lines, axes, or technical diagrams where consistent edge alignment matters.

This setting only affects drawing operations performed with a **stroke** paint style. Filled shapes are not affected by the stroke cap configuration.

**Parameters:**

| Name | Type | Description |
|-----|------|-------------|
| — | — | This function takes no parameters. |

**Return value:**

This function does not return a value. It updates the stroke rendering style of the canvas.

### ButtStrokeCap()

Sets the stroke cap style to **butt** (flat) for all subsequent stroke-based drawing operations on the canvas.

With a butt stroke cap, lines and paths end exactly at their specified endpoints, without any extension or rounding. This is the most precise stroke termination mode and is well-suited for technical drawings, pixel-accurate layouts, and situations where line endpoints must align exactly with other graphical elements.

This setting only affects drawing operations performed using a **stroke** paint style. It has no effect on filled shapes.

**Parameters:**

| Name | Type | Description |
|-----|------|-------------|
| — | — | This function takes no parameters. |

**Return value:**

This function does not return a value. It modifies the current stroke cap style of the canvas.

### Color(color)

Sets the current drawing color used for all subsequent drawing and text operations on the canvas.

The color is specified as a string and parsed into an RGBA color internally. This color applies to both stroke and fill operations, depending on the current paint style. Changing the color affects all primitives drawn after the call, without altering previously rendered content.

This function is typically used to control contrast, encode stimulus conditions, or distinguish different graphical elements within a single image.

**Parameters:**

| Name  | Type   | Description |
|------|--------|-------------|
| `color` | `str` | Color specification string. Common formats include hexadecimal color codes (e.g. `"#FF0000"` for red, `"#00FF0080"` for semi-transparent green). |

**Return value:**

This function does not return a value. It updates the current drawing color of the canvas.

### StrokeWidth(width)

Sets the width of the stroke used for subsequent stroke-based drawing operations on the canvas.

The stroke width determines the thickness of lines, paths, and shape outlines when the paint style is set to `Stroke`. The value is interpreted in canvas pixel units. This setting is essential for controlling visual salience, line visibility, and scale consistency across different display resolutions.

This function does not affect filled shapes, except where outlines are explicitly drawn.

**Parameters:**

| Name   | Type    | Description |
|--------|---------|-------------|
| `width` | double | Stroke thickness in pixels. Larger values produce thicker lines and outlines. |

**Return value:**

This function does not return a value. It updates the current stroke width used by the canvas.

### Fill(fill)

Sets whether subsequent drawing operations use a **filled** or **stroked** paint style.

When enabled, shapes and text are rendered as solid filled regions. When disabled, only the outlines of shapes and paths are drawn, using the current stroke settings (such as stroke width and stroke cap). This function controls a fundamental rendering mode and is commonly toggled when switching between drawing outlines, contours, and solid stimuli.

The setting applies to all subsequent drawing operations until changed again.

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| `fill` | bool | If `true`, drawing operations use a filled style. If `false`, drawing operations use a stroked (outline-only) style. |

**Return value:**

This function does not return a value. It updates the current paint style of the canvas.

### Font(id)

Sets the typeface used for all subsequent text rendering operations on the canvas.

This function selects a font by `id` from a font included as an `<file-asset>` in the protocol. Once set, the font is used by all text-related functions such as `Write`, `TextWidth`, and `TextHeight`.

If an unknown font name is provided, the function will raise an error, making this a safe way to ensure that only explicitly registered and reproducible fonts are used in experiments.

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| `id` | string | ID of a font added as a `<file-asset>` in the `<assets>` element of the protocol. |

**Return value:**

This function does not return a value. It updates the current font used for text rendering on the canvas.

### TextSize(size)

Sets the font size used for all subsequent text rendering operations on the canvas.

The text size controls the height of rendered glyphs and is specified in canvas pixel units. This setting affects all text-related measurements and rendering, including `Write`, `TextWidth`, and `TextHeight`. Adjusting the text size is essential for matching stimulus scale to display resolution and ensuring consistent visual angles across experimental conditions.

The setting remains active until changed again.

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| `size` | float | Font size in pixels used for rendering text. Larger values produce larger text. |

**Return value:**

This function does not return a value. It updates the current text size used by the canvas.

### AlignLeft()

Sets the horizontal text alignment to **left** for all subsequent text and sprite rendering operations.

When left alignment is enabled, the x-coordinate provided to text drawing functions (such as `Write`) is interpreted as the **left edge** of the rendered text or sprite. This is the default and most commonly used alignment when positioning labels, annotations, or stimuli relative to a known origin.

This setting affects only text and sprite rendering and has no effect on non-text drawing primitives.

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

**Return value:**

This function does not return a value. It updates the horizontal text alignment of the canvas.

### AlignCenter()

Sets the horizontal text alignment to **center** for all subsequent text and sprite rendering operations.

When left alignment is enabled, the x-coordinate provided to text drawing functions (such as `Write`) is interpreted as the **center** of the rendered text or sprite. This is the default and most commonly used alignment when positioning labels, annotations, or stimuli relative to a known origin.

This setting affects only text and sprite rendering and has no effect on non-text drawing primitives.

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

**Return value:**

This function does not return a value. It updates the horizontal text alignment of the canvas.

### AlignRight()

Sets the horizontal text alignment to **right** for all subsequent text and sprite rendering operations.

When left alignment is enabled, the x-coordinate provided to text drawing functions (such as `Write`) is interpreted as the **right edge** of the rendered text or sprite. 

This setting affects only text rendering and has no effect on non-text or non-sprite drawing primitives.

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

**Return value:**

This function does not return a value. It updates the horizontal text alignment of the canvas.

### AlignTop()

Sets the vertical alignment to **top** for subsequent text and sprite drawing operations.

When top alignment is enabled, the y-coordinate provided to text (`Write`) and sprite (`Sprite`) drawing functions is interpreted as the **top edge** of the rendered content. This makes it easier to position text labels or images relative to a fixed upper boundary, such as aligning elements to the top of a display region or layout cell.

This setting affects:
- Text vertical positioning via baseline adjustment
- Sprite bitmap placement via height-based offsetting

The alignment remains active until changed by another vertical alignment function.

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

**Return value:**

This function does not return a value. It updates the current vertical alignment mode of the canvas.

### AlignMiddle()

Sets the vertical alignment to **middle** for subsequent text and sprite drawing operations.

When top alignment is enabled, the y-coordinate provided to text (`Write`) and sprite (`Sprite`) drawing functions is interpreted as the **middle** of the rendered content. This makes it easier to position text labels or images relative to a fixed upper boundary, such as aligning elements in the middle of a display region or layout cell.

This setting affects:
- Text vertical positioning via baseline adjustment
- Sprite bitmap placement via height-based offsetting

The alignment remains active until changed by another vertical alignment function.

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

**Return value:**

This function does not return a value. It updates the current vertical alignment mode of the canvas.

### AlignBottom()

Sets the vertical alignment to **bottom** for subsequent text and sprite drawing operations.

When top alignment is enabled, the y-coordinate provided to text (`Write`) and sprite (`Sprite`) drawing functions is interpreted as the **bottom edge** of the rendered content. This makes it easier to position text labels or images relative to a fixed lower boundary, such as aligning elements to the bottom of a display region or layout cell.

This setting affects:
- Text vertical positioning via baseline adjustment
- Sprite bitmap placement via height-based offsetting

The alignment remains active until changed by another vertical alignment function.

**Parameters:**

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

**Return value:**

This function does not return a value. It updates the current vertical alignment mode of the canvas.

## Drawing Functions

The drawing functions of `ImageCanvas` are responsible for **producing visual output** on the canvas. Unlike styling and layout functions, these calls directly render geometry, text, paths, or images using the current drawing state. Each drawing function consumes the canvas state as it exists at the moment of the call, applying the active color, stroke settings, fill mode, font, and alignment. Once a primitive is drawn, it becomes part of the image and is not affected by later state changes. `ImageCanvas` follows an **immediate-mode rendering model**: drawing commands are executed in sequence and rendered directly into the underlying image buffer. This design makes the execution order explicit and meaningful—later drawing operations will appear on top of earlier ones. This model is well-suited to experimental stimulus construction, where stimuli are often built procedurally and layered in a controlled, deterministic way.

Drawing functions focus exclusively on *what* is being drawn:
- Points, lines, shapes, paths
- Text glyphs
- Bitmap sprites

They do not accept styling parameters themselves. Instead, appearance is defined entirely by prior calls to styling and alignment functions. This separation encourages readable, declarative stimulus definitions and reduces repetition in protocol code.

Complex shapes and trajectories are constructed using `ImagePath` objects and rendered via the `Draw` function. This design allows geometry to be defined once and reused multiple times with different visual styles, supporting both clarity and efficiency.

All drawing operations use the same pixel-based coordinate system and share a unified alignment model: 1) horizontal alignment affects text and sprite anchoring, 2) vertical alignment affects baseline handling for text and bounding for sprites

This consistency allows text, shapes, and images to be combined naturally within the same layout logic. Together, the drawing functions provide a compact but expressive toolkit for constructing precise, layered, and reproducible visual stimuli in LabBench.

### CreatePath()

Creates and returns a new `ImagePath` object that can be used to construct complex vector paths.

An `ImagePath` represents a mutable sequence of drawing commands (such as moves and lines) that define arbitrary shapes, contours, or trajectories. Paths are built incrementally using path functions (e.g. `Move`, `Line`, `Close`) and can later be rendered onto the canvas using the `Draw` function.

This mechanism is particularly useful for drawing non-primitive shapes, smooth trajectories, or stimuli defined by a sequence of connected segments, while keeping path construction logically separate from rendering.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

#### Return Value

Returns an `ImagePath` object representing an empty path ready to be populated with drawing commands.


### Draw(path)

Renders an `ImagePath` onto the canvas using the current drawing state.

This function draws the geometry defined by an `ImagePath` object, applying the current paint configuration, including color, stroke width, stroke cap, fill mode, and antialiasing. The same path can be reused and drawn multiple times with different styles by modifying the canvas state between draw calls.

Depending on whether the paint style is set to **stroke** or **fill**, the path will be rendered as an outlined shape or as a filled region.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `path` | `ImagePath` | Path object defining the geometry to be rendered. The path must have been constructed using path drawing commands before rendering. |

#### Return Value

This function does not return a value. It draws the specified path onto the canvas.

### Point(x, y)

Draws a single point at the specified canvas coordinates using the current drawing style.

The point is rendered using the current paint configuration, including color and stroke width. The visual appearance of the point (such as its size) is influenced by the current stroke width and antialiasing settings. This function is useful for marking precise locations, sample points, or reference positions within a stimulus.

Coordinates are specified in canvas pixel space, with the origin at the top-left corner.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `x` | double | Horizontal position of the point in pixels. |
| `y` | double | Vertical position of the point in pixels. |

#### Return Value

This function does not return a value. It draws a point at the specified location on the canvas.

### Line(x1, y1, x2, y2)

Draws a straight line segment between two points on the canvas using the current drawing style.

The line is rendered according to the current paint configuration, including color, stroke width, stroke cap style, and antialiasing. This function is commonly used for drawing axes, borders, trajectories, or any linear visual elements within a stimulus.

Coordinates are specified in canvas pixel space, with the origin at the top-left corner.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `x1` | `double` | Horizontal coordinate of the line’s starting point in pixels. |
| `y1` | `double` | Vertical coordinate of the line’s starting point in pixels. |
| `x2` | `double` | Horizontal coordinate of the line’s ending point in pixels. |
| `y2` | `double` | Vertical coordinate of the line’s ending point in pixels. |

#### Return Value

This function does not return a value. It draws a line between the specified points on the canvas.


### Circle(x, y, r)

Draws a circle centered at the specified position on the canvas using the current drawing style.

The circle’s appearance is controlled by the current paint configuration. If the paint style is set to **stroke**, only the outline of the circle is drawn using the current stroke width. If the paint style is set to **fill**, the circle is rendered as a solid disk.

This function is commonly used for drawing markers, fixation points, or circular stimuli in visual experiments.

Coordinates and radius are specified in canvas pixel units.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `x` | `float` | Horizontal coordinate of the circle center in pixels. |
| `y` | `float` | Vertical coordinate of the circle center in pixels. |
| `r` | `float` | Radius of the circle in pixels. |

#### Return Value

This function does not return a value. It draws a circle at the specified location on the canvas.

### Rectangle(x1, y1, x2, y2)

Draws an axis-aligned rectangle defined by two corner coordinates using the current drawing style.

The rectangle is specified by its top-left and bottom-right corners in canvas pixel coordinates. Depending on the current paint style, the rectangle is rendered either as an outlined shape (**stroke**) or as a solid filled area (**fill**).

This function is commonly used for drawing bounding boxes, background regions, masks, or rectangular stimuli.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `x1` | `float` | Horizontal coordinate of the left edge of the rectangle in pixels. |
| `y1` | `float` | Vertical coordinate of the top edge of the rectangle in pixels. |
| `x2` | `float` | Horizontal coordinate of the right edge of the rectangle in pixels. |
| `y2` | `float` | Vertical coordinate of the bottom edge of the rectangle in pixels. |

#### Return Value

This function does not return a value. It draws a rectangle onto the canvas using the specified coordinates.

### Rectangle(x1, y1, x2, y2, r)

Draws an axis-aligned rectangle with uniformly rounded corners using the current drawing style.

The rectangle is defined by its top-left and bottom-right corners, with all four corners rounded by the same radius. The rounding radius is applied equally in both the horizontal and vertical directions. As with other shape primitives, the rectangle can be rendered as either an outline or a filled shape depending on the current paint style.

This function is useful for drawing panels, buttons, or stimuli that require softened edges rather than sharp corners.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `x1` | `float` | Horizontal coordinate of the left edge of the rectangle in pixels. |
| `y1` | `float` | Vertical coordinate of the top edge of the rectangle in pixels. |
| `x2` | `float` | Horizontal coordinate of the right edge of the rectangle in pixels. |
| `y2` | `float` | Vertical coordinate of the bottom edge of the rectangle in pixels. |
| `r`  | `float` | Corner radius in pixels, applied uniformly to all corners. |

#### Return Value

This function does not return a value. It draws a rounded rectangle onto the canvas.

### Rectangle(x1, y1, x2, y2, rx, ry)

Draws an axis-aligned rectangle with independently rounded corners in the horizontal and vertical directions using the current drawing style.

The rectangle is defined by its top-left and bottom-right corners. The corner rounding is specified separately for the horizontal (`rx`) and vertical (`ry`) radii, allowing for elliptical corner shapes. Depending on the current paint style, the rectangle is rendered as either a filled shape or an outlined shape.

This function is useful when fine control over corner curvature is required, such as creating pill-shaped elements or rectangles with non-uniform rounding.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `x1` | `float` | Horizontal coordinate of the left edge of the rectangle in pixels. |
| `y1` | `float` | Vertical coordinate of the top edge of the rectangle in pixels. |
| `x2` | `float` | Horizontal coordinate of the right edge of the rectangle in pixels. |
| `y2` | `float` | Vertical coordinate of the bottom edge of the rectangle in pixels. |
| `rx` | `float` | Horizontal corner radius in pixels. |
| `ry` | `float` | Vertical corner radius in pixels. |

#### Return Value

This function does not return a value. It draws a rounded rectangle with independent corner radii onto the canvas.


### Sprite(x, y, sprite)

Draws a bitmap image (sprite) onto the canvas at the specified position, using the current horizontal and vertical alignment settings.

The sprite is provided as raw image data and decoded internally into a bitmap before rendering. The final on-canvas position is computed using the current text alignment (`AlignLeft`, `AlignCenter`, `AlignRight`) for horizontal placement and the current vertical alignment (`AlignTop`, `AlignMiddle`, `AlignBottom`) for vertical placement.

This allows sprites to be positioned semantically (e.g. centered on a point, aligned by their top edge, or anchored by their bottom edge) without manual coordinate adjustment. This behavior mirrors text alignment, enabling consistent layout logic for mixed text-and-image stimuli.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `x` | `float` | Reference x-coordinate in pixels. Its interpretation depends on the current horizontal alignment. |
| `y` | `float` | Reference y-coordinate in pixels. Its interpretation depends on the current vertical alignment. |
| `sprite` | `byte[]` | Encoded PNG image data representing the sprite to be drawn. |

#### Return Value

This function does not return a value. It draws the sprite bitmap onto the canvas at the computed position.

## Text functions

The text functions of `ImageCanvas` provide precise control over text measurement and rendering, enabling text to be used as a first-class visual element in LabBench stimuli. These functions support both standard text placement and advanced layouts such as text following arbitrary paths. In `ImageCanvas`, text is treated as geometry rather than annotation. Font selection, size, alignment, and stroke/fill style all influence how text occupies space on the canvas. Text functions expose measurement utilities (such as text width and height) so that text can be positioned and combined with other graphical elements in a deterministic and reproducible way.

Unlike shapes and sprites, text is rendered relative to a **baseline**, not a bounding box. The text functions handle this internally by translating semantic alignment choices (top, middle, bottom) into correct baseline positions using font metrics. This design allows protocol code to reason about text placement using intuitive reference points without manual metric calculations.

Text measurement functions do not produce visual output; instead, they provide the information required for layout and alignment. Rendering functions consume this information and apply the current canvas state to draw text in the correct position. This separation enables robust stimulus construction, allowing layout decisions to be made explicitly and verified programmatically.

In addition to standard text placement, text can be rendered along arbitrary paths. This method supports curved labels, trajectory-aligned annotations, and stimuli where text must follow non-linear geometry, all while respecting the same font, alignment, and styling rules.

### TextWidth(text)

Computes and returns the horizontal width of the specified text string using the current font and text size.

The measured width reflects how much horizontal space the text will occupy when rendered with the current typeface, text size, and paint configuration. This function does not draw anything; it is intended for layout calculations, alignment, and dynamic positioning of text relative to other visual elements.

The result is particularly useful when manually spacing labels, centering text, or placing graphical elements relative to text extents.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `text` | `str` | The text string whose rendered width should be measured. |

#### Return Value

Returns a `float` representing the width of the rendered text in pixels, using the current font and text size.

### GetTextY(y)

Computes the baseline-adjusted y-coordinate for text rendering based on the current vertical alignment setting.

Text in Skia is positioned relative to its **baseline**, not its bounding box. This function converts a semantically meaningful reference position into the correct baseline position so that text appears top-aligned, center-aligned, or bottom-aligned as intended.

It is used internally by text drawing functions, but is exposed to allow advanced users to perform precise text layout calculations when mixing text with other graphical elements.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `y` | `float` | Reference y-coordinate in pixels, interpreted according to the current vertical alignment. |

#### Return Value

Returns a `float` representing the baseline y-coordinate that should be used when rendering text so that it respects the current vertical alignment.

### Write(x, y, text, solid = true)

Renders a text string onto the canvas at the specified position using the current text and style settings.

The text is drawn using the currently selected font, text size, color, and alignment. Horizontal alignment affects how the x-coordinate is interpreted, while vertical alignment determines how the y-coordinate is mapped to the text baseline. The function automatically performs the necessary baseline adjustment to ensure correct vertical positioning.

The `solid` parameter temporarily overrides the current paint style, allowing text to be drawn either as filled glyphs or as stroked outlines without permanently changing the canvas state.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `x` | `float` | Reference x-coordinate in pixels. Its interpretation depends on the current horizontal text alignment. |
| `y` | `float` | Reference y-coordinate in pixels. Its interpretation depends on the current vertical alignment. |
| `text` | `str` | The text string to render. |
| `solid` | `bool` | If `true`, text is rendered as filled glyphs. If `false`, text is rendered as stroked outlines using the current stroke settings. |

#### Return Value

This function does not return a value. It draws the specified text onto the canvas.

### Write(path, x, y, text, solid = true)

Renders a text string along a predefined path using the current text and style settings.

The text glyphs are laid out following the geometry of the provided `ImagePath`, allowing text to curve, follow trajectories, or align with complex shapes. The `x` parameter specifies an offset along the path, while the vertical alignment setting is used to compute the appropriate baseline offset from the path.

As with standard text rendering, the `solid` parameter temporarily overrides the current paint style so that text can be drawn as filled glyphs or stroked outlines without altering the persistent canvas state.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| `path` | `ImagePath` | Path object that defines the trajectory along which the text is rendered. |
| `x` | `float` | Horizontal offset along the path in pixels, controlling where the text begins. |
| `y` | `float` | Vertical offset relative to the path, interpreted according to the current vertical alignment. |
| `text` | `str` | The text string to render along the path. |
| `solid` | `bool` | If `true`, text is rendered as filled glyphs. If `false`, text is rendered as stroked outlines using the current stroke settings. |

#### Return Value

This function does not return a value. It draws the specified text along the given path onto the canvas.
