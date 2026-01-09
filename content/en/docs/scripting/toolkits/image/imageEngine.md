---
title: Image Engine
description: Pixel based alterations of images.
weight: 20
---

{{% pageinfo %}}
The `ImageEngine` class provides a fluent, in-memory image processing pipeline for modifying bitmap images using masks, color transformations, and compositing operations. It allows loading an image, selectively replacing or isolating colors, overlaying additional images, and finally exporting the result as a LabBench image asset, all while operating directly on pixel data for efficient, repeatable transformations.
{{% /pageinfo %}}

An `ImageEngine` is created with the `GetImageEngine(image)` function in the `Image` toolkit. In the example below, two `ImageEngine` objects are created; one in the constructor `__init__` of the `TimeSlotInstruction` class that creates image masks that can later be used to replace colors in the image, and one in the `Generate()` function which is used to inform the operator where to apply a cream and where to perform an assessment:

```python
class TimeSlotInstruction:
   def __init__(self, tc):
      self.tc = tc
      self.AreaPreparation = self.tc.Assets.Sequence.AreaPreparation
      imageEngine = tc.Image.GetImageEngine(self.AreaPreparation) # ImageEngine creation
      self.locationMasks = [imageEngine.CreateMask(self.AreaPreparation, color) for color in GetLocationColors()]

   def Generate(self, applicationSite, testSite):
      imageEngine = self.tc.Image.GetImageEngine(self.AreaPreparation) # ImageEngine creation
      markerColors = ["#FFFFFF", "#FFFFFF", "#FFFFFF", "#FFFFFF"]

      if applicationSite >= 0:
         markerColors[int(self.tc.LocationSequence[applicationSite])] = "#4472C4"
      if testSite >= 0:
         markerColors[int(self.tc.LocationSequence[testSite])] = "#FF0000"

      imageEngine.ReplaceColor(self.locationMasks, markerColors)

      return imageEngine.GetImageAsset()    
```

This is an example, where the the `ImageEngine` class is used to create instructions to the operator at runtime to perform automatic randomization of an experiment.

## Functions

### CreateMask(image, color)

Creates a reusable pixel mask from an image by identifying all pixels that match a specified color.

This function analyzes the provided image and builds an `ImageMask` where each pixel is marked as either matching or not matching the given color. The resulting mask can be reused with other image operations, such as color replacement, to efficiently apply transformations only to selected pixels.

Internally, the image data is decoded into a bitmap and cached, and the mask itself may also be cached for performance when the same image and color combination is used multiple times.

#### Parameters

| Name  | Type    | Description |
|------|---------|-------------|
| `image` | `bytes` | PNG-encoded image data from which the mask will be created. The image is decoded and analyzed pixel by pixel. |
| `color` | `string`   | Color to match when creating the mask, specified as a string (for example, `"#FF0000"`). Only pixels exactly matching this color will be included in the mask. |

#### Return Value

Returns an `ImageMask` instance representing all pixels in the image that match the specified color. This mask can be passed to other image processing functions, such as color replacement, to selectively modify the image.

### ReplaceColor(masks, newColor)

Replaces multiple colors in the image by applying a set of precomputed masks with corresponding replacement colors.

This function iterates over a collection of `ImageMask` objects and replaces the pixels selected by each mask with a new color. Each mask is paired positionally with a color from the `newColor` collection, allowing multiple independent color substitutions to be applied in a single operation.

All replacements are performed on the underlying image managed by the `ImageEngine`. The operation is cumulative and modifies the current image state. The function returns the same `ImageEngine` instance to support fluent chaining of image operations.

An exception is thrown if the number of masks does not exactly match the number of replacement colors.

#### Parameters

| Name      | Type                     | Description |
|-----------|--------------------------|-------------|
| `masks`     | `IEnumerable<ImageMask>` | A collection of image masks defining which pixels should be replaced for each operation. Each mask must be compatible with the image dimensions. |
| `newColor`  | `IEnumerable<string>`    | A collection of colors, specified as strings (for example, `"#00FF00"`), used to replace the pixels selected by the corresponding mask. |

#### Return Value

Returns the current `ImageEngine` instance after all color replacements have been applied, enabling method chaining.

### ReplaceColor(mask, newColor)

Replaces a specific color region in the image using a single precomputed mask.

This function applies an `ImageMask` to the current image and replaces all pixels selected by the mask with a new color. The mask defines exactly which pixels are affected, allowing precise and efficient color substitution without re-analyzing the image content.

The operation modifies the image managed by the `ImageEngine` in place and returns the same instance, making it suitable for fluent chaining with other image processing functions.

#### Parameters

| Name     | Type        | Description |
|----------|-------------|-------------|
| `mask`     | `ImageMask` | A precomputed image mask that selects the pixels to be replaced. The mask must be compatible with the image dimensions. |
| `newColor` | `str`       | The replacement color, specified as a string (for example, `"#0000FF"`). All pixels selected by the mask will be set to this color. |

#### Return Value

Returns the current `ImageEngine` instance after the color replacement has been applied, enabling method chaining.

### KeepColor(color)

Preserves a single color in the image and makes all other pixels transparent.

This function scans the entire image and retains only the pixels that exactly match the specified color. All other pixels are replaced with transparency, effectively isolating the chosen color into its own layer. This is useful for masking, segmentation, or extracting specific visual elements from an image.

The operation modifies the image managed by the `ImageEngine` in place and returns the same instance to support fluent chaining with other image processing operations.

#### Parameters

| Name  | Type  | Description |
|-------|-------|-------------|
| `color` | `str` | The color to preserve, specified as a string (for example, `"#FFFFFF"`). Only pixels matching this color will remain visible; all others will become transparent. |

#### Return Value

Returns the current `ImageEngine` instance after non-matching pixels have been made transparent, enabling method chaining.

### AddImage(data)

Overlays another image onto the current image using alpha-aware pixel replacement.

This function decodes the provided image data and composites it onto the image managed by the `ImageEngine`. For each pixel, non-transparent pixels from the added image replace the corresponding pixels in the current image, while transparent pixels are ignored. This makes it suitable for layering sprites, icons, or annotations on top of an existing image.

The operation modifies the current image in place and returns the same `ImageEngine` instance, allowing fluent chaining with other image processing functions.

#### Parameters

| Name | Type    | Description |
|------|---------|-------------|
| `data` | `bytes` | PNG-encoded image data to be added on top of the current image. The image must have the same dimensions as the target image. |

#### Return Value

Returns the current `ImageEngine` instance after the image has been composited, enabling method chaining.

### GetImageAsset()

Creates an image asset from the current image state.

This function encodes the current image managed by the `ImageEngine` into a PNG image and wraps it in a `MemoryImageAsset`. The resulting asset can be passed directly to LabBench components that operate on image assets, such as storage, caching, or display systems.

Calling this function does not modify the image and can be used at any point to capture the current result of a sequence of image operations.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

#### Return Value

Returns an `IAsset` instance containing the PNG-encoded image data representing the current image.
