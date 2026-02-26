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

## Trigger Setup

```xml
<trigger-setup logic-system="positive" 
    high-byte-voltage-level="unconnected" 
    low-byte-voltage-level="unconnected"/>
```

## Stimulators

### Digitimer DS5

```xml
<ds5 name="DS5" transconductance="1mA_1V"/>
```

### NoxiSTIM

```xml
<noxistim name="NoxiSTIM" transconductance="1mA_1V"/>
```


## Response Devices

```xml
<device-name id="[Device ID]" timing-source="internal">
    <!-- Device specific elements -->
</device-name>
```

Timing sources:

| Source | Function |
|--------|----------|
| none   |  |
| 

### LabBench BUTTON

```xml
<button id="button" timing-source="internal">
    <map>
        <button-assignment code="1" button="button-01" label="Button 01" />
    </map>
</button>
```

### LabBench PAD

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

### LabBench SCALE

```xml
<visual-analogue-scale id="scale"
    length="10"
    sample-period="200"
    timing-source="none" />
```

### LabBench VTG

```xml
<visual-trigger id="vtg"                        
    timing-source="internal" 
    arming-period="200"/>
```

### LabBench ATG

```xml
<audio-trigger id="atg"                        
    timing-source="internal" 
    arming-period="200" />
```


