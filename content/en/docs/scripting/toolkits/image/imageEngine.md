---
title: Image Engine
description: Pixel based alterations of images.
weight: 20
---

{{% pageinfo %}}


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

