---
title: "LabBench JOYSTICK"
description: "Setup of joysticks/gamepads."
weight: 6
---

{{% pageinfo %}}

This `<joystick>` is a standard Joystick USB device used for tasks like answering questionnaires and making ratings.
It supports different button setups, each marked by its experiment ID. The button setup changes depending
on the chosen procedure. 

{{% /pageinfo %}}

The device implements the Button, Joystick, and Trigger instruments. The Trigger instrument is a dummy
implementation with no functionality, implemented by the device, so it can act as a procedure device for protocols
that would otherwise require a LabBench I/O device, or be used to create protocols that can be used with
both a Joystick and a LabBench I/O device.

The LabBench JOYSTICK is included in experimental setups with an `<joystick>` element:

```xml
<joystick id="joystick">
    <map>
        <button-assignment code="16" button="decrease" label="Decrease rating" />
        <button-assignment code="32" button="increase" label="Increase rating"/>
        <button-assignment code="2" button="previous" label="Previous scale"/>
        <button-assignment code="4" button="next" label="Next scare"/>
    </map>
    <map experimental-setup-id="questionnaire">
        <button-assignment code="1" button="left" label="Left" />
        <button-assignment code="2" button="up" label="Up" />
        <button-assignment code="4" button="down" label="Down" />
        <button-assignment code="8" button="right" label="Rigt" />
        <button-assignment code="16" button="decrease" label="Decrease" />
        <button-assignment code="32" button="increase" label="Increase" />
        <button-assignment code="64" button="previous" label="Previous" />
        <button-assignment code="128" button="next" label="Next" />
    </map>
</joystick>
```

**Attributes:**

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to procedures in the protocol.</p>|
