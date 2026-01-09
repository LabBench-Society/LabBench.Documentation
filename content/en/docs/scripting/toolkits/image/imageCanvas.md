---
title: Image Canvas
description: A drawing canvas for creating images.
weight: 10
---

{{% pageinfo %}}


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

### `byte[] GetImage()`

### `IAsset GetAsset()`

## Style functions

### `void RoundStrokeCap()`

### `void SquareStrokeCap()`

### `void ButtStrokeCap()`

### `void Color(string color)`

### `void StrokeWidth(double width)`

### `void Fill(bool fill)`

### `void Font(string name)`

### `void TextSize(float size)`

### `void AlignLeft()`

### `void AlignCenter()`

### `void AlignRight()`

### `void AlignTop()`

### `void AlignMiddle()`

### `void AlignBottom()`

## Drawing functions

### `ImagePath CreatePath()`

### `void Draw(ImagePath path)`

### `void Point(double x, double y)`

### `void Line(double x1, double y1, double x2, double y2)`

### `void Circle(double x, double y, double r)`

### `void Rectangle(double x1, double y1, double x2, double y2)`

### `void Rectangle(double x1, double y1, double x2, double y2, double r)`

### `void Rectangle(double x1, double y1, double x2, double y2, double rx, double ry)`

### `void Sprite(double x, double y, byte[] sprite)`

## Text functions

### `double TextWidth(string text)`

### `float GetTextY(double y)`

### `void Write(double x, double y, string text, bool solid = true)`

### `void Write(ImagePath path, double x, double y, string text, bool solid = true)`