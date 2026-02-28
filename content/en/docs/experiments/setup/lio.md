---
title: "LabBench I/O"
description: "Setup of LabBench I/O devices."
linkTitle: "LabBench I/O"
weight: 1
---

{{% pageinfo %}}

The LabBench I/O device serves as a central hub for experiments requiring precise coordination of stimulation, participant responses, and external equipment. It supports flexible experimental designs by integrating digital and analogue signaling for stimulus generation and response collection.

{{% /pageinfo %}}

The LabBench I/O device is included in experimental setups with an `<lio>` element:

```xml
<lio id="lio" default-analogue-output="0">
    <trigger-setup logic-system="positive" 
                    high-byte-voltage-level="unconnected" 
                    low-byte-voltage-level="unconnected"/>
    <stimulators>                  
        <!-- Stimulator definition -->
    </stimulators>
    <response-devices>
        <!-- Definition of response devices -->
    </response-devices>
</lio>
```

**Attributes**:


| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to procedures in the protocol.</p>|
|<p>default-analogue-output</p>|<p>optional</p>|<p>Voltage output on the STIMULATOR A when the device is idle [ double ]. This voltage must be between -10V and 10V.</p>|

## Trigger Setup

Defines how digital trigger signals generated on the INTERFACE port are electrically and logically configured, specifying whether triggers use positive or negative logic and which voltage levels are driven on the high and low bytes, allowing the LabBench I/O device to be matched to the electrical requirements of connected external equipment.

```xml
<trigger-setup logic-system="positive" 
    high-byte-voltage-level="unconnected" 
    low-byte-voltage-level="unconnected"/>
```

**Attributes**:

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>logic-system</p>|<p>required</p>|<p>Specifies the logic convention used when generating digital triggers with the INTERFACE port. In <strong>positive logic</strong>, a high voltage represents the active or true state, whereas in <strong>negative logic</strong>, a low voltage represents the active or true state and the interpretation of high and low is inverted.</p>|
|<p>low-byte-voltage-level</p>|<p>required</p>|<p>Voltage level for the low-order byte.</p>|
|<p>high-byte-voltage-level</p>|<p>required</p>|<p>Voltage level for the high-order byte.</p>|

## Stimulators

Defines the external electrical stimulator controlled via the LabBench I/O device, specifying which stimulator hardware is connected and its initial current–voltage conversion setting, enabling LabBench to generate precisely timed and parameterized electrical stimulation as part of the experimental protocol.

### Digitimer DS5

The **Digitimer DS5** is a constant-current electrical stimulator widely used in neuroscience and psychophysics research to deliver precisely controlled electrical pulses to peripheral nerves or tissues, supporting reproducible stimulation across a wide range of experimental protocols.

```xml
<ds5 name="DS5" transconductance="1mA_1V"/>
```

**Attributes**:

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the equipment that will be used to identify it to the operator in the LabBench Runner.</p>|
|<p>transconductance</p>|<p>optional</p>|<p>Initial transconductance of the stimulator. This can be changed during runtime in LabBech Runner.</p>|


### NoxiSTIM

The **NoxiSTIM**</strong>** is an isolated, current-controlled electrical stimulator developed for research use.

```xml
<noxistim name="NoxiSTIM" transconductance="1mA_1V"/>
```

**Attributes**:

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the equipment that will be used to identify it to the operator in the LabBench Runner.</p>|
|<p>transconductance</p>|<p>optional</p>|<p>Initial transconductance of the stimulator. This can be changed during runtime in LabBech Runner.</p>|


## Response Devices

Defines the set of participant response and event-detection devices connected to the LabBench I/O device, including trigger detectors, buttons, response pads, and rating scales.

Up to two devices can be defined, corresponding to the two available response ports on the device.

Devices are assigned to response ports **in the order they are defined** within this element: the first device is connected to response port 1 and the second to response port 2. As a consequence, it is possible to occupy only response port 1 without using response port 2, but not the other way around.

```xml
<device-name id="[Device ID]" timing-source="internal">
    <!-- Device specific elements -->
</device-name>
```

**Attributes**:

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the response device [ string ]. This <code>id</code> must be unique.</p>|
|<p>timing-source</p>|<p>optional</p>|<p>Timing or trigger source:</p> <ul> <li><code>none</code>: no source is configured.</li> <li><code>internal</code>: the source is an internal opration such as start of a stimulus.</li> <li><code>external</code>: a trigger event is received from external equipment.</li> <li><code>button</code>: a trigger event is received from a button press on a connected response device attached to any response port.</li> <li><code>response-port01</code>: a trigger is received on response port 1.</li> <li><code>response-port02</code>: a trigger is received on response port 2.</li> <li><code>response-port03</code>: a trigger is received on response port 3.</li> <li><code>response-port04</code>: a trigger is received on response port 4.</li> </ul>|

### LabBench BUTTON

The **LabBench BUTTON** is a simple single-button response device used to collect discrete participant responses such as responses in yes/no response task. (e.g., for threshold estimation in perception threshold tracking).


```xml
<button id="button" timing-source="internal">
    <map>
        <button-assignment code="1" button="button-01" label="Button 01" />
    </map>
</button>
```

### LabBench PAD

The **LabBench PAD** is a configurable multi-button response device used for collecting discrete participant responses during experiments.

```xml
<response-pad id="pad" 
    timing-source="internal" 
    type="button-4-cross">
    <map experimental-setup-id="match: image|questionnaire">
        <button-assignment code="5" button="previous" label="previous"/> 
        <button-assignment code="6" button="next" label="next"/> 
        <button-assignment code="3" button="up" label="up" />
        <button-assignment code="1" button="down" label="down" />
        <button-assignment code="2" button="decrease" label="decrease" />
        <button-assignment code="4" button="increase" label="increase" />
    </map>  
</response-pad>
```

**Attributes**:

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>type</p>|<p>optional</p>|<p>Type of response pad</p>|

### LabBench SCALE

A visual analogue scale (VAS) represents a ratio scale along which observers report the perceived magnitude of a subjective sensation.
A ratio scale means that responses are defined on a continuum, with a true zero corresponding to the absence of the perceptual quantity,
and equal distances along the scale correspond to equal increments in perceived magnitude. As a consequence, ratios between values are
interpretable (e.g., a response at 60 can be meaningfully understood as twice the perceived intensity of a response at 30, under the
assumptions of the scale).

The scale is defined by a  modality and the lower and upper anchors of the perceptual dimension. The lower anchor denotes the null
intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality. The scale
is also defined by its physical length, typically 10cm.

```xml
<visual-analogue-scale id="scale"
    length="10"
    sample-period="200"
    timing-source="none" />
```

**Attributes**:

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>sample-period</p>|<p>optional</p>| Sampling period for sampling of the ratings. |
|<p>length</p>|<p>optional</p>|<p>Physical length of the scale in centimeters [ double ].</p>|

### LabBench VTG

Defines a **visual trigger detector (LabBench VTG)** that uses a photosensor to detect visual fiducials embedded in on-screen stimuli and generates precise trigger events when these fiducials are displayed. The arming period specifies a refractory interval to avoid multiple detections of the same visual event, while the timing source controls how detections are timestamped.

```xml
<visual-trigger id="vtg"                        
    timing-source="internal" 
    arming-period="200"/>
```

**Attributes**:

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>arming-period</p>|<p>optional</p>|<p>Refractory interval in milliseconds after each detection to prevent repeated triggering from the same event [ int ].</p>|

### LabBench ATG

Defines an **audio trigger detector (LabBench ATG)** that monitors an incoming audio signal and generates a precise trigger event when the signal exceeds a defined threshold. The arming period specifies a refractory interval after each detection to prevent repeated triggering from the same sound event, while the timing source determines how detected events are timestamped.

```xml
<audio-trigger id="atg"                        
    timing-source="internal" 
    arming-period="200" />
```

**Attributes**:

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>arming-period</p>|<p>optional</p>|<p>Refractory interval in milliseconds after each detection to prevent repeated triggering from the same event [ int ].</p>|

