---
title: Experimental Setups
description: Information on how to define experimental setups.
weight: 20
---

{{% pageinfo %}}

Experimental setups are the collection of research devices that are used to perform a study. These can consist of for example stimulators, displays, and psychophysical rating devices that implements the abstract instruments that are used by the procedures/tests in a LabBench protocol to run a study.

{{% /pageinfo %}}

## Instruments 

Each test in a protocol may require a set of instruments to carry out its experimental procedures. Instruments are abstractions of the functionality provided by research devices, defining the capabilities of a generalized class of devices. 

For example, for a stimulus-response test in cuff pressure algometry, you will need an `IPressureAlgometer` and an `IRatioScale` instrument. The `IPressureAlgometer` is used in the stimulus-response test to provide a linearly increasing pressure. At the same time, the `IRatioScale` instrument allows the subject to rate the pain and stop the stimulation when the Pain Tolerance Threshold (PTT) is reached. However, the IPressureAlgometer is not tied to a specific pressure algometry device; instead, it defines what LabBench expects all pressure algometers to be capable of. Today, the IPressureAlgometer instrument is provided by two pressure algometers: the Nocitech CPAR and LabBench CPAR+ devices. 

Using Instruments in tests instead of concrete devices makes it easier to add new research devices to LabBench. For example, currently, there are two types of Cuff Pressure Algometry devices available, with the Nocitech CPAR devices predating the LabBench CPAR+. The CPAR+ offers better performance than the CPAR device and has a trigger system; however, the two devices are largely functionally equivalent. Consequently, in protocols that do not need the trigger system provided by the CPAR+ device, these two devices can be used interchangeably.

Without Instruments, there would have been two sets of identical tests, one set for the CPAR device and another set for the CPAR+ device. With Instruments, there is no need to implement a second identical set of tests for the CPAR+ device; all that was required for the CPAR+ device to be used in the tests that were initially intended for the CPAR device was to implement the `IPressureAlgometer` interface, which significantly reduced the amount of work required to add the new LabBench CPAR+ device to LabBench. 


## Devices

Instruments are typically implemented by multiple devices, and one research device typically implements multiple instruments. For example, an `IRatioScale` instrument is built into both Nocitech CPAR and LabBench CPAR+, as well as LabBench I/O devices. Consequently, for cuff pressure algometry tests, you do not need a separate device providing the `IRatioScale` instrument because this is built into and provided by these devices in addition to the `IPressureAlgometer` instrument that is the primary function of the Nocitech CPAR and LabBench CPAR+ devices.

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

The `<devices>` element list which devices are required for the experiment and specifies their configuration, whereas the `<device-mapping>` assigns these devices to the instruments that are required for each test. Currently, it is possible to add the following types of devices to the `<devices>` element in `<experimental-setup>`:

| Device            | Description                                       | Instruments |
|-------------------|---------------------------------------------------|-------------|
| `<lio>`           | LabBench I/O                                      | IStimulator, ITriggerGenerator, IScales, IResponseHost |
| `<cpar>`          | Nocitech CPAR                                     | IPressureAlgometer, IButton, IRatioScale, IScales |
| `<cparplus>`      | LabBench CPAR+                                    | IPressureAlgometer, IButton, IRatioScale, IScales |
| `<daqmx>`         | National Instrument DAQmx Cards                   | IStimulator, ISweepSampler, IButton |
| `<sound>`         | Standard Soundcards                               | IStimulator, ISoundPlayer |
| `<joystick>`      | USB PC Joysticks/Gamepads                         | IButton, IJoystick, `*`ITriggerGenerator |
| `<tactor>`        | Engineering Acoustics Universal Tactor Controller | |
| `<tcs>`           | QSTLab Thermal Cutaneous Stimulator               | |
| `<thermal-plate>` | QSTLab Thermal Plate                              | |
| `<evas>`          | QSTLab eVAS                                       | |
| `<display>`       | Secondary Computer Monitors                       | |

`*` Dummy implementation, no actual functionality provided.

All devices required by a protocol is listed in the `<devices>` as nested elements. These elements assign an ID that is used to identify the device when they are mapped in the `<device-mapping>` element to the Instruments required by tests.

The Experiment Definition File does not, however, specify the actual physical devices that are in your laboratory. The reason for this is that the same experiment may be performed at multiple sites, and consequently, the Experiment Definition File cannot know which devices are present. Instead, when an experiment is added to a test site, physical devices are assigned by LabBench Designer to the devices in the `<devices>` element.

### Device assignments

The `<devices>` elements specify and configure the research devices that are used in the experiment, but it does not configure which devices are used in the tests in the protocol. Each test will require a set of Instruments to perform their experimental procedures. Below is an example of device assignments to instruments required by tests in a protocol:

```xml
<device-mapping>
    <device-assignment instrument-name="Button" device-id="joystick" />
    <device-assignment instrument-name="Questionnaire" device-id="display.questionnaire" />
    <device-assignment instrument-name="ImageDisplay" device-id="display.image" />
    <device-assignment instrument-name="PressureAlgometer" device-id="cpar" /> 
</device-mapping>
```

The names of the required instruments, in this case Button, Questionnaire, and PressureAlgometer are determined by the tests in the protocol The names that must be assigned a device from the `<devices>` element can be looked up in the documentation for the test. 

Each device that is assigned to an Instrument, required by a test, must implement the required Instrument for that name. Assigning a device that does not implement the required Instrument will result in an error that will prevent the experiment from being run by the LabBench interpreter.

Each mapping of a device to an Instrument is done with a `<device-assignment>` element, where the device-id is the id of the device from the `<devices>` element, instrument-name is the name of the Instrument from test. 

You may note from listing above that two of the assigned devices is identified by `[root device].[sub device]`. Devices may have sub-devices – in this example, the display device has two sub-devices; 1) an `IQuestionnaire` device (`id = "questionnaire"`), and 2) an `IImageDisplay` device (`id = “image”`). They cannot be active at the same time, the display will either work as an `IQuestionnaire` instrument, or an `IImageDisplay` instrument, depending on which `experimental-setup` has been specified by the currently selected test. 



In the device mapping in listing above only the type of test is specified (test-type), which means that devices are assigned to all tests of a given type. This is possible because we have a relatively simple protocol where all tests of a given type are used for purposes that do not conflict with each other. For example, we have two <meta-survey> tests that all get assigned a Response and Display instrument, even though only the <meta-survey> test for the DASS questionnaire will use these instruments.  However, this does not conflict with the purpose of these two tests and will not result in an error while running the experiment. Assigning a device to an Instrument name is never an error, it is only an error to not assigning a device to an Instrument name required by a test.

The simple mapping of a given device to all tests of a given type is possible for our experiment, but there are experiments where this simple mapping breaks down and cannot be used. One example of a protocol that required a more specific mapping was an experiment where auditory and tactile sensitivity was determined for children living with autism. In that case, both the auditory and vibrotactile sensitivity was determined by the same type of test, an \verb|<|psychophysics-threshold-estimation\verb|>| test that requires an IAnalogGenerator instrument named Stimulator to be assigned in the \verb|<|device-mapping\verb|>|. In the experiment, a sound card and an EA Tactor Device were used to study the auditory and vibrotactile sensitivity, respectively. Both devices implement the IAnalogGenerator instrument, and thus both can be used by the \verb|<|psychophysics-threshold-estimation\verb|>| test to determine auditory and vibrotactile thresholds. However, since both thresholds are determined by the same type of test, assigning both devices to the Stimulator name would result in a conflict. For that situation, it is possible to specify both a test-type and test-id on the <device-assignment> elements. When a test-id is specified, the device will be assigned only to one specific test with the given test-id. With this mechanism it is possible to specify that the test for the auditory thresholds will be using the sound card and the test for the vibrotactile thresholds will be using the EA Tactor Device. The <device-mapping> element for this mapping is shown below as an example:

\begin{lstlisting}[language=XML, caption=Device mapping where devices are mapped the Stimulator instrument required by the psychophysics-threshold-estimation test.]
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
\end{lstlisting}