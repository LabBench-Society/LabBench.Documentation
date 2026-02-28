---
title: "Nocitech CPAR"
description: "Setup of the Nocitech CPAR device for cuff pressure algometry."
linkTitle: "Nocitech CPAR"
weight: 300
---

{{% pageinfo %}}

The **Nocitech CPAR** is a computer-controlled cuff pressure algometer that delivers precise, reproducible pressure stimulation for neuroscience research. It generates customisable piecewise-linear pressure waveforms with accurate temporal control, supporting advanced psychophysical protocols. The device enables automated cuff pressure algometry protocols that are not feasible with manual devices.

{{% /pageinfo %}}

The Nocitech CPAR device is included in experimental setups with an `<cpar>` element:


```xml

```

**Attributes:**

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to procedures in the protocol.</p>|
|<p>compressor-mode</p>|<p>optional</p>|<p>Control mode for the compressor; AUTO: The compressor will refill automatically after each procedure in the protocol, MANUAL: The compressor will only refill when the minimal working pressure has been reached:</p> <ul> <li><strong>auto</strong>: the compressor will refill automatically after each procedure in the protocol.</li> <li><strong>manual</strong>: the compressor will only refill when the minimal working pressure has been reached.</li> </ul>|
