---
title: Image
description: Toolkit for manipulating and creating images.
weight: 20
---

{{% pageinfo %}}

Images are an integral part of numerous protocols, for example, providing instructions to operators or are used as visual stimuli in experimental procedures such as Stroop, Flanker, or Stop-Signal Tasks. Images can either be included as file assets in protocols or be created programmatically. 

{{% /pageinfo %}}

The Image toolkit can be accessed from Python scripts as `tc.Image` and can be used to create either an `ImageCanvas` or `ImageEngine`. An ImageCanvas is used to create images programmatically with drawing primitives, such as drawing a pixel, line, or shape. An `ImageEngine` is used to manipulate an existing image by changing pixels based on a pixel mask and colours.

## Creating an ImageCanvas

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

## Creating an ImageEngine

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

### `ImageEngine GetImageEngine(byte[] image)`


### `ImageCanvas GetCanvas(IImageDisplay display, string colour)`

### `ImageCanvas GetCanvas(int width, int heigth, string colour)`

### `ImageCanvas GetCanvas(byte[] image)`
