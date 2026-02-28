---
title: "LabBench CPAR+"
description: "Setup of LabBench CPAR+ devices."
linkTitle: "LabBench CPAR+"
weight: 2
---

{{% pageinfo %}}

The **LabBench CPAR+** is a computer-controlled cuff pressure algometer that delivers precise, reproducible pressure stimulation for neuroscience research. It generates customisable piecewise-linear pressure waveforms with accurate temporal control, supporting advanced psychophysical protocols. The device enables automated cuff pressure algometry protocols that are not feasible with manual devices.

{{% /pageinfo %}}

The LabBench CPAR+ device is included in experimental setups with an `<cparplus>` element:

```xml

```

**Attributes:**

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to procedures in the protocol.</p>|
|<p>rating-scale</p>|<p>optional</p>|<p>Identification of an optional external rating scale to use with the LabBench CPAR+ [ string ]. If it is not specified or left blank the device will use the rating scale connected to its response port.</p>|
|<p>button</p>|<p>optional</p>|<p>Identification of an optional external button to use with the LabBench CPAR+ [ string ]. If it is not specified or left blank the device will use the rating scale connected to its response port.</p>|
