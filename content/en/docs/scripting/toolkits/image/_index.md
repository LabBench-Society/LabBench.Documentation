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


```python


```

## Creating an ImageEngine

```python


```


## Functions

### `ImageEngine GetImageEngine(byte[] image)`


### `ImageCanvas GetCanvas(IImageDisplay display, string colour)`

### `ImageCanvas GetCanvas(int width, int heigth, string colour)`

### `ImageCanvas GetCanvas(byte[] image)`
