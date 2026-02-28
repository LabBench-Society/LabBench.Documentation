---
title: Experimental Setups
description: Information on how to define experimental setups.
weight: 10
---

{{% pageinfo %}}

Experimental setups are collections of research devices used to perform a study. These can include, for example, stimulators, displays, and psychophysical rating devices that implement the abstract instruments used by the procedures in a LabBench protocol.

{{% /pageinfo %}}

## Instruments 

Instruments are used in a protocol to carry out experimental procedures. Instruments are abstractions of the functionality provided by research devices, defining the capabilities of a generalised class of devices. Each instrument is given a name by the test requiring it, which is used to assign a device that implements the interface.

For example, for a stimulus-response test in cuff pressure algometry, you will need an `IPressureAlgometer` and an `IRatioScale` instrument. The `IPressureAlgometer` is used in the stimulus-response test to provide a linearly increasing pressure. At the same time, the `IRatioScale` instrument allows the subject to rate the pain and stop the stimulation when the Pain Tolerance Threshold (PTT) is reached. However, the IPressureAlgometer is not tied to a specific pressure algometry device; instead, it defines what LabBench expects all pressure algometers to be capable of. Today, the IPressureAlgometer instrument is implemented by two pressure algometers: the Nocitech CPAR and LabBench CPAR+ devices. 

## Devices

Instruments are typically implemented across multiple devices, and a single research device typically implements multiple instruments. For example, an `IRatioScale` instrument is built into both Nocitech CPAR and LabBench CPAR+, as well as LabBench I/O devices. Consequently, for cuff pressure algometry tests, you do not need a separate device providing the `IRatioScale` instrument because this is built into and provided by these devices in addition to the `IPressureAlgometer` instrument that is the primary function of the Nocitech CPAR and LabBench CPAR+ devices.

Currently, LabBench supports the following devices:

| Device            | Description                                       | Instruments |
|-------------------|---------------------------------------------------|-------------|
| `<lio>`           | <p><span style="white-space: nowrap;">[LabBench I/O](docs/experiments/setup/lio/)</span></p> | IStimulator, ITriggerGenerator, IScales, IButton, IRatioScale, ITriggerDetector |
| `<cparplus>`      | <p><span style="white-space: nowrap;">[LabBench CPAR+](docs/experiments/setup/cparplus/)</span></p> | IPressureAlgometer, IButton, IRatioScale, IScales |
| `<sound>`         | <p><span style="white-space: nowrap;">[LabBench SOUND](docs/experiments/setup/sound/)</span></p> | IStimulator, ISoundPlayer |
| `<joystick>`      | <p><span style="white-space: nowrap;">[LabBench JOYSTICK](docs/experiments/setup/joystick/) </span></p>| IButton, IJoystick, `*`ITriggerGenerator |
| `<display>`       | <p><span style="white-space: nowrap;">[LabBench DISPLAY](docs/experiments/setup/display/)</span></p> | IDisplay, IRatioScale, IIntervalScale, IOrdinalScale, IImageDisplay, IScales, IQuestionnaire |
| `<cpar>`          | <p><span style="white-space: nowrap;">[Nocitech CPAR](docs/experiments/setup/cpar/)</span></p> | IPressureAlgometer, IButton, IRatioScale, IScales |

`*` Dummy implementation, no actual functionality provided.


## Experimental Setup Variants

Experiment Definition Files include a mechanism called experimental setup variants, which allows multiple functionally equivalent experimental setups to be defined within a single Experiment Definition File. As long as each setup provides the required instruments for the experimental procedures in the protocol, these setups can be used interchangeably. 

Below is a code listing that demonstrates how multiple experimental setups can be defined in an Experiment Definition File:

```xml
<experimental-setup-variants default="CPARPlus">
    <experimental-setup name="LabBench CPAR+" id="CPARPlus">
        <!-- Content omited for brevity -->
    </experimental-setup>        
    <experimental-setup name="Nocitech CPAR" id="CPAR">
        <!-- Content omited for brevity -->
    </experimental-setup>        
</experimental-setup-variants>
```

Each experimental setup is identified by a name (e.g., `name="LabBench CPAR+"`) and an ID (e.g., `id="CPARPlus"`). The name identifies the setup in LabBench Designer, while the ID identifies the setup within the Experimental Definition File and the data sets for experiments. One of these setups is the default selected when an experiment is created and will be used if the experiment is stored remotely in its repository. This default setup is defined by the `default="CPARPlus"` attribute on the `<experimental-setup-variants>` element.

While an Experiment Definition File can contain multiple experimental setups, only one can be used for an experiment. When an experiment is created from an Experiment Definition File, you must choose one specific experimental setup to use for that experiment, as it is assumed and not advised to change the experimental setup during an experiment.

## Experimental Setups

Each device setup is defined with an `<experimental-setup>` element, as shown in the code listing below:

```xml
<experimental-setup name="LabBench CPAR+" id="CPARPlus">
    <devices>
        <!--  Research devices used in the experimental setup -->
    </devices>
    <device-mapping>
        <!--  Assignment of devices to instruments required by the tests in the protocol -->
    </device-mapping>
</experimental-setup>
```

### Definition of devices 

The `<devices>` element lists the devices required for the experiment. It specifies their configuration, whereas the `<device-mapping>` assigns these devices to the instruments that are required for each test. All devices required by a protocol must be listed in the `<devices>` element. The devices listed in the `<devices>` elements are assigned an ID used to identify them when they are mapped in the `<device-mapping>` element to the Instruments required by tests.

The Experiment Definition File does not, however, specify the actual physical devices that are in your laboratory. The reason is that the same experiment may be performed at multiple sites, and consequently, the Experiment Definition File cannot know which devices are present. Instead, when an experiment is added to a test site, LabBench Designer assigns physical devices to the devices in the `<devices>` element.

### Device assignments

The `<devices>` elements specify and configure the research devices used in the experiment, but they do not assign these devices to the instruments required by the protocol's tests. These assignments are done by the `<device-mapping>` element, which maps devices to the required instruments using `<device-assignment>` elements. 

Each device assigned to an Instrument required by a procedure must implement the required Instrument for that name. Assigning a device that does not implement the required Instrument will result in an error that will prevent the experiment from being run by the LabBench interpreter.

The general form of a `<device-mapping>` element is shown below:

```xml
<device-mapping>
    <device-assignment 
        instrument-name="[Required: name of the instrument assigned by tests in the protocol]" 
        device-id="[Required: ID of the device from the <devices> element]" 
        procedure-id="[Optional: ID of the test to assign the device]"/>
</device-mapping>
```

The `instrument-name` attribute is the name of the required instrument assigned by one or more procedures in the protocol. Unless explicitly specified in the protocol, the name of the Instrument is the Instrument name with the initial `I` removed. The `device-id` attribute is the ID of the device from the `<devices>` element to assign to the instrument name. 

The optional `procedure-id` specifies which tests in the protocol the device is assigned to. The `test-id` can either be a literal test identifier in the protocol or a regular expression. If it is a regular expression, the device will be assigned to all procedures whose identifier matches it. Use the `match:` keyword to specify that the `procedure-id` is a regular expression.
                                                     |
Below is an example of simple device assignments to instruments required by tests in a protocol:

```xml
<device-mapping>
    <device-assignment instrument-name="ImageDisplay" device-id="display.image" />
    <device-assignment instrument-name="PressureAlgometer" device-id="cpar" /> 
</device-mapping>
```

You may note from the listing above that two of the assigned devices are identified by `[root device].[sub device]`. Devices may have sub-devices – in this example, the display device has a sub-device `IImageDisplay` device (`id = “image”`). 

The simple mapping of a given device to all tests of a given type is possible for experiments with only one device implementing a given instrument. However, there are experiments where this simple mapping breaks down and cannot be used. 

One example of a protocol that requires a more specific mapping is an experiment where both auditory and electrical thresholds need to be determined with a `<psychophysics-threshold-estimation>` procedure that requires an `IStimulator` instrument named Stimulator to be assigned. The code below illustrates how such a device assignment can be implemented if all auditory tests have Auditory in their IDs and all electrical tests have Electrical in their IDs:

```xml
<device-mapping>   
    <device-assignment procedure-id="match: Auditory"
                       instrument-name="Stimulator"
                       device-id="sound" />
    <device-assignment procedure-id="match: Electrical"
                       instrument-name="Stimulator"
                       device-id="lio" />

    <!--  Other required mapping has been omitted for brevity -->                       
</device-mapping>
```