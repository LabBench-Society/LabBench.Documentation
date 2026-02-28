---
title: "LabBench SOUND"
description: "Setup of sound cards."
weight: 5
---

{{% pageinfo %}}
Soundcards in LabBench enable precise generation of audio signals, making them suitable for a wide range of auditory, psychophysical, and neurophysiological experiments. By leveraging low-latency playback, multi-channel audio, and tight synchronisation with other LabBench devices. 
{{% /pageinfo %}}

The a soundcard is included in experimental setups with an `<sound>` element:

```xml
<sound id="sound" />
```

**Attributes:**

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to procedures in the protocol.</p>|
