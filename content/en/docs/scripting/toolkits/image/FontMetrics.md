---
title: Font Metrics
description: Information about the currenty selected font
weight: 40
---

`FontMetrics` provides detailed, read-only measurements describing the vertical geometry of the currently active font on an `ImageCanvas`. These metrics define how text is positioned relative to its baseline and how much vertical space glyphs occupy above and below it.

The metrics reflect the currently selected font and text size and are updated automatically whenever font-related properties change. They are primarily used for precise text layout, vertical alignment, and advanced positioning scenarios where semantic alignment alone is not sufficient.

Text rendering is fundamentally **baseline-based**. Rather than being positioned by a bounding box, glyphs extend upward and downward from a baseline. `FontMetrics` exposes the numerical values that describe these extents, allowing text to be aligned consistently with other graphical elements such as shapes and sprites.

These metrics are beneficial when:
- Computing exact text height
- Aligning text to geometric features
- Implementing custom layout logic
- Ensuring consistent spacing across different fonts or sizes

## FontMetrics Properties

| Property | Type | Description |
|--------|------|-------------|
| `Ascent` | `float` | Vertical distance from the baseline to the highest point of typical glyphs. This value is usually negative, indicating upward extension from the baseline. |
| `Descent` | `float` | Vertical distance from the baseline to the lowest point of glyphs that extend downward. This value is usually positive. |
| `Top` | `float` | Maximum vertical extent above the baseline, including extra spacing beyond typical glyph shapes. |
| `Bottom` | `float` | Maximum vertical extent below the baseline, including extra spacing beyond typical glyph shapes. |
| `Leading` | `float` | Recommended additional vertical spacing between consecutive lines of text. |

---

## Common Derived Quantities

Although not provided directly, the following values are frequently computed from font metrics:

| Property | Calculation |
|----------|-------------|
| TextHeight | `height = Descent - Ascent` |
| FullVerticalBounds | `bounds = Bottom - Top` |


These quantities are used internally by `ImageCanvas` for vertical alignment and are useful for custom layout logic.

---

## Example Usage in Python

```python
canvas.Font("Default")
canvas.TextSize(24)

metrics = canvas.FontMetrics

text_height = metrics.Descent - metrics.Ascent
baseline_offset = -metrics.Ascent
```
