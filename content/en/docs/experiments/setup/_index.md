---
title: Experimental Setups
description: Information on how to define experimental setups.
weight: 10
---

{{% pageinfo %}}

Experimental setups are the collection of research devices that are used to perform a study. These can consist of for example stimulators, displays, and psychophysical rating devices that implements the abstract instruments that are used by the procedures/tests in a LabBench protocol to run a study.

{{% /pageinfo %}}

## Instruments 

Instruments are used in a protocol for the tests to carry out experimental procedures. Instruments are abstractions of the functionality provided by research devices, defining the capabilities of a generalized class of devices. Each instrument is given a name by the test requiring it, which is used to assign a device to it that implements the interface.

For example, for a stimulus-response test in cuff pressure algometry, you will need an `IPressureAlgometer` and an `IRatioScale` instrument. The `IPressureAlgometer` is used in the stimulus-response test to provide a linearly increasing pressure. At the same time, the `IRatioScale` instrument allows the subject to rate the pain and stop the stimulation when the Pain Tolerance Threshold (PTT) is reached. However, the IPressureAlgometer is not tied to a specific pressure algometry device; instead, it defines what LabBench expects all pressure algometers to be capable of. Today, the IPressureAlgometer instrument is provided by two pressure algometers: the Nocitech CPAR and LabBench CPAR+ devices. 

Using Instruments in tests instead of concrete devices makes it easier to add new research devices to LabBench. For example, currently, there are two types of Cuff Pressure Algometry devices available, with the Nocitech CPAR devices predating the LabBench CPAR+. The CPAR+ offers better performance than the CPAR device and has a trigger system; however, the two devices are largely functionally equivalent. Consequently, in protocols that do not need the trigger system provided by the CPAR+ device, these two devices can be used interchangeably.

Without Instruments, there would have been two sets of identical tests, one set for the CPAR device and another set for the CPAR+ device. With Instruments, there is no need to implement a second identical set of tests for the CPAR+ device; all that was required for the CPAR+ device to be used in the tests that were initially intended for the CPAR device was to implement the `IPressureAlgometer` interface, which significantly reduced the amount of work required to add the new LabBench CPAR+ device to LabBench. 


## Devices

Instruments are typically implemented by multiple devices, and one research device typically implements multiple instruments. For example, an `IRatioScale` instrument is built into both Nocitech CPAR and LabBench CPAR+, as well as LabBench I/O devices. Consequently, for cuff pressure algometry tests, you do not need a separate device providing the `IRatioScale` instrument because this is built into and provided by these devices in addition to the `IPressureAlgometer` instrument that is the primary function of the Nocitech CPAR and LabBench CPAR+ devices.

Currently, LabBench supports the following devices:

| Device            | Description                                       | Instruments |
|-------------------|---------------------------------------------------|-------------|
| `<lio>`           | [LabBench I/O](docs/experiments/setup/lio/)       | IStimulator, ITriggerGenerator, IScales, IButton, IRatioScale, ITriggerDetector |
| `<cpar>`          | [Nocitech CPAR](docs/experiments/setup/cpar/)      | IPressureAlgometer, IButton, IRatioScale, IScales |
| `<cparplus>`      | [LabBench CPAR+](docs/experiments/setup/cparplus/)     | IPressureAlgometer, IButton, IRatioScale, IScales |
| `<daqmx>`         | [National Instrument DAQmx Cards](docs/experiments/setup/daqmx/)  | IStimulator, ISweepSampler, IButton |
| `<sound>`         | [Standard Soundcards](docs/experiments/setup/sound/)                               | IStimulator, ISoundPlayer |
| `<joystick>`      | [USB PC Joysticks/Gamepads](docs/experiments/setup/joystick/)                         | IButton, IJoystick, `*`ITriggerGenerator |
| `<tactor>`        | [Engineering Acoustics Universal Tactor Controller](docs/experiments/setup/tactor/) | IStimulator |
| `<tcs>`           | [QSTLab Thermal Cutaneous Stimulator](docs/experiments/setup/tcs/)               | IThermalStimulator, IButton, IStimulator, ISweepSampler |
| `<thermal-plate>` | [QSTLab Thermal Plate](docs/experiments/setup/thermal-plate/)                              | IThermalPlate |
| `<evas>`          | [QSTLab eVAS](docs/experiments/setup/evas/)                                       | IRatioScale, IScales, IButton |
| `<display>`       | [Secondary Computer Monitors](docs/experiments/setup/display/)                       | IDisplay, IRatioScale, IIntervalScale, IOrdinalScale, IImageDisplay, IScales, IQuestionnaire |

`*` Dummy implementation, no actual functionality provided.


## Experimental Setup Variants

Experiment Definition Files offer a mechanism called experimental setup variants, which allows multiple functionally equivalent experimental setups to be defined within the same Experiment Definition File. As long as each setup is capable of providing the required instruments for the experimental procedures/tests in the protocol, these setups can be used interchangeably. 

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

Each experimental setup is identified by a name (e.g., `name="LabBench CPAR+"`) and an ID (e.g., `id="CPARPlus"`). The name is used to identify the setup in LabBench Designer, while the ID identifies the setup within the Experimental Definition File and data sets for experiments. One of these setups is the default selected when an experiment is created and will be used if the experiment is stored remotely in its repository. This default setup is defined by the `default="CPARPlus"` attribute on the `<experimental-setup-variants>` element.

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

The `<devices>` element list which devices are required for the experiment and specifies their configuration, whereas the `<device-mapping>` assigns these devices to the instruments that are required for each test. All devices required by a protocol must be listed in the `<devices>` element. The devices listed in the `<devices>` elements is assigned an ID that is used to identify the device when they are mapped in the `<device-mapping>` element to the Instruments required by tests.

The Experiment Definition File does not, however, specify the actual physical devices that are in your laboratory. The reason for this is that the same experiment may be performed at multiple sites, and consequently, the Experiment Definition File cannot know which devices are present. Instead, when an experiment is added to a test site, physical devices are assigned by LabBench Designer to the devices in the `<devices>` element.

### Device assignments

The `<devices>` elements specify and configure the research devices that are used in the experiment, but it does not assign these devices to the instruments that are required by the tests in the protocol. These assignment are done by the `<device-mapping>` element, which is used to map devices to the required instruments with `<deive-assignment>` elements. 

Each device that is assigned to an Instrument, required by a test, must implement the required Instrument for that name. Assigning a device that does not implement the required Instrument will result in an error that will prevent the experiment from being run by the LabBench interpreter.

The general form of a `<device-mapping>` element is shown below:

```xml
<device-mapping>
    <device-assignment instrument-name="[Required: name of the instrument assigned by tests in the protocol]" 
                       device-id="[Required: ID of the device from the <devices> element]" 
                       test-type="[Optional: type of the test to assign the device]"
                       test-id="[Optional: ID of the test to assign the device]"/>
</device-mapping>
```

The `instrument-name` attribute is the name of the required instrument assigned by one or more tests in the protocol, which unless explicitly specified in the protocol is the name of the Instrument with the initial `I` removed. The `device-id` attribute is the ID of the device from the `<devices>` element to assign to the instrument name. The `test-type` and `test-id` is used to specify which tests in the protocol the device is assigned to based on the following lookup rules:

| `test-type` | `test-id`   | Assignment rule                                                                         |
|-------------|-------------|-----------------------------------------------------------------------------------------|
| Not present | Not present | Device assignment is used for all tests in a protocol regardless of their type and ID.  |
| Present     | Not present | Device assignment is used for all tests of `test-type` in a protocol.                   |
| Present     | Present     | Device assignment is used for all tests of `test-type` with ID `test-id` in a protocol. |
| Not present | Present     | Invalid, do not use.                                                                    |


Below is an example of simple device assignments to instruments required by tests in a protocol:

```xml
<device-mapping>
    <device-assignment instrument-name="ImageDisplay" device-id="display.image" />
    <device-assignment instrument-name="PressureAlgometer" device-id="cpar" /> 
</device-mapping>
```

You may note from listing above that two of the assigned devices is identified by `[root device].[sub device]`. Devices may have sub-devices – in this example, the display device has a subdevice `IImageDisplay` device (`id = “image”`). 

In the device mapping in listing above only the type of test is specified (test-type), which means that devices are assigned to all tests of a given type. This is possible because we have a relatively simple protocol where all tests of a given type are used for purposes that do not conflict with each other. 

The simple mapping of a given device to all tests of a given type is possible for experiments with only one device implementing a given instrument. However, there are experiments where this simple mapping breaks down and cannot be used. 

One example of a protocol that require a more specific mapping was an experiment where auditory and tactile sensitivity was determined for children living with autism. In that case, both the auditory and vibrotactile sensitivity was determined by the same type of test, a `<psychophysics-threshold-estimation>` test that requires an `IStimulator` instrument named Stimulator to be assigned. 

In the experiment, a sound card and an EA Tactor Device were used to study the auditory and vibrotactile sensitivity, respectively. Both devices implement the IStimulator instrument, and thus both can be used by the `<psychophysics-threshold-estimation>` tests to determine auditory and vibrotactile thresholds. However, since both thresholds are determined by the same type of test, assigning both devices to the Stimulator name would result in a conflict. For that situation, it is required to specify both a test-type and test-id on two <device-assignment> elements; one for the auditory and one for the vibrotactile threshold estimation. 

When a test-id is specified, the device will be assigned only to one specific test with the given test-id. With this mechanism it is possible to specify that the test for the auditory thresholds will be using the sound card and the test for the vibrotactile thresholds will be using the EA Tactor Device. The `<device-mapping>` elements for this mapping is shown below as an example:

```xml
<device-mapping>   
    <device-assignment test-type="psychophysics-threshold-estimation"
                       test-id="TA1"
                       instrument-name="Stimulator"
                       device-id="sound" />
    <device-assignment test-type="psychophysics-threshold-estimation"
                       test-id="TV1"
                       instrument-name="Stimulator"
                       device-id="tactor" />

    <!--  Other required mapping has been omitted for brevity -->                       
</device-mapping>
```