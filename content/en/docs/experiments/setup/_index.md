---
title: Experimental Setups
description: Information on how to define experimental setups.
weight: 20
---

{{% pageinfo %}}

The purpose of this section is to provide information on how to administer a LabBench system.

{{% /pageinfo %}}



## Instruments

Each test in a protocol may require a set of instruments to carry out their experimental procedure. Instruments are abstractions over functionality provided by research devices that define the capabilities of a generalized class of devices. 

For example, for a stimulus-response test in cuff pressure algometry, you will need an `IPressureAlgometer` and an `IRatioScale` instrument. The `IPressureAlgometer` is for the stimulus-response test used to provide a linearly increasing pressure, and the `IRatioScale` instrument is used by the subject to rate the pain and to stop the stimulation when the Pain Tolerance Threshold (PTT) is reached. However, the IPressureAlgometer is not tied to a specific pressure algometry device; instead, it defines what LabBench expects all pressure algometers to be capable of, and today the IPressureAlgometer instrument is provided by two pressure algometers: the Nocitech CPAR and LabBench CPAR+ devices. 

Using Instruments in tests instead of concrete devices makes it easier to add new research devices to LabBench. For example, currently, there two types of Cuff Pressure Algometry devices available, where the Nocitech CPAR devices predates the LabBench CPAR+. The CPAR+ offers better performance than the CPAR device and has a trigger system; however, the two devices are largely functionally equivalent. 

Without Instruments, there would have been two sets of identical tests, one set for the CPAR device, and another set for the CPAR+ device. With Instruments, there is no need to implement a second identical set of tests for the CPAR+ device; all that was required for the CPAR+ device to be used in the tests that were originally intended for the CPAR device was to implement the IPressureAlgometer interface, which greatly reduced the amount of work required to add this new device to LabBench. 

## Devices

A specific research device typically also implements multiple instruments. For example, an `IRatioScale` instrument is built into both the Nocitech CPAR and LabBench CPAR+ devices. Consequently, for cuff pressure algometry tests, you do not need a separate device providing the `IRatioScale` instrument because this is built into and provided by these devices in addition to the `IPressureAlgometer` instrument.

Devices are actual research devices such as a CPAR+ device or a NI DAQmx card. When an Experimental Definition File is written the `<experimental-setup>` element contains two nested elements the `<devices>` and `<device-mapping>` elements.

```xml
<experimental-setup>
    <devices>
        <!--  Research devices used in the experimental setup -->
    </devices>
    <device-mapping>
        <!--  Assignment of devices to instruments required by the tests in the protocol -->
    </device-mapping>
</experimental-setup>
```

The `<devices>` element list which devices are required for the experiment and specifies their configuration, whereas the `<device-mapping>` assigns these devices to the instruments that are required for each test.  All devices required by a protocol is listed in the `<devices>` as nested elements. These elements assign an ID that is used to identify the device when they are mapped to the Instruments required by tests in the `<device-mapping>` element, and they also configure the devices for the experiment.

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