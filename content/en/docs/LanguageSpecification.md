---
title: Language Specification
description: Definition of the LabBench Language
weight: 200
---


<a id="LabBench.Core.Experiment"></a>
### Experiment

<p>Defines an entire experiment and contains the following elements:</p>
<ol>
<li><code>&lt;subject-validator&gt;</code>: defines the rule for valid subject/session IDs.</li>
<li><code>&lt;experimental-setup&gt;</code> or <code>&lt;experimental-setup-variants&gt;</code>: defines the research equipment used in the protocol and assigns them to tests in the protocol.</li>
<li><code>&lt;protocol&gt;</code>: defines the protocol for the experiment. This protocol consists of a test (procedures).</li>
<li><code>&lt;post-actions&gt;</code>: defines actions that should be executed when a session is completed.</li>
</ol>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<subject-validator>`](#LabBench.Core.TextValidator)</p> | <p>optional</p> |<p>A subject validator can guard against invalid subject/session IDs. Subject/session IDs are validated with regular expressions. This tutorial <a href="https://regexlearn.com/">RegexLearn</a> teaches how to write regular expressions. When writing regular expressions, it is beneficial to test them with a suitable tool <a href="https://regex101.com/">regex101</a>.</p>|
| <p>[`<experimental-setup>`](#LabBench.Core.Setup.ExperimentalSetup)</p> | <p>optional</p> |<p>Defines the experimental setup for the experiment, which consists of defining and configuring the required research devices and assigning these to tests in the protocol.</p>|
| <p>[`<experimental-setup-variants>`](#LabBench.Core.ExperimentalSetupCollection)</p> | <p>optional</p> |<p>Defines possible experimental setups for the protocol.</p>|
| <p>[`<protocol>`](#LabBench.Core.Protocol)</p> | <p>required</p> |<p>This element defines the protocol for the experiment. The main part of the protocol definition is the definition of the tests (experimental procedures) performed in the experimental sessions. The test definitions must be performed for all protocols and are supported by optional elements.</p> <p>This protocol contains the following elements:</p> <ol> <li><code>&lt;languages&gt;</code>: this <strong>optional</strong> element defines the languages/cultures for which the protocol is localized. If present, the startup wizard will display a page where the operator can select the language to use in the current experimental session.</li> <li><code>&lt;sessions&gt;</code>: this <strong>optional</strong> element defines the sessions of the experiment. If present, the startup wizard will display a page where the operator can select the current session, and each test in the <code>&lt;tests&gt;</code> element must define which session it belongs to. When the session is performed, the LabBench Runner will only display tests for the current session.</li> <li><code>&lt;properties&gt;</code>: this <strong>optional</strong> element defines properties of the protocol that modifies the execution of the tests.</li> <li><code>&lt;randomizations&gt;</code>: this <strong>optional</strong> element defines variables generated once a subject is created and exported with the recorded data. The primary use of these variables is randomization. However, they can be used for any variable that should be persisted in the data set.</li> <li><code>&lt;defines&gt;</code>: this <strong>optional</strong> element defines variables that can have any type. Consequently, they can be used for complex variables not saved in the data set, such as Python classes created in backing scripts. They are created every time a session is started.</li> <li><code>&lt;templates&gt;</code>: this <strong>optional</strong> element defines template variables and test templates that can be used to construct tests at runtime in the <code>&lt;tests&gt;</code> element.</li> <li><code>&lt;tests&gt;</code>: this <strong>mandatory</strong> element defines the tests of the protocol. These can be directly defined in this element or constructed from test templates defined in the <code>&lt;templates&gt;</code> element.</li> <li><code>&lt;assets&gt;</code>: this <strong>optional</strong> element defines external files that the tests in the protocol can use.</li> </ol>|
| <p>`<post-actions>`</p> | <p>optional</p> |<p> The `<post-actions>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Actions.CSVAction"><code>&lt;export-to-csv&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Actions.ExportAction"><code>&lt;export-data&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Actions.ScriptAction"><code>&lt;export-script&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Actions.LogAction"><code>&lt;export-log&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Actions.CopyAction"><code>&lt;copy&gt;</code></a> </span></li> </ul> </p>|


<a id="LabBench.Core.TextValidator"></a>
### TextValidator

<p>A text validator can guard against invalid text input. Text is validated with regular
expressions. This tutorial, <a href="https://regexlearn.com/">RegexLearn</a>, teaches how to
write regular expressions. When writing regular expressions, it is beneficial to test
them with a suitable tool <a href="https://regex101.com/">regex101</a>.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>regex</p>|<p>required</p>|<p>The regular expression that are used to validate the text [ string ].</p>|
|<p>advice</p>|<p>required</p>|<p>An advice on how to write a correct text input [ text ].</p>|


<a id="LabBench.Core.Setup.ExperimentalSetup"></a>
### ExperimentalSetup

<p>The <strong>devices</strong> element lists the devices required for the experiment and specifies their configuration, whereas the <strong>device-mapping</strong> assigns these devices to the instruments required for each test.</p>
<p>All devices that a protocol requires are listed in the <strong>devices</strong> element as nested elements. These elements assign an ID that is used to identify the device when mapped to the Instruments required by tests in the <strong>device-mapping</strong> element, and they also configure the devices for the experiment.</p>
<p>The <strong>devices</strong> elements specify and configure the research devices used in the experiment, but it does not configure which devices are used in the tests in the protocol. Each test will require a set of Instruments to perform the experimental procedures. Each device that is assigned to an Instrument Name, required by a test, must implement the required Instrument for that name. Assigning a device that does not implement the required Instrument will result in an error that will prevent the experiment from being run by the LabBench interpreter.</p>
<p>Each mapping of a device to an Instrument is done with a <strong>device-assignment</strong> element, where the device-id is the id of the device from the <strong>devices</strong> element, instrument-name is the name of the Instrument from test, and test-type is the type of test that requires the Instrument.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>optional</p>|<p>Identifier of the experimental setup [ string ].</p>|
|<p>name</p>|<p>optional</p>|<p>Name of the experimental setup that will be used to identify it in LabBench [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>`<devices>`</p> | <p>optional</p> |<p> The `<devices>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.LIO.LIOSetup"><code>&lt;lio&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.CPAR.CPARSetup"><code>&lt;cpar&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.CPARPlus.CPARPlusSetup"><code>&lt;cpar-plus&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.SOUND.SoundSetup"><code>&lt;sound&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.Joystick.JoystickSetup"><code>&lt;joystick&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.TCS.TCSSetup"><code>&lt;tcs&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.DISPLAY.DisplaySetup"><code>&lt;display&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.EVAS.EVASSetup"><code>&lt;evas&gt;</code></a> </span></li> </ul> </p>|
| <p>`<device-mapping>`</p> | <p>optional</p> |<p> The `<device-mapping>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.DeviceAssignment"><code>&lt;device-assignment&gt;</code></a> </span></li> </ul> </p>|


<a id="LabBench.Core.Setup.LIO.LIOSetup"></a>
### LIOSetup

<h3 id="labbench-io">LabBench I/O</h3>
<p>The LabBench I/O device serves as a central hub for experiments requiring precise coordination of stimulation, participant responses, and external equipment. It supports flexible experimental designs by integrating digital and analog signaling for stimulus generation and response collection.</p>
<p>Common experimental applications include:</p>
<ul>
<li><strong>Precise Event Synchronization and Triggering</strong>:
The device generates and routes digital triggers to synchronize experimental events with external systems such as EEG, EMG, motion capture, eye tracking, or imaging equipment. Trigger logic and voltage levels are adjustable to meet the requirements of various hardware platforms.</li>
<li><strong>Electrical and Sensory Stimulation Control</strong>:
Computer-controlled interfaces with external stimulators allow precise timing of electrical or sensory stimuli in psychophysical, nociceptive, or neurophysiological paradigms.</li>
<li><strong>Reaction Time and Behavioral Response Tasks</strong>:
The device collects button presses and response pad inputs for tasks, measuring reaction times and behavioral responses.</li>
<li><strong>Psychophysical ratings</strong>:
The device supports psychophysical rating scales for real-time reporting of subjective experiences, such as pain intensity, discomfort, or perceptual magnitude, during stimulation or after discrete events.</li>
<li><strong>Externally Triggered and Closed-Loop Paradigms</strong>:
The device detects auditory or visual events to trigger experimental actions, enabling closed-loop designs in which stimulation or task flow depends on the detected signals or participant behavior.</li>
</ul>
<p>Overall, the LabBench I/O device supports complex, multimodal experimental protocols that require precise timing and flexible configuration of stimulation, responses, and external recordings. It is well-suited for advanced psychophysics, systems neuroscience, and human neurophysiology studies.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>default-analog-output</p>|<p>optional</p>|<p>Voltage output on the STIMULATOR A when the device is idle [ double ]. This voltage must be between -10V and 10V.</p>|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to tests in the protocol.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<trigger-setup>`](#LabBench.Core.Setup.LIO.LIOTriggerSetup)</p> | <p>optional</p> |<p>Defines how digital trigger signals generated on the INTERFACE port are electrically and logically configured, specifying whether triggers use positive or negative logic and which voltage levels are driven on the high and low bytes, allowing the LabBench I/O device to be matched to the electrical requirements of connected external equipment.</p>|
| <p>[`<stimulators>`](#LabBench.Core.Setup.LIO.LIOGeneratorSetup)</p> | <p>optional</p> |<p>Defines the external electrical stimulator controlled via the LabBench I/O device, specifying which stimulator hardware is connected and its initial current–voltage conversion setting, enabling LabBench to generate precisely timed and parameterized electrical stimulation as part of the experimental protocol.</p>|
| <p>[`<response-devices>`](#LabBench.Core.Setup.LIO.LIOResponseDeviceSetup)</p> | <p>optional</p> |<p>Defines the set of participant response and event-detection devices connected to the LabBench I/O device, including trigger detectors, buttons, response pads, and rating scales.</p> <p>Up to two devices can be defined, corresponding to the two available response ports on the device.</p> <p>Devices are assigned to response ports <strong>in the order they are defined</strong> within this element: the first device is connected to response port 1 and the second to response port 2. As a consequence, it is possible to occupy only response port 1 without using response port 2, but not the other way around.</p>|


<a id="LabBench.Core.Setup.LIO.LIOTriggerSetup"></a>
### LIOTriggerSetup

<p>Defines how digital trigger signals generated on the INTERFACE port are electrically and logically configured, specifying whether triggers use positive or negative logic and which voltage levels are driven on the high and low bytes, allowing the LabBench I/O device to be matched to the electrical requirements of connected external equipment.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>logic-system</p>|<p>required</p>|<p>Specifies the logic convention used when generating digital triggers with the INTERFACE port. In <strong>positive logic</strong>, a high voltage represents the active or true state, whereas in <strong>negative logic</strong>, a low voltage represents the active or true state and the interpretation of high and low is inverted.</p>|
|<p>low-byte-voltage-level</p>|<p>required</p>|<p>Voltage level for the low-order byte.</p>|
|<p>high-byte-voltage-level</p>|<p>required</p>|<p>Voltage level for the high-order byte.</p>|


<a id="LabBench.Core.Setup.LIO.LIOGeneratorSetup"></a>
### LIOGeneratorSetup

<p>Defines the external electrical stimulator controlled via the LabBench I/O device, specifying which stimulator hardware is connected and its initial current–voltage conversion setting, enabling LabBench to generate precisely timed and parameterized electrical stimulation as part of the experimental protocol.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<ds5>`](#LabBench.Interface.Setup.Stimulators.DS5) </span><br /><span style="white-space: nowrap;">  [`<noxistim>`](#LabBench.Interface.Setup.Stimulators.NoxiSTIM) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Interface.Setup.Stimulators.DS5"></a>
### DS5

<p>The <strong>Digitimer DS5</strong> is a constant-current electrical stimulator widely used in neuroscience and psychophysics research to deliver precisely controlled electrical pulses to peripheral nerves or tissues, supporting reproducible stimulation across a wide range of experimental protocols.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the equipment that will be used to identify it to the operator in the LabBench Runner.</p>|
|<p>transconductance</p>|<p>optional</p>|<p>Initial transconductance of the stimulator. This can be changed during runtime in LabBech Runner.</p>|


<a id="LabBench.Interface.Setup.Stimulators.NoxiSTIM"></a>
### NoxiSTIM

<p>The <strong>NoxiSTIM</strong> is an isolated, current-controlled electrical stimulator developed for research use, capable of delivering up to ~100 mA pulses (with safety-limited durations) and high voltage outputs for peripheral nerve and sensory stimulation in psychophysics and neurophysiology experiments; it requires trained supervision due to the potential risks of electrical stimulation and is used to elicit reflexes and controlled sensory responses in human subject research.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the equipment that will be used to identify it to the operator in the LabBench Runner.</p>|
|<p>transconductance</p>|<p>optional</p>|<p>Initial transconductance of the stimulator. This can be changed during runtime in LabBech Runner.</p>|


<a id="LabBench.Core.Setup.LIO.LIOResponseDeviceSetup"></a>
### LIOResponseDeviceSetup

<p>Defines the set of participant response and event-detection devices connected to the LabBench I/O device, including trigger detectors, buttons, response pads, and rating scales.</p>
<p>Up to two devices can be defined, corresponding to the two available response ports on the device.</p>
<p>Devices are assigned to response ports <strong>in the order they are defined</strong> within this element: the first device is connected to response port 1 and the second to response port 2. As a consequence, it is possible to occupy only response port 1 without using response port 2, but not the other way around.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<button>`](#LabBench.Interface.Setup.Response.Buttons.ButtonSetup) </span><br /><span style="white-space: nowrap;">  [`<visual-analog-scale>`](#LabBench.Interface.Setup.Response.Scales.VisualAnalogScaleSetup) </span><br /><span style="white-space: nowrap;">  [`<audio-trigger>`](#LabBench.Interface.Setup.Response.Triggers.AudioTriggerDetectorSetup) </span><br /><span style="white-space: nowrap;">  [`<visual-trigger>`](#LabBench.Interface.Setup.Response.Triggers.VisualTriggerDetectorSetup) </span><br /><span style="white-space: nowrap;">  [`<response-pad>`](#LabBench.Interface.Setup.Response.Buttons.ResponsePadSetup) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Interface.Setup.Response.Buttons.ButtonSetup"></a>
### ButtonSetup

<p>The <strong>LabBench BUTTON</strong> is a simple single-button response device used to collect discrete participant responses such as responses in yes/no response task. (e.g., for threshold estimation in perception threshold tracking).</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the response device [ string ]. This <code>id</code> must be unique.</p>|
|<p>timing-source</p>|<p>optional</p>|<p>Timing or trigger source:</p> <ul> <li><code>none</code>: no source is configured.</li> <li><code>internal</code>: the source is an internal opration such as start of a stimulus.</li> <li><code>external</code>: a trigger event is received from external equipment.</li> <li><code>button</code>: a trigger event is received from a button press on a connected response device attached to any response port.</li> <li><code>response-port01</code>: a trigger is received on response port 1.</li> <li><code>response-port02</code>: a trigger is received on response port 2.</li> <li><code>response-port03</code>: a trigger is received on response port 3.</li> <li><code>response-port04</code>: a trigger is received on response port 4.</li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<map>`](#LabBench.Interface.Instruments.Response.ButtonMap) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Interface.Instruments.Response.ButtonMap"></a>
### ButtonMap

<p>A button configuration for the device. Each button configuration is activated based on the experimental-setup-id
of the currently selected test in the protocol.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>The experimental-setup-id that will activate the button configuration [ string ]. If this attribute is omitted, the button configuration will default to the device's configuration, which will be activated if no configuration is found for the currently active experimental-setup-id.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<button-assignment>`](#LabBench.Interface.Instruments.Response.ButtonAssignment) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Interface.Instruments.Response.ButtonAssignment"></a>
### ButtonAssignment

<p>Assign a button function to a physical button on the device. Tests and devices that use this
device as their controller-device  will need a specific set of button functions to operate.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>code</p>|<p>required</p>|<p>The code that identifies the physical button on the device [ int ].</p>|
|<p>button</p>|<p>required</p>|<p>The button function to assign to the physical button on the device.</p>|
|<p>label</p>|<p>required</p>|<p>A descriptive label that will be used in LabBench Designer to explain the function of the button [ string ].</p>|


<a id="LabBench.Interface.Setup.Response.Scales.VisualAnalogScaleSetup"></a>
### VisualAnalogScaleSetup

<p>A visual analog scale (VAS) represents a ratio scale along which observers report the perceived magnitude of a subjective sensation.
A ratio scale means that responses are defined on a continuum, with a true zero corresponding to the absence of the perceptual quantity,
and equal distances along the scale correspond to equal increments in perceived magnitude. As a consequence, ratios between values are
interpretable (e.g., a response at 60 can be meaningfully understood as twice the perceived intensity of a response at 30, under the
assumptions of the scale).</p>
<p>The scale is defined by a  modality and the lower and upper anchors of the perceptual dimension. The lower anchor denotes the null
intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality. The scale
is also defined by its physical length, typically 10cm.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the response device [ string ]. This <code>id</code> must be unique.</p>|
|<p>sample-period</p>|<p>optional</p>||
|<p>timing-source</p>|<p>optional</p>|<p>Timing or trigger source:</p> <ul> <li><code>none</code>: no source is configured.</li> <li><code>internal</code>: the source is an internal opration such as start of a stimulus.</li> <li><code>external</code>: a trigger event is received from external equipment.</li> <li><code>button</code>: a trigger event is received from a button press on a connected response device attached to any response port.</li> <li><code>response-port01</code>: a trigger is received on response port 1.</li> <li><code>response-port02</code>: a trigger is received on response port 2.</li> <li><code>response-port03</code>: a trigger is received on response port 3.</li> <li><code>response-port04</code>: a trigger is received on response port 4.</li> </ul>|
|<p>length</p>|<p>optional</p>|<p>Physical length of the scale in centimeters [ double ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<anchors>`](#LabBench.Interface.Setup.Response.Scales.AnchorDefinitions)</p> | <p>optional</p> |<p>Definition of the scale modality and its lower and upper anchors of the perceptual dimension. The lower anchor denotes the null intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality.</p>|
| <p>`<button-maps>`</p> | <p>optional</p> |<p> The `<button-maps>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Interface.Instruments.Response.ButtonMap"><code>&lt;map&gt;</code></a> </span></li> </ul> </p>|


<a id="LabBench.Interface.Setup.Response.Scales.AnchorDefinitions"></a>
### AnchorDefinitions

<p>Definition of the scale modality and its lower and upper anchors of the perceptual dimension. The lower anchor denotes the null
intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<modality>`](#LabBench.Interface.Setup.Response.Scales.Anchor)</p> | <p>required</p> |<p>The modality of the scale such as pain, itch, pleasentness, nausia, etc.</p>|
| <p>[`<top-anchor>`](#LabBench.Interface.Setup.Response.Scales.Anchor)</p> | <p>required</p> |<p>Definition of the top anchor for the scale.</p>|
| <p>[`<bottom-anchor>`](#LabBench.Interface.Setup.Response.Scales.Anchor)</p> | <p>required</p> |<p>Definition of the bottom anchor for the scale.</p>|


<a id="LabBench.Interface.Setup.Response.Scales.Anchor"></a>
### Anchor

<p>Definition of a modality or anchor.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>text</p>|<p>required</p>|<p>Text describing the element [ string ]. This text will be used if no localization <code>&lt;localized-text&gt;</code> for the element is found.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<localized-text>`](#LabBench.Interface.Setup.Response.Scales.LocalizedText) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Interface.Setup.Response.Scales.LocalizedText"></a>
### LocalizedText

<p>Localization of the text, if a localized language is selected then that text will be used instead of the text defined in the text attribute.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>language</p>|<p>required</p>|<p>Language code, which must be defined in one of the <code>&lt;language&gt;</code> definitions in the <code>&lt;languages&gt;</code> in the protocol [ string ].</p>|
|<p>text</p>|<p>required</p>|<p>Localized text to use for the language [ string ].</p>|


<a id="LabBench.Interface.Setup.Response.Triggers.AudioTriggerDetectorSetup"></a>
### AudioTriggerDetectorSetup

<p>Defines an <strong>audio trigger detector (LabBench ATG)</strong> that monitors an incoming audio signal and generates a precise trigger event when the signal exceeds a defined threshold. The arming period specifies a refractory interval after each detection to prevent repeated triggering from the same sound event, while the timing source determines how detected events are timestamped.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the response device [ string ]. This <code>id</code> must be unique.</p>|
|<p>arming-period</p>|<p>optional</p>|<p>Refractory interval in milliseconds after each detection to prevent repeated triggering from the same event [ int ].</p>|
|<p>timing-source</p>|<p>optional</p>|<p>Timing or trigger source:</p> <ul> <li><code>none</code>: no source is configured.</li> <li><code>internal</code>: the source is an internal opration such as start of a stimulus.</li> <li><code>external</code>: a trigger event is received from external equipment.</li> <li><code>button</code>: a trigger event is received from a button press on a connected response device attached to any response port.</li> <li><code>response-port01</code>: a trigger is received on response port 1.</li> <li><code>response-port02</code>: a trigger is received on response port 2.</li> <li><code>response-port03</code>: a trigger is received on response port 3.</li> <li><code>response-port04</code>: a trigger is received on response port 4.</li> </ul>|


<a id="LabBench.Interface.Setup.Response.Triggers.VisualTriggerDetectorSetup"></a>
### VisualTriggerDetectorSetup

<p>Defines a <strong>visual trigger detector (LabBench VTG)</strong> that uses a photosensor to detect visual fiducials embedded in on-screen stimuli and generates precise trigger events when these fiducials are displayed. The arming period specifies a refractory interval to avoid multiple detections of the same visual event, while the timing source controls how detections are timestamped.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the response device [ string ]. This <code>id</code> must be unique.</p>|
|<p>arming-period</p>|<p>optional</p>|<p>Refractory interval in milliseconds after each detection to prevent repeated triggering from the same event [ int ].</p>|
|<p>timing-source</p>|<p>optional</p>|<p>Timing or trigger source:</p> <ul> <li><code>none</code>: no source is configured.</li> <li><code>internal</code>: the source is an internal opration such as start of a stimulus.</li> <li><code>external</code>: a trigger event is received from external equipment.</li> <li><code>button</code>: a trigger event is received from a button press on a connected response device attached to any response port.</li> <li><code>response-port01</code>: a trigger is received on response port 1.</li> <li><code>response-port02</code>: a trigger is received on response port 2.</li> <li><code>response-port03</code>: a trigger is received on response port 3.</li> <li><code>response-port04</code>: a trigger is received on response port 4.</li> </ul>|


<a id="LabBench.Interface.Setup.Response.Buttons.ResponsePadSetup"></a>
### ResponsePadSetup

<p>The <strong>LabBench PAD</strong> is a configurable multi-button response device used for collecting discrete participant responses during experiments.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the response device [ string ]. This <code>id</code> must be unique.</p>|
|<p>type</p>|<p>optional</p>|<p>Type of response pad</p>|
|<p>timing-source</p>|<p>optional</p>|<p>Timing or trigger source:</p> <ul> <li><code>none</code>: no source is configured.</li> <li><code>internal</code>: the source is an internal opration such as start of a stimulus.</li> <li><code>external</code>: a trigger event is received from external equipment.</li> <li><code>button</code>: a trigger event is received from a button press on a connected response device attached to any response port.</li> <li><code>response-port01</code>: a trigger is received on response port 1.</li> <li><code>response-port02</code>: a trigger is received on response port 2.</li> <li><code>response-port03</code>: a trigger is received on response port 3.</li> <li><code>response-port04</code>: a trigger is received on response port 4.</li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<map>`](#LabBench.Interface.Instruments.Response.ButtonMap) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Setup.CPAR.CPARSetup"></a>
### CPARSetup

<h3 id="nocitch-cpar">Nocitch CPAR</h3>
<p>The <strong>Nocitech CPAR</strong> is a computer-controlled cuff pressure algometer that delivers precise, reproducible pressure stimulation for neuroscience research. It generates customizable piecewise-linear pressure waveforms with accurate temporal control, supporting advanced psychophysical protocols. The device enables automated cuff pressure algometry protocols that are not feasible with manual devices.</p>
<p>Possible protocols:</p>
<ul>
<li><strong>Cuff Pressure Pain Detection and Tolerance Thresholds</strong>:
Automatically measures the pressure at which a subject first perceives pain (pain detection threshold) and when pain becomes intolerable (pain tolerance threshold).</li>
<li><strong>Temporal Summation (TS)</strong>:
Applies repeated, identical pressure stimuli to assess increases in perceived pain over time, reflecting central facilitatory pain mechanisms (often referred to as “wind-up”).</li>
<li><strong>Spatial Summation</strong>:
Uses multiple cuffs or varied stimulation areas to study how pain perception changes with the spatial extent of stimulation.</li>
<li><strong>Conditioned Pain Modulation (CPM)</strong>:
Implements a “pain-inhibits-pain” paradigm, where a conditioning stimulus at one site alters the pain response at another.</li>
</ul>
<p>These protocols are commonly used in quantitative sensory testing (QST) to investigate peripheral and central sensitisation mechanisms in both healthy and clinical populations.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>compressor-mode</p>|<p>optional</p>|<p>Control mode for the compressor; AUTO: The compressor will refill automatically after each test in the protocol, MANUAL: The compressor will only refill when the minimal working pressure has been reached.</p>|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to tests in the protocol.</p>|


<a id="LabBench.Core.Setup.CPARPlus.CPARPlusSetup"></a>
### CPARPlusSetup

<h3 id="labbench-cpar">LabBench CPAR+</h3>
<p>The <strong>LabBench CPAR+</strong> is a computer-controlled cuff pressure algometer that delivers precise, reproducible pressure stimulation for neuroscience research. It generates customizable piecewise-linear pressure waveforms with accurate temporal control, supporting advanced psychophysical protocols. The device enables automated cuff pressure algometry protocols that are not feasible with manual devices.</p>
<p>Possible protocols:</p>
<ul>
<li><strong>Cuff Pressure Pain Detection and Tolerance Thresholds</strong>:
Automatically measures the pressure at which a subject first perceives pain (pain detection threshold) and when pain becomes intolerable (pain tolerance threshold).</li>
<li><strong>Temporal Summation (TS)</strong>:
Applies repeated, identical pressure stimuli to assess increases in perceived pain over time, reflecting central facilitatory pain mechanisms (often referred to as “wind-up”).</li>
<li><strong>Spatial Summation</strong>:
Uses multiple cuffs or varied stimulation areas to study how pain perception changes with the spatial extent of stimulation.</li>
<li><strong>Conditioned Pain Modulation (CPM)</strong>:
Implements a “pain-inhibits-pain” paradigm, where a conditioning stimulus at one site alters the pain response at another.</li>
</ul>
<p>These protocols are commonly used in quantitative sensory testing (QST) to investigate peripheral and central sensitisation mechanisms in both healthy and clinical populations.</p>
<p>The device synchronizes with external recording and stimulation equipment via digital trigger inputs and outputs. It features two independently controllable cuff pressure channels and provides real-time pressure signals as analog outputs. The CPAR+ requires an external air supply from standard compressors or compressed air bottles.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>rating-scale</p>|<p>optional</p>|<p>Identification of an optional external rating scale to use with the LabBench CPAR+ [ Text ]. If it is not specified or left blank the device will use the rating scale connected to its response port.</p>|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to tests in the protocol.</p>|
|<p>button</p>|<p>optional</p>|<p>Identification of an optional external button to use with the LabBench CPAR+ [ Text ]. If it is not specified or left blank the device will use the rating scale connected to its response port.</p>|


<a id="LabBench.Core.Setup.SOUND.SoundSetup"></a>
### SoundSetup

<h3 id="soundcard">Soundcard</h3>
<p>Soundcards in LabBench enable precise generation of audio signals, making them suitable for a wide range of auditory, psychophysical, and neurophysiological experiments. By leveraging low-latency playback, multi-channel audio, and tight synchronization with other LabBench devices, soundcards can be integrated into complex experimental protocols, including:</p>
<ul>
<li>Auditory Detection and Discrimination Thresholds
Presentation of pure tones, noise, or complex sounds to determine hearing thresholds, just-noticeable differences (JNDs), and frequency or intensity discrimination performance.</li>
<li>Psychophysical Scaling and Rating Experiments
Delivery of controlled auditory stimuli while collecting subjective ratings (e.g. loudness, unpleasantness, or salience) using LabBench response devices or questionnaires.</li>
<li>Temporal Processing and Auditory Timing Tasks
Protocols investigating temporal resolution, gap detection, sensitivity to amplitude or frequency modulation, and rhythm perception all rely on accurate stimulus timing.</li>
<li>Multisensory Integration Experiments
Synchronization of auditory stimuli with visual, tactile, or nociceptive stimulation (e.g., LabBench CPAR+) to study cross-modal interactions and sensory integration mechanisms.</li>
<li>Event-Related and Continuous Stimulation Paradigms
Generation of discrete auditory events or continuous sound streams aligned with digital triggers for EEG, MEG, or other physiological recordings.</li>
</ul>
<p>Soundcards are commonly used in auditory neuroscience and psychophysics, where precise control over stimulus timing, waveform shape, and synchronization is critical for reproducible experimental designs.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to tests in the protocol.</p>|


<a id="LabBench.Core.Setup.Joystick.JoystickSetup"></a>
### JoystickSetup

<h3 id="joystick">Joystick</h3>
<p>This <joystick> is a standard USB device used for tasks like answering questionnaires and making ratings.
It supports different button setups, each marked by its experiment ID. The button setup changes depending
on the chosen test.</p>
<p>The device implements the Button, Joystick, and Trigger instruments. The Trigger instrument is a dummy
implementation with no functionality, implemented by the device, so it can act as a test device for protocols
that would otherwise require a LabBench I/O device, or be used to create protocols that can be used with
both a Joystick and a LabBench I/O device.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to tests in the protocol.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<map>`](#LabBench.Interface.Instruments.Response.ButtonMap) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Setup.TCS.TCSSetup"></a>
### TCSSetup

<h3 id="qstlab-tcs">QSTLab TCS</h3>
<p>The <strong>QSTLab Thermal Cutaneous Stimulator (TCS)</strong> is a portable, battery-powered device for controlled contact thermal stimulation in quantitative sensory testing and pain research, offering a 0–60 °C range with 0.1 °C precision and ramps up to 300 °C/sec, five independently settable stimulation zones, external computer control and triggers for EEG/ECG/MRI integration — ideal for automated QST protocols in LabBench.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>minimal-temperature</p>|<p>optional</p>|<p>Minimal allowed temperature [ double ]. Must be zero or higher.</p>|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to tests in the protocol.</p>|
|<p>neutral-temperature</p>|<p>required</p>|<p>Neutral temperature [ double ].</p>|
|<p>maximal-temperature</p>|<p>optional</p>|<p>Maximal allowed temperature [ double ]. Must be 60C or lower.</p>|
|<p>trigger-output</p>|<p>optional</p>|<p>Generate a trigger at the onset of stimuli [ bool ].</p>|


<a id="LabBench.Core.Setup.DISPLAY.DisplaySetup"></a>
### DisplaySetup

<h3 id="labbench-display">LabBench Display</h3>
<p>This <code>&lt;display&gt;</code> device opens a fixed, always-on-top window on a monitor connected to the laboratory computer. Within an experiment,
this window supports multiple instruments based on the selected test. Each instrument defines the experiment-setup-id
that activates it, and each test specifies which experiment-setup-id will be used while it is selected.</p>
<p>Instruments that can be defined are:</p>
<ul>
<li>Image Display: Displays instructions when tests are inactive and visual stimuli when active.</li>
<li>Questionnaire: Displays questionnaires for participants to complete.</li>
<li>Visual Analog Scale: Displays a ratio scale for participants to rate perceptions.</li>
<li>Numerical Rating Scale: Displays an interval scale for participants to rate perceptions.</li>
<li>Categorical Rating Scale: Displays an ordinal scale for participants to rate perceptions.</li>
<li>Composite Scale: Displays a set of rating scales for participants to potentially rate multiple perceptions simultaneously.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>normative-distance</p>|<p>optional</p>|<p>Normative distance for visual elements [ double:centimeters ]. This value is used with the monitor.distance to scale the elements so they have the same visual angle for the subject as if they where positioned at the normative distance.</p>|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to tests in the protocol.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<typography>`](#LabBench.Interface.Setup.Screen.Typography)</p> | <p>optional</p> |<p>Typography establishes the global typographic and color standards for on-screen textual elements in questionnaires and rating scales. It defines default foreground, background, active, and inactive colors, as well as role-specific typography presets for titles, instructions, answers, scale modalities, anchors, and category labels across various question and scale types.</p>|
| <p>`<configurations>`</p> | <p>optional</p> |<p> The `<configurations>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.Display.DisplayCategoricalScaleSetup"><code>&lt;categorical-scale&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.Display.DisplayNumericalScaleSetup"><code>&lt;numerical-scale&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.Display.DisplayVisualAnalogScaleSetup"><code>&lt;visual-analog-scale&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.Display.DisplayCompositeScaleSetup"><code>&lt;composite-scale&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.Display.ImageSetup"><code>&lt;image-display&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Setup.Display.DisplayQuestionnaireSetup"><code>&lt;questionnaire&gt;</code></a> </span></li> </ul> </p>|


<a id="LabBench.Interface.Setup.Screen.Typography"></a>
### Typography

<p>Typography establishes the global typographic and color standards for on-screen textual elements in questionnaires and rating scales.
It defines default foreground, background, active, and inactive colors, as well as role-specific typography presets for titles,
instructions, answers, scale modalities, anchors, and category labels across various question and scale types.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>background-color</p>|<p>optional</p>|<p>Background color [ Text (default: #FFFFFF) ].</p>|
|<p>foreground-color</p>|<p>optional</p>|<p>Foreground color [ Text (default: #000000) ].</p>|
|<p>active-color</p>|<p>optional</p>|<p>Active color [ Text (default: #FF0000) ].</p>|
|<p>inactive-color</p>|<p>optional</p>|<p>Inactive color [ Text (default: #161616) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<title>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for question titles in questionnaires.</p>|
| <p>[`<instruction>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for question instructions in questionnaires.</p>|
| <p>[`<answer>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for possible answers to boolean, list, and multiple-choice questions in questionnaires.</p>|
| <p>[`<likert-category>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for categories in likert and dimensional likert questions in questionnaires.</p>|
| <p>[`<numerical-answer>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for answers to numerical questions in questionnaires.</p>|
| <p>[`<text-answer>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for answers to text questions in questionnaires.</p>|
| <p>[`<time-answer>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for answers to time/date questions in questionnaires.</p>|
| <p>[`<scale-modality>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for scale modalities in numerical, categorical, and psychometric rating questions in questionnaires as well as for psychomeric rating scales.</p>|
| <p>[`<top-anchor>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for the top anchor in psychometric rating questions in questionnaires as well as for psychomeric rating scales.</p>|
| <p>[`<bottom-anchor>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for the bottom anchor in and psychometric rating questions in questionnaires as well as for psychomeric rating scales.</p>|
| <p>[`<crs-category>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for the categories in categorical rating questions in questionnaires as well as for categorical rating scales.</p>|
| <p>[`<nrs-category>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for the categories in numerical rating questions in questionnaires as well as for numerical rating scales.</p>|


<a id="LabBench.Interface.Setup.Screen.ElementTypography"></a>
### ElementTypography

<p>Typography of a screen element</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>size</p>|<p>required</p>|<p>Size of the font that is used for the element.</p>|
|<p>border-thickness</p>|<p>optional</p>|<p>Border thickness of the element.</p>|
|<p>style</p>|<p>optional</p>|<p>Style of the font, whether it is normal or in italic.</p>|
|<p>weight</p>|<p>optional</p>|<p>Indicates the visual weight (degree of blackness or thickness of strokes) of the characters in the font.</p>|
|<p>color</p>|<p>optional</p>|<p>The color of the element</p>|


<a id="LabBench.Core.Setup.Display.DisplayCategoricalScaleSetup"></a>
### DisplayCategoricalScaleSetup

<p>A categorical rating scale (CRS) represents an ordered set of discrete response categories used to report the perceived
magnitude or quality of a subjective sensation. CRS scales are ordinal scales, meaning that the ordering of categories
is meaningful, but neither the magnitude of differences between adjacent categories nor ratios between categories is
defined or assumed to be equal. As a result, comparisons are limited to statements of greater-than or less-than (e.g.,
category C indicates more perceived intensity than category B), without any metric interpretation of spacing.</p>
<p>The scale is defined by a modality and a finite set of semantically labeled categories spanning the response range from
minimal to maximal perceived intensity.</p>
<p>For its operation, its <code>controller-device</code> must implement a <code>Button</code> instrument with the following <code>button-assignments</code>:</p>
<ul>
<li><code>increase</code>: increase the rating on the scale.</li>
<li><code>decrease</code>: decrease the rating on the scale.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Device identification that will be used to identify the sub-device in device assignments [ Text ].</p>|
|<p>experimental-setup-id</p>|<p>required</p>|<p>Identification of the experimental setup state where this device will be active [ Text ].</p>|
|<p>controller-device</p>|<p>required</p>|<p>Identification of the device used to control this device [ Text ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<anchors>`](#LabBench.Interface.Setup.Response.Scales.AnchorDefinitions)</p> | <p>required</p> |<p>Definition of the scale modality and its lower and upper anchors of the perceptual dimension. The lower anchor denotes the null intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality.</p>|
| <p>`<categories>`</p> | <p>optional</p> |<p> The `<categories>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Interface.Setup.Response.Scales.Anchor"><code>&lt;category&gt;</code></a> </span></li> </ul> </p>|


<a id="LabBench.Core.Setup.Display.DisplayNumericalScaleSetup"></a>
### DisplayNumericalScaleSetup

<p>With a numerical rating scale (NRS), observers report the perceived magnitude of a subjective sensation by selecting
a value from an ordered numeric set. In LabBench, an NRS is treated as an interval scale, meaning that equal numeric
differences are intended to correspond to equal differences in perceived magnitude, but the zero point does not
constitute a true absence of the perceptual quantity in a measurement-theoretic sense. Consequently, differences
between values are interpretable, whereas ratios are not (e.g., the difference between ratings 6 and 8 is meaningful,
but a rating of 8 cannot be interpreted as “twice” the intensity of a rating of 4).</p>
<p>The scale is defined by a  modality and the lower and upper anchors of the perceptual dimension. The lower anchor denotes the null
intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality. The anchors
serve as reference points for minimal and maximal perceived intensity, without implying a physically or perceptually absolute zero.
Responses are restricted to discrete steps between a minum and maximum integer value.</p>
<p>For its operation, its <code>controller-device</code> must implement a <code>Button</code> instrument with the following <code>button-assignments</code>:</p>
<ul>
<li><code>increase</code>: increase the rating on the scale.</li>
<li><code>decrease</code>: decrease the rating on the scale.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Device identification that will be used to identify the sub-device in device assignments [ Text ].</p>|
|<p>experimental-setup-id</p>|<p>required</p>|<p>Identification of the experimental setup state where this device will be active [ Text ].</p>|
|<p>maximum</p>|<p>required</p>|<p>The maximal value for the scale [ int ].</p>|
|<p>minimum</p>|<p>required</p>|<p>The minimum value for the scale [ int ].</p>|
|<p>controller-device</p>|<p>required</p>|<p>Identification of the device used to control this device [ Text ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<anchors>`](#LabBench.Interface.Setup.Response.Scales.AnchorDefinitions)</p> | <p>required</p> |<p>Definition of the scale modality and its lower and upper anchors of the perceptual dimension. The lower anchor denotes the null intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality.</p>|


<a id="LabBench.Core.Setup.Display.DisplayVisualAnalogScaleSetup"></a>
### DisplayVisualAnalogScaleSetup

<p>A visual analog scale (VAS) represents a ratio scale along which observers report the perceived magnitude of a subjective sensation.
A ratio scale means that responses are defined on a continuum, with a true zero corresponding to the absence of the perceptual quantity,
and equal distances along the scale correspond to equal increments in perceived magnitude. As a consequence, ratios between values are
interpretable (e.g., a response at 60 can be meaningfully understood as twice the perceived intensity of a response at 30, under the
assumptions of the scale).</p>
<p>The scale is defined by a  modality and the lower and upper anchors of the perceptual dimension. The lower anchor denotes the null
intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality. The scale
is also defined by its physical length, typically 10cm.</p>
<p>For its operation, its <code>controller-device</code> must implement a <code>Button</code> instrument with the following <code>button-assignments</code>:</p>
<ul>
<li><code>increase</code>: increase the rating on the scale.</li>
<li><code>decrease</code>: decrease the rating on the scale.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Device identification that will be used to identify the sub-device in device assignments [ Text ].</p>|
|<p>experimental-setup-id</p>|<p>required</p>|<p>Identification of the experimental setup state where this device will be active [ Text ].</p>|
|<p>length</p>|<p>optional</p>|<p>Physical length of the scale in centimeters [ double ].</p>|
|<p>controller-device</p>|<p>required</p>|<p>Identification of the device used to control this device [ Text ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<anchors>`](#LabBench.Interface.Setup.Response.Scales.AnchorDefinitions)</p> | <p>required</p> |<p>Definition of the scale modality and its lower and upper anchors of the perceptual dimension. The lower anchor denotes the null intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality.</p>|


<a id="LabBench.Core.Setup.Display.DisplayCompositeScaleSetup"></a>
### DisplayCompositeScaleSetup

<p>A composite scale consists of one or more psychophysical rating scales, each of which can be a visual analog,
numerical, or categorical scale. It is possible, but not recommended, to mix scales; the most common
configuration is a single scale.</p>
<p>For its operation, it must be assigned a <code>controller-device</code> that must implement a <code>Button</code> instrument with
the following <code>button-assignments</code>:</p>
<ul>
<li><code>increase</code>: increase the rating on the currently active scale.</li>
<li><code>decrease</code>: decrease the rating on the current active scale.</li>
<li><code>previous</code>: activate the previous scale in the defined set of scales.</li>
<li><code>next</code>: activate the next scale in the defined set of scales.</li>
</ul>
<p>If only one scale is defined, the <code>previous</code> and <code>next</code> buttons will have no effect.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Device identification that will be used to identify the sub-device in device assignments [ Text ].</p>|
|<p>experimental-setup-id</p>|<p>required</p>|<p>Identification of the experimental setup state where this device will be active [ Text ].</p>|
|<p>controller-device</p>|<p>required</p>|<p>Identification of the device used to control this device [ Text ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<visual-analog-scale>`](#LabBench.Core.Setup.Display.NestedVisualAnalogScaleSetup) </span><br /><span style="white-space: nowrap;">  [`<numerical-scale>`](#LabBench.Core.Setup.Display.NestedNumericalScaleSetup) </span><br /><span style="white-space: nowrap;">  [`<categorical-scale>`](#LabBench.Core.Setup.Display.NestedCategoricalScaleSetup) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Setup.Display.NestedVisualAnalogScaleSetup"></a>
### NestedVisualAnalogScaleSetup

<p>A visual analog scale (VAS) represents a ratio scale along which observers report the perceived magnitude of a subjective sensation.
A ratio scale means that responses are defined on a continuum, with a true zero corresponding to the absence of the perceptual quantity,
and equal distances along the scale correspond to equal increments in perceived magnitude. As a consequence, ratios between values are
interpretable (e.g., a response at 60 can be meaningfully understood as twice the perceived intensity of a response at 30, under the
assumptions of the scale).</p>
<p>The scale is defined by a  modality and the lower and upper anchors of the perceptual dimension. The lower anchor denotes the null
intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality. The scale
is also defined by its physical length, typically 10cm.</p>
<p>For its operation, its <code>controller-device</code> must implement a <code>Button</code> instrument with the following <code>button-assignments</code>:</p>
<ul>
<li><code>increase</code>: increase the rating on the scale.</li>
<li><code>decrease</code>: decrease the rating on the scale.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the scale [ string ].</p>|
|<p>length</p>|<p>optional</p>|<p>Physical length of the scale in centimeters [ double ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<anchors>`](#LabBench.Interface.Setup.Response.Scales.AnchorDefinitions)</p> | <p>required</p> |<p>Definition of the scale modality and its lower and upper anchors of the perceptual dimension. The lower anchor denotes the null intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality.</p>|


<a id="LabBench.Core.Setup.Display.NestedNumericalScaleSetup"></a>
### NestedNumericalScaleSetup

<p>With a numerical rating scale (NRS), observers report the perceived magnitude of a subjective sensation by selecting
a value from an ordered numeric set. In LabBench, an NRS is treated as an interval scale, meaning that equal numeric
differences are intended to correspond to equal differences in perceived magnitude, but the zero point does not
constitute a true absence of the perceptual quantity in a measurement-theoretic sense. Consequently, differences
between values are interpretable, whereas ratios are not (e.g., the difference between ratings 6 and 8 is meaningful,
but a rating of 8 cannot be interpreted as “twice” the intensity of a rating of 4).</p>
<p>The scale is defined by a  modality and the lower and upper anchors of the perceptual dimension. The lower anchor denotes the null
intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality. The anchors
serve as reference points for minimal and maximal perceived intensity, without implying a physically or perceptually absolute zero.
Responses are restricted to discrete steps between a minum and maximum integer value.</p>
<p>For its operation, its <code>controller-device</code> must implement a <code>Button</code> instrument with the following <code>button-assignments</code>:</p>
<ul>
<li><code>increase</code>: increase the rating on the scale.</li>
<li><code>decrease</code>: decrease the rating on the scale.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the scale [ string ].</p>|
|<p>maximum</p>|<p>required</p>|<p>The maximal value for the scale [ int ].</p>|
|<p>minimum</p>|<p>required</p>|<p>The minimum value for the scale [ int ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<anchors>`](#LabBench.Interface.Setup.Response.Scales.AnchorDefinitions)</p> | <p>required</p> |<p>Definition of the scale modality and its lower and upper anchors of the perceptual dimension. The lower anchor denotes the null intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality.</p>|


<a id="LabBench.Core.Setup.Display.NestedCategoricalScaleSetup"></a>
### NestedCategoricalScaleSetup

<p>A categorical rating scale (CRS) represents an ordered set of discrete response categories used to report the perceived
magnitude or quality of a subjective sensation. CRS scales are ordinal scales, meaning that the ordering of categories
is meaningful, but neither the magnitude of differences between adjacent categories nor ratios between categories is
defined or assumed to be equal. As a result, comparisons are limited to statements of greater-than or less-than (e.g.,
category C indicates more perceived intensity than category B), without any metric interpretation of spacing.</p>
<p>The scale is defined by a modality and a finite set of semantically labeled categories spanning the response range from
minimal to maximal perceived intensity.</p>
<p>For its operation, its <code>controller-device</code> must implement a <code>Button</code> instrument with the following <code>button-assignments</code>:</p>
<ul>
<li><code>increase</code>: increase the rating on the scale.</li>
<li><code>decrease</code>: decrease the rating on the scale.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the scale [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<anchors>`](#LabBench.Interface.Setup.Response.Scales.AnchorDefinitions)</p> | <p>required</p> |<p>Definition of the scale modality and its lower and upper anchors of the perceptual dimension. The lower anchor denotes the null intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality.</p>|
| <p>`<categories>`</p> | <p>optional</p> |<p> The `<categories>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Interface.Setup.Response.Scales.Anchor"><code>&lt;category&gt;</code></a> </span></li> </ul> </p>|


<a id="LabBench.Core.Setup.Display.ImageSetup"></a>
### ImageSetup

<p>An instrument that can be used for the display of images. This can be used either to display instructions to
participants when tests are inactive or to display visual stimuli for experimental procedures such as visually
evoked potentials and behavioral tests (Stroop, Flanker, Stop-Signal tasks, etc.).</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Device identification that will be used to identify the sub-device in device assignments [ Text ].</p>|
|<p>experimental-setup-id</p>|<p>required</p>|<p>Identification of the experimental setup state where this device will be active [ Text ].</p>|
|<p>background-color</p>|<p>optional</p>|<p>Setting this attribute will override the background color defined by in the typography element for the display.</p>|


<a id="LabBench.Core.Setup.Display.DisplayQuestionnaireSetup"></a>
### DisplayQuestionnaireSetup

<p>Displays questionnaires for participants to complete, which can be used to ask the participants to provide answers to:</p>
<ul>
<li>Boolean Questions: binary questions answered with either a true or false statement.</li>
<li>Numerical Questions: numbers provided by the participant but entered by the operator.</li>
<li>Text Questions: verbal answers provided by the participant but entered by the operator.</li>
<li>Likert Questions: A scale that captures how strongly someone agrees, disagrees, or feels about a statement using a fixed set of ordered response options.</li>
<li>List Questions: A set of binary statements that each can be either true or false.</li>
<li>Time Questions: a date and time provided by the participant, entered by the operator.</li>
<li>Map Questions: a set of regions, such as a body map, where each region can be marked.</li>
<li>Categorical Rating Questions: rating of a sensation on a categorical scale.</li>
<li>Numerical Rating Questions: rating of a sensation on a numerical scale.</li>
<li>Visual Rating Questions: rating of a sensation on a visual analog rating scale.</li>
</ul>
<p>For the participants to fill out these questions, the controller-device must define the following buttons:</p>
<ul>
<li><code>up</code>, <code>down</code>: Is used by Boolean and Likert questions to set answers, and is used by List and Map questions to navigate between answers.</li>
<li><code>left</code>, <code>right</code>: Is used by Map questions to navigate between answers.</li>
<li><code>increase</code>, <code>decrease</code>: Is used by Map, List, Likert, and Rating questions to set answers.</li>
<li><code>previous</code>, <code>next</code>: used to navigate between questions.</li>
</ul>
<p>If the controller-device also implements the Joystick instrument, this joystick can be used to move between selected areas in map questions.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Device identification that will be used to identify the sub-device in device assignments [ Text ].</p>|
|<p>experimental-setup-id</p>|<p>required</p>|<p>Identification of the experimental setup state where this device will be active [ Text ].</p>|
|<p>controller-device</p>|<p>required</p>|<p>Identification of the device used to control this device [ Text ].</p>|


<a id="LabBench.Core.Setup.EVAS.EVASSetup"></a>
### EVASSetup

<p>QSTLab eVAS</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>initialize-rating-to-zero</p>|<p>optional</p>|<p>Reset the rating to zero when a test is started [ bool ].</p>|
|<p>id</p>|<p>required</p>|<p>Identification of the device, which is used to identify the device when it is assigned to tests in the protocol.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<visual-analog-scale>`](#LabBench.Interface.Setup.Response.Scales.VisualAnalogScaleSetup)</p> | <p>optional</p> |<p>A visual analog scale (VAS) represents a ratio scale along which observers report the perceived magnitude of a subjective sensation. A ratio scale means that responses are defined on a continuum, with a true zero corresponding to the absence of the perceptual quantity, and equal distances along the scale correspond to equal increments in perceived magnitude. As a consequence, ratios between values are interpretable (e.g., a response at 60 can be meaningfully understood as twice the perceived intensity of a response at 30, under the assumptions of the scale).</p> <p>The scale is defined by a  modality and the lower and upper anchors of the perceptual dimension. The lower anchor denotes the null intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality. The scale is also defined by its physical length, typically 10cm.</p>|


<a id="LabBench.Core.Setup.DeviceAssignment"></a>
### DeviceAssignment

<p>Assignment of a device to an instrument required by one or more of the tests in the protocol.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>device-id</p>|<p>required</p>|<p>Identification of the device, this must be the ID of a device defined in the devices section of the experimental setup.</p>|
|<p>test-type</p>|<p>optional</p>|<p>If specified then the device will be assigned to the instrument-name for all tests of this type. If a test-type is not specified then the device will be assigned to all tests regardless of their type.</p>|
|<p>test-id</p>|<p>optional</p>|<p>If specified the device will only be assigned to one test in the protocol with has this specified test-id.</p>|
|<p>instrument-name</p>|<p>required</p>|<p>Instrument name that the tests in the protocol has assigned to the instrument.</p>|


<a id="LabBench.Core.ExperimentalSetupCollection"></a>
### ExperimentalSetupCollection

<p>Defines possible experimental setups for the protocol.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>default</p>|<p>optional</p>|<p>Identifier of the default experimental setup. This setup will be used when an experiment is installed remotely.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<experimental-setup>`](#LabBench.Core.Setup.ExperimentalSetup) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Protocol"></a>
### Protocol

<p>This element defines the protocol for the experiment. The main part of the protocol definition is the definition of the tests (experimental procedures) performed in the experimental sessions. The test definitions must be performed for all protocols and are supported by optional elements.</p>
<p>This protocol contains the following elements:</p>
<ol>
<li><code>&lt;languages&gt;</code>: this <strong>optional</strong> element defines the languages/cultures for which the protocol is localized. If present, the startup wizard will display a page where the operator can select the language to use in the current experimental session.</li>
<li><code>&lt;sessions&gt;</code>: this <strong>optional</strong> element defines the sessions of the experiment. If present, the startup wizard will display a page where the operator can select the current session, and each test in the <code>&lt;tests&gt;</code> element must define which session it belongs to. When the session is performed, the LabBench Runner will only display tests for the current session.</li>
<li><code>&lt;properties&gt;</code>: this <strong>optional</strong> element defines properties of the protocol that modifies the execution of the tests.</li>
<li><code>&lt;randomizations&gt;</code>: this <strong>optional</strong> element defines variables generated once a subject is created and exported with the recorded data. The primary use of these variables is randomization. However, they can be used for any variable that should be persisted in the data set.</li>
<li><code>&lt;defines&gt;</code>: this <strong>optional</strong> element defines variables that can have any type. Consequently, they can be used for complex variables not saved in the data set, such as Python classes created in backing scripts. They are created every time a session is started.</li>
<li><code>&lt;templates&gt;</code>: this <strong>optional</strong> element defines template variables and test templates that can be used to construct tests at runtime in the <code>&lt;tests&gt;</code> element.</li>
<li><code>&lt;tests&gt;</code>: this <strong>mandatory</strong> element defines the tests of the protocol. These can be directly defined in this element or constructed from test templates defined in the <code>&lt;templates&gt;</code> element.</li>
<li><code>&lt;assets&gt;</code>: this <strong>optional</strong> element defines external files that the tests in the protocol can use.</li>
</ol>
<p>The order of these elements is significant and must be defined in the order given above.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<languages>`](#LabBench.Core.LanguageCollection)</p> | <p>optional</p> |<p>The <code>&lt;languages&gt;</code> element can localize protocols. When specified, it must contain a list of languages, which will be shown to the operator in the Startup wizard in LabBench Runner. The operator can then select one language, and its language code will be added to the definition as the variable <code>Language</code>.</p> <p>Consequently, this <code>Language</code> variable can then be used in Python expressions and scripts to provide the correct translations of the text in the protocol. Protocol assets in the <code>&lt;assets&gt;</code> can also select different files based on the selected language code.</p> <p>Use of language codes from the <a href="https://www.iso.org/iso-639-language-code">ISO 639</a> standard is recommended, as this standard guarantees that protocols can be combined. A list of ISO 639 language codes can be found at <a href="https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes">List of ISO 639 language codes</a></p>|
| <p>[`<sessions>`](#LabBench.Core.SessionConfiguration)</p> | <p>optional</p> |<p>Defines the list of individual experimental sessions scheduled for each participant in the study.</p> <p>In human neuroscience and clinical trials, a session is a distinct visit or time block during which a subject completes a specific set of procedures, such as cognitive tasks, drug administration, imaging, or behavioral assessments. Sessions are often spread across days or weeks to observe changes over time, reduce participant burden, or separate different experimental conditions.</p> <p>Each <code>&lt;session&gt;</code> entry within this block should include a unique id and a descriptive name. Sessions are critical for organizing the study timeline, managing subject logistics, and ensuring consistent data collection across repeated measures or trial phases.</p> <p>Use this tag to structure how data and procedures are grouped over time in your protocol. When LabBench Runner is started, the operator will choose an active session in the Startup Wizard.</p> <p>In Python code the <code>id</code> of the currently active session is available as <code>tc.ActiveSession</code>.</p>|
| <p>[`<properties>`](#LabBench.Core.Properties.ProtocolProperties)</p> | <p>optional</p> |<p>Defines protocol level properties.</p>|
| <p>[`<randomizations>`](#LabBench.Core.Randomization.RandomizationGenerator)</p> | <p>optional</p> |<p>Defines random variables that are assigned once when a subject is enrolled in the study and remain constant across all sessions.</p> <p>These variables are used to represent subject-specific randomized factors such as treatment group assignment, stratification variables, or any random attributes that do not change over time. By defining them here, you ensure that these values are generated at subject creation and stay invariant throughout the entire experimental protocol.</p> <p>Use <code>&lt;randomizations&gt;</code> to organize all subject-level random factors critical for consistent data labeling and analysis. These variables are included in the exported data set.</p>|
| <p>`<defines>`</p> | <p>optional</p> |<p> The `<defines>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Definition"><code>&lt;define&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<templates>`](#LabBench.Core.Templating.TemplateCollection)</p> | <p>optional</p> |<p>This element defines template variables and test templates that can be used to programmatically generate the tests in the protocol. Tests can be generated with test constructors in the <code>&lt;tests&gt;</code> element. Using test templates to create tests <code>&lt;tests&gt;</code> element is called templating and can be seen as code-generating code. Constructors generate tests at the place in the <code>&lt;tests&gt;</code> element where the constructor is defined.</p> <p>Constructors can be organized into <code>&lt;sequences&gt;</code> and generated by <code>&lt;foreach&gt;</code> loops. Both <code>&lt;sequences&gt;</code>  and <code>&lt;foreach&gt;</code> elements make it possible to perform randomization of the order in which the generated tests appear in the protocol.</p>|
| <p>[`<tests>`](#LabBench.Core.Tests.TestCollection)</p> | <p>optional</p> |<p>The <code>&lt;tests&gt;</code> element defines the tests of the protocol. These can be directly defined in this element or constructed from test templates defined in the <code>&lt;templates&gt;</code> element.</p>|
| <p>[`<assets>`](#LabBench.Core.Assets.AssetManager)</p> | <p>optional</p> |<p>Files can be included in experiments in the form of assets within the <code>&lt;assets&gt;</code> element in the Experiment Definition File. This element consists of a set of <code>&lt;file-asset&gt;</code> that can be used in tests and Python code.</p> <p>The following assets can be included:</p> <ul> <li><strong>.py</strong>: Python code</li> <li><strong>.md</strong>: Markdown Files</li> <li><strong>.txt</strong>: Text Files</li> <li><strong>.rtf</strong>: Rich Text Format</li> <li><strong>.png</strong>: Portable Network Graphics</li> <li><strong>.zip</strong>: Zip files</li> <li><strong>.json</strong>: Data files</li> <li><strong>.wav</strong>: Sound files</li> <li><strong>.csv</strong>: Comma Separated Values</li> <li><strong>.svg</strong>: Scalable Vector Graphics</li> <li><strong>.ttf</strong>: True Type Fonts</li> </ul> <p>Within calculated parameters, assets can be referred to by the <code>id</code> with the following notation: <code>Asset.[AssetID]</code>. Files within zip archives can be further addressed as <code>Asset.[AssetID].[Name of file without extension]</code>. Please note that paths and extensions within zip files are not considered. Consequently, in a zip file, there must be only one file with a given name, regardless of its extension or location within the zip file.</p>|


<a id="LabBench.Core.LanguageCollection"></a>
### LanguageCollection

<p>The <code>&lt;languages&gt;</code> element can localize protocols. When specified, it must contain a list of languages, which will be shown to the operator in the Startup wizard in LabBench Runner. The operator can then select one language, and its language code will be added to the definition as the variable <code>Language</code>.</p>
<p>Consequently, this <code>Language</code> variable can then be used in Python expressions and scripts to provide the correct translations of the text in the protocol. Protocol assets in the <code>&lt;assets&gt;</code> can also select different files based on the selected language code.</p>
<p>Use of language codes from the <a href="https://www.iso.org/iso-639-language-code">ISO 639</a> standard is recommended, as this standard guarantees that protocols can be combined. A list of ISO 639 language codes can be found at <a href="https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes">List of ISO 639 language codes</a></p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<language>`](#LabBench.Core.Language) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Language"></a>
### Language

<p>Definition of a language.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>code</p>|<p>required</p>|<p>This attribute is the language code (ISO 639) used to identify the language in the protocol [ Text ].</p>|
|<p>name</p>|<p>required</p>|<p>This attribute is the name of that language that will be shown in the Startup Wizard [ Text ].</p>|


<a id="LabBench.Core.SessionConfiguration"></a>
### SessionConfiguration

<p>Defines the list of individual experimental sessions scheduled for each participant in the study.</p>
<p>In human neuroscience and clinical trials, a session is a distinct visit or time block during which a subject completes a specific set of procedures, such as cognitive tasks, drug administration, imaging, or behavioral assessments. Sessions are often spread across days or weeks to observe changes over time, reduce participant burden, or separate different experimental conditions.</p>
<p>Each <code>&lt;session&gt;</code> entry within this block should include a unique id and a descriptive name. Sessions are critical for organizing the study timeline, managing subject logistics, and ensuring consistent data collection across repeated measures or trial phases.</p>
<p>Use this tag to structure how data and procedures are grouped over time in your protocol. When LabBench Runner is started, the operator will choose an active session in the Startup Wizard.</p>
<p>In Python code the <code>id</code> of the currently active session is available as <code>tc.ActiveSession</code>.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<session>`](#LabBench.Core.SessionDefinition) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.SessionDefinition"></a>
### SessionDefinition

<p>Defines a single experimental session within the overall study timeline.</p>
<p>A session represents one scheduled visit or timepoint when a participant engages in specific tasks or procedures. Each session must have a unique <code>id</code> (used for referencing and tracking) and a human-readable <code>name</code> (used for display and documentation).</p>
<p>Sessions are the building blocks of longitudinal and multi-phase protocols, allowing researchers to organize data collection across multiple timepoints such as baseline, intervention, and follow-up. The order and content of sessions are often tied to the study design and are critical for analysis and reproducibility.</p>
<p><strong>Attributes:</strong></p>
<ul>
<li><code>id</code>: A short, unique identifier (e.g., <code>&quot;SES01&quot;</code>) this will be used to identify the session in the LabBench markup language and in included Python code.</li>
<li><code>name</code>: A descriptive human-readable name (e.g., <code>&quot;Session 1&quot;</code> or <code>&quot;Pre-treatment Visit&quot;</code>) this is the name that will be shown to the operator in the LabBench Runner startup wizard.</li>
</ul>
<p><strong>Example:</strong></p>
<pre><code class="language-xml">&lt;session id=&quot;SES01&quot; name=&quot;Session 1&quot; /&gt;
</code></pre>
<p>Use one <code>&lt;session&gt;</code> element per visit to clearly define the structure of your experimental schedule.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>A unique identifier for the session, used for referencing within the protocol.</p>|
|<p>name</p>|<p>required</p>|<p>A human-readable label for the session, used for display in the LabBench Runner Startup Wizard.</p>|


<a id="LabBench.Core.Properties.ProtocolProperties"></a>
### ProtocolProperties

<p>Defines protocol level properties.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<rerun-policy>`](#LabBench.Core.Properties.ProtocolRerunPolicy)</p> | <p>optional</p> |<p>Specifies a test rerun policy for the protocol. When a test is completed its results will automatically be saved in the current session. However, if a test is rerun these results will be discarded and replaced with the new results from the test. When a test is rerun a warning dialog will be displayed, which can be customized by this rerun policy to display a custom message and to require that a reason is provided before the test can be restarted.</p>|
| <p>[`<incomplete-protocol-warning>`](#LabBench.Core.XmlTools.BooleanValue)</p> | <p>optional</p> |<p>Display a warning if the protocol is incomplete when the LabBench Runner is closed.</p>|
| <p>[`<allow-in-session-participant-creation>`](#LabBench.Core.XmlTools.BooleanValue)</p> | <p>optional</p> |<p>Allow participants to be created during a session. The default is true.</p>|
| <p>[`<in-session-display-of-participants>`](#LabBench.Core.XmlTools.BooleanValue)</p> | <p>optional</p> |<p>Display the list of existing participants during in-session selection or creation of a participant. The default is true.</p>|


<a id="LabBench.Core.Properties.ProtocolRerunPolicy"></a>
### ProtocolRerunPolicy

<p>Specifies a test rerun policy for the protocol. When a test is completed its results will automatically be saved in the current session. However, if a test is rerun these results will be discarded and replaced with the new results from the test. When a test is rerun a warning dialog will be displayed, which can be customized by this rerun policy to display a custom message and to require that a reason is provided before the test can be restarted.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>message</p>|<p>optional</p>|<p>The message to be displayed to the operator [ DynamicText ]. The default value is 'Rerunning the test will discard the current results.'.</p>|
|<p>require-reason</p>|<p>optional</p>|<p>Force the operator to provide a reason for rerunning the test that is entered into the session log.</p>|
|<p>force-warning</p>|<p>optional</p>|<p>Display the warning when a test that discards data is rerun. The default value is false.</p>|


<a id="LabBench.Core.XmlTools.BooleanValue"></a>
### BooleanValue

<p>bool</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|
|<p>value</p>|<p>required</p>|<p>Boolean value [ bool ].</p>|


<a id="LabBench.Core.Randomization.RandomizationGenerator"></a>
### RandomizationGenerator

<p>Defines random variables that are assigned once when a subject is enrolled in the study and remain constant across all sessions.</p>
<p>These variables are used to represent subject-specific randomized factors such as treatment group assignment, stratification variables, or any random attributes that do not change over time. By defining them here, you ensure that these values are generated at subject creation and stay invariant throughout the entire experimental protocol.</p>
<p>Use <code>&lt;randomizations&gt;</code> to organize all subject-level random factors critical for consistent data labeling and analysis. These variables are included in the exported data set.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<integers>`](#LabBench.Core.Randomization.RandomIntegerList) </span><br /><span style="white-space: nowrap;">  [`<integer>`](#LabBench.Core.Randomization.RandomInteger) </span><br /><span style="white-space: nowrap;">  [`<strings>`](#LabBench.Core.Randomization.RandomStringList) </span><br /><span style="white-space: nowrap;">  [`<string>`](#LabBench.Core.Randomization.RandomString) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Randomization.RandomIntegerList"></a>
### RandomIntegerList

<p>Defines a named set of integer values that can be used as fixed options or parameters within the experimental protocol.</p>
<p>This element uses a Python-style list (<code>[1,2,3]</code>) in the <code>value</code> attribute structured list syntax.
The <code>name</code> attribute assigns a variable name to the set, and the <code>value</code> attribute provides the list of integers.</p>
<p><strong>Attributes:</strong></p>
<ul>
<li><code>name</code>: A descriptive name for the integer set (e.g., <code>&quot;Order&quot;</code>) [ text ].</li>
<li><code>value</code>: A list of integers enclosed in square brackets and separated by commas (e.g., <code>&quot;[1,2,3]&quot;</code>) [ int = Calculated(tc) ].</li>
</ul>
<p><strong>Examples:</strong></p>
<p>Defined within the LabBench Markup Language:</p>
<pre><code class="language-xml">&lt;integers name=&quot;Order&quot; value=&quot;[1,2,3]&quot; /&gt;
</code></pre>
<p>Defined in a Python backing script:</p>
<pre><code class="language-xml">&lt;integers name=&quot;Order&quot; value=&quot;func: Script.CreateOrder(tc)&quot; /&gt;
</code></pre>
<p>Within the LabBench Markup Language the created variable can be accessed by its <code>name</code>, and within a Python script it can be accessed as <code>tc.[Name]</code>.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>||
|<p>value</p>|<p>required</p>||


<a id="LabBench.Core.Randomization.RandomInteger"></a>
### RandomInteger

<p>Defines a single named integer value to be used as a fixed parameter in the experimental protocol.</p>
<p>The <code>name</code> attribute specifies the label for the value, and the <code>value</code> attribute holds the integer itself. This element is useful for defining constants such as counts, limits, or configuration parameters that apply across sessions or subjects.</p>
<p><strong>Attributes:</strong></p>
<ul>
<li><code>name</code>: A descriptive name for the parameter (e.g., <code>&quot;NumberOfSites&quot;</code>) [ text ].</li>
<li><code>value</code>: A single integer value (e.g., <code>&quot;4&quot;</code>) [ int = Calculated(tc) ].</li>
</ul>
<p><strong>Example:</strong></p>
<p>Defined within the LabBench Markup Language:</p>
<pre><code class="language-xml">&lt;strings name=&quot;NumberOfSites&quot; value=&quot;4&quot; /&gt; 
</code></pre>
<p>Defined in a Python backing script:</p>
<pre><code class="language-xml">&lt;integers name=&quot;NumberOfSites&quot; value=&quot;func: Script.CreateNumberOfSites(tc)&quot; /&gt;
</code></pre>
<p>Within the LabBench Markup Language the created variable can be accessed by its <code>name</code>, and within a Python script it can be accessed as <code>tc.[Name]</code>.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>||
|<p>value</p>|<p>required</p>||


<a id="LabBench.Core.Randomization.RandomStringList"></a>
### RandomStringList

<p>Defines a named set of string values to be used as fixed options or parameters within the experimental protocol.</p>
<p>This element uses a Python-style list (<code>['Cowhage','Histamine']</code>) in the <code>value</code> attribute. The <code>name</code> attribute specifies the label, and the <code>value</code> attribute provides a list of string options.</p>
<p><strong>Attributes:</strong></p>
<ul>
<li><code>name</code>: A descriptive name for the string set (e.g., <code>&quot;Puritogens&quot;</code>) [ text ].</li>
<li><code>value</code>: A list of strings enclosed in square brackets and separated by commas, with each string in single quotes (e.g., <code>['Cowhage','Histamine']</code>).</li>
</ul>
<p><strong>Example:</strong></p>
<p>Defined within the LabBench Markup Language:</p>
<pre><code class="language-xml">&lt;strings name=&quot;Puritogens&quot; value=&quot;['Cowhage','Histamine']&quot; /&gt; [ text[] = Calculated(tc) ].
</code></pre>
<p>Defined in a Python backing script:</p>
<pre><code class="language-xml">&lt;integers name=&quot;Order&quot; value=&quot;func: Script.CreatePruritogens(tc)&quot; /&gt;
</code></pre>
<p>Within the LabBench Markup Language the created variable can be accessed by its <code>name</code>, and within a Python script it can be accessed as <code>tc.[Name]</code>.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>||
|<p>value</p>|<p>required</p>||


<a id="LabBench.Core.Randomization.RandomString"></a>
### RandomString

<p>Defines a single named string value to be used as a fixed parameter in the experimental protocol.</p>
<p>The <code>name</code> attribute assigns a label to the value, and the <code>value</code> attribute provides the string itself. This is useful for specifying constant text values such as site names, condition labels, or protocol settings that do not change during the study.</p>
<p><strong>Attributes:</strong></p>
<ul>
<li><code>name</code>: A descriptive name for the parameter (e.g., <code>&quot;SiteName&quot;</code>).</li>
<li><code>value</code>: A single string value (e.g., <code>&quot;'Arm'&quot;&quot;</code>) [ text = Calculated(tc) ].</li>
</ul>
<p><strong>Example:</strong></p>
<p>Defined within the LabBench Markup Language:</p>
<pre><code class="language-xml">&lt;strings name=&quot;SiteName&quot; value=&quot;'Arm'&quot; /&gt; 
</code></pre>
<p>Defined in a Python backing script:</p>
<pre><code class="language-xml">&lt;integers name=&quot;SiteName&quot; value=&quot;func: Script.CreateSiteName(tc)&quot; /&gt;
</code></pre>
<p>Within the LabBench Markup Language the created variable can be accessed by its <code>name</code>, and within a Python script it can be accessed as <code>tc.[Name]</code>.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>||
|<p>value</p>|<p>required</p>||


<a id="LabBench.Core.Definition"></a>
### Definition

<p>Definition of a variable that can be used in calculated parameters.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name of the variable [ Text ].</p>|
|<p>value</p>|<p>required</p>|<p>The value of the variable [ Any = Calculated(tc) ].</p>|


<a id="LabBench.Core.Templating.TemplateCollection"></a>
### TemplateCollection

<p>This element defines template variables and test templates that can be used to programmatically generate the tests in the protocol. Tests can be generated with test constructors in the <code>&lt;tests&gt;</code> element. Using test templates to create tests <code>&lt;tests&gt;</code> element is called templating and can be seen as code-generating code. Constructors generate tests at the place in the <code>&lt;tests&gt;</code> element where the constructor is defined.</p>
<p>Constructors can be organized into <code>&lt;sequences&gt;</code> and generated by <code>&lt;foreach&gt;</code> loops. Both <code>&lt;sequences&gt;</code>  and <code>&lt;foreach&gt;</code> elements make it possible to perform randomization of the order in which the generated tests appear in the protocol.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Template variables are used to generate text and calculated parameter attributes in tests. List test variables can also be iterated over in  <code>&lt;foreach&gt;</code> loops and thus generate multiple tests, each differing by an element in this list.</p> <p>An example of the generated of a test ID from a template variable:</p> <pre><code class="language-xml">id=&quot;var: 'B05{t}'.format(t = t)&quot; </code></pre> <p>The keyword <code>var:</code> instructs the test constructor to generate the value of the <code>id</code> programmatically from the Python expression in the code; the template variable is named <code>t</code>, which comes from the following for each loop:</p> <pre><code class="language-xml">&lt;foreach variable=&quot;t&quot; in=&quot;tests&quot;&gt; </code></pre>|
| <p>[`<content>`](#LabBench.Core.Templating.TemplateList)</p> | <p>optional</p> |<p>The <code>&lt;content&gt;</code> element defines the test templates from which test constructors can generate tests.</p>|


<a id="LabBench.Core.Templating.VariableCollection"></a>
### VariableCollection

<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<string>`](#LabBench.Core.Templating.Variables.StringVariable) </span><br /><span style="white-space: nowrap;">  [`<strings>`](#LabBench.Core.Templating.Variables.StringListVariable) </span><br /><span style="white-space: nowrap;">  [`<struct>`](#LabBench.Core.Templating.Variables.StructVariable) </span><br /><span style="white-space: nowrap;">  [`<structs>`](#LabBench.Core.Templating.Variables.StructListVariable) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Templating.Variables.StringVariable"></a>
### StringVariable

<p>string</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name of the variable [ string ].</p>|
|<p>value</p>|<p>required</p>|<p>Value of the variable [ string ].</p>|


<a id="LabBench.Core.Templating.Variables.StringListVariable"></a>
### StringListVariable

<p>string[]</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name of the variable [ string ].</p>|
|<p>value</p>|<p>required</p>|<p>Value of the variable [ string ]. List of strings are specified as strings seperated by semicolons <code>;</code>.</p>|


<a id="LabBench.Core.Templating.Variables.StructVariable"></a>
### StructVariable

<p>struct</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name of the variable [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<string>`](#LabBench.Core.Templating.Variables.StringVariable) </span><br /><span style="white-space: nowrap;">  [`<struct>`](#LabBench.Core.Templating.Variables.StructVariable) </span><br /><span style="white-space: nowrap;">  [`<strings>`](#LabBench.Core.Templating.Variables.StringListVariable) </span><br /><span style="white-space: nowrap;">  [`<structs>`](#LabBench.Core.Templating.Variables.StructListVariable) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Templating.Variables.StructListVariable"></a>
### StructListVariable

<p>struct[]</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name of the variable [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<struct>`](#LabBench.Core.Templating.Variables.UnnamedStructVariable) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Templating.Variables.UnnamedStructVariable"></a>
### UnnamedStructVariable

<p>struct</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<string>`](#LabBench.Core.Templating.Variables.StringVariable) </span><br /><span style="white-space: nowrap;">  [`<struct>`](#LabBench.Core.Templating.Variables.StructVariable) </span><br /><span style="white-space: nowrap;">  [`<strings>`](#LabBench.Core.Templating.Variables.StringListVariable) </span><br /><span style="white-space: nowrap;">  [`<structs>`](#LabBench.Core.Templating.Variables.StructListVariable) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Templating.TemplateList"></a>
### TemplateList

<p>The <code>&lt;content&gt;</code> element defines the test templates from which test constructors can generate tests.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<questionnaire>`](#LabBench.Core.Tests.Meta.Survey.SurveyTemplate) </span><br /><span style="white-space: nowrap;">  [`<sequential>`](#LabBench.Core.Tests.Meta.Sequential.SequentialTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<stimulation-sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.EvokedPotentialsTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<algometry-stimulus-response>`](#LabBench.Core.Tests.Algometry.StimulusResponse.AlgometryStimulusResponseTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<algometry-conditioned-pain-modulation>`](#LabBench.Core.Tests.Algometry.ConditionedPain.AlgometryConditionedPainTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<algometry-temporal-summation>`](#LabBench.Core.Tests.Algometry.TemporalSummation.AlgometryTemporalSummationTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<algometry-static-temporal-summation>`](#LabBench.Core.Tests.Algometry.StaticTemporalSummation.AlgometryStaticTemporalSummationTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<algometry-stimulus-rating>`](#LabBench.Core.Tests.Algometry.StimulusRating.AlgometryStimulusRatingTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<algometry-conditioned-pain-modulation-rating>`](#LabBench.Core.Tests.Algometry.ConditionedPainRating.AlgometryConditionedPainRatingTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<algometry-arbitrary-temporal-summation>`](#LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.AlgometryArbitraryTemporalSummationTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-threshold-estimation>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ThresholdEstimationTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-cold-pressor>`](#LabBench.Core.Tests.Psychophysics.ColdPresser.ColdPressorTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-manual-threshold-estimation>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualThresholdEstimationTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-response-recording>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.ResponseRecordingTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-stimulus-presentation>`](#LabBench.Core.Tests.Psychophysics.StimulusPresentation.StimulusPresentationTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<thermal-rated-stimulation>`](#LabBench.Core.Tests.Thermal.RatedStimulation.ThermalRatedStimulationTestTemplate) </span><br /><span style="white-space: nowrap;">  [`<thermal-threshold-estimation>`](#LabBench.Core.Tests.Thermal.ThresholdEstimation.ThermalThresholdEstimationTestTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Survey.SurveyTemplate"></a>
### SurveyTemplate

<p>The questionnaire test allows either the operator or the participant to answer a set of questions.
The questionnaire can consist of the following types of questions:</p>
<ul>
<li><strong>Boolean Questions</strong>: questions that have mutually exclusive binary answer, which usually consists
of answering a true or false statement, but can also consist of dichotomies such as child/adult.</li>
<li><strong>Numerical Questions</strong>: are questions that can be answered with numerical answers.</li>
<li><strong>Text Questions</strong>: are questions that can be answered with either free or validated text.</li>
<li><strong>Likert Questions</strong>: A scale that captures how strongly someone agrees, disagrees, or feels about a
statement using a fixed set of ordered response options.</li>
<li><strong>List Questions</strong>: A set of binary statements that each can be either true or false.</li>
<li><strong>Time Questions</strong>: a date and time provided by the participant, entered by the operator.</li>
<li><strong>Map Questions</strong>: is answered by marking one or more regions, such as areas on a body map.</li>
<li><strong>Categorical Rating Questions</strong>: rating of a sensation on a categorical scale.</li>
<li><strong>Numerical Rating Questions</strong>: rating of a sensation on a numerical scale.</li>
<li><strong>Visual Rating Questions</strong>: rating of a sensation on a visual analog rating scale.</li>
</ul>
<p>All questions are identified with an id and have a title and an instruction. If the questionnaire is to be
answered by the participant, a <code>Questionnaire</code> instrument must be assigned to the test in the experimental setup.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>progress-format</p>|<p>optional</p>|<p>Controls the progress information that is provided by the test:</p> <ul> <li><code>none</code>: no progresss information is provided.</li> <li><code>percentage</code>: progress is provided as the percentage of completed questions.</li> <li><code>index</code>: progress is provided as [current question no] / [total number of questions].</li> </ul>|
|<p>control</p>|<p>optional</p>|<p>Sets whether the questionnaire is filled out by the operator or the participant:</p> <ul> <li><code>operator</code>: answers are provided by the operator.</li> <li><code>subject</code>: answers are provided by the participant. In this mode a Questionnaire instrument must be assigned to the test.</li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>`<templates>`</p> | <p>optional</p> |<p> The `<templates>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.BaseTemplate"><code>&lt;instruction&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.AreaQuestionTemplate"><code>&lt;map&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.TextQuestionTemplate"><code>&lt;text&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.BooleanQuestionTemplate"><code>&lt;boolean&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.NumericalQuestionTemplate"><code>&lt;numeric&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.LikertQuestionTemplate"><code>&lt;likert&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.DimensionalLikertQuestionTemplate"><code>&lt;dimensional-likert&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.BooleanListQuestionTemplate"><code>&lt;list&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.DateTimeQuestionTemplate"><code>&lt;time&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.VisualAnalogScaleQuestionTemplate"><code>&lt;visual-analog-scale&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.NumericalScaleQuestionTemplate"><code>&lt;numerical-scale&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.CategoricalScaleQuestionTemplate"><code>&lt;categorical-scale&gt;</code></a> </span></li> </ul> </p>|
| <p>`<content>`</p> | <p>optional</p> |<p> The `<content>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.AreaQuestionConstructor"><code>&lt;map&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.TextQuestionConstructor"><code>&lt;text&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.BooleanQuestionConstructor"><code>&lt;boolean&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.NumericalQuestionConstructor"><code>&lt;numeric&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.LikertQuestionConstructor"><code>&lt;likert&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.DimensionalLikertQuestionConstructor"><code>&lt;dimensional-likert&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.BooleanListQuestionConstructor"><code>&lt;list&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.DateTimeQuestionConstructor"><code>&lt;time&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.InstructionQuestionConstructor"><code>&lt;instruction&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.VisualAnalogScaleQuestionConstructor"><code>&lt;visual-analog-scale&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.NumericalScaleQuestionConstructor"><code>&lt;numerical-scale&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.CategoricalScaleQuestionConstructor"><code>&lt;categorical-scale&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.QuestionConstructorForeach"><code>&lt;foreach&gt;</code></a> </span></li> </ul> </p>|


<a id="LabBench.Core.Templating.TestEventsTemplate"></a>
### TestEventsTemplate

<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p>
<p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>start</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is started [ bool = Calculated(tc) ]. If False is returned the test will be aborted.</p>|
|<p>complete</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is completed [ bool = Calculated(tc) ]. If False is returned the test will be aborted.</p>|
|<p>abort</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is aborted [ bool = Calculated(tc) ]. Please note this calculated attribute must always return True.</p>|
|<p>selected</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is selected regardsless of its state [ bool = Calculated(tc) ]. Please note if a selected state is defined this will override the code provided in this attribute.</p>|
|<p>selected-blocked</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is selected and is in the blocked state [ bool = Calculated(tc) ].</p>|
|<p>selected-ready</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is selected and is in the ready state [ bool = Calculated(tc) ].</p>|
|<p>selected-completed</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is selected and is in the completed state [ bool = Calculated(tc) ].</p>|
|<p>selected-excluded</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is selected and is in the excluded state [ bool = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<instrument>`](#LabBench.Core.Templating.DeviceDescriptionTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Templating.DeviceDescriptionTemplate"></a>
### DeviceDescriptionTemplate

<p>@Schema.Core.Setup.DeviceDescription.md</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Instrument name of the instrument. There must be a device assignment with that instrument name of the correct instrument type.</p>|
|<p>interface</p>|<p>required</p>|<p>Type of instrument.</p>|


<a id="LabBench.Core.Templating.TestPropertiesTemplate"></a>
### TestPropertiesTemplate

<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<auto-start>`](#LabBench.Core.XmlTools.BooleanValue)</p> | <p>optional</p> |<p>Start the test when it is selected automatically when the previous test in the protocol has been completed. The test is only started automatically if the completion of a previous test selects the test. It is not started automatically if the operator manually selects the test. This test property can be used to speed up the execution of protocols. The default value of this test property is &quot;false,&quot; meaning tests will not be automatically started.</p>|
| <p>[`<auto-advance>`](#LabBench.Core.XmlTools.BooleanValue)</p> | <p>optional</p> |<p>This element controls whether the next test in the protocol will be automatically selected when the current test is completed. The default value is &quot;true,&quot; meaning the next test will be automatically selected.</p>|
| <p>[`<time-constraint>`](#LabBench.Core.Templating.TimeConstraintTemplate)</p> | <p>optional</p> |<p>This element places a time constraint on when the test can be started based on either the start time or completion time of another test in the protocol. The time constraint can impose a minimum (min attribute is specified) or maximum time (max attribute is specified) that must elapse before the test can be started or a time window (both min and max attributes are specified) within which the time can be started.</p>|
| <p>[`<extended-data-collection>`](#LabBench.Core.XmlTools.BooleanValue)</p> | <p>optional</p> |<p>This element sets a flag that can inform tests to collect more extended data. The extra data, if any, collected depends on the tests, and the documentation for the specific tests must be consulted to determine which extended data will be collected by setting this flag.</p>|
| <p>[`<instructions>`](#LabBench.Core.Templating.TestInstructionsTemplate)</p> | <p>optional</p> |<p>This element specifies instructions for the operator when the test is not running. They will be shown in the test window instead of the test-specific user interface.</p>|
| <p>[`<subject-instructions>`](#LabBench.Core.Templating.SubjectInstructionsTemplate)</p> | <p>optional</p> |<p>This element specifies instructions for the subject. They will be shown on an ImageDisplay instrument that must be assigned to the test in a device assignment in the experimental setup.</p>|
| <p>[`<next>`](#LabBench.Core.Templating.TestLinkTemplate)</p> | <p>optional</p> |<p>Link to another test within the protocol.</p>|
| <p>[`<previous>`](#LabBench.Core.Templating.TestLinkTemplate)</p> | <p>optional</p> |<p>Link to another test within the protocol.</p>|
| <p>[`<annotations>`](#LabBench.Core.Templating.TestAnnotationsTemplate)</p> | <p>optional</p> |<p>Custom data that can be added to test results either in the experiment definition file (*.expx) or by Python code.</p>|


<a id="LabBench.Core.Templating.TimeConstraintTemplate"></a>
### TimeConstraintTemplate

<p>This element places a time constraint on when the test can be started based on either the start time or completion time of another test in the protocol. The time constraint can impose a minimum (min attribute is specified) or maximum time (max attribute is specified) that must elapse before the test can be started or a time window (both min and max attributes are specified) within which the time can be started.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>test-id</p>|<p>required</p>|<p>This attribute specifies the ID of the test to which the timing constraint is relative.</p>|
|<p>min</p>|<p>optional</p>|<p>If this attribute is specified, it specifies the minimum time to pass before the test can be started. If the max attribute is also specified, the timing constraint is a time window in which the test can only be started within the minimum (min attribute) and maximum (max attribute) time values.</p>|
|<p>max</p>|<p>optional</p>|<p>If this attribute is specified, it specifies the maximum time that the test can be started. If the min attribute is also specified, the timing constraint is a time window in which the test can only be started within the minimum (min attribute) and maximum (max attribute) time values.</p>|
|<p>notification</p>|<p>optional</p>|<p>This attribute controls whether a beep should be sounded when the timing constraint is satisfied.</p>|
|<p>time-reference</p>|<p>optional</p>|<p>This attribute specifies whether the timing constraint is relative to a test's start or end (completion).</p>|


<a id="LabBench.Core.Templating.TestInstructionsTemplate"></a>
### TestInstructionsTemplate

<p>This element specifies instructions for the operator when the test is not running. They will be shown in the test window instead of the test-specific user interface.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>start-instruction</p>|<p>optional</p>|<p>Tooltip for the start button [ DynamicText]. If specified, this will override the default text.</p>|
|<p>override-results</p>|<p>optional</p>|<p>This attribute controls whether instructions will be shown instead of test results in the test window for completed tests. If set to true, instructions will be shown instead of the test results [ Boolean (true/false) ]. The default value is false.</p>|
|<p>default</p>|<p>optional</p>|<p>Instructions that will be shown if instructions are not specified for the current test state [ IAsset = Calculated(tc) ].</p>|
|<p>blocked</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its BLOCKED state. If this attribute is not specified, then the value of the default attribute will be shown instead [ IAsset = Calculated(tc) ]</p>|
|<p>ready</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its READY state. If this attribute is not specified, then the value of the default attribute will be shown instead [ IAsset = Calculated(tc) ].</p>|
|<p>excluded</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its EXCLUDED state. If this attribute is not specified, then the value of the default attribute will be shown instead [ IAsset = Calculated(tc) ].</p>|
|<p>completed</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its COMPLETED state. If this attribute is not specified, then the value of the default attribute will be shown instead [ IAsset = Calculated(tc) ].</p>|


<a id="LabBench.Core.Templating.SubjectInstructionsTemplate"></a>
### SubjectInstructionsTemplate

<p>This element specifies instructions for the subject. They will be shown on an ImageDisplay instrument that must be assigned to the test in a device assignment in the experimental setup.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>experimental-setup-id</p>|<p>required</p>|<p>This attribute specifies the experimental setup ID that will activate the assigned ImageDisplay [ Text ]. This ID can be different from the experimental setup ID for the test in general and will only be activated when the test is not running.</p>|
|<p>default</p>|<p>optional</p>|<p>Instructions that will be shown if instructions are not specified for the current test state [ IAsset = Calculated(tc) ].</p>|
|<p>blocked</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its BLOCKED state [ IAsset = Calculated(tc) ]. If this attribute is not specified, then the value of the default attribute will be shown instead.</p>|
|<p>ready</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its READY state [ IAsset = Calculated(tc) ]. If this attribute is not specified, then the value of the default attribute will be shown instead.</p>|
|<p>excluded</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its EXCLUDED state [ IAsset = Calculated(tc) ]. If this attribute is not specified, then the value of the default attribute will be shown instead.</p>|
|<p>completed</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its COMPLETED state [ IAsset = Calculated(tc) ]. If this attribute is not specified, then the value of the default attribute will be shown instead.</p>|


<a id="LabBench.Core.Templating.TestLinkTemplate"></a>
### TestLinkTemplate

<p>Link to another test within the protocol.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification (<code>id</code>) of the test that is linked to [ dynamic string ].</p>|


<a id="LabBench.Core.Templating.TestAnnotationsTemplate"></a>
### TestAnnotationsTemplate

<p>Custom data that can be added to test results either in the experiment definition file (*.expx) or
by Python code.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<bool>`](#LabBench.Core.XmlTools.BooleanValueTemplate) </span><br /><span style="white-space: nowrap;">  [`<bools>`](#LabBench.Core.XmlTools.BooleanListValueTemplate) </span><br /><span style="white-space: nowrap;">  [`<number>`](#LabBench.Core.XmlTools.NumberValueTemplate) </span><br /><span style="white-space: nowrap;">  [`<numbers>`](#LabBench.Core.XmlTools.NumberListValueTemplate) </span><br /><span style="white-space: nowrap;">  [`<string>`](#LabBench.Core.XmlTools.StringValueTemplate) </span><br /><span style="white-space: nowrap;">  [`<strings>`](#LabBench.Core.XmlTools.StringListValueTemplate) </span><br /><span style="white-space: nowrap;">  [`<integer>`](#LabBench.Core.XmlTools.IntegerValueTemplate) </span><br /><span style="white-space: nowrap;">  [`<integers>`](#LabBench.Core.XmlTools.IntegerListValueTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.XmlTools.BooleanValueTemplate"></a>
### BooleanValueTemplate

<p>bool</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|
|<p>value</p>|<p>required</p>||


<a id="LabBench.Core.XmlTools.BooleanListValueTemplate"></a>
### BooleanListValueTemplate

<p>bool[]</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<bool>`](#LabBench.Core.XmlTools.BooleanValueTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.XmlTools.NumberValueTemplate"></a>
### NumberValueTemplate

<p>double</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|
|<p>value</p>|<p>required</p>|<p>Value [ double ].</p>|


<a id="LabBench.Core.XmlTools.NumberListValueTemplate"></a>
### NumberListValueTemplate

<p>double[]</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<number>`](#LabBench.Core.XmlTools.NumberValueTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.XmlTools.StringValueTemplate"></a>
### StringValueTemplate

<p>string</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|
|<p>value</p>|<p>required</p>|<p>Value [ string ].</p>|


<a id="LabBench.Core.XmlTools.StringListValueTemplate"></a>
### StringListValueTemplate

<p>string[]</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<text>`](#LabBench.Core.XmlTools.StringValueTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.XmlTools.IntegerValueTemplate"></a>
### IntegerValueTemplate

<p>int</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|
|<p>value</p>|<p>required</p>|<p>Integer value [ int ].</p>|


<a id="LabBench.Core.XmlTools.IntegerListValueTemplate"></a>
### IntegerListValueTemplate

<p>int[]</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<number>`](#LabBench.Core.XmlTools.IntegerValueTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Templating.TestDependencyTemplate"></a>
### TestDependencyTemplate

<p>Calculated parameters and Python code may use results from previously completed tests.
For example, a Stimulation sequence test may set the intensity (<code>x=&quot;[TestID].[ChannelID]</code>)of
the stimuli to thresholds determined in a completed Threshold Estimation test. However, if
the stimulation sequence test is started before the Threshold Estimation test has been completed,
the code above would result in a runtime error.</p>
<p>Consequently, it must be declared if the results of a test are used in another test. This declaration
is done with the <code>&lt;dependency&gt;</code> element within the <code>&lt;dependencies&gt;</code> element in the test definition.</p>
<p>These dependencies can be nonvirtual or virtual. If a test dependency is nonvirtual, rerunning
the dependency will invalidate the dependent's results, meaning that after the dependency has
completed, the dependent's results will be discarded. If a test dependency is virtual, it means
it is a logical dependency that does not invalidate the results of the dependent. Consequently,
in that case, the result of the dependent will not be discarded when the dependency is completed.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the test that the current test depends on [ string ].</p>|
|<p>virtual</p>|<p>optional</p>|<p>Is it a virtual dependency [ bool ].</p>|


<a id="LabBench.Core.Templating.ConditionTemplate"></a>
### ConditionTemplate

<p>Makes it possible to exclude tests based on the results of completed tests.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>expression</p>|<p>required</p>|<p>Condition on the execution of the test [ bool = Calculated(tc) ]. If this calculated attribute is True the test will be included, otherwise it will be excluded.</p>|
|<p>help</p>|<p>required</p>|<p>This attribute must provide an explanation for why a test has been excluded [ DynamicText ].</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.BaseTemplate"></a>
### BaseTemplate

<p>Base class for templates.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.AreaQuestionTemplate"></a>
### AreaQuestionTemplate

<p>The <code>&lt;map&gt;</code> question lets users select areas on an image, such as marking pain on a body map.
If the map question is answered by the operator, they selected/deselected areas by clicking
on the image in the LabBench Runner test window. If the participants answer the question,
they will use a Button instrument to navigate between areas and to select/deselct them.</p>
<p>When participants answer the question, the following button functions must be defined in the
button configuration:</p>
<ul>
<li><code>up</code>, <code>down</code>, <code>left</code>, <code>right</code>: are used to navigate between areas.</li>
<li><code>increase</code> and <code>decrease</code>: are used to select/deselect areas.</li>
</ul>
<p>If the assigned device also implements the Joystick instrument, joystick movement can be used
to navigate between areas.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|
|<p>image-map</p>|<p>required</p>|<p>An image that will provide the areas that can be selected [ image = Calculated(tc) ]. Each area must be uniformly colored with a single color, and an <code>&lt;area&gt;</code> element for that color must be defined for that. The question will then replace that color with either the selected-color, deselected-color, active-selected-color, or active-deselected-color, depending on whether that area is selected/deselected and active or inactive.</p>|
|<p>overlay-image</p>|<p>optional</p>|<p>An overlay image that will be added on top of the processed area image [ image = Calculated(tc) ]. Consequently, this image can be used to add information and a decal to the area image. For the areas to be visible, all pixels that do not provide information or a decal must be transparent.</p>|
|<p>selected-color</p>|<p>required</p>|<p>The color of areas that the subject have selected, but which is currently not active [ string ]. The color must be specified in hex in the form of #RRGGBB.</p>|
|<p>active-selected-color</p>|<p>required</p>|<p>The color of areas that are selected and active [ string ]. The color must be specified in hex in the form of #RRGGBB. Please not that the concept of active/inactive areas is only used when the questionnaire is answered by the participant. If the operator answers the questionnaire then this attribute has no effect.</p>|
|<p>deselected-color</p>|<p>required</p>|<p>The color of areas that the subject has not selected and which are currently not active [ string ]. This color is typically the same as the background color of the image, meaning deselected/not active areas will not be colored. The color must be specified in hex in the form of #RRGGBB.</p>|
|<p>active-deselected-color</p>|<p>required</p>|<p>The color of areas that are active but not selected [ string ]. The color must be specified in hex in the form of #RRGGBB. Please not that the concept of active/inactive areas is only used when the questionnaire is answered by the participant. If the operator answers the questionnaire then this attribute has no effect.</p>|
|<p>selection-mode</p>|<p>optional</p>|<p>Area selection mode:</p> <ul> <li><code>single</code>: one a single area can be selected. If an area is selected and another area is allready selected then the other area will be automatically deselected.</li> <li><code>multiple</code>: multiple areas can be selected simultaneously.</li> </ul>|
|<p>initial-active-area</p>|<p>optional</p>|<p>Sets which area is initially active [ string ]. This must be the ID of an <code>&lt;area&gt;</code> element.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<area>`](#LabBench.Core.Tests.Meta.Survey.Questions.AreaTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Survey.Questions.AreaTemplate"></a>
### AreaTemplate

<p>An area on the image can be selected or deselected. Each area has an id and a <code>color</code>, which
matches the color of the pixels in that area. The operator or participant will not see this
color, as it will be replaced by one of the following:</p>
<ul>
<li><code>deselected-color</code>: an area that is neither selected nor active.</li>
<li><code>selected-color</code>: an area that has been selected by the operator/participant but is not active.</li>
<li><code>active-deselected-color</code>: an  area has not been selected and is active.</li>
<li><code>active-selected-color</code>: an  area has been selected and is active.</li>
</ul>
<p>The concept of an active/inactive area is relevant only when the participant completes the
questionnaire. In that mode, it is the area currently in focus, and pressing the increase/decrease
button selects/deselects the area, respectively.</p>
<p>When the participant answers the questionnaire, each area must also set up navigation to adjacent
areas, specifying which area will be made active when the up, down, left, or right button is
pressed. For each area, at least one button must be defined so the participant can’t get trapped
and can't navigate away from the area.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the area [ string ]. This <code>id</code> must be unique.</p>|
|<p>color</p>|<p>required</p>|<p>The color that defines the area on the image [ string ]. Must be specified as a hex value #RRGGBB.</p>|
|<p>up</p>|<p>optional</p>|<p>Which area should be activated when the <code>up</code> button is pressed [ string ]. Must be the <code>id</code> of an area.</p>|
|<p>down</p>|<p>optional</p>|<p>Which area should be activated when the <code>down</code> button is pressed [ string ]. Must be the <code>id</code> of an area.</p>|
|<p>left</p>|<p>optional</p>|<p>Which area should be activated when the <code>left</code> button is pressed [ string ]. Must be the <code>id</code> of an area.</p>|
|<p>right</p>|<p>optional</p>|<p>Which area should be activated when the <code>right</code> button is pressed [ string ]. Must be the <code>id</code> of an area.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.TextQuestionTemplate"></a>
### TextQuestionTemplate

<p>The <code>&lt;text&gt;</code> question allows the participant or operator to provide a verbal free-form
answer to a statement. The answer is in text that can be validated with a regular expression.</p>
<p>If the participant answers the question, the answer must be given verbally to the operator,
who then enters it into the questionnaire. The operator's entered value will be displayed
to the participant so they can confirm it is correct.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|
|<p>maximal-length</p>|<p>optional</p>|<p>Maximal length of the answer [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<validation>`](#LabBench.Core.TextValidatorTemplate)</p> | <p>optional</p> |<p>A text validator can guard against invalid text input. Text is validated with regular expressions. This tutorial, <a href="https://regexlearn.com/">RegexLearn</a>, teaches how to write regular expressions. When writing regular expressions, it is beneficial to test them with a suitable tool <a href="https://regex101.com/">regex101</a>.</p>|


<a id="LabBench.Core.TextValidatorTemplate"></a>
### TextValidatorTemplate

<p>A text validator can guard against invalid text input. Text is validated with regular
expressions. This tutorial, <a href="https://regexlearn.com/">RegexLearn</a>, teaches how to
write regular expressions. When writing regular expressions, it is beneficial to test
them with a suitable tool <a href="https://regex101.com/">regex101</a>.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>regex</p>|<p>required</p>|<p>The regular expression that are used to validate the text [ string ].</p>|
|<p>advice</p>|<p>required</p>|<p>An advice on how to write a correct text input [ text ].</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.BooleanQuestionTemplate"></a>
### BooleanQuestionTemplate

<p>The <code>&lt;boolean&gt;</code> question asks a statement that can either be true or false. If the participant
answers the question, the answer is selected with the <code>up</code> and <code>down</code> buttons.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|
|<p>true-label</p>|<p>optional</p>|<p>Description of the true option [ dynamic string ].</p>|
|<p>false-label</p>|<p>optional</p>|<p>Description of the false option [ dynamic string ].</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.NumericalQuestionTemplate"></a>
### NumericalQuestionTemplate

<p>The <code>&lt;numeric&gt;</code> question allows the participant or operator to provide a numerical
answer to a statement. The answer can be validated to be within a given range.</p>
<p>If the participant answers the question, the answer must be given verbally to the operator,
who then enters it into the questionnaire. The operator's entered value will be displayed
to the participant so they can confirm it is correct.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<validation>`](#LabBench.Core.NumberValidatorTemplate)</p> | <p>optional</p> |<p>Validation that a number is within a given range.</p>|


<a id="LabBench.Core.NumberValidatorTemplate"></a>
### NumberValidatorTemplate

<p>Validation that a number is within a given range.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>max</p>|<p>required</p>|<p>Maximal value for the number [ double ].</p>|
|<p>max-included</p>|<p>optional</p>|<p>Is the maximum included in the allowed range [ bool ].</p>|
|<p>min</p>|<p>required</p>|<p>Minimum value for the number [ double ].</p>|
|<p>min-included</p>|<p>optional</p>|<p>Is the minimum included in the allowed range [ bool ].</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.LikertQuestionTemplate"></a>
### LikertQuestionTemplate

<p>The <code>&lt;likert&gt;</code> question enables participants or operators to indicate their level of agreement,
endorsement, or frequency using a Likert scale. A Likert scale is a symmetrically ordered set
of response categories, from which a single option may be selected.</p>
<p>In LabBench, Likert scales are presented vertically. This vertical orientation allows for
longer, more descriptive labels for response categories than horizontally displayed categorical
rating scales. Participants select their response using the <code>up</code> and <code>down</code> button.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<choice>`](#LabBench.Core.Tests.Meta.LikertChoiceTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.LikertChoiceTemplate"></a>
### LikertChoiceTemplate

<p>Definition of a response category on the Likert scale. Each response category is quantified
by an integer value that corresponds to the Likert scale score if that category is selected.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>value</p>|<p>required</p>|<p>Likert scale score if that category is selected [ int ].</p>|
|<p>label</p>|<p>required</p>|<p>Description of the category [ dynamic string ].</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.DimensionalLikertQuestionTemplate"></a>
### DimensionalLikertQuestionTemplate

<p>The <code>&lt;dimensional-likert&gt;</code> question enables participants or operators to indicate their level of
agreement, endorsement, or frequency using multiple Likert scales. A Likert scale is a symmetrically
ordered set of response categories, from which a single option may be selected.</p>
<p>In LabBench, each Likert scale is presented horizontally. Participants select which Likert scale is
active using the <code>up</code> and <code>down</code> buttons, and perform their rating with the <code>increase</code> and <code>decrease</code> buttons.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<dimension>`](#LabBench.Core.Tests.Meta.LikertDimensionTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.LikertDimensionTemplate"></a>
### LikertDimensionTemplate

<p>An individual Likert scale on the multi-dimensional Likert scale question.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Description of the Likert scale [ dynamic string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<choice>`](#LabBench.Core.Tests.Meta.LikertChoiceTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Survey.Questions.BooleanListQuestionTemplate"></a>
### BooleanListQuestionTemplate

<p>The <code>&lt;list&gt;</code> question allows the participant or operator to provide answers to a set of statements,
each of which can be true or false.</p>
<p>If the participant answers the question, the <code>down</code> and <code>up</code> buttons will navigate between questions,
and pressing <code>increase</code>/<code>decrease</code> will set the answer to true/false, respectively.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<item>`](#LabBench.Core.Tests.Meta.Survey.Questions.BooleanListItemTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Survey.Questions.BooleanListItemTemplate"></a>
### BooleanListItemTemplate

<p>A statement that can either be true or false.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>LabBench.Core.Tests.Meta.Survey.Questions.BooleanListItem.ID</p>|
|<p>question</p>|<p>required</p>|<p>A statement that the participant or operator can answer is either true or false [ dynamic string ].</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.DateTimeQuestionTemplate"></a>
### DateTimeQuestionTemplate

<p>The <code>&lt;time&gt;</code> question allows the participant or operator to provide answers to a question
when something occurred. The answer is in the form of a date and time.</p>
<p>If the participant answers the question, the answer must be given verbally to the operator,
who then enters it into the questionnaire. The operator's entered value will be displayed
to the participant so they can confirm it is correct.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.VisualAnalogScaleQuestionTemplate"></a>
### VisualAnalogScaleQuestionTemplate

<p>The <code>&lt;visual-analog-scale&gt;</code> question asks the participant or operator to rate a sensation
on a visual analog rating scale. If the participant answers the question, the rating is
increased/decreased by pressing the <code>increase</code>/<code>decrease buttons</code>, respectively.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|
|<p>top-anchor</p>|<p>required</p>|<p>Top anchor for the scale [ dynamic text ].</p>|
|<p>bottom-anchor</p>|<p>required</p>|<p>Bottom anchor for the scale [ dynamic text ].</p>|
|<p>length</p>|<p>optional</p>|<p>Physical length of the scale in centimeters [ double ].</p>|
|<p>active-color</p>|<p>required</p>|<p>Color for the active part of the scale [ string ]. The string must encode a valid RGB color value, either in hex as #RRGGBB or as a rgb(RRR,GGG,BBB). For the rgb() notation the colors are in base 10.</p>|
|<p>inactive-color</p>|<p>required</p>|<p>Color for the inactive part of the scale [ string ]. The string must encode a valid RGB color value, either in hex as #RRGGBB or as a rgb(RRR,GGG,BBB). For the rgb() notation the colors are in base 10.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.NumericalScaleQuestionTemplate"></a>
### NumericalScaleQuestionTemplate

<p>The <code>&lt;numerical-scale&gt;</code> question asks the participant or operator to rate a sensation
on a numerical rating scale. If the participant answers the question, the rating is
increased/decreased by pressing the <code>increase</code>/<code>decrease buttons</code>, respectively.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|
|<p>top-anchor</p>|<p>required</p>|<p>Top anchor for the scale [ dynamic text ].</p>|
|<p>bottom-anchor</p>|<p>required</p>|<p>Bottom anchor for the scale [ dynamic text ].</p>|
|<p>maximum</p>|<p>required</p>|<p>The maximal value for the scale [ int ].</p>|
|<p>minimum</p>|<p>required</p>|<p>The minimum value for the scale [ int ].</p>|
|<p>active-color</p>|<p>required</p>|<p>Color for the active part of the scale [ string ]. The string must encode a valid RGB color value, either in hex as #RRGGBB or as a rgb(RRR,GGG,BBB). For the rgb() notation the colors are in base 10.</p>|
|<p>inactive-color</p>|<p>required</p>|<p>Color for the inactive part of the scale [ string ]. The string must encode a valid RGB color value, either in hex as #RRGGBB or as a rgb(RRR,GGG,BBB). For the rgb() notation the colors are in base 10.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.CategoricalScaleQuestionTemplate"></a>
### CategoricalScaleQuestionTemplate

<p>The <code>&lt;categorical-scale&gt;</code> question asks the participant or operator to rate a sensation
on a categorical rating scale. If the participant answers the question, the rating is
increased/decreased by pressing the <code>increase</code>/<code>decrease buttons</code>, respectively.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|
|<p>top-anchor</p>|<p>required</p>|<p>Top anchor for the scale [ dynamic text ].</p>|
|<p>bottom-anchor</p>|<p>required</p>|<p>Bottom anchor for the scale [ dynamic text ].</p>|
|<p>active-color</p>|<p>required</p>|<p>Color for the active part of the scale [ string ]. The string must encode a valid RGB color value, either in hex as #RRGGBB or as a rgb(RRR,GGG,BBB). For the rgb() notation the colors are in base 10.</p>|
|<p>inactive-color</p>|<p>required</p>|<p>Color for the inactive part of the scale [ string ]. The string must encode a valid RGB color value, either in hex as #RRGGBB or as a rgb(RRR,GGG,BBB). For the rgb() notation the colors are in base 10.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<category>`](#LabBench.Core.Tests.Meta.Survey.Questions.CategoryTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Survey.Questions.CategoryTemplate"></a>
### CategoryTemplate

<p>Category definition.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>value</p>|<p>required</p>|<p>Description that will be displayed to the participant [ dynamic text ].</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.AreaQuestionConstructor"></a>
### AreaQuestionConstructor

<p>Construction of questions from templates</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the question [ string ].</p>|
|<p>title</p>|<p>optional</p>|<p>Title of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>instruction</p>|<p>optional</p>|<p>Instruction of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>condition</p>|<p>optional</p>|<p>Condition of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>selection-mode</p>|<p>optional</p>|<p>Area selection mode:</p> <ul> <li><code>single</code>: one a single area can be selected. If an area is selected and another area is allready selected then the other area will be automatically deselected.</li> <li><code>multiple</code>: multiple areas can be selected simultaneously.</li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.TextQuestionConstructor"></a>
### TextQuestionConstructor

<p>Construction of questions from templates</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the question [ string ].</p>|
|<p>title</p>|<p>optional</p>|<p>Title of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>instruction</p>|<p>optional</p>|<p>Instruction of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>condition</p>|<p>optional</p>|<p>Condition of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.BooleanQuestionConstructor"></a>
### BooleanQuestionConstructor

<p>Construction of questions from templates</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the question [ string ].</p>|
|<p>title</p>|<p>optional</p>|<p>Title of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>instruction</p>|<p>optional</p>|<p>Instruction of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>condition</p>|<p>optional</p>|<p>Condition of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.NumericalQuestionConstructor"></a>
### NumericalQuestionConstructor

<p>Construction of questions from templates</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the question [ string ].</p>|
|<p>title</p>|<p>optional</p>|<p>Title of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>instruction</p>|<p>optional</p>|<p>Instruction of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>condition</p>|<p>optional</p>|<p>Condition of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.LikertQuestionConstructor"></a>
### LikertQuestionConstructor

<p>Construction of questions from templates</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the question [ string ].</p>|
|<p>title</p>|<p>optional</p>|<p>Title of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>instruction</p>|<p>optional</p>|<p>Instruction of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>condition</p>|<p>optional</p>|<p>Condition of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.DimensionalLikertQuestionConstructor"></a>
### DimensionalLikertQuestionConstructor

<p>Construction of questions from templates</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the question [ string ].</p>|
|<p>title</p>|<p>optional</p>|<p>Title of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>instruction</p>|<p>optional</p>|<p>Instruction of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>condition</p>|<p>optional</p>|<p>Condition of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.BooleanListQuestionConstructor"></a>
### BooleanListQuestionConstructor

<p>Construction of questions from templates</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the question [ string ].</p>|
|<p>title</p>|<p>optional</p>|<p>Title of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>instruction</p>|<p>optional</p>|<p>Instruction of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>condition</p>|<p>optional</p>|<p>Condition of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.DateTimeQuestionConstructor"></a>
### DateTimeQuestionConstructor

<p>Construction of questions from templates</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the question [ string ].</p>|
|<p>title</p>|<p>optional</p>|<p>Title of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>instruction</p>|<p>optional</p>|<p>Instruction of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>condition</p>|<p>optional</p>|<p>Condition of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.InstructionQuestionConstructor"></a>
### InstructionQuestionConstructor

<p>DEPRECATED: Do not use in the new protocols as this question will be removed in a future version of LabBench.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the question [ string ].</p>|
|<p>title</p>|<p>optional</p>|<p>Title of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>instruction</p>|<p>optional</p>|<p>Instruction of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>condition</p>|<p>optional</p>|<p>Condition of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.VisualAnalogScaleQuestionConstructor"></a>
### VisualAnalogScaleQuestionConstructor

<p>Construction of questions from templates</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the question [ string ].</p>|
|<p>title</p>|<p>optional</p>|<p>Title of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>instruction</p>|<p>optional</p>|<p>Instruction of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>condition</p>|<p>optional</p>|<p>Condition of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.NumericalScaleQuestionConstructor"></a>
### NumericalScaleQuestionConstructor

<p>Construction of questions from templates</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the question [ string ].</p>|
|<p>title</p>|<p>optional</p>|<p>Title of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>instruction</p>|<p>optional</p>|<p>Instruction of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>condition</p>|<p>optional</p>|<p>Condition of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.CategoricalScaleQuestionConstructor"></a>
### CategoricalScaleQuestionConstructor

<p>Construction of questions from templates</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the question [ string ].</p>|
|<p>title</p>|<p>optional</p>|<p>Title of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>instruction</p>|<p>optional</p>|<p>Instruction of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>condition</p>|<p>optional</p>|<p>Condition of the constructed question [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.QuestionConstructorForeach"></a>
### QuestionConstructorForeach

<p>Use a <code>foreach</code> loop with a template variable list to generate questions from templates programmatically.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>variable</p>|<p>required</p>|<p>Variable name [ string ]. The <code>foreach</code> loop iterates over all values in the template variable list named by the <code>in</code> attribute, and for each iteration, the value is available in the variable named by the <code>variable</code> attribute.</p>|
|<p>in</p>|<p>required</p>|<p>Name of the template variable list to iterate over [ string ]. The attribute is named <code>in</code> to resemble the typical foreach programming construct <code>foreach (var n in variable)</code>.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<map>`](#LabBench.Core.Tests.Meta.Survey.Questions.AreaQuestionConstructor) </span><br /><span style="white-space: nowrap;">  [`<text>`](#LabBench.Core.Tests.Meta.Survey.Questions.TextQuestionConstructor) </span><br /><span style="white-space: nowrap;">  [`<boolean>`](#LabBench.Core.Tests.Meta.Survey.Questions.BooleanQuestionConstructor) </span><br /><span style="white-space: nowrap;">  [`<numeric>`](#LabBench.Core.Tests.Meta.Survey.Questions.NumericalQuestionConstructor) </span><br /><span style="white-space: nowrap;">  [`<likert>`](#LabBench.Core.Tests.Meta.Survey.Questions.LikertQuestionConstructor) </span><br /><span style="white-space: nowrap;">  [`<dimensional-likert>`](#LabBench.Core.Tests.Meta.Survey.Questions.DimensionalLikertQuestionConstructor) </span><br /><span style="white-space: nowrap;">  [`<list>`](#LabBench.Core.Tests.Meta.Survey.Questions.BooleanListQuestionConstructor) </span><br /><span style="white-space: nowrap;">  [`<time>`](#LabBench.Core.Tests.Meta.Survey.Questions.DateTimeQuestionConstructor) </span><br /><span style="white-space: nowrap;">  [`<instruction>`](#LabBench.Core.Tests.Meta.Survey.Questions.InstructionQuestionConstructor) </span><br /><span style="white-space: nowrap;">  [`<visual-analog-scale>`](#LabBench.Core.Tests.Meta.Survey.Questions.VisualAnalogScaleQuestionConstructor) </span><br /><span style="white-space: nowrap;">  [`<numerical-scale>`](#LabBench.Core.Tests.Meta.Survey.Questions.NumericalScaleQuestionConstructor) </span><br /><span style="white-space: nowrap;">  [`<categorical-scale>`](#LabBench.Core.Tests.Meta.Survey.Questions.CategoricalScaleQuestionConstructor) </span><br /><span style="white-space: nowrap;">  [`<foreach>`](#LabBench.Core.Tests.Meta.Survey.QuestionConstructorForeach) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Sequential.SequentialTestTemplate"></a>
### SequentialTestTemplate

<p>The sequential test makes it possible to use state machines to implement experimental procedures. Unlike most other tests, it has no base functionality that can be configured in the LabBench Language; instead, its functionality must be implemented by a Python script that is called from its test events and state events.</p>
<p>In most cases, you will have access to instruments from the Python script to implement the intended experimental procedure. This access is provided by declaring the instruments in the <code>&lt;test-events&gt;</code> element. The instruments declared that they will be available for both the test events and state events.</p>
<p>The states in the state machine are defined in the <code>&lt;states&gt;</code> element, which also makes it possible to define which Python functions are called for the <code>enter</code>, <code>leave</code>, and <code>update</code> state events.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p><span style="white-space: nowrap;">  [`<update-rate-deterministic>`](#LabBench.Core.DeterministicRateParameter) </span><br /><span style="white-space: nowrap;">  [`<update-rate-random>`](#LabBench.Core.UniformlyDistributedRateParameter) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |
| <p>[`<states>`](#LabBench.Core.Tests.Meta.Sequential.SequentialTestStateCollectionTemplate)</p> | <p>required</p> |<p>Definition of the states in the state machine. The following state events define the functionality of these states:</p> <ul> <li><code>enter</code>: a calculated attribute, that is executed when the state is entered.</li> <li><code>leave</code>: a calculated attribute, that is executed when the state is left.</li> <li><code>update</code>: a calculated attribute that is executed periodically. This attribute must return a string that controls whether the state machine will; &quot;*&quot;) stay in the current state, State ID) go to the state with StateID, &quot;abort&quot;) abort the test, &quot;complete&quot;) complete the test.</li> </ul> <p>In the TestContext <code>tc</code>, both test events and state events have access to a <code>tc.CurrentState</code> object that provides:</p> <ul> <li><code>CurrentState.ID</code>: The State ID of the currently active state [ text(readonly)].</li> <li><code>CurrentState.RunningTime</code>: The running time in milliseconds of the currently active state  [ int(readonly) ].</li> <li><code>CurrentState.Name</code>: Name of the currently active state [ text(readonly) ].</li> <li><code>CurrentState.Status</code>: A text that will be shown to the operator in the test window. Can be set by the events to provide information to the operator.</li> <li><code>CurrentState.SetPlotter(lambda x, y)</code>: Events can set a Python function that must generate an image that will be shown to the operator in the test window.</li> </ul>|


<a id="LabBench.Core.DeterministicRateParameter"></a>
### DeterministicRateParameter

<p>A determistic rate of test execution with a fixed period.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>value</p>|<p>optional</p>|<p>Period of the test execution [ int ].</p>|


<a id="LabBench.Core.UniformlyDistributedRateParameter"></a>
### UniformlyDistributedRateParameter

<p>Active tests are updated at regular intervals. This element defines an update interval
that is randomly uniformly distributed between <code>min</code> and <code>max</code>.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>min</p>|<p>optional</p>|<p>Minimum value for the update period [ double ].</p>|
|<p>max</p>|<p>optional</p>|<p>Maximal value for the update period [ double ].</p>|


<a id="LabBench.Core.Tests.Meta.Sequential.SequentialTestStateCollectionTemplate"></a>
### SequentialTestStateCollectionTemplate

<p>Definition of the states in the state machine. The following state events define the functionality of these states:</p>
<ul>
<li><code>enter</code>: a calculated attribute, that is executed when the state is entered.</li>
<li><code>leave</code>: a calculated attribute, that is executed when the state is left.</li>
<li><code>update</code>: a calculated attribute that is executed periodically. This attribute must return a string that controls whether the state machine will; &quot;*&quot;) stay in the current state, State ID) go to the state with StateID, &quot;abort&quot;) abort the test, &quot;complete&quot;) complete the test.</li>
</ul>
<p>In the TestContext <code>tc</code>, both test events and state events have access to a <code>tc.CurrentState</code> object that provides:</p>
<ul>
<li><code>CurrentState.ID</code>: The State ID of the currently active state [ text(readonly)].</li>
<li><code>CurrentState.RunningTime</code>: The running time in milliseconds of the currently active state  [ int(readonly) ].</li>
<li><code>CurrentState.Name</code>: Name of the currently active state [ text(readonly) ].</li>
<li><code>CurrentState.Status</code>: A text that will be shown to the operator in the test window. Can be set by the events to provide information to the operator.</li>
<li><code>CurrentState.SetPlotter(lambda x, y)</code>: Events can set a Python function that must generate an image that will be shown to the operator in the test window.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>enter</p>|<p>optional</p>|<p>Specifies code that will be executed when a state is entered [ bool = Calculated(tc) ]. If False is returned, the test will be aborted.</p>|
|<p>leave</p>|<p>optional</p>|<p>Specifies code that will be executed when a state is left [ bool = Calculated(tc) ]. If False is returned, the test will be aborted.</p>|
|<p>update</p>|<p>required</p>|<p>Specifies code that will be executed periodically while the test is active [ Text = Calculated(tc) ]. If text returned will control the next active state. How often the code is executed is controlled by the update rate of the test.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<state>`](#LabBench.Core.Tests.Meta.Sequential.SequentialTestStateTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Sequential.SequentialTestStateTemplate"></a>
### SequentialTestStateTemplate

<p>Definition of a test state.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>ID of the test state. Must be unique, and not one of the reserved keywords for state or test transitions. These keywoards are, *, abort, and complete.</p>|
|<p>name</p>|<p>optional</p>|<p>This optional attribute specifies a human readable name for the test state. If it is not specified the ID of the test state will be used instead.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>This optional attribute, specifies the ID of the experimental setup that will be active will the test state is active. If none is specified the experimental setup for the test will be used instead.</p>|


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.EvokedPotentialsTestTemplate"></a>
### EvokedPotentialsTestTemplate

<p>The <code>&lt;stimulation-sequence&gt;</code> test generates stimulus sequences for evoked potentials, behavioral tasks,
or similar procedures. Construct the sequence by creating a stimulus pattern to control timing and a
stimulus set to define which stimuli are delivered.</p>
<p>The stimulation pattern <code>&lt;stimulation-pattern&gt;</code>is constructed from a composition of sequences, which
can be deterministic or random. However, to use this test, the stimulation pattern (number of stimuli
and randomization) is generated when the test starts. Consequently, it is not possible to change the
stimulation pattern while the test is running, so it cannot depend on participant performance during
the test. Use the <code>&lt;sequential&gt;</code> test if the stimulation pattern depends on the participant, as that
test is more versatile but also more complex to implement than this stimulation sequence test.</p>
<p>The stimulation pattern is first generated, yielding a set of temporal stimulation slots that can be
filled with stimuli; which stimuli are inserted into these stimulation slots is defined by the stimulus
set <code>&lt;stimuli&gt;</code>. The stimuli set defines a set of stimuli and controls their randomization. To fill
the stimulation pattern, a batch of stimuli is first generated by the stimulus set. This batch of
stimuli is inserted into the stimulation slots until all have been allocated, then a new batch is
generated. This process is repeated until all stimulation slots have been allocated a stimulus.</p>
<p>The test delivers stimuli via the stimulation component, which, by default, uses the Stimulator
and TriggerGenerator instruments to deliver stimuli and triggers, respectively. If more complex
or multimodal stimuli are required, a <code>&lt;stimulation-scripts&gt;</code> can be defined to generate the
stimuli/triggers from a Python script. When generations are done from a Python script, any visual,
auditory, or physical stimulus, and combinations thereof that are possible with LabBench can be generated.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>stimulus-update-rate</p>|<p>optional</p>|<p>Update rate for stimulus generation [ int = Calculated(tc) ].</p>|
|<p>trigger-update-rate</p>|<p>optional</p>|<p>Update rate for trigger generation [ int = Calculated(tc) ]. If not defined, the stimulus generation update rate will be used.</p>|
|<p>response-collection</p>|<p>optional</p>|<p>Type of response collection that will be performed:</p> <ul> <li><code>none</code>: <strong>no responses are collected</strong> for this test.</li> <li><code>yes-no</code>: <strong>binary response collection</strong> using a button device. An <code>Button</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>ratio-rating</code>: <strong>continuous ratio-scale rating</strong> using a ratio scale device. An <code>RatioScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>numerical-rating</code>: <strong>numerical rating collection</strong> using an interval scale device. An <code>IntervalScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>categorical-rating</code>: <strong>categorical response collection</strong> using an ordinal scale device. An <code>OrdinalScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>[`<configuration>`](#LabBench.Core.Components.ComponentConfiguration)</p> | <p>optional</p> |<p>Configuration of test components, which includes configuration of the stimulation, trigger, and sampling components that are used by the test.</p>|
| <p>[`<stimulation-scripts>`](#LabBench.Core.Components.Stimulation.ScriptedStimulationTemplate)</p> | <p>optional</p> |<p>Custom stimulation where the stimulation is implemented with calculated parameters that can either be a single-line Python statement or, more commonly, by calling a Python function in a script.</p>|
| <p>[`<stimulation-pattern>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulationPatternTemplate)</p> | <p>required</p> |<p>The <code>&lt;stimulation-pattern&gt;</code> element determines when stimuli are delivered. The pattern generates a set of time slots, each of which is either filled with stimuli from the <code>&lt;stimuli&gt;</code> set or with a pause.</p> <p>The stimulation pattern is generated from a composition of two types of sequences:</p> <ul> <li><code>&lt;sequence&gt;</code>: a sequence with deterministic parameters.</li> <li><code>&lt;uniformly-distributed-sequence&gt;</code>: a random sequence with an period that is uniformly distrubed between a minimum and maximal period.</li> </ul> <p>The time of a sequence is relative to the starting time of its parent sequence. If a sequence is root, meaning it has no parent, it is relative to time zero.</p> <p>For calcuated parameters the following variables will be in scope:</p> <ul> <li><code>NumberOfStimuli</code>: Number of stimuli that will be generated by the <code>&lt;stimuli&gt;</code> element each time a new batch of stimuli is required.</li> </ul>|
| <p>[`<stimuli>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulusSetTemplate)</p> | <p>required</p> |<p>The <code>&lt;stimuli&gt;</code> defines a set of stimuli. These will be inserted into the time slots generated by the <code>&lt;stimulation-pattern&gt;</code>. The set consists of a series of <code>&lt;stimulus&gt;</code> elements. Each element may produce multiple stimuli based on its <code>count</code> attribute.</p> <p>The test supports randomization of stimulation order based on the <code>order</code> attribute (<code>round-robin</code>, <code>random</code>, <code>block-random</code>, <code>latin-squares</code>, <code>generated</code>). Ensure that the number of stimulation time slots generated by the stimulation pattern is exactly divisible by the <code>NumberOfStimuli</code> in this element. Otherwise, any extra stimulation time slots that do not fit into a complete cycle defined by <code>NumberOfStimuli</code> will not be delivered.</p> <p>For calculated stimulus parameters and scripted stimulation, the stimulus <code>id</code> will be available as in the <code>StimulusName</code> variable. The currently active block is available in the <code>BlockNumber</code> variable.</p>|


<a id="LabBench.Core.Components.ComponentConfiguration"></a>
### ComponentConfiguration

<p>Configuration of test components, which includes configuration of the stimulation, trigger, and sampling components that are used by the test.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<stimulation-generation>`](#LabBench.Core.Components.StimulationConfiguration)</p> | <p>optional</p> |<p>Configuration of the stimulation start trigger</p>|
| <p>[`<trigger-generation>`](#LabBench.Core.Components.TriggerConfiguration)</p> | <p>optional</p> |<p>Configuration of the trigger generation start trigger</p>|


<a id="LabBench.Core.Components.StimulationConfiguration"></a>
### StimulationConfiguration

<p>Configuration of the stimulation start trigger</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>trigger-source</p>|<p>optional</p>|<p>Timing or trigger source:</p> <ul> <li><code>none</code>: no source is configured.</li> <li><code>internal</code>: the source is an internal opration such as start of a stimulus.</li> <li><code>external</code>: a trigger event is received from external equipment.</li> <li><code>button</code>: a trigger event is received from a button press on a connected response device attached to any response port.</li> <li><code>response-port01</code>: a trigger is received on response port 1.</li> <li><code>response-port02</code>: a trigger is received on response port 2.</li> <li><code>response-port03</code>: a trigger is received on response port 3.</li> <li><code>response-port04</code>: a trigger is received on response port 4.</li> </ul>|


<a id="LabBench.Core.Components.TriggerConfiguration"></a>
### TriggerConfiguration

<p>Configuration of the trigger generation start trigger</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>trigger-source</p>|<p>optional</p>|<p>Timing or trigger source:</p> <ul> <li><code>none</code>: no source is configured.</li> <li><code>internal</code>: the source is an internal opration such as start of a stimulus.</li> <li><code>external</code>: a trigger event is received from external equipment.</li> <li><code>button</code>: a trigger event is received from a button press on a connected response device attached to any response port.</li> <li><code>response-port01</code>: a trigger is received on response port 1.</li> <li><code>response-port02</code>: a trigger is received on response port 2.</li> <li><code>response-port03</code>: a trigger is received on response port 3.</li> <li><code>response-port04</code>: a trigger is received on response port 4.</li> </ul>|


<a id="LabBench.Core.Components.Stimulation.ScriptedStimulationTemplate"></a>
### ScriptedStimulationTemplate

<p>Custom stimulation where the stimulation is implemented with calculated parameters that can either be a single-line Python statement or, more commonly, by calling a Python function in a script.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>initialize</p>|<p>optional</p>|<p>Calculated parameter that will be called when the test is started [ bool = Calculated(ts) ]. If False is returned, the test will be aborted; otherwise, it will be started.</p>|
|<p>stimulate</p>|<p>required</p>|<p>Calculated parameter that is called for each stimulation and which must implement the stimulation [ bool = Calculated(ts, x) ]. If False is returned, the test will be aborted.</p>|
|<p>stimulus-description</p>|<p>optional</p>|<p>Description of the stimulus.</p>|
|<p>stimulus-unit</p>|<p>optional</p>|<p>Unit for the stimulation modulity.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<instrument>`](#LabBench.Core.Templating.DeviceDescriptionTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulationPatternTemplate"></a>
### StimulationPatternTemplate

<p>The <code>&lt;stimulation-pattern&gt;</code> element determines when stimuli are delivered. The pattern generates a
set of time slots, each of which is either filled with stimuli from the <code>&lt;stimuli&gt;</code> set or with a pause.</p>
<p>The stimulation pattern is generated from a composition of two types of sequences:</p>
<ul>
<li><code>&lt;sequence&gt;</code>: a sequence with deterministic parameters.</li>
<li><code>&lt;uniformly-distributed-sequence&gt;</code>: a random sequence with an period that is uniformly distrubed
between a minimum and maximal period.</li>
</ul>
<p>The time of a sequence is relative to the starting time of its parent sequence. If a sequence is root,
meaning it has no parent, it is relative to time zero.</p>
<p>For calcuated parameters the following variables will be in scope:</p>
<ul>
<li><code>NumberOfStimuli</code>: Number of stimuli that will be generated by the <code>&lt;stimuli&gt;</code> element each time a new batch of stimuli is required.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>time-base</p>|<p>optional</p>|<p>Timebase for enclosing elements:</p> <ul> <li><code>microseconds</code></li> <li><code>milliseconds</code></li> <li><code>seconds</code></li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.DeterministicSequenceTemplate) </span><br /><span style="white-space: nowrap;">  [`<uniformly-distributed-sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.UniformlyDistributedSequenceTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.DeterministicSequenceTemplate"></a>
### DeterministicSequenceTemplate

<p>Generate a deterministic sequence based on these parameters:</p>
<ul>
<li><code>Iterations</code>: indicates how many times to repeat the process for generating individual time slots. Each iteration produces one time slot inserted at a time according to the sequence attributes. If the 'Iterations' attribute is omitted, it defaults to 1.</li>
<li><code>Tperiod</code>: The period by which the sequence is repeated, meaning the time between the time slots that are generated by the sequence. If this attribute is omitted, the period will be automatically calculated based on the duration of the sequences it contains.</li>
<li><code>Toffset</code>: Time offset from the start of the sequence until insertion of the first time slot. Consequently, this attribute will offset all timeslots within the sequence.</li>
<li><code>stimulate</code>: Fill the time slot with a stimulus.</li>
<li><code>pause</code>: Insert a pause into the time slot.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>iterations</p>|<p>optional</p>|<p>Number of sequence iterations [ double = Calculated(tc) ]. For each sequence iteration, one time slot is generated.</p>|
|<p>stimulate</p>|<p>optional</p>|<p>Fill time slots with stimuli from the <code>&lt;stimuli&gt;</code> set [ bool ]. Please note that if <code>pause</code> is set to true, this attribute is ignored.</p>|
|<p>pause</p>|<p>optional</p>|<p>Fill time slots with pauses [ bool ]. Please note that this attribute will overrule the <code>stimulate</code> attribute.</p>|
|<p>Tperiod</p>|<p>optional</p>|<p>Period by which time slots are generated [ double = Calculated(tc) ].</p>|
|<p>Toffset</p>|<p>optional</p>|<p>Time offset by which all generated time slots are delayed [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.DeterministicSequenceTemplate) </span><br /><span style="white-space: nowrap;">  [`<uniformly-distributed-sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.UniformlyDistributedSequenceTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.UniformlyDistributedSequenceTemplate"></a>
### UniformlyDistributedSequenceTemplate

<p>Generate a uniformly distributed sequence based on these parameters:</p>
<ul>
<li><code>Iterations</code>: indicates how many times to repeat the process for generating individual time slots. Each iteration produces one time slot inserted at a time according to the sequence attributes. If the 'Iterations' attribute is omitted, it defaults to 1.</li>
<li><code>maxTperiod</code>: The maximal period by which the sequence is repeated, meaning the time between the time slots that are generated by the sequence. If this attribute is omitted, the period will be automatically calculated based on the duration of the sequences it contains. The period is uniformly distributed between minTperiod and maxTperiod.</li>
<li><code>minTperiod</code>: The minimal period by which the sequence is repeated, meaning the time between the time slots that are generated by the sequence. If this attribute is omitted, the period will be automatically calculated based on the duration of the sequences it contains. The period is uniformly distributed between minTperiod and maxTperiod.</li>
<li><code>Toffset</code>: Time offset from the start of the sequence until insertion of the first time slot. Consequently, this attribute will offset all timeslots within the sequence.</li>
<li><code>stimulate</code>: Fill the time slot with a stimulus.</li>
<li><code>pause</code>: Insert a pause into the time slot.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>iterations</p>|<p>optional</p>|<p>Number of sequence iterations [ double = Calculated(tc) ]. For each sequence iteration, one time slot is generated.</p>|
|<p>stimulate</p>|<p>optional</p>|<p>Fill time slots with stimuli from the <code>&lt;stimuli&gt;</code> set [ bool ]. Please note that if <code>pause</code> is set to true, this attribute is ignored.</p>|
|<p>pause</p>|<p>optional</p>|<p>Fill time slots with pauses [ bool ]. Please note that this attribute will overrule the <code>stimulate</code> attribute.</p>|
|<p>maxTperiod</p>|<p>required</p>|<p>Minimal value for the period [ double = Calculated(tc) ]. The period is uniformly distributed between minTperiod and maxTperiod.</p>|
|<p>minTperiod</p>|<p>required</p>|<p>Maximal value for the period [ double = Calculated(tc) ]. The period is uniformly distributed between minTperiod and maxTperiod.</p>|
|<p>Toffset</p>|<p>optional</p>|<p>Time offset by which all generated time slots are delayed [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.DeterministicSequenceTemplate) </span><br /><span style="white-space: nowrap;">  [`<uniformly-distributed-sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.UniformlyDistributedSequenceTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulusSetTemplate"></a>
### StimulusSetTemplate

<p>The <code>&lt;stimuli&gt;</code> defines a set of stimuli. These will be inserted into the time slots generated
by the <code>&lt;stimulation-pattern&gt;</code>. The set consists of a series of <code>&lt;stimulus&gt;</code> elements. Each
element may produce multiple stimuli based on its <code>count</code> attribute.</p>
<p>The test supports randomization of stimulation order based on the <code>order</code> attribute (<code>round-robin</code>,
<code>random</code>, <code>block-random</code>, <code>latin-squares</code>, <code>generated</code>). Ensure that the number of stimulation
time slots generated by the stimulation pattern is exactly divisible by the <code>NumberOfStimuli</code>
in this element. Otherwise, any extra stimulation time slots that do not fit into a complete cycle
defined by <code>NumberOfStimuli</code> will not be delivered.</p>
<p>For calculated stimulus parameters and scripted stimulation, the stimulus <code>id</code> will be available
as in the <code>StimulusName</code> variable. The currently active block is available in the <code>BlockNumber</code> variable.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>order</p>|<p>optional</p>|<p>Method for generating a batch of stimuli from the stimulus set:</p> <ul> <li><code>round-robin</code>: stimuli are generated in the order they are defined in the stimulus set.</li> <li><code>random</code>: One batch of stimuli is generated such that the batch size matches the number of time slots to be filled. The stimuli in this batch are then randomized, ensuring that the order of stimulus presentation is fully randomized.</li> <li><code>block-random</code>: Multiple batches of stimuli are generated. Each batch contains all stimuli from the stimulus set (equal to the set size). After batch creation, the order of stimuli within each batch is randomized independently, meaning each batch is randomized but covers all stimuli.</li> <li><code>latin-squares</code>: Psydorandomization of the stimulation order. Like block-random multiple batches, but each batch is pseudorandomized with Latin squares. Latin squares are a counterbalancing method that uses a Latin square design to ensure each condition appears equally often in each ordinal position across all stimulus batches, while still presenting the sequence in a seemingly random order.</li> <li><code>generated</code>: the order of the stimuli is implemented in Python. The Python function must return a list of length <code>NumberOfStimuli</code> that contains the order in which the current batch of stimuli will be ordered. The stimuli are identified in the returned list by their name.</li> </ul>|
|<p>generator</p>|<p>optional</p>|<p>Order by which the stimuli in a batch are reorganized when the order attribute is set to <code>generated</code> [ string[] = Calculated(tc) ]. The list must be of length <code>NumberOfStimuli</code> and contain the names of the stimuli in the order they should be reordered.</p> <p>Consequently, the <code>generated</code> order can only be used for <code>&lt;stimuli&gt;</code> sets for which all stimuli have their <code>count</code> set to one (1), as otherwise the stimulus names in the set are not unique.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<stimulus>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulusDeclarationConstructor) </span><br /><span style="white-space: nowrap;">  [`<foreach>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulusDeclarationConstructorForeach) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulusDeclarationConstructor"></a>
### StimulusDeclarationConstructor

<p>Definition of a stimulus in the stimulus set.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name that will be used to identify the stimulus in results, calculated parameters, and Python scripts [ string ].</p>|
|<p>count</p>|<p>optional</p>|<p>Number of stimuli that will be generated from this stimulus declaration [ int = Calculated(tc) ].</p>|
|<p>intensity</p>|<p>optional</p>|<p>Intensity (<code>x</code>) of that will be passed to the stimulus in calculated parameters [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<triggers>`](#LabBench.Core.Components.Triggering.TriggerDefinitionTemplate)</p> | <p>optional</p> |<p>Specifies a set of triggers to be generated. These triggers will all be generated with a given duration (<code>duration</code>) and delay (<code>Tdelay</code>). The delay is relative to the start time of its parent trigger sequence; if it has no parent trigger sequence, it is relative to time zero.</p> <p>A trigger may generate a trigger on multiple digital outputs. Each output is specified with a nested <code>&lt;code&gt;</code> element.</p>|
| <p>[`<stimulus>`](#LabBench.Core.Components.Stimulation.StimulusDefinitionTemplate)</p> | <p>optional</p> |<p>Definition of a stimulus.</p>|


<a id="LabBench.Core.Components.Triggering.TriggerDefinitionTemplate"></a>
### TriggerDefinitionTemplate

<p>Specifies a set of triggers to be generated. These triggers will all be generated with a given
duration (<code>duration</code>) and delay (<code>Tdelay</code>). The delay is relative to the start time of its parent
trigger sequence; if it has no parent trigger sequence, it is relative to time zero.</p>
<p>A trigger may generate a trigger on multiple digital outputs. Each output is specified with a nested
<code>&lt;code&gt;</code> element.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<trigger>`](#LabBench.Core.Components.Triggering.TriggerSpecificationTemplate) </span><br /><span style="white-space: nowrap;">  [`<repeated-trigger>`](#LabBench.Core.Components.Triggering.RepeatedTriggerSequenceTemplate) </span><br /><span style="white-space: nowrap;">  [`<combined-triggers>`](#LabBench.Core.Components.Triggering.CombinedTriggerSequenceTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.Triggering.TriggerSpecificationTemplate"></a>
### TriggerSpecificationTemplate

<p>Specifies a set of triggers to be generated. These triggers will all be generated with a given
duration (<code>duration</code>) and delay (<code>Tdelay</code>). The delay is relative to the start time of its parent
trigger sequence; if it has no parent trigger sequence, it is relative to time zero.</p>
<p>A trigger may generate a trigger on multiple digital outputs. Each output is specified with a nested
<code>&lt;code&gt;</code> element.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Tdelay</p>|<p>optional</p>|<p>Trigger delay relative to the starting time of its parent sequence [ double = Calculated(tc) ].</p>|
|<p>duration</p>|<p>required</p>|<p>Trigger duration [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<code>`](#LabBench.Core.Components.Triggering.TriggerCodeTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Components.Triggering.TriggerCodeTemplate"></a>
### TriggerCodeTemplate

<p>Trigger definitions that are defined by <code>output</code> and <code>value</code>. The <code>output</code> controls
where the trigger is generated, and the <code>value</code> controls which trigger code is
generated. The <code>value</code> attribute is optional and is default set to one (1).</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>output</p>|<p>required</p>|<p>Controls where a trigger will be delivered and what types of triggers can be generated:</p> <ul> <li><code>Digital</code>: Trigger OUT digital output. This output is a 1-bit trigger output, meaning that any trigger code different from zero will result in an active high output being</li> <li><code>Stimulus</code>: Stimulator T digital output. This output is a 1-bit trigger output, meaning that any trigger code different from zero will result in an active high output being</li> <li><code>Code</code>: TRIGGER INTERFACE digital output. This is a 16-bit trigger output, meaning the trigger value will be generated.</li> </ul> <p>Please note that the logic convention (positive/negative) applies only to the <code>Code</code> output; all other outputs use positive logic.</p>|
|<p>value</p>|<p>optional</p>|<p>Trigger code to be generated [ int = Calculated(tc) ].</p>|


<a id="LabBench.Core.Components.Triggering.RepeatedTriggerSequenceTemplate"></a>
### RepeatedTriggerSequenceTemplate

<p>Repetition of enclosed triggers.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Tdelay</p>|<p>optional</p>|<p>The delay that the enclosed trigger sequence is delayed with before it is repeated <code>N</code> times with a period of <code>Tperiod</code> [ double = Calculated(tc) ].</p>|
|<p>Tperiod</p>|<p>required</p>|<p>The period by which the enclosed triggers are repeated [ double = Calculated(tc) ].</p>|
|<p>N</p>|<p>optional</p>|<p>The number of times the enclosed triggers are repeated [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<trigger>`](#LabBench.Core.Components.Triggering.TriggerSpecificationTemplate) </span><br /><span style="white-space: nowrap;">  [`<repeated-trigger>`](#LabBench.Core.Components.Triggering.RepeatedTriggerSequenceTemplate) </span><br /><span style="white-space: nowrap;">  [`<combined-trigger>`](#LabBench.Core.Components.Triggering.CombinedTriggerSequenceTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.Triggering.CombinedTriggerSequenceTemplate"></a>
### CombinedTriggerSequenceTemplate

<p>Generation of triggers from a composition of triggers and trigger sequences.
The triggers of each enclosing trigger or trigger sequence will be merged
together in time.</p>
<p>This will fail if the enclosed triggers or trigger sequences contain incompatible
triggers, meaning that two or more distinct trigger codes are to be generated
simultaneously on the same trigger output.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Tdelay</p>|<p>optional</p>|<p>Delay that all enclosed triggers are delayed with [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<trigger>`](#LabBench.Core.Components.Triggering.TriggerSpecificationTemplate) </span><br /><span style="white-space: nowrap;">  [`<repeated-trigger>`](#LabBench.Core.Components.Triggering.RepeatedTriggerSequenceTemplate) </span><br /><span style="white-space: nowrap;">  [`<combined-triggers>`](#LabBench.Core.Components.Triggering.CombinedTriggerSequenceTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Components.Stimulation.StimulusDefinitionTemplate"></a>
### StimulusDefinitionTemplate

<p>Definition of a stimulus.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<pulse>`](#LabBench.Core.Components.Stimulation.PulseTemplate) </span><br /><span style="white-space: nowrap;">  [`<ramp>`](#LabBench.Core.Components.Stimulation.RampTemplate) </span><br /><span style="white-space: nowrap;">  [`<sine>`](#LabBench.Core.Components.Stimulation.SineTemplate) </span><br /><span style="white-space: nowrap;">  [`<arbitrary>`](#LabBench.Core.Components.Stimulation.ArbitraryTemplate) </span><br /><span style="white-space: nowrap;">  [`<combined>`](#LabBench.Core.Components.Stimulation.CombinedStimulusTemplate) </span><br /><span style="white-space: nowrap;">  [`<repeated>`](#LabBench.Core.Components.Stimulation.RepeatedStimulusTemplate) </span><br /><span style="white-space: nowrap;">  [`<window>`](#LabBench.Core.Components.Stimulation.WindowTemplate) </span><br /><span style="white-space: nowrap;">  [`<multiple-outputs>`](#LabBench.Core.Components.Stimulation.MultipleOutputStimulusTemplate) </span><br /><span style="white-space: nowrap;">  [`<linear-segments>`](#LabBench.Core.Components.Stimulation.LinearSegmentsStimulusTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.Stimulation.PulseTemplate"></a>
### PulseTemplate

<p>Rectangular stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Is</p>|<p>required</p>|<p>Stimulus intensity (Is)  [ double = Calculated(tc, x)].</p>|
|<p>Ts</p>|<p>required</p>|<p>Duration of the stimulus in milliseconds [ double = Calculated(tc, x) ].</p>|
|<p>Tdelay</p>|<p>optional</p>|<p>Delay of the stimulus in miliseconds [ double = Calculated(tc, x) ]</p>|


<a id="LabBench.Core.Components.Stimulation.RampTemplate"></a>
### RampTemplate

<p>A linearly increasing stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Is</p>|<p>required</p>|<p>Stimulus intensity (Is) is the change in the intensity at the end of the ramp from the stimulus offset (Ioffset) [ double = Calculated(tc, x)].</p>|
|<p>Ioffset</p>|<p>optional</p>|<p>Stimulus intensity offset (Ioffset) is the value that all stimulus intensities during the stimulus are offset with [ double = Calculated(tc, x)].</p>|
|<p>Ts</p>|<p>required</p>|<p>Duration of the stimulus in milliseconds [ double = Calculated(tc, x) ].</p>|
|<p>Tdelay</p>|<p>optional</p>|<p>Delay of the stimulus in miliseconds [ double = Calculated(tc, x) ]</p>|


<a id="LabBench.Core.Components.Stimulation.SineTemplate"></a>
### SineTemplate

<p>Sinusoidal stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Is</p>|<p>required</p>|<p>Stimulus intensity [ double = Calculated(tc, x) ].</p>|
|<p>Ts</p>|<p>required</p>|<p>Stimulus duration in milliseconds [ double = Calculated(tc, x) ].</p>|
|<p>Tdelay</p>|<p>optional</p>|<p>Delay in milliseconds of the stimulus relative to its parent stimulus [ double = Calculated(tc, x) ].</p>|
|<p>Frequency</p>|<p>required</p>|<p>Frequency of the sinusoidal stimulus [ double = Calculated(tc, x) ].</p>|


<a id="LabBench.Core.Components.Stimulation.ArbitraryTemplate"></a>
### ArbitraryTemplate

<p>An arbitrary stimulus that is defined by a mathematical expression.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Ts</p>|<p>required</p>|<p>Duration of the stimulus in milliseconds [ double = Calculated(tc, x) ].</p>|
|<p>Tdelay</p>|<p>optional</p>|<p>Delay of the stimulus in miliseconds [ double = Calculated(tc, x) ]</p>|
|<p>expression</p>|<p>required</p>|<p>A mathematical expression that defines the stimulus. The expression must be a single-line Python statement that returns a double. In the scope of this expression are the current time (t) in milliseconds, a free parameter (x), a set of mathematical functions, and the results and definitions of the current protocol.</p>|


<a id="LabBench.Core.Components.Stimulation.CombinedStimulusTemplate"></a>
### CombinedStimulusTemplate

<p>A combined stimulus is the summation of a set of individual stimuli. The stimulus duration and delays of each stimulus in the set are relative to the combined stimulus's starting time.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<pulse>`](#LabBench.Core.Components.Stimulation.PulseTemplate) </span><br /><span style="white-space: nowrap;">  [`<ramp>`](#LabBench.Core.Components.Stimulation.RampTemplate) </span><br /><span style="white-space: nowrap;">  [`<sine>`](#LabBench.Core.Components.Stimulation.SineTemplate) </span><br /><span style="white-space: nowrap;">  [`<arbitrary>`](#LabBench.Core.Components.Stimulation.ArbitraryTemplate) </span><br /><span style="white-space: nowrap;">  [`<combined>`](#LabBench.Core.Components.Stimulation.CombinedStimulusTemplate) </span><br /><span style="white-space: nowrap;">  [`<repeated>`](#LabBench.Core.Components.Stimulation.RepeatedStimulusTemplate) </span><br /><span style="white-space: nowrap;">  [`<window>`](#LabBench.Core.Components.Stimulation.WindowTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Components.Stimulation.RepeatedStimulusTemplate"></a>
### RepeatedStimulusTemplate

<p>Repeats an enclosed stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Tdelay</p>|<p>optional</p>|<p>Delay in milliseconds of the repeated stimulus relative to its parent stimulus [ double = Calculated(tc, x) ].</p>|
|<p>Tperiod</p>|<p>required</p>|<p>Period in milliseconds that the enclosed stimulus is repeated [ double = Calculated(tc, x) ].</p>|
|<p>N</p>|<p>optional</p>|<p>Number of times the enclosed stimulus is repeated [ int = Calculated(tc, x) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<pulse>`](#LabBench.Core.Components.Stimulation.PulseTemplate) </span><br /><span style="white-space: nowrap;">  [`<ramp>`](#LabBench.Core.Components.Stimulation.RampTemplate) </span><br /><span style="white-space: nowrap;">  [`<sine>`](#LabBench.Core.Components.Stimulation.SineTemplate) </span><br /><span style="white-space: nowrap;">  [`<arbitrary>`](#LabBench.Core.Components.Stimulation.ArbitraryTemplate) </span><br /><span style="white-space: nowrap;">  [`<combined>`](#LabBench.Core.Components.Stimulation.CombinedStimulusTemplate) </span><br /><span style="white-space: nowrap;">  [`<repeated>`](#LabBench.Core.Components.Stimulation.RepeatedStimulusTemplate) </span><br /><span style="white-space: nowrap;">  [`<window>`](#LabBench.Core.Components.Stimulation.WindowTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.Stimulation.WindowTemplate"></a>
### WindowTemplate

<p>Window that gets multiplied on its enclosing stimuli.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>window</p>|<p>required</p>|<p>Type of window that the enclosing stimulus is windowed with.</p>|
|<p>parameter</p>|<p>optional</p>|<p>Parameter if any of the window function.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<pulse>`](#LabBench.Core.Components.Stimulation.PulseTemplate) </span><br /><span style="white-space: nowrap;">  [`<ramp>`](#LabBench.Core.Components.Stimulation.RampTemplate) </span><br /><span style="white-space: nowrap;">  [`<sine>`](#LabBench.Core.Components.Stimulation.SineTemplate) </span><br /><span style="white-space: nowrap;">  [`<arbitrary>`](#LabBench.Core.Components.Stimulation.ArbitraryTemplate) </span><br /><span style="white-space: nowrap;">  [`<combined>`](#LabBench.Core.Components.Stimulation.CombinedStimulusTemplate) </span><br /><span style="white-space: nowrap;">  [`<repeated>`](#LabBench.Core.Components.Stimulation.RepeatedStimulusTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.Stimulation.MultipleOutputStimulusTemplate"></a>
### MultipleOutputStimulusTemplate

<p>Represent a stimulus that spand over multiple stimulation outputs.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<output>`](#LabBench.Core.Components.Stimulation.AnalogOutputTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Components.Stimulation.AnalogOutputTemplate"></a>
### AnalogOutputTemplate

<p>An analog output channel in a multiple output stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>channel</p>|<p>required</p>|<p>Number of the output channel. The stimulation device determines the meaning of this number.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<pulse>`](#LabBench.Core.Components.Stimulation.PulseTemplate) </span><br /><span style="white-space: nowrap;">  [`<ramp>`](#LabBench.Core.Components.Stimulation.RampTemplate) </span><br /><span style="white-space: nowrap;">  [`<sine>`](#LabBench.Core.Components.Stimulation.SineTemplate) </span><br /><span style="white-space: nowrap;">  [`<arbitrary>`](#LabBench.Core.Components.Stimulation.ArbitraryTemplate) </span><br /><span style="white-space: nowrap;">  [`<combined>`](#LabBench.Core.Components.Stimulation.CombinedStimulusTemplate) </span><br /><span style="white-space: nowrap;">  [`<repeated>`](#LabBench.Core.Components.Stimulation.RepeatedStimulusTemplate) </span><br /><span style="white-space: nowrap;">  [`<window>`](#LabBench.Core.Components.Stimulation.WindowTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.Stimulation.LinearSegmentsStimulusTemplate"></a>
### LinearSegmentsStimulusTemplate

<p>A stimulus created from piecewise linear segments.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>baseline</p>|<p>required</p>|<p>The baseline for the stimulus [ double = Calculated(tc, x) ]. This baseline is the stimulus intensity outside the linear segments, and the starting value for the linear segments.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<segment>`](#LabBench.Core.Components.Stimulation.SegmentTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Components.Stimulation.SegmentTemplate"></a>
### SegmentTemplate

<p>Definition of a segment of a piecewise-linear stimulus. The segment is defined by its duration and intensity at its end. Its starting intensity is defined by the end intensity of the previous segment or by the baseline intensity of the piecewise-linear stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>duration</p>|<p>required</p>|<p>Duration of the segment in milliseconds [ double = Calculated(tc, x) ].</p>|
|<p>value</p>|<p>required</p>|<p>End intensity of the segment [ double = Calculated(ts, x) ].</p>|


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulusDeclarationConstructorForeach"></a>
### StimulusDeclarationConstructorForeach

<p>Use a <code>foreach</code> loop with a template variable list to generate stimulus declarations from templates programmatically.</p>
<p>Example: Generate stimuli for a duration test using a <code>foreach</code> loop:</p>
<pre><code class="language-xml">&lt;stimuli&gt;
    &lt;foreach variable=&quot;duration&quot; in=&quot;Durations&quot;&gt;
        &lt;stimulus name=&quot;var: f'S{duration}'&quot;&gt;
            &lt;stimulus&gt;
                &lt;pulse Is=&quot;x&quot; Ts=&quot;var: f'{duration}'&quot; /&gt;
            &lt;/stimulus&gt;
        &lt;/stimulus&gt;
    &lt;/foreach&gt;
&lt;/stimuli&gt;
</code></pre>
<p>When the template is used, the <code>Durations</code> list template variable is defined as in this example:</p>
<pre><code class="language-xml">&lt;stimulation-sequence-constructor id=&quot;T01&quot; name=&quot;SR-Curve&quot; template=&quot;SR&quot;&gt;
    &lt;variables&gt;
        &lt;strings name=&quot;Durations&quot; value=&quot;50;100;200;400&quot; /&gt;
    &lt;/variables&gt;
&lt;/stimulation-sequence-constructor&gt;
</code></pre>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>variable</p>|<p>required</p>|<p>Variable name [ string ]. The <code>foreach</code> loop iterates over all values in the template variable list named by the <code>in</code> attribute, and for each iteration, the value is available in the variable named by the <code>variable</code> attribute.</p>|
|<p>in</p>|<p>required</p>|<p>Name of the template variable list to iterate over [ string ]. The attribute is named <code>in</code> to resemble the typical foreach programming construct <code>foreach (var n in variable)</code>.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<stimulus>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulusDeclarationConstructor) </span><br /><span style="white-space: nowrap;">  [`<foreach>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulusDeclarationConstructorForeach) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Algometry.StimulusResponse.AlgometryStimulusResponseTestTemplate"></a>
### AlgometryStimulusResponseTestTemplate

<p>Stimulus-response tests determine the psychophysical rating (VAS Rating) to a linearly increasing pressure stimulus.
From this stimulus-response curve, several psychophysical parameters can be determined:</p>
<ol>
<li>PDT: The Pain Detection Threshold,</li>
<li>PTL: The Pain Tolerance Limit, and</li>
<li>PTT: The Pain Tolerance Threshold (PTT).</li>
</ol>
<p>The determined parameters depend on the test configuration and the subject's instructions.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>second-cuff</p>|<p>optional</p>|<p>Inflate the second cuff together with the primary cuff [ bool ]. If this attribute is set to true, the value of the primary cuff parameter is irrelevant. Placing the two cuffs adjacent to each other can be used to study spatial summation.</p>|
|<p>pressure-limit</p>|<p>optional</p>|<p>This attribute is the maximum pressure the device will deliver before it aborts the test [ double = Calculated(tc) ]. The maximal pressure for the device is 100kPa.</p>|
|<p>conditioning-time</p>|<p>optional</p>|<p>This attribute is the time from the test's start until the pressure starts to increase linearly [ double = Calculated(tc) ].</p>|
|<p>delta-pressure</p>|<p>optional</p>|<p>This attribute is the rate of increase [kPa/s] of the applied pressure [ double = Calculated(tc) ].</p>|
|<p>vas-pdt</p>|<p>optional</p>|<p>The VAS score is interpreted as the Pain Detection Threshold (PDT) [ double = Calculated(tc) ]. This attribute should be set to at least 0.1cm to allow for a small deadband in the button on the VAS meter, which is required so as not to risk that noise will accidentally trigger an early determination of the PDT. It can be set to higher than 0.1cm to allow for non-painful stimulations to be rated by the subject.</p>|
|<p>stop-mode</p>|<p>required</p>|<p>Stop mode for the test (stop-on-maximal-rating or stop-when-button-pressed). This attribute determines whether the VAS scale has two (2) or three anchor points (3). When set to stop-on-maximal-rating the VAS scale has two anchor points (pain detection threshold (PDT), pain tolerance threshold (PTT)). When set to stop-when-button-pressed the VAS scale has three anchor points (pain detection threshold (PDT), pain tolerance limit (PTL), pain tolerance threshold (PTT)).</p>|
|<p>primary-cuff</p>|<p>required</p>|<p>Determines which cuff (1 or 2) will be used for the pressure stimulation [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Algometry.ConditionedPain.AlgometryConditionedPainTestTemplate"></a>
### AlgometryConditionedPainTestTemplate

<p>With the conditioned pain modulation test, one cuff applies static pressure while the other determines a stimulus-response curve. The stimulus-response curve determines the psychophysical rating (VAS Rating) to a linearly increasing pressure stimulus.</p>
<p>From this stimulus-response curve, several psychophysical parameters can be determined:</p>
<ul>
<li>Pain Detection Threshold (PDT),</li>
<li>Pain Tolerance Limit (PTL),</li>
<li>Pain Tolerance Threshold (PTT).</li>
</ul>
<p>The determined parameters depend on the test configuration and the subject's instructions.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>conditional-pressure</p>|<p>required</p>|<p>This attribute is the pressure that will be applied with the conditioning cuff [ double = Calculated(tc) ].</p>|
|<p>delta-conditional-pressure</p>|<p>optional</p>|<p>This attribute is the rate of increase [kPa/s] of the applied conditioning pressure [ double = Calculated(tc) ].</p>|
|<p>conditioning-time</p>|<p>optional</p>|<p>This attribute is the time from the test's start until the pressure starts to increase linearly [ double = Calculated(tc) ].</p>|
|<p>pressure-limit</p>|<p>optional</p>|<p>This attribute is the maximum pressure the device will deliver before it aborts the test [ double = Calculated(tc) ]. The maximal pressure for the device is 100kPa.</p>|
|<p>delta-pressure</p>|<p>optional</p>|<p>This attribute is the rate of increase [kPa/s] of the applied pressure [ y = Calculated(tc) ].</p>|
|<p>vas-pdt</p>|<p>optional</p>|<p>The VAS score is interpreted as the Pain Detection Threshold (PDT) [ double = Calculated(tc) ]. This attribute should be set to at least 0.1cm to allow for a small deadband in the button on the VAS meter, which is required so as not to risk that noise will accidentally trigger an early determination of the PDT. It can be set to higher than 0.1cm to allow for non-painful stimulations to be rated by the subject.</p>|
|<p>stop-mode</p>|<p>required</p>|<p>Stop mode for the test (stop-on-maximal-rating or stop-when-button-pressed). This attribute determines whether the VAS scale has two (2) or three anchor points (3). When set to stop-on-maximal-rating the VAS scale has two anchor points (pain detection threshold (PDT), pain tolerance threshold (PTT)). When set to stop-when-button-pressed the VAS scale has three anchor points (pain detection threshold (PDT), pain tolerance limit (PTL), pain tolerance threshold (PTT)).</p>|
|<p>primary-cuff</p>|<p>required</p>|<p>Determines which cuff (1 or 2) will be used for the pressure stimulation [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Algometry.TemporalSummation.AlgometryTemporalSummationTestTemplate"></a>
### AlgometryTemporalSummationTestTemplate

<p>The temporal summation test applies a series of rectangular pressure stimuli to one or both cuffs. The subject is asked to rate the pain sensation of these stimuli on the VAS meter as soon as possible after
the cessation of a pressure stimulus. The VAS rating for a stimulus is recorded just before the next stimulus is given or would have been given if it had not been the last stimulus in the series.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>no-of-stimuli</p>|<p>optional</p>|<p>This attribute is the number of pressure stimuli applied during the test [ int = Calculated(tc) ].</p>|
|<p>t-on</p>|<p>optional</p>|<p>This attribute is the duration of the rectangular stimuli [ double = Calculated(tc) ].</p>|
|<p>t-off</p>|<p>optional</p>|<p>This attribute is the pause between the stimuli in the series [ double = Calculated(tc) ].</p>|
|<p>pressure-stimulate</p>|<p>optional</p>|<p>This attribute is the pressure that will be applied during the rectangular pressure stimuli [ double = Calculated(tc) ].</p>|
|<p>pressure-static</p>|<p>optional</p>|<p>This attribute is the pressure that will be applied in between the pressure stimuli [ double = Calculated(tc) ]. This value is included as a slight static pressure between the stimuli can prevent the cuff from shifting during the test.</p>|
|<p>second-cuff</p>|<p>optional</p>|<p>Inflate the second cuff together with the primary cuff [ bool ]. If this attribute is set to true, the value of the primary cuff parameter is irrelevant. Placing the two cuffs adjacent to each other can be used to study spatial summation.</p>|
|<p>primary-cuff</p>|<p>optional</p>|<p>Determines which cuff (1 or 2) will be used for the pressure stimulation [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Algometry.StaticTemporalSummation.AlgometryStaticTemporalSummationTestTemplate"></a>
### AlgometryStaticTemporalSummationTestTemplate

<p>The static temporal summation applies a constant pressure for a specified duration instead of a series of stimuli to determine the temporal summation of pressure stimulation.</p>
<p>During this pressure stimulation and for a period after the test, the subject's VAS score will be recorded as the result of the test.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>pressure-stimulate</p>|<p>optional</p>|<p>This attribute is the pressure that is applied during the static pressure stimulation [ double = Calculated(tc)  ].</p>|
|<p>stimulus-duration</p>|<p>optional</p>|<p>This attribute is the duration [s] of the constant pressure stimulation [ double = Calculated(tc) ].</p>|
|<p>tail-duration</p>|<p>optional</p>|<p>This attribute is the duration after the cessation of the pressure stimulation in which the VAS score is recorded [ double = Calculated(tc) ].</p>|
|<p>second-cuff</p>|<p>optional</p>|<p>Inflate the second cuff together with the primary cuff [ bool ]. If this attribute is set to true, the value of the primary cuff parameter is irrelevant. Placing the two cuffs adjacent to each other can be used to study spatial summation.</p>|
|<p>primary-cuff</p>|<p>optional</p>|<p>Determines which cuff (1 or 2) will be used for the pressure stimulation [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Algometry.StimulusRating.AlgometryStimulusRatingTestTemplate"></a>
### AlgometryStimulusRatingTestTemplate

<p>The stimulus rating test provides a way to determine the Pain Detection Threshold (PDT), the Pain Tolerance Threshold (PTT), or both with an attached button.</p>
<p>The test is executed in the same way as the stimulus-response test and is defined by the same parameters, with the exception that it does not have a stop-mode parameter but instead has a measurement parameter.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>second-cuff</p>|<p>optional</p>|<p>Inflate the second cuff together with the primary cuff [ bool ]. If this attribute is set to true, the value of the primary cuff parameter is irrelevant. Placing the two cuffs adjacent to each other can be used to study spatial summation.</p>|
|<p>pressure-limit</p>|<p>optional</p>|<p>This attribute is the maximum pressure the device will deliver before it aborts the test [ double = Calculated(tc) ]. The maximal pressure for the device is 100kPa.</p>|
|<p>conditioning-time</p>|<p>optional</p>|<p>This attribute is the time from the test's start until the pressure starts to increase linearly [ double = Calculated(tc) ].</p>|
|<p>delta-pressure</p>|<p>optional</p>|<p>This attribute is the rate of increase [kPa/s] of the applied pressure [ double = Calculated(tc) ].</p>|
|<p>primary-cuff</p>|<p>required</p>|<p>Determines which cuff (1 or 2) will be used for the pressure stimulation [ int = Calculated(tc) ].</p>|
|<p>measurement</p>|<p>required</p>|<p>Determine the Pain Detection Threshold (PDT), Pain Tolerance Threshold (PTT), or both. If the PDT or PTT is to be determined, the subject must press the button when the threshold is reached. If both the PDT and PTT are to be determined, the subject must press the button when the PDT is reached and release it when the PTT is reached.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Algometry.ConditionedPainRating.AlgometryConditionedPainRatingTestTemplate"></a>
### AlgometryConditionedPainRatingTestTemplate

<p>The conditioned pain modulation rating test is analogous to the conditioned pain modulation test that uses a button instead of the VAS to determine pain detection threshold (PDT), pain tolerance threshold (PTT), or both.</p>
<p>The same parameters define the test as the conditioned pain modulation test, with the addition of the measurement parameter that defines how the button is used to determine PDT, PTT, or both.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>conditional-pressure</p>|<p>required</p>|<p>This attribute is the pressure that will be applied with the conditioning cuff [ double = Calculated(tc) ].</p>|
|<p>delta-conditional-pressure</p>|<p>optional</p>|<p>This attribute is the rate of increase [kPa/s] of the conditioning pressure [ double = Calculated(tc) ].</p>|
|<p>conditioning-time</p>|<p>optional</p>|<p>This attribute is the time from the test's start until the pressure starts to increase linearly [ double = Calculated(tc) ].</p>|
|<p>pressure-limit</p>|<p>optional</p>|<p>This attribute is the maximum pressure the device will deliver before it aborts the test. The maximal pressure for the device is 100kPa.</p>|
|<p>delta-pressure</p>|<p>optional</p>|<p>This attribute is the rate of increase [kPa/s] of the applied pressure [ double = Calculated(tc) ].</p>|
|<p>primary-cuff</p>|<p>required</p>|<p>Determines which cuff (1 or 2) will be used for the pressure stimulation [ double = Calculated(tc) ].</p>|
|<p>measurement</p>|<p>required</p>|<p>Determine the Pain Detection Threshold (PDT), Pain Tolerance Threshold (PTT), or both. If the PDT or PTT is to be determined, the subject must press the button when the threshold is reached. If both the PDT and PTT are to be determined, the subject must press the button when the PDT is reached and release it when the PTT is reached.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.AlgometryArbitraryTemporalSummationTestTemplate"></a>
### AlgometryArbitraryTemporalSummationTestTemplate

<p>The arbitrary temporal summation test applies a series of rectangular pressure stimuli to one or both cuffs.</p>
<p>The subject is asked to rate the pain sensation of these stimuli on the VAS meter as soon as possible after the cessation of a pressure stimulus.</p>
<p>The VAS rating for a stimulus is recorded just before the next stimulus is given or would have been given if it had not been the last stimulus in the series. The arbitrary temporal summation test makes it possible to specify each stimulus in the series individually, and thus, each stimulus can have a different intensity and duration.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>pressure-static</p>|<p>optional</p>|<p>This attribute is the pressure that will be applied in between the pressure stimuli [ double = Calculated(tc) ]. This value is included as a slight static pressure between the stimuli can prevent the cuff from shifting during the test.</p>|
|<p>second-cuff</p>|<p>optional</p>|<p>Inflate together with the primary cuff [ bool ]. If this attribute is set to true, the value of the primary cuff parameter is irrelevant. Placing the two cuffs adjacent to each other can be used to study spatial summation.</p>|
|<p>primary-cuff</p>|<p>required</p>|<p>Determines which cuff [1 or 2] that will be used for the pressure stimulation [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>`<stimuli>`</p> | <p>optional</p> |<p> The `<stimuli>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.TemporalSummationStimulusTemplate"><code>&lt;stimulus&gt;</code></a> </span></li> </ul> </p>|


<a id="LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.TemporalSummationStimulusTemplate"></a>
### TemporalSummationStimulusTemplate

<p>Specification of a pressure stimulus in the series of pressure stimuli.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>pressure</p>|<p>required</p>|<p>Stimulation pressure  [ double = Calculated(tc) ].</p>|
|<p>t-on</p>|<p>required</p>|<p>Duration of the stimulus [ double = Calculated(tc) ]</p>|
|<p>t-off</p>|<p>required</p>|<p>Pause between stimulations [ double = Calculated(tc) ]</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ThresholdEstimationTestTemplate"></a>
### ThresholdEstimationTestTemplate

<p>The threshold estimation test is used to estimate thresholds/psychometric functions when LabBench controls the stimulus generation automatically. Estimation of these thresholds/psychometric functions consists of three parts: the stimulus modality, response task, and estimation algorithm:</p>
<ul>
<li><strong>Stimulus modality</strong>: the type of stimulus, such as tactile, thermal, pressure, or electrical, presented to the subject and for which a threshold/psychometric function is estimated.</li>
<li><strong>Response task</strong>: the perception task that the subject is asked to perform when the stimulus is presented. The outcome of this task is either true: the subject performed the task correctly, or false: the the subject failed to perform the task correctly.</li>
<li><strong>Estimation algorithm</strong>: the adaptive algorithm by which the threshold/psychometric function is estimated. This algorithm uses the outcome of the response task (correct/incorrect) to update the estimate of the threshold or psychometric function for each stimulus presentation.</li>
</ul>
<p>The thresholds or psychometric functions are estimated for an independent variable (x). An increase in x is assumed to increase the probability that the subject will correctly perform the response task. If there is an inverted relationship, the independent variable (x) inversion must be performed in the stimulus specification.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>stimulus-update-rate</p>|<p>required</p>|<p>Update rate for stimulus generation [ int = Calculated(tc) ].</p>|
|<p>trigger-update-rate</p>|<p>optional</p>|<p>Update rate for trigger generation [ int = Calculated(tc) ]. If not defined, the stimulus generation update rate will be used.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p><span style="white-space: nowrap;">  [`<update-rate-deterministic>`](#LabBench.Core.DeterministicRateParameter) </span><br /><span style="white-space: nowrap;">  [`<update-rate-random>`](#LabBench.Core.UniformlyDistributedRateParameter) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |
| <p>[`<configuration>`](#LabBench.Core.Components.ComponentConfiguration)</p> | <p>optional</p> |<p>Configuration of test components, which includes configuration of the stimulation, trigger, and sampling components that are used by the test.</p>|
| <p><span style="white-space: nowrap;">  [`<manual-yes-no-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualYesNoResponseTemplate) </span><br /><span style="white-space: nowrap;">  [`<yes-no-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.YesNoResponseTemplate) </span><br /><span style="white-space: nowrap;">  [`<forced-yes-no-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ForcedYesNoResponseTemplate) </span><br /><span style="white-space: nowrap;">  [`<manual-interval-rating-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualIntervalResponseTemplate) </span><br /><span style="white-space: nowrap;">  [`<interval-rating-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.IntervalResponseTemplate) </span><br /><span style="white-space: nowrap;">  [`<manual-categorical-rating-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualCategoricalResponseTemplate) </span><br /><span style="white-space: nowrap;">  [`<categorical-rating-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.CategoricalResponseTemplate) </span><br /><span style="white-space: nowrap;">  [`<ratio-rating-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.RatioResponseTemplate) </span><br /><span style="white-space: nowrap;">  [`<interval-forced-choice-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.IntervalForcedChoiceResponseTemplate) </span><br /><span style="white-space: nowrap;">  [`<alternative-forced-choice-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.AlternativeForcedChoiceResponseTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |
| <p>[`<stimulation-scripts>`](#LabBench.Core.Components.Stimulation.ScriptedStimulationTemplate)</p> | <p>optional</p> |<p>Custom stimulation where the stimulation is implemented with calculated parameters that can either be a single-line Python statement or, more commonly, by calling a Python function in a script.</p>|
| <p>[`<stimulus-channel-template>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.StimulusChannelTemplate)</p> | <p>optional</p> |<p>A stimulus channel estimates the threshold or psychometric function of a single stimulus. This threshold or psychometric function is estimated with a dedicated estimation method (Psi-method, Up/Down method, and similar) that maintains its own state for the channel but uses the same response task to determine the relationship between a stimulus parameter (x) and the probabilistic behavioral response of the participants (i.e., whether they can perform the response task correctly).</p> <p>Once a threshold or psychometric function has been estimated, the result can be accessed by calculated parameters as <code>[Test ID].[Channel ID]</code>.</p>|
| <p>`<channels>`</p> | <p>optional</p> |<p> The `<channels>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.StimulusChannelConstructor"><code>&lt;channel&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.StimulusChannelConstructorForeach"><code>&lt;foreach&gt;</code></a> </span></li> </ul> </p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualYesNoResponseTemplate"></a>
### ManualYesNoResponseTemplate

<p>In a Manual Yes/No response task, the experimenter asks the subject after each stimulation whether they felt the stimulus. This response is then entered into the algorithm manually by the experimenter. Consequently, the test will wait indefinitely until the subject has answered the experimenter.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>instruction</p>|<p>required</p>|<p>Question that the experimenter must ask the subject that the subject must answer with either a Yes or No response [ string ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.YesNoResponseTemplate"></a>
### YesNoResponseTemplate

<p>In a Yes/No response task, the subject is asked to press the button each time a stimulus is felt. This response is timed, meaning that if the subject does not press the button before the next stimulus is given, then it will be assumed that the stimulus was not felt.</p>

<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ForcedYesNoResponseTemplate"></a>
### ForcedYesNoResponseTemplate

<p>In the forced yes/no task, the stimulus is first presented to the subject, along with a cue that prompts the subject to attend to it.</p>
<p>Then a probe image is presented to the subject, with instructions to answer Yes or No to a stimulus quality; for example, if one or two stimuli could be felt, the subject presses one button for Yes and another for No. The task will wait indefinitely until the subject has answered the question.</p>
<p>This task is usually used for stimuli that are always felt but whose quality changes with increasing intensity. Examples of such stimuli are two-point stimuli or stimuli used to determine a just noticeable difference.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>probe</p>|<p>required</p>|<p>Image that will be used to probe the subject for an answer to the Yes/No question [ Image = Calculated(tc) ].</p>|
|<p>cue</p>|<p>required</p>|<p>Image that will be used to cue the subject to pay attention to the stimulus [ Image = Calculated(tc) ].</p>|
|<p>display-duration</p>|<p>optional</p>|<p>The duration in milliseconds that the cue will be displayed to the subject [ int ].</p>|
|<p>display-interval</p>|<p>optional</p>|<p>The duration in milliseconds between the display of the cue and the display of the prompt [ int ]. The display-interval value must be greater than the display-duration value.</p>|
|<p>pause</p>|<p>optional</p>|<p>The delay in milliseconds between when the subject answered the question and the next stimulus is presented [ int ].</p>|
|<p>yes-button</p>|<p>required</p>|<p>Button that the subject will use to indicate a Yes answer to the question [ Button ].</p>|
|<p>no-button</p>|<p>required</p>|<p>Button that the subject will use to indicate a No answer to the question [ Button ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualIntervalResponseTemplate"></a>
### ManualIntervalResponseTemplate

<p>In the Manual Interval Rating Task, the subject is asked to rate the stimuli's sensations on an interval rating scale by the experimenter. The subject provides this rating verbally, which the experimenter then manually enters into the algorithm. The response task will wait indefinitely until the experimenter has entered the subject's rating into the algorithm. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False.</p>
<p>The Manual Interval Categorical Rating task is an example of a response task that enables determining the stimulus intensity required to evoke a supramaximal response, rather than determining the intensity required to evoke a threshold response, such as a perception or pain threshold.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>instruction</p>|<p>optional</p>|<p>Question that the experimenter must ask to prompt the subject to rate the sensation on the interval rating scale [ string ].</p>|
|<p>target</p>|<p>required</p>|<p>Target rating for the response task [ int = Calculated(tc) ].</p>|
|<p>minimum</p>|<p>optional</p>|<p>Minimum rating on the interval rating scale [ int ]. Default is 0.</p>|
|<p>maximum</p>|<p>optional</p>|<p>Maximal rating on the interval rating scale [ int ]. Default is 10.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.IntervalResponseTemplate"></a>
### IntervalResponseTemplate

<p>In the Interval Rating Task, the subject is asked to rate the stimuli's sensations on an interval rating scale. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False.</p>
<p>The Interval Rating task is an example of a response task that enables determining the stimulus intensity required to evoke a supramaximal response, rather than determining the intensity required to evoke a threshold response, such as a perception or pain threshold.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>target</p>|<p>required</p>|<p>Target rating for the response task [ int = Calculated(tc) ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualCategoricalResponseTemplate"></a>
### ManualCategoricalResponseTemplate

<p>@Schema.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualCategoricalResponse.md</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>instruction</p>|<p>optional</p>|<p>Question that the experimenter must ask to prompt the subject to rate the sensation on the categorial rating scale [ string ].</p>|
|<p>target</p>|<p>required</p>|<p>Target rating for the response task [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<category>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualCategoryTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualCategoryTemplate"></a>
### ManualCategoryTemplate

<p>In the Manual Categorial Rating Task, the subject is asked to rate the stimuli's sensations on a categorial rating scale by the experimenter. The subject provides this rating verbally, which the experimenter then manually enters into the algorithm. The response task will wait indefinitely until the experimenter has entered the subject's rating into the algorithm. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False.</p>
<p>The Manual Categorical Rating task is an example of a response task that enables determining the stimulus intensity required to evoke a supramaximal response, rather than determining the intensity required to evoke a threshold response, such as a perception or pain threshold.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>text</p>|<p>required</p>|<p>Description of the category [ string. ]</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.CategoricalResponseTemplate"></a>
### CategoricalResponseTemplate

<p>In the Categorial Rating Task, the subject is asked to rate the stimuli's sensations on a categorial rating scale. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False.</p>
<p>The Categorical Rating task is an example of a response task that enables determining the stimulus intensity required to evoke a supramaximal response, in contrast to determining the intensity required to evoke a threshold response, such as a perception or pain threshold.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>target</p>|<p>required</p>|<p>Target rating for the response task [ int = Calculated(tc) ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.RatioResponseTemplate"></a>
### RatioResponseTemplate

<p>In the Ratio Rating Task, the subject is asked to rate the stimuli's sensations on a ratio rating scale/visual analog scale. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False.</p>
<p>The Ratio Rating task is an example of a response task that enables determining the stimulus intensity required to evoke a supramaximal response, rather than determining the intensity required to evoke a threshold response, such as a perception or pain threshold.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>target</p>|<p>required</p>|<p>Target rating for the response task [ int = Calculated(tc) ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.IntervalForcedChoiceResponseTemplate"></a>
### IntervalForcedChoiceResponseTemplate

<p>In an interval forced choice response task, the subject is presented with N time intervals in which the stimulus is given in one of them. The subject is asked to select the interval at which the stimulus was felt. If the subject can feel the stimulus, they will select the correct interval; if they cannot, they will have a 1/N chance to select the correct interval.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>probe</p>|<p>required</p>|<p>Image that will be used to probe the subject for an answer to which stimulus interval the stimulus was presented when the cue was shown[ Image = Calculated(tc) ].</p>|
|<p>display-duration</p>|<p>optional</p>|<p>The duration in milliseconds that the cue will be displayed to the subject [ int ].</p>|
|<p>display-interval</p>|<p>optional</p>|<p>The duration in milliseconds between the display of cues or the prompt [ int ]. The display-interval value must be greater than the display-duration value.</p>|
|<p>pause</p>|<p>optional</p>|<p>The delay in milliseconds between when the subject answered the question and the next stimulus is presented [ int ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<interval>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.StimulusInterval) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.StimulusInterval"></a>
### StimulusInterval

<p>Configuration of a stimulus interval. Stimuli will be generated for each stimulus interval in the order they are defined; when the stimulus is generated, the cue for that stimulus interval will be shown to the subject.</p>
<p>For each trial, one stimulus interval will be randomly selected as the one in which the stimulus is to be present. For that interval, the stimulus intensity (x) will be set to the current intensity determined by the estimation algorithm; for all other intervals, the stimulus intensity (x) will be set to Imin for the stimulus channel.</p>
<p>For calculated parameters, the currently active stimulus interval and selected stimulus interval are also available as the StimulusInterval and SelectedStimulusInterval parameters, respectively. These parameters contain the stimulus interval IDs.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>ID of the stimulus interval [ string ].</p>|
|<p>image</p>|<p>required</p>|<p>Cue to be shown to subject in the stimulus interval [ Image = Calculated(tc) ].</p>|
|<p>button</p>|<p>required</p>|<p>Button that the subject will use to indicate that the stimulus was present in the stimulus interval.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.AlternativeForcedChoiceResponseTemplate"></a>
### AlternativeForcedChoiceResponseTemplate

<p>In an alternative forced choice response task, the subject is presented with one stimulus randomly selected from a set of N stimulus alternatives. Once the stimulus is complete, the subject will be asked to choose the given stimulus from the set of stimulus alternatives. If the subject can feel the stimulus, they will select the correct one; if they cannot, they will have a 1/N chance to select the correct stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>probe</p>|<p>required</p>|<p>Image that will be used to probe the subject for an answer to which stimulus alternative was presented when the cue was shown[ Image = Calculated(tc) ].</p>|
|<p>cue</p>|<p>required</p>|<p>Image that will be used to cue the subject to pay attention to the stimulus [ Image = Calculated(tc) ].</p>|
|<p>display-duration</p>|<p>optional</p>|<p>The duration in milliseconds that the cue will be displayed to the subject [ int ].</p>|
|<p>display-interval</p>|<p>optional</p>|<p>The duration in milliseconds between the display of the cue and the display of the prompt [ int ]. The display-interval value must be greater than the display-duration value.</p>|
|<p>pause</p>|<p>optional</p>|<p>The delay in milliseconds between when the subject answered the question and the next stimulus is presented [ int ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<alternative>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.StimulusAlternativeTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.StimulusAlternativeTemplate"></a>
### StimulusAlternativeTemplate

<p>Configuration of a stimulus alternative where each is a different variant of the stimulus. For example, in a test that determines the just noticeable difference between three audible tones, there will be three different stimulus alternatives, for which either the first, middle, or last tone will be of a different intensity than the other tones.</p>
<p>For each trial, one stimulus alternative will be selected at random and presented to the subject. The selected one is available to calculated parameters in the StimulusAlternative parameter, whose value is the id attribute of the selected stimulus alternative.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Unique ID of the stimulus alternative [ string ].</p>|
|<p>button</p>|<p>required</p>|<p>Button that the subject will use to indicate if they felt this specific stimulus alternative.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.StimulusChannelTemplate"></a>
### StimulusChannelTemplate

<p>A stimulus channel estimates the threshold or psychometric function of a single stimulus. This threshold or psychometric function is estimated with a dedicated estimation method (Psi-method, Up/Down method, and similar) that maintains its own state for the channel but uses the same response task to determine the relationship between a stimulus parameter (x) and the probabilistic behavioral response of the participants (i.e., whether they can perform the response task correctly).</p>
<p>Once a threshold or psychometric function has been estimated, the result can be accessed by calculated parameters as <code>[Test ID].[Channel ID]</code>.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Imin</p>|<p>optional</p>|<p>Minimal stimulus intensity for the channel [ double = Calculated(tc) ].</p>|
|<p>Imax</p>|<p>required</p>|<p>Maximal stimulus intensity for the channel [ double = Calculated(tc) ].</p>|
|<p>confidence-level</p>|<p>optional</p>|<p>Confidence level when plotting estimated parameters for psychometric functions (alpha, beta, etc) [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<catch-trials>`](#LabBench.Core.Tests.Psychophysics.CatchTrialsTemplate)</p> | <p>optional</p> |<p>Catch trials are intermittent trials in which the stimulus is presented at an unequivocally subthreshold level, allowing the experimenter to verify attention. By comparing responses on these impossible trials to their known correct outcomes, catch trials provide direct empirical estimates of guess rates, helping distinguish genuine perceptual limits from non-sensory errors.</p>|
| <p><span style="white-space: nowrap;">  [`<psi-method>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.PsiAlgorithmTemplate) </span><br /><span style="white-space: nowrap;">  [`<up-down-method>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.UpDownAlgorithmTemplate) </span><br /><span style="white-space: nowrap;">  [`<discrete-up-down-method>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.DiscreteUpDownAlgorithmTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.CatchTrialsTemplate"></a>
### CatchTrialsTemplate

<p><strong>Catch trials</strong> are predefined control trials incorporated into an experimental protocol. These trials
present either a stimulus with a known or obvious outcome or no stimulus, and serve to evaluate subject
attention, task comprehension, and response compliance. Catch trials do not contribute to the primary
experimental measurements.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>order</p>|<p>required</p>|<p>Randomization of the catch trial:</p> <ul> <li><strong>deterministic</strong>: Deterministic catch trials will occur with a fixed interval.</li> <li><strong>block-randomized</strong>: Block randomized will occur once within a block of interval number of stimuli.</li> <li><strong>randomized</strong>: Randomized catch trials will be generated with a probability of 1/interval.</li> </ul>|
|<p>interval</p>|<p>required</p>|<p>The interval, block-size, or probability with which the catch trial is generated [ int ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.PsiAlgorithmTemplate"></a>
### PsiAlgorithmTemplate

<p>This method implements the Psi method of Kontsevich &amp; Tyler (1999). The Psi method is a Bayesian adaptive procedure that maintains a full joint posterior distribution over the threshold and slope of the psychometric function, while holding the guess and lapse rates fixed.</p>
<p>On each trial, the algorithm evaluates a set of candidate stimulus intensities and, for each one, computes the expected reduction in entropy of the current posterior if that stimulus were presented. It then selects the stimulus level that maximizes expected information gain, presents it to the observer, records the binary response, and updates the posterior via Bayes� rule.</p>
<p>This iterative cycle - predict information gain =&gt; choose optimal stimulus =&gt; observe response =&gt; update posterior - allows the method to rapidly converge on precise estimates of threshold and slope with high efficiency compared to traditional staircases or other adaptive schemes.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>number-of-trials</p>|<p>required</p>|<p>Number of trials that are performed with the algorithm [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<quick>`](#LabBench.Psychophysics.PsychometricFunction)</p> | <p>required</p> |<p>The psychometric function that links stimulus intensity to the probability of a correct or “yes” response, providing a quantitative model of perceptual sensitivity.</p>|
| <p>[`<beta>`](#LabBench.Core.XmlTools.ArrayGeneratorTemplate)</p> | <p>required</p> |<p>The beta range specifies the set of slope values considered in the posterior distribution, constraining the possible steepnesses of the psychometric function that the algorithm can infer.</p>|
| <p>[`<alpha>`](#LabBench.Core.XmlTools.ArrayGeneratorTemplate)</p> | <p>required</p> |<p>The alpha range defines the set of threshold values over which the algorithm computes and updates its posterior, effectively bounding the possible thresholds it can estimate.</p>|
| <p>[`<intensity>`](#LabBench.Core.XmlTools.ArrayGeneratorTemplate)</p> | <p>required</p> |<p>The intensity range defines the allowable stimulus levels the algorithm can choose from on each trial when selecting the next, most informative stimulus.</p>|


<a id="LabBench.Psychophysics.PsychometricFunction"></a>
### PsychometricFunction

<p>Psychometric function.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>alpha</p>|<p>optional</p>|<p>The alpha parameter of a psychometric function specifies its threshold, the stimulus intensity at which performance reaches a chosen criterion probability (i.e. 50% correct) [ double ].</p>|
|<p>beta</p>|<p>optional</p>|<p>The beta parameter of a psychometric function determines its slope, describing how rapidly response probability increases with stimulus intensity around the threshold [ double ].</p>|
|<p>lambda</p>|<p>optional</p>|<p>The lambda parameter of a psychometric function specifies the lapse rate, accounting for stimulus-independent errors by setting an upper performance bound below 100% [ double ].</p>|
|<p>gamma</p>|<p>optional</p>|<p>The gamma parameter of a psychometric function specifies the guess rate, representing the lower asymptote of performance due to chance-level responding.</p>|


<a id="LabBench.Core.XmlTools.ArrayGeneratorTemplate"></a>
### ArrayGeneratorTemplate

<p>Generation of arrays.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|
|<p>type</p>|<p>required</p>|<p>Algorithm to use for the generation of values:</p> <ul> <li><strong>linspace</strong>: the generated values are linearly spaced between the <code>x0</code> and <code>x1</code> values, both values included. A total of <code>n</code> values will be generated.</li> <li><strong>logspace</strong>: the values are given as <code>x_n = base^xl_n</code>, where <code>xl_n</code> are the values of a <code>linspace</code> generated values.</li> <li><strong>geomspace</strong>: the values are generated as a geometric progression between the <code>x0</code> and <code>x1</code> values, both values included. Consequently, each subsequent value <code>x_n + 1</code> is found as a common ratio <code>r</code> multiplied by the previous value <code>x_n</code>. The common ratio is calculated automatically, resulting in <code>n</code> values spaced geometrically between <code>x0</code> and <code>x1</code>.</li> <li><strong>array</strong>: the values are generated from a calculated parameter [ double[] = Calculated(tc) ].</li> </ul>|
|<p>n</p>|<p>optional</p>|<p>Number of samples to generate [ double = Calculated(tc) ]. Value will be rounded down to nearest integer.</p>|
|<p>x0</p>|<p>optional</p>|<p>Starting value for the generated values [ double = Calculated(tc) ].</p>|
|<p>x1</p>|<p>optional</p>|<p>End value for the generated values [ double = Calculated(tc) ].</p>|
|<p>base</p>|<p>optional</p>|<p>Base value for logspace generated values [ double = Calculated(tc) ].</p>|
|<p>value</p>|<p>optional</p>|<p>Value for array generated values [ double[] = Calculated(tc) ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.UpDownAlgorithmTemplate"></a>
### UpDownAlgorithmTemplate

<p>The up/down, also known as the staircase method, is an adaptive method that estimates a psychophysical threshold by increasing the intensity until the subject performs the response task correctly, then reversing the direction of intensity change and decreasing it until the subject fails to perform the response task correctly.</p>
<p>This pattern of increasing/decreasing the intensity until the subject either succeeds or fails the response task is repeated a set number of times. When complete, the algorithm finds the threshold as the average intensity at which the intensity change reversed, due to a change from failing (increasing threshold) to succeeding (decreasing threshold). The algorithm can be configured to either initially increase or decrease the intensity with the <code>initial-direction</code> attribute.</p>
<p>The step size of the intensity change can either be absolute or relative. If it is absolute, the step size is in the same unit as the intensity and changes the intensity by a fixed amount. If it is relative, its intensity changes by a given fraction of its current value. The step size can also be adaptive: initially higher to approach the threshold quickly, then decreasing with each reversal of the intensity change until a given maximal reduction is reached. When the step size is adaptive, the average will be weighted by the inverse of the step sizes.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>reversal-rule</p>|<p>optional</p>|<p>The number of times the participants must either succeed or fail for the intensity change to change direction [int = Calculated(tc)]. This attribute is used for both upward and downward directions unless either the <code>up-rule</code> or the <code>down-rule</code> is defined, respectively. The default value for this attribute is one (1).</p>|
|<p>up-rule</p>|<p>optional</p>|<p>The number of times the participants must succeed when the intensity is increased upward for the intensity change to change direction [int = Calculated(tc)]. The default value for this attribute is one (1).</p>|
|<p>down-rule</p>|<p>optional</p>|<p>The number of times the participants must fail when the intensity is decreased upward for the intensity change to change direction [int = Calculated(tc)]. The default value for this attribute is one (1).</p>|
|<p>step-size</p>|<p>optional</p>|<p>Will be used as the initial step size in both the up and down directions, unless the step-size-up or step-size-down is defined [double = Calculated(tc)]. Default value is 0.1.</p>|
|<p>step-size-up</p>|<p>optional</p>|<p>Will be used as the initial step size in the upward direction [double = Calculated(tc)]. If it is undefined, the step-size attribute will be used instead as the initial step size for the up direction.</p>|
|<p>step-size-down</p>|<p>optional</p>|<p>Will be used as the initial step size in the downward direction [double = Calculated(tc)]. If it is undefined, the step-size attribute will be used instead as the initial step size for the downward direction.</p>|
|<p>step-size-reduction</p>|<p>optional</p>|<p>Used to configure adaptive step sizes [ double = Calculated(tc) ]. The step size after a reversal will be <code>new-step-size</code> = (1 - <code>step-size-reduction</code>) * <code>old-step-size</code>. The default value is 0.5.</p>|
|<p>max-step-size-reduction</p>|<p>optional</p>|<p>The maximum by which step sizes will be reduced when adaptive step sizes are enabled by setting the <code>step-size-reduction</code> attribute to a non-zero value [ double = Calculated(tc) ].</p>|
|<p>step-size-type</p>|<p>optional</p>|<p>Type of step size: absolute, the step size is added or subtracted to the current intensity, or relative, the step size is relative to the current intensity.</p>|
|<p>stop-rule</p>|<p>required</p>|<p>Number of reversals required before the algorithm is completed [ int = Calculated(tc) ].</p>|
|<p>skip-rule</p>|<p>optional</p>|<p>The number of initial reversals that are skipped when calculating the threshold as the average of the intensity at the reversals [ int = Calculated(tc) ]. Consequently, if this <code>skip-role</code> attribute is set to one (3) and the stop-rule is set to nine (9), the threshold will be calculated from the last six (6) reversals. The default value is zero (0).</p>|
|<p>start-intensity</p>|<p>required</p>|<p>Initial intensity for the algorithm [ double = Calculated(tc) ].</p>|
|<p>initial-direction</p>|<p>optional</p>|<p>Initial direction for the intensity change.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<quick>`](#LabBench.Psychophysics.PsychometricFunction)</p> | <p>optional</p> |<p>Psychometric function.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.DiscreteUpDownAlgorithmTemplate"></a>
### DiscreteUpDownAlgorithmTemplate

<p>The up/down method, also known as the staircase method, is an adaptive method that estimates a psychophysical threshold by increasing the intensity until the subject performs the response task correctly, then reversing the direction of intensity change and decreasing it until the subject fails to perform the response task correctly. This discrete version of the method <code>&lt;discrete-up-down-method&gt;</code> is different from the continuous version of the method  <code>&lt;up-down-method&gt;</code>  in that stimulus intensities can only take on values from a discrete set of values instead of from a continuum of values between the minimum and maximum intensity values.</p>
<p>This pattern of increasing/decreasing the intensity until the subject either succeeds or fails the response task is repeated a set number of times. When complete, the algorithm finds the threshold as the average intensity at which the intensity change reverses, from failing (increasing threshold) to succeeding (decreasing threshold). The algorithm can be configured to either initially increase or decrease the intensity with the <code>initial-direction</code> attribute.</p>
<p>The index of the currently selected intensity is available to calculated parameters as the <code>IntensityIndex</code> variable.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>stop-rule</p>|<p>required</p>|<p>Number of reversals required before the algorithm is completed [ int = Calculated(tc) ].</p>|
|<p>initial-intensity</p>|<p>required</p>|<p>This attribute is used to select the initial intensity from the set of allowed intensities ('intensities') [ double = Calculated(tc) ]. The initial intensity will be selected as the intensity in the set of allowed intensities closest to the value of this initial intensity attribute. If this attribute is not defined, the initial intensity will be set based on the initial direction. If the initial direction is upward, the smallest allowed intensity will be used; otherwise, the largest allowed intensity will be used.</p>|
|<p>intensities</p>|<p>required</p>|<p>The discrete set of allowed stimulus intensities in the form of an array of doubles [ double[] = Calculated(tc) ]. These values must be ordered from the smallest to the largest and must be within the bounds of the Imin and Imax attributes for the stimulus channel.</p>|
|<p>initial-direction</p>|<p>optional</p>|<p>Initial direction for the intensity change.</p>|
|<p>initial-step-size</p>|<p>optional</p>|<p>Sets the initial step size [ int = Calculated(tc) ]. The initial step size can be set to a value larger than one (1) to initially rapidly approach the threshold. Once a reversal has occurred, the step size will be set to one (1).</p>|
|<p>skip-rule</p>|<p>optional</p>|<p>The number of initial reversals that are skipped when calculating the threshold as the average of the intensity at the reversals [ int = Calculated(tc) ]. Consequently, if this <code>skip-role</code> attribute is set to one (3) and the stop-rule is set to nine (9), the threshold will be calculated from the last six (6) reversals. The default value is zero (0).</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.StimulusChannelConstructor"></a>
### StimulusChannelConstructor

<p>A stimulus channel estimates the threshold or psychometric function of a single stimulus. This threshold or psychometric function is estimated with a dedicated estimation method (Psi-method, Up/Down method, and similar) that maintains its own state for the channel but uses the same response task to determine the relationship between a stimulus parameter (x) and the probabilistic behavioral response of the participants (i.e., whether they can perform the response task correctly).</p>
<p>Once a threshold or psychometric function has been estimated, the result can be accessed by calculated parameters as <code>[Test ID].[Channel ID]</code>.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Unique ID of the stimulus channel [ string ].</p>|
|<p>name</p>|<p>required</p>|<p>Name of the channel [ string ].</p>|
|<p>Imin</p>|<p>optional</p>|<p>Minimal stimulus intensity for the channel [ double = Calculated(tc) ].</p>|
|<p>Imax</p>|<p>optional</p>|<p>Maximal stimulus intensity for the channel [ double = Calculated(tc) ].</p>|
|<p>confidence-level</p>|<p>optional</p>|<p>Confidence level when plotting estimated parameters for psychometric functions (alpha, beta, etc) [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<catch-trials>`](#LabBench.Core.Tests.Psychophysics.CatchTrialsTemplate)</p> | <p>optional</p> |<p>Catch trials are intermittent trials in which the stimulus is presented at an unequivocally subthreshold level, allowing the experimenter to verify attention. By comparing responses on these impossible trials to their known correct outcomes, catch trials provide direct empirical estimates of guess rates, helping distinguish genuine perceptual limits from non-sensory errors.</p>|
| <p><span style="white-space: nowrap;">  [`<psi-method>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.PsiAlgorithmTemplate) </span><br /><span style="white-space: nowrap;">  [`<up-down-method>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.UpDownAlgorithmTemplate) </span><br /><span style="white-space: nowrap;">  [`<discrete-up-down-method>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.DiscreteUpDownAlgorithmTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |
| <p>[`<triggers>`](#LabBench.Core.Components.Triggering.TriggerDefinitionTemplate)</p> | <p>optional</p> |<p>Specifies a set of triggers to be generated. These triggers will all be generated with a given duration (<code>duration</code>) and delay (<code>Tdelay</code>). The delay is relative to the start time of its parent trigger sequence; if it has no parent trigger sequence, it is relative to time zero.</p> <p>A trigger may generate a trigger on multiple digital outputs. Each output is specified with a nested <code>&lt;code&gt;</code> element.</p>|
| <p>[`<stimulus>`](#LabBench.Core.Components.Stimulation.StimulusDefinitionTemplate)</p> | <p>optional</p> |<p>Definition of a stimulus.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.StimulusChannelConstructorForeach"></a>
### StimulusChannelConstructorForeach

<p>Use a <code>foreach</code> loop with a template variable list to generate stimulation channels from templates programmatically.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>variable</p>|<p>required</p>|<p>Variable name [ string ]. The <code>foreach</code> loop iterates over all values in the template variable list named by the <code>in</code> attribute, and for each iteration, the value is available in the variable named by the <code>variable</code> attribute.</p>|
|<p>in</p>|<p>required</p>|<p>Name of the template variable list to iterate over [ string ]. The attribute is named <code>in</code> to resemble the typical foreach programming construct <code>foreach (var n in variable)</code>.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<stimulus>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.StimulusChannelConstructor) </span><br /><span style="white-space: nowrap;">  [`<foreach>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.StimulusChannelConstructorForeach) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ColdPresser.ColdPressorTestTemplate"></a>
### ColdPressorTestTemplate

<p>The Cold Pressor test is a standardized experimental pain paradigm in which a participant immerses a hand
or forearm in cold water to determine pain detection (PDT) and tolerance thresholds (PTT). The thresholds
are measured as the time to pain onset and the time to pain tolerance.</p>
<p>The test can be configured to measure PDT, PTT, or both. When a single threshold is measured, time
measurement is started with a button press when the hand is placed in the cold water and stopped with a
second button press when the hand is withdrawn from the water. When both thresholds are measured, the
second button press marks the PDT, and the third button press marks the PTT when the hand is withdrawn
from the water.</p>
<p>While the test is designed for the Cold Pressor test, it can be used for any task for which detection and
tolerance thresholds can be quantified by the time the participant experiences them. All instructions and
descriptive texts can be customized to adapt the test for other tasks.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>control</p>|<p>optional</p>|<p>Configuration of who marks the events with a press of a button: the operator or the participant.</p>|
|<p>measurement</p>|<p>required</p>|<p>This attribute controls how the test interprets button presses and can be used to determine the PDT, PTT,  or both:</p> <ul> <li><code>PDT</code>: Determination of a detection threshold.</li> <li><code>PTT</code>: Determination of a tolerance threshold.</li> <li><code>BOTH</code>: Determination of both a detection and tolerance threshold.</li> </ul> <p>For all measurements the first button press markes the start of the task.</p>|
|<p>time-limit</p>|<p>required</p>|<p>Time limit for the test in seconds [ double = Calculated(tc) ]. If the end event has been marked within this time limit, the test will end automatically, and the participant will be marked as a non-responder.</p>|
|<p>button</p>|<p>required</p>|<p>Configuration of the button used to mark events during the test.</p>|
|<p>ready-instruction</p>|<p>optional</p>|<p>Instructions to be used when the test is ready to run [ dynamic test ].</p> <p>The default text for this instruction is &quot;Test is ready to run&quot;.</p>|
|<p>completed-instruction</p>|<p>optional</p>|<p>The default text for this instruction is &quot;Test is completed&quot;.</p>|
|<p>pending-instruction</p>|<p>optional</p>|<p>Instructions to be used when the test is running and waiting for the first event to be marked [ dynamic text ]. For the cold-pressor test, the first event is when the participant's hand is placed in the water.</p> <p>The default text for this instruction is &quot;Press the button when the hand is placed in the water&quot;.</p>|
|<p>pain-instruction</p>|<p>optional</p>|<p>Instructions to be used when determining the pain detection threshold (PDT) [ dynamic text ]. This instruction applies to PDT and BOTH measurements.</p> <p>The default text for this instruction is &quot;Press the button when pain is felt&quot;.</p>|
|<p>completion-instruction</p>|<p>optional</p>|<p>Instructions to be used for the final event [ dynamic text ]. For the cold-pressor test, this event is the withdrawal of the hand from the water.</p> <p>The default text for this instruction is &quot;Press the button when the hand is withdrawn from the water&quot;.</p>|
|<p>pdt-label</p>|<p>optional</p>|<p>Label to be used for the PDT measurement [ dynamic text ]. The default value is cold pain detection threshold (CPD).</p>|
|<p>ptt-label</p>|<p>optional</p>|<p>Label to be used for the PTT measurement [ dynamic text ]. The default value is cold pain tolerance threshold (CPT)</p>|
|<p>non-responder-label</p>|<p>optional</p>|<p>Description of non-responders [ dynamic text ].</p>|
|<p>responder-label</p>|<p>optional</p>|<p>Description of responders [ dynamic text ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualThresholdEstimationTestTemplate"></a>
### ManualThresholdEstimationTestTemplate

<p>The manual threshold estimation test is used to estimate thresholds/psychometric functions when LabBench cannot control the stimulus, and instead, the experimenter must manually apply the stimulus to the subject. Estimation of these thresholds/psychometric functions consists of two parts: response task and estimation algorithm:</p>
<ul>
<li><strong>Response task</strong>: the perception task that the subject is asked to perform when the stimulus is presented. The outcome of this task is either correct: the subject perceived the stimulus correctly, or incorrect: the stimulus intensity was too low, and the subject failed to perceive the stimulus correctly.</li>
<li><strong>Estimation algorithm</strong>: the adaptive algorithm by which the threshold/psychometric function is estimated. This algorithm uses the outcome of the response task (correct/incorrect) to update the estimate of the threshold or psychometric function for each stimulus presentation.</li>
</ul>
<p>The stimulus is defined by the nature of the questions asked in the response task. The thresholds or psychometric functions are estimated for an independent variable (x). An increase in x is assumed to increase the probability that the subject will correctly perform the response task.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>stimulus-unit</p>|<p>required</p>||


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>[`<intensity-transformation>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.Transform)</p> | <p>optional</p> |<p>The test instructs the experimenter which stimulus intensity to apply to the subject for each iteration of the estimation.</p> <p>For specific mechanical stimulators, there can be an offset between the scale that the experimenter uses to set the stimulus intensity and the actual intensity given by the stimulator to the subject. For example, when a custom-made two-point discriminator is made from a caliper, there might be a constant offset between the distance indicated on the caliper scale and the distance between the tips of the custom-made prongs attached to the caliper.</p> <p>The intensity-transformation allows the intensity displayed to the experimenter to be linearly transformed before it is shown to the experimenter, meaning that the experimenter will not need to apply this transformation mentally while following the test's instructions.</p>|
| <p>[`<catch-trials>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualCatchTrialsTemplate)</p> | <p>optional</p> |<p>A catch trial is a trial in which no stimulus or the equivalent of no stimulus is presented.It is included to estimate the participant's baseline tendency to respond positively without a stimulus.</p>|
| <p><span style="white-space: nowrap;">  [`<psi-algorithm>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.Algorithms.ManualPsiAlgorithmTemplate) </span><br /><span style="white-space: nowrap;">  [`<up-down-algorithm>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.Algorithms.ManualUpDownAlgorithmTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |
| <p><span style="white-space: nowrap;">  [`<yes-no-task>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ResponseTasks.ManualYesNoTaskTemplate) </span><br /><span style="white-space: nowrap;">  [`<two-interval-forced-choice-task>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ResponseTasks.ManualTwoIntervalForcedChoiceTaskTemplate) </span><br /><span style="white-space: nowrap;">  [`<one-interval-forced-choice-task>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ResponseTasks.ManualOneIntervalForcedChoiceTaskTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.Transform"></a>
### Transform

<p>The test instructs the experimenter which stimulus intensity to apply to the subject for each iteration of the estimation.</p>
<p>For specific mechanical stimulators, there can be an offset between the scale that the experimenter uses to set the stimulus intensity and the actual intensity given by the stimulator to the subject. For example, when a custom-made two-point discriminator is made from a caliper, there might be a constant offset between the distance indicated on the caliper scale and the distance between the tips of the custom-made prongs attached to the caliper.</p>
<p>The intensity-transformation allows the intensity displayed to the experimenter to be linearly transformed before it is shown to the experimenter, meaning that the experimenter will not need to apply this transformation mentally while following the test's instructions.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>a</p>|<p>optional</p>|<p>Slope (a) for the linear intensity transformation (y = ax + b) [ double ].</p>|
|<p>b</p>|<p>optional</p>|<p>Offset (b) for the linear intensity transformation (y = ax + b) [ double ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualCatchTrialsTemplate"></a>
### ManualCatchTrialsTemplate

<p>A catch trial is a trial in which no stimulus or the equivalent of no stimulus is presented.It is included to estimate the participant's baseline tendency to respond positively without a stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>order</p>|<p>required</p>|<p>Order in which the catch trials is generated [ deterministic, block-randomized, or randomized ]</p>|
|<p>interval</p>|<p>required</p>|<p>The interval, block-size, or probability with which the catch trial is generated [ int ].</p>|
|<p>image</p>|<p>optional</p>|<p>The image that is used to instruct the operator to perform a catch trial [ image = Calculated(tc) ]</p>|
|<p>instruction</p>|<p>optional</p>|<p>The instruction used to inform the operator to perform a catch trial [ DynamicText ]</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.Algorithms.ManualPsiAlgorithmTemplate"></a>
### ManualPsiAlgorithmTemplate

<p>The Psi Method, developed by <a href="https://www.sciencedirect.com/science/article/pii/S0042698998002855?via%3Dihub">Lenny Kontsevich and Christopher Tyler (1999)</a>, is a Bayesian adaptive psychometric procedure used to estimate perception thresholds and the shape of the psychometric function (like slope, lapse rate, etc.). It is more advanced than up/down staircases and offers greater efficiency and precision. The algorithm aims to estimate the full psychometric function for the perception of a stimulus instead of only determining a threshold. At each trial in the algorithm, a posterior probability distribution is maintained for the unknown parameters of the psychometric function (alpha, beta).</p>
<p>At each trial, the method will:</p>
<ol>
<li>The posterior probability distributions for correct and incorrect results are calculated based on Bayes's Theorem from the a priori probability distribution (the posterior probability distribution from the previous step in the algorithm).</li>
<li>Determine the optimal stimulus intensity that reveals the most information on the unknown parameters of the psychometric function. This optimal test intensity is determined by minimizing the entropy based on Shannon entropy (H) calculated from the posterior probability distributions that will result from both a correct and incorrect response.</li>
<li>The response task (Yes/No, One Interval Forced Choice, or Two Interval Forced Choice) tests the optimal stimulus intensity.</li>
<li>Depending on the participant's response to the response task, the posterior probability distribution for either the correct or incorrect response is selected as the a priori probability distribution for the next step in the algorithm.</li>
</ol>
<p>Consequently, the algorithm will iteratively update its information on the most probable psychometric function. The algorithm is set to perform a fixed set of steps; thus, the execution time is known and fixed, in contrast to the Up/Down algorithm, whose execution time depends on the participant's responses.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>intensities</p>|<p>required</p>|<p>Stimulation intensities [ double[] = Calculated(tc) ].</p>|
|<p>intensity-labels</p>|<p>optional</p>|<p>When specified, labels provided by this attribute will be displayed instead of intensities [ string[] = Calculated(tc) ]. The list of labels specified must have the same length as the list of intensities.</p>|
|<p>number-of-trials</p>|<p>required</p>|<p>Number of stimuli that will be presented to the subject [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<gumbel>`](#LabBench.Psychophysics.Function.Gumbel) </span><br /><span style="white-space: nowrap;">  [`<hyperbolic-secant>`](#LabBench.Psychophysics.Function.HyperbolicSecant) </span><br /><span style="white-space: nowrap;">  [`<logistics>`](#LabBench.Psychophysics.Function.Logistic) </span><br /><span style="white-space: nowrap;">  [`<log-quick>`](#LabBench.Psychophysics.Function.LogQuick) </span><br /><span style="white-space: nowrap;">  [`<normal>`](#LabBench.Psychophysics.Function.Normal) </span><br /><span style="white-space: nowrap;">  [`<quick>`](#LabBench.Psychophysics.Function.Quick) </span><br /><span style="white-space: nowrap;">  [`<weibull>`](#LabBench.Psychophysics.Function.Weibull) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |
| <p>[`<beta>`](#LabBench.Core.XmlTools.ArrayGeneratorTemplate)</p> | <p>required</p> |<p>Range of beta parameters.</p>|
| <p>[`<alpha>`](#LabBench.Core.XmlTools.ArrayGeneratorTemplate)</p> | <p>required</p> |<p>Range of alpha parameters.</p>|


<a id="LabBench.Psychophysics.Function.Gumbel"></a>
### Gumbel

<p>Gumbel Psychometric Function</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>alpha</p>|<p>optional</p>|<p>The alpha parameter of a psychometric function specifies its threshold, the stimulus intensity at which performance reaches a chosen criterion probability (i.e. 50% correct) [ double ].</p>|
|<p>beta</p>|<p>optional</p>|<p>The beta parameter of a psychometric function determines its slope, describing how rapidly response probability increases with stimulus intensity around the threshold [ double ].</p>|
|<p>lambda</p>|<p>optional</p>|<p>The lambda parameter of a psychometric function specifies the lapse rate, accounting for stimulus-independent errors by setting an upper performance bound below 100% [ double ].</p>|
|<p>gamma</p>|<p>optional</p>|<p>The gamma parameter of a psychometric function specifies the guess rate, representing the lower asymptote of performance due to chance-level responding.</p>|


<a id="LabBench.Psychophysics.Function.HyperbolicSecant"></a>
### HyperbolicSecant

<p>Hyperbolic Secant Psychometric Function</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>alpha</p>|<p>optional</p>|<p>The alpha parameter of a psychometric function specifies its threshold, the stimulus intensity at which performance reaches a chosen criterion probability (i.e. 50% correct) [ double ].</p>|
|<p>beta</p>|<p>optional</p>|<p>The beta parameter of a psychometric function determines its slope, describing how rapidly response probability increases with stimulus intensity around the threshold [ double ].</p>|
|<p>lambda</p>|<p>optional</p>|<p>The lambda parameter of a psychometric function specifies the lapse rate, accounting for stimulus-independent errors by setting an upper performance bound below 100% [ double ].</p>|
|<p>gamma</p>|<p>optional</p>|<p>The gamma parameter of a psychometric function specifies the guess rate, representing the lower asymptote of performance due to chance-level responding.</p>|


<a id="LabBench.Psychophysics.Function.Logistic"></a>
### Logistic

<p>Logistic Psychometric Function</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>alpha</p>|<p>optional</p>|<p>The alpha parameter of a psychometric function specifies its threshold, the stimulus intensity at which performance reaches a chosen criterion probability (i.e. 50% correct) [ double ].</p>|
|<p>beta</p>|<p>optional</p>|<p>The beta parameter of a psychometric function determines its slope, describing how rapidly response probability increases with stimulus intensity around the threshold [ double ].</p>|
|<p>lambda</p>|<p>optional</p>|<p>The lambda parameter of a psychometric function specifies the lapse rate, accounting for stimulus-independent errors by setting an upper performance bound below 100% [ double ].</p>|
|<p>gamma</p>|<p>optional</p>|<p>The gamma parameter of a psychometric function specifies the guess rate, representing the lower asymptote of performance due to chance-level responding.</p>|


<a id="LabBench.Psychophysics.Function.LogQuick"></a>
### LogQuick

<p>Log-Quick Psychometric Function</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>alpha</p>|<p>optional</p>|<p>The alpha parameter of a psychometric function specifies its threshold, the stimulus intensity at which performance reaches a chosen criterion probability (i.e. 50% correct) [ double ].</p>|
|<p>beta</p>|<p>optional</p>|<p>The beta parameter of a psychometric function determines its slope, describing how rapidly response probability increases with stimulus intensity around the threshold [ double ].</p>|
|<p>lambda</p>|<p>optional</p>|<p>The lambda parameter of a psychometric function specifies the lapse rate, accounting for stimulus-independent errors by setting an upper performance bound below 100% [ double ].</p>|
|<p>gamma</p>|<p>optional</p>|<p>The gamma parameter of a psychometric function specifies the guess rate, representing the lower asymptote of performance due to chance-level responding.</p>|


<a id="LabBench.Psychophysics.Function.Normal"></a>
### Normal

<p>Normal Psychometric Function</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>alpha</p>|<p>optional</p>|<p>The alpha parameter of a psychometric function specifies its threshold, the stimulus intensity at which performance reaches a chosen criterion probability (i.e. 50% correct) [ double ].</p>|
|<p>beta</p>|<p>optional</p>|<p>The beta parameter of a psychometric function determines its slope, describing how rapidly response probability increases with stimulus intensity around the threshold [ double ].</p>|
|<p>lambda</p>|<p>optional</p>|<p>The lambda parameter of a psychometric function specifies the lapse rate, accounting for stimulus-independent errors by setting an upper performance bound below 100% [ double ].</p>|
|<p>gamma</p>|<p>optional</p>|<p>The gamma parameter of a psychometric function specifies the guess rate, representing the lower asymptote of performance due to chance-level responding.</p>|


<a id="LabBench.Psychophysics.Function.Quick"></a>
### Quick

<p>Quick Psychometric Function</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>alpha</p>|<p>optional</p>|<p>The alpha parameter of a psychometric function specifies its threshold, the stimulus intensity at which performance reaches a chosen criterion probability (i.e. 50% correct) [ double ].</p>|
|<p>beta</p>|<p>optional</p>|<p>The beta parameter of a psychometric function determines its slope, describing how rapidly response probability increases with stimulus intensity around the threshold [ double ].</p>|
|<p>lambda</p>|<p>optional</p>|<p>The lambda parameter of a psychometric function specifies the lapse rate, accounting for stimulus-independent errors by setting an upper performance bound below 100% [ double ].</p>|
|<p>gamma</p>|<p>optional</p>|<p>The gamma parameter of a psychometric function specifies the guess rate, representing the lower asymptote of performance due to chance-level responding.</p>|


<a id="LabBench.Psychophysics.Function.Weibull"></a>
### Weibull

<p>Weibull Psychometric Function</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>alpha</p>|<p>optional</p>|<p>The alpha parameter of a psychometric function specifies its threshold, the stimulus intensity at which performance reaches a chosen criterion probability (i.e. 50% correct) [ double ].</p>|
|<p>beta</p>|<p>optional</p>|<p>The beta parameter of a psychometric function determines its slope, describing how rapidly response probability increases with stimulus intensity around the threshold [ double ].</p>|
|<p>lambda</p>|<p>optional</p>|<p>The lambda parameter of a psychometric function specifies the lapse rate, accounting for stimulus-independent errors by setting an upper performance bound below 100% [ double ].</p>|
|<p>gamma</p>|<p>optional</p>|<p>The gamma parameter of a psychometric function specifies the guess rate, representing the lower asymptote of performance due to chance-level responding.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.Algorithms.ManualUpDownAlgorithmTemplate"></a>
### ManualUpDownAlgorithmTemplate

<p>The up/down algorithm, also known as the staircase method, is an adaptive method for estimating psychophysical minimal intensity (threshold) at which a participant perceives a stimulus with 50% reliability. The algorithm adjusts the intensity based on the participant's response; if the response is correct, the intensity is decreased (the stimulus becomes harder to perceive); if it is incorrect, the intensity is increased (the stimulus becomes easier to perceive).</p>
<p>The algorithm will initially either increase (initial-direction=&quot;increasing&quot;) or decrease (initial-direction=&quot;decreasing&quot;) the intensity from the lowest or highest possible intensity, respectively. It will continue to do so until the subject answers correctly or incorrectly, depending on the direction of intensity change, after which the direction of intensity change is reversed. At each reversal, the intensity is stored, and the threshold is calculated as the average of these intensities where the direction of intensity change was reversed.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>intensities</p>|<p>required</p>|<p>Stimulation intensities [ double[] = Calculated(tc) ].</p>|
|<p>intensity-labels</p>|<p>optional</p>|<p>When specified, labels provided by this attribute will be displayed instead of intensities [ string[] = Calculated(tc) ]. The list of labels specified must have the same length as the list of intensities.</p>|
|<p>stop-rule</p>|<p>required</p>|<p>Number of intensity revarsel that must occur before the algorithm terminated [ int = Calculated(tc) ].</p>|
|<p>terminate-on-limit-reached</p>|<p>optional</p>|<p>[ DEPRECATED ]</p>|
|<p>initial-direction</p>|<p>optional</p>|<p>Initial direction of the intensity change [ increasing or decreasing ]. If not specified it is set to increasing.</p>|
|<p>initial-step-size</p>|<p>optional</p>|<p>Initial step size [ int = Calculated(tc) ]. Once a intensity reversal have occured the step size will be set to one (1).</p>|
|<p>skip-rule</p>|<p>optional</p>|<p>Number of initial intensity reversal that will be discarded in the threshold calculation [ int = Calculated(tc) ]. If not specified this attribute is set to zero.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ResponseTasks.ManualYesNoTaskTemplate"></a>
### ManualYesNoTaskTemplate

<p>A Yes/No response task can be performed when the stimulus can elicit a positive response (Yes) or negative response (No). It is performed by asking the subject a question. For example, for a two-point discrimination test, &quot;How many points did you feel touching the skin?&quot; to which the subject can answer either &quot;One&quot; or &quot;Two&quot;. In this example, if the subject answers Two, they correctly perceive the stimulus by answering positively.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>question</p>|<p>required</p>|<p>The question about the stimulus that the participants is required to answer [ DynamicText ].</p>|
|<p>task-illustration-image</p>|<p>required</p>|<p>The image that is used to illustrate the stimulation task for the operator [ image = Calculated(tc) ]</p>|
|<p>positive-answer</p>|<p>required</p>|<p>The expected answer for positive responses [ DynamicText ].</p>|
|<p>negative-answer</p>|<p>required</p>|<p>The expected answer for negative responses [ DynamicText ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ResponseTasks.ManualTwoIntervalForcedChoiceTaskTemplate"></a>
### ManualTwoIntervalForcedChoiceTaskTemplate

<p>In a two-interval forced-choice task, the stimulus is presented in one of two time intervals. The participant is then asked to answer in which time interval the stimulus was presented. If the intensity makes it possible for the participant to perceive the stimulus, they will choose the correct interval. However, if the intensity is too low to be perceived, the participant will be forced to answer and will thus have a 50% chance of answering correctly. Consequently, the two-interval forced choice task is usually used with the Psi-Method, which can estimate psychometric functions for which the guess rate (gamma) is 50%.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>question</p>|<p>required</p>|<p>The question about the stimulus that the participants is required to answer [ DynamicText ].</p>|
|<p>no-stimulus-image</p>|<p>required</p>|<p>Image used to illustrate an interval where no stimulus should be presented [ image = Calculated(tc) ].</p>|
|<p>stimulus-image</p>|<p>required</p>|<p>Image used to illustrate an interval where a stimulus should be presented [ image = Calculated(tc) ].</p>|
|<p>interval-a</p>|<p>required</p>|<p>Name of interval A [ DynamicText ].</p>|
|<p>interval-b</p>|<p>required</p>|<p>Name of interval B [ DynamicText ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ResponseTasks.ManualOneIntervalForcedChoiceTaskTemplate"></a>
### ManualOneIntervalForcedChoiceTaskTemplate

<p>In a one-interval forced-choice task, the participant is asked to choose between two alternatives based on the stimulus presented. If the intensity makes it possible for the participant to perceive the stimulus, they will choose the correct alternative. However, if the intensity is too low to be perceived, the participant will be forced to answer and will thus have a 50% chance of answering correctly. Consequently, the one-interval forced choice task is usually used with the Psi-Method, which can estimate psychometric functions for which the guess rate (gamma) is 50%.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>question</p>|<p>required</p>|<p>The question about the stimulus that the participants is required to answer [ DynamicText ].</p>|
|<p>alternative-a-image</p>|<p>required</p>|<p>Image used to demonstrate alternative A to the operator [ image = Calculated(tc) ].</p>|
|<p>alternative-b-image</p>|<p>required</p>|<p>Image used to demonstrate alternative B to the operator [ image = Calculated(tc) ].</p>|
|<p>alternative-a</p>|<p>required</p>|<p>Expected response when the participant can perceive alternative A [ DynamicText ].</p>|
|<p>alternative-b</p>|<p>required</p>|<p>Expected response when the participant can perceive alternative B [ DynamicText ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.ResponseRecordingTestTemplate"></a>
### ResponseRecordingTestTemplate

<p>The response recording test allows for the collection of psychophysiological ratings over a specified time period or until the experimenter indicates a particular event. During this process, ratings can be recorded while also capturing a set of signals and/or marking events with predefined markers.</p>
<p>To function, the test must be assigned a Scales instrument in the device-mapping element of the experimental setup. The number and types of psychophysical ratings that are collected by the test are defined by the psychophysical rating scales that are defined in the Scales instrument.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>duration</p>|<p>required</p>|<p>Sample duration for the response recoding [ double = Calculated(tc) ].</p>|
|<p>sample-rate</p>|<p>required</p>|<p>Sample rate for the response recording [ double = Calculated (tc) ]. This sample rate is used both for the psychophysical responses and the defined signals if any.</p>|
|<p>response-weight</p>|<p>optional</p>|<p>Weight given to the psychophysical ratings in the user interface [ int ]. Default value is 1.</p>|
|<p>signal-weight</p>|<p>optional</p>|<p>Weight given to the recorded signals in the user interface [ int ]. Default value is 0.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>[`<events-makers>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.EventMarkerCollectionTemplate)</p> | <p>optional</p> |<p>Used to define the markers that an experimenter can use to mark events while the test is running. Events could be events such as a pain detection or a pain tolerance threshold. Events are organized into event groups, where only one event group can be active at any time. When the experimenter marks an event, then the marker can be configured to activate another event group. Consequently, this can be used to define the sequential logical flow of events, such as enforcing that a pain detection threshold is always before a pain tolerance threshold. When the test is started, the first defined event group will be active.</p>|
| <p>[`<signals>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.SignalGroupCollectionTemplate)</p> | <p>optional</p> |<p>Defines the signals that will be sampled simultaneously with the collection of psychophysiological ratings and the script that will be called for each recording time to sample the signals.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.EventMarkerCollectionTemplate"></a>
### EventMarkerCollectionTemplate

<p>Used to define the markers that an experimenter can use to mark events while the test is running. Events could be events such as a pain detection or a pain tolerance threshold. Events are organized into event groups, where only one event group can be active at any time. When the experimenter marks an event, then the marker can be configured to activate another event group. Consequently, this can be used to define the sequential logical flow of events, such as enforcing that a pain detection threshold is always before a pain tolerance threshold. When the test is started, the first defined event group will be active.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<group>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.EventMarkerGroupTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.EventMarkerGroupTemplate"></a>
### EventMarkerGroupTemplate

<p>Defines a group of events that are active simultaneously.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Unique identifier for the event group [ Text ]. This identifier is used by event markers to identity the next active event group.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<marker>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.EventMarkerTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.EventMarkerTemplate"></a>
### EventMarkerTemplate

<p>Defines a marker for an event.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Unique identifier for the event marker [ Text ].</p>|
|<p>name</p>|<p>optional</p>|<p>Name of the event [ Dynamic Text ]. If not specified the ID of the event will be used as its name.</p>|
|<p>complete</p>|<p>optional</p>|<p>Complete the test when the event is marked [ Boolean ]. Default value is false.</p>|
|<p>next-group</p>|<p>optional</p>|<p>Event group to activate when the event is marked [ Text ]. This must be an ID of an event group, if no next-group is specified the currently active event group will remain active.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.SignalGroupCollectionTemplate"></a>
### SignalGroupCollectionTemplate

<p>Defines the signals that will be sampled simultaneously with the collection of psychophysiological ratings and the script that will be called for each recording time to sample the signals.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>sample</p>|<p>required</p>|<p>This attribute specifies the script that will be used to sample the signals [ [double] = Calculated(tc) ]. The script must return a list of the same length as the number of defined signals and in the same order.</p>|
|<p>min</p>|<p>required</p>|<p>Global minimum value for the sampled signals [ double = Calculated(tc) ].</p>|
|<p>max</p>|<p>required</p>|<p>Global maximum value for the sampled signals [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<signal>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.SignalDeclarationTemplate) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.SignalDeclarationTemplate"></a>
### SignalDeclarationTemplate

<p>Definition of a signal that will be sampled in the sample script that is defined as an attribute on the <code>&lt;signals&gt;</code> element. This sample script must return a list of values with the same length as the number of signals defined in the signals element.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the signal [ Text ]. This identifier must be unique for all the defined signals.</p>|
|<p>name</p>|<p>required</p>|<p>Name for the signal [ Dynamic Text ]. If no name is provided the ID of the signal will be used as its name.</p>|
|<p>type</p>|<p>optional</p>|<p>Type of signal that is sampled.</p>|
|<p>unit</p>|<p>optional</p>|<p>Unit of signal that is sampled [ Text ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.StimulusPresentation.StimulusPresentationTestTemplate"></a>
### StimulusPresentationTestTemplate

<p>The Stimulus Presentation test allows a participant to become familiar with a stimulus and to
rate its sensation on a psychophysical rating scale.</p>
<p>The test can also be used to manually find thresholds, as the last tested intensity is available
in the calculated parameter <code>[TestID].Intensity</code> upon completion.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>stimulus-update-rate</p>|<p>required</p>|<p>The update rate for the generated stimuli [ int = Calculated(tc) ]. This update rate must be supported by the device that will deliver the stimuli.</p>|
|<p>trigger-update-rate</p>|<p>optional</p>|<p>The update rate for the generated triggers [ int = Calculated(tc) ]. This update rate must be supported by the device that will deliver the stimuli, and if it is unspecified, the stimulus update rate will be used as the update rate for the trigger generation.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>[`<configuration>`](#LabBench.Core.Components.ComponentConfiguration)</p> | <p>optional</p> |<p>Configuration of test components, which includes configuration of the stimulation, trigger, and sampling components that are used by the test.</p>|
| <p>[`<intensity>`](#LabBench.Core.XmlTools.ArrayGeneratorTemplate)</p> | <p>required</p> |<p>Specification of the intensities for the stimuli that the experimenter can choose during a session.</p>|
| <p>[`<responses>`](#LabBench.Core.Components.ResponseEngineTemplate)</p> | <p>optional</p> |<p>This element defines the <strong>response engine</strong> used by a test to collect behavioral or rating-based responses from the subject.</p> <p>The response engine supports multiple response modalities, including:</p> <ul> <li>Binary responses (yes/no, button presses)</li> <li>Numerical ratings (interval scales)</li> <li>Ratio ratings (continuous scales)</li> <li>Categorical ratings (ordinal scales)</li> </ul> <p>If no response collection mode is specified, the response engine is disabled and no response device is required for the test.</p>|
| <p>[`<triggers>`](#LabBench.Core.Components.TriggerEngineTemplate)</p> | <p>optional</p> |<p>Trigger generation.</p>|
| <p>[`<stimulation>`](#LabBench.Core.Components.StimulationEngineTemplate)</p> | <p>optional</p> |<p>Stimulation configuration that can either be delivered with a Stimulator instrument, or with any combination of instruments when the `<scripts>´ element is defined.</p>|


<a id="LabBench.Core.Components.ResponseEngineTemplate"></a>
### ResponseEngineTemplate

<p>This element defines the <strong>response engine</strong> used by a test to collect behavioral or rating-based responses from the subject.</p>
<p>The response engine supports multiple response modalities, including:</p>
<ul>
<li>Binary responses (yes/no, button presses)</li>
<li>Numerical ratings (interval scales)</li>
<li>Ratio ratings (continuous scales)</li>
<li>Categorical ratings (ordinal scales)</li>
</ul>
<p>If no response collection mode is specified, the response engine is disabled and no response device is required for the test.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>response-collection</p>|<p>optional</p>|<p>Type of response collection that will be performed:</p> <ul> <li><code>none</code>: <strong>no responses are collected</strong> for this test.</li> <li><code>yes-no</code>: <strong>binary response collection</strong> using a button device. An <code>Button</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>ratio-rating</code>: <strong>continuous ratio-scale rating</strong> using a ratio scale device. An <code>RatioScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>numerical-rating</code>: <strong>numerical rating collection</strong> using an interval scale device. An <code>IntervalScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>categorical-rating</code>: <strong>categorical response collection</strong> using an ordinal scale device. An <code>OrdinalScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> </ul>|


<a id="LabBench.Core.Components.TriggerEngineTemplate"></a>
### TriggerEngineTemplate

<p>Trigger generation.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>start-triggger</p>|<p>optional</p>|<p>Timing or trigger source:</p> <ul> <li><code>none</code>: no source is configured.</li> <li><code>internal</code>: the source is an internal opration such as start of a stimulus.</li> <li><code>external</code>: a trigger event is received from external equipment.</li> <li><code>button</code>: a trigger event is received from a button press on a connected response device attached to any response port.</li> <li><code>response-port01</code>: a trigger is received on response port 1.</li> <li><code>response-port02</code>: a trigger is received on response port 2.</li> <li><code>response-port03</code>: a trigger is received on response port 3.</li> <li><code>response-port04</code>: a trigger is received on response port 4.</li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<trigger>`](#LabBench.Core.Components.Triggering.TriggerSpecificationTemplate) </span><br /><span style="white-space: nowrap;">  [`<repeated-trigger>`](#LabBench.Core.Components.Triggering.RepeatedTriggerSequenceTemplate) </span><br /><span style="white-space: nowrap;">  [`<combined-triggers>`](#LabBench.Core.Components.Triggering.CombinedTriggerSequenceTemplate) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.StimulationEngineTemplate"></a>
### StimulationEngineTemplate

<p>Stimulation configuration that can either be delivered with a Stimulator instrument, or with
any combination of instruments when the `<scripts>´ element is defined.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>start-trigger</p>|<p>optional</p>|<p>Timing or trigger source:</p> <ul> <li><code>none</code>: no source is configured.</li> <li><code>internal</code>: the source is an internal opration such as start of a stimulus.</li> <li><code>external</code>: a trigger event is received from external equipment.</li> <li><code>button</code>: a trigger event is received from a button press on a connected response device attached to any response port.</li> <li><code>response-port01</code>: a trigger is received on response port 1.</li> <li><code>response-port02</code>: a trigger is received on response port 2.</li> <li><code>response-port03</code>: a trigger is received on response port 3.</li> <li><code>response-port04</code>: a trigger is received on response port 4.</li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<scripts>`](#LabBench.Core.Components.Stimulation.ScriptedStimulationTemplate)</p> | <p>optional</p> |<p>Custom stimulation where the stimulation is implemented with calculated parameters that can either be a single-line Python statement or, more commonly, by calling a Python function in a script.</p>|
| <p>[`<stimulus>`](#LabBench.Core.Components.Stimulation.StimulusDefinitionTemplate)</p> | <p>optional</p> |<p>Definition of a stimulus.</p>|


<a id="LabBench.Core.Tests.Thermal.RatedStimulation.ThermalRatedStimulationTestTemplate"></a>
### ThermalRatedStimulationTestTemplate

<p>The Thermal Rated Stimulation test allows a thermal stimulus to be delivered to a
participant while simultaneously recording the participant's psychophysical rating
of the sensation.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>response-collection</p>|<p>optional</p>|<p>Type of response collection that will be performed:</p> <ul> <li><code>none</code>: <strong>no responses are collected</strong> for this test.</li> <li><code>yes-no</code>: <strong>binary response collection</strong> using a button device. An <code>Button</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>ratio-rating</code>: <strong>continuous ratio-scale rating</strong> using a ratio scale device. An <code>RatioScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>numerical-rating</code>: <strong>numerical rating collection</strong> using an interval scale device. An <code>IntervalScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>categorical-rating</code>: <strong>categorical response collection</strong> using an ordinal scale device. An <code>OrdinalScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> </ul>|
|<p>sample-times</p>|<p>optional</p>|<p>Must return a list of the times the participant's response should be sampled [ double[] = Calculated(tc) ]. This attribute is only used if the <code>response-collection</code> is not set to <code>none</code>.</p>|
|<p>intensity</p>|<p>required</p>|<p>Intensity (<code>x</code>) that will be passed to the stimulus defined by the <code>&lt;stimulus&gt;</code> element [ double = Calculated(tc) ].</p>|
|<p>minimal-display-temperature</p>|<p>optional</p>|<p>Used for displaying the thermal stimulus; it is the lower bound for the stimulation temperature [ double = Calculated(tc) ].</p>|
|<p>maximal-display-temperature</p>|<p>optional</p>|<p>Used for displaying the thermal stimulus; it is the upper bound for the stimulation temperature [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>[`<stimulus>`](#LabBench.Core.Components.Stimulation.StimulusDefinitionTemplate)</p> | <p>optional</p> |<p>Definition of a stimulus.</p>|


<a id="LabBench.Core.Tests.Thermal.ThresholdEstimation.ThermalThresholdEstimationTestTemplate"></a>
### ThermalThresholdEstimationTestTemplate

<p>The Thermal Threshold Estimation Test determines cold and heat thresholds by decreasing/increasing the temperature until the participants press a button. The temperature at the time of the button press is taken as the temperature threshold.</p>
<p>This procedure can be repeated a set number of times, and the threshold is taken as an average of the repeated threshold measurements.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the template that must be unique within the protocol. This <code>id</code>is used to identify the test template from test constructors in the protocol.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>threshold-type</p>|<p>required</p>|<p>Configuration of the thermal threshold to be determined.</p>|
|<p>stimulation-rate</p>|<p>required</p>|<p>The rate of temperature change for the determination of thresholds [ double = Calculated(tc) ].</p>|
|<p>maximal-temperature</p>|<p>required</p>|<p>Maximal temperature for the thermal stimulus [ double = Calculated(tc) ].</p> <p>Please note that this temperature is higher than the <code>neutral-temperature</code> for heat thresholds and lower for cold thresholds. This temperature must be within the output temperature range (<code>minimal-temperature</code> to <code>maximal-temperature</code>) of the Thermal Stimulator assigned to the test.</p>|
|<p>return-rate</p>|<p>required</p>|<p>Rate by which the temperature is returned to the neutral temperature once the threshold has been reached [ double = Calculated(tc) ].</p>|
|<p>initial-stimulation-delay</p>|<p>required</p>|<p>Delay from start of the test in seconds to the start of the first threshold determination [ double = Calculated(tc) ].</p>|
|<p>stimulation-interval</p>|<p>required</p>|<p>Interval between threshold determinations in seconds [ double = Calculated(tc) ].</p>|
|<p>repetitions</p>|<p>required</p>|<p>Number of times the threshold is determined [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|
| <p>[`<test-events>`](#LabBench.Core.Templating.TestEventsTemplate)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Templating.TestPropertiesTemplate)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Templating.TestDependencyTemplate"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Templating.ConditionTemplate)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.TestCollection"></a>
### TestCollection

<p>The <code>&lt;tests&gt;</code> element defines the tests of the protocol. These can be directly defined in this element or constructed from test templates defined in the <code>&lt;templates&gt;</code> element.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<questionnaire>`](#LabBench.Core.Tests.Meta.Survey.SurveyTest) </span><br /><span style="white-space: nowrap;">  [`<stimulation-sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.EvokedPotentialsTest) </span><br /><span style="white-space: nowrap;">  [`<sequential>`](#LabBench.Core.Tests.Meta.Sequential.SequentialTest) </span><br /><span style="white-space: nowrap;">  [`<algometry-stimulus-response>`](#LabBench.Core.Tests.Algometry.StimulusResponse.AlgometryStimulusResponseTest) </span><br /><span style="white-space: nowrap;">  [`<algometry-conditioned-pain-modulation>`](#LabBench.Core.Tests.Algometry.ConditionedPain.AlgometryConditionedPainTest) </span><br /><span style="white-space: nowrap;">  [`<algometry-temporal-summation>`](#LabBench.Core.Tests.Algometry.TemporalSummation.AlgometryTemporalSummationTest) </span><br /><span style="white-space: nowrap;">  [`<algometry-static-temporal-summation>`](#LabBench.Core.Tests.Algometry.StaticTemporalSummation.AlgometryStaticTemporalSummationTest) </span><br /><span style="white-space: nowrap;">  [`<algometry-stimulus-rating>`](#LabBench.Core.Tests.Algometry.StimulusRating.AlgometryStimulusRatingTest) </span><br /><span style="white-space: nowrap;">  [`<algometry-conditioned-pain-modulation-rating>`](#LabBench.Core.Tests.Algometry.ConditionedPainRating.AlgometryConditionedPainRatingTest) </span><br /><span style="white-space: nowrap;">  [`<algometry-arbitrary-temporal-summation>`](#LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.AlgometryArbitraryTemporalSummationTest) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-threshold-estimation>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ThresholdEstimationTest) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-cold-pressor>`](#LabBench.Core.Tests.Psychophysics.ColdPresser.ColdPressorTest) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-manual-threshold-estimation>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualThresholdEstimationTest) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-response-recording>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.ResponseRecordingTest) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-stimulus-presentation>`](#LabBench.Core.Tests.Psychophysics.StimulusPresentation.StimulusPresentationTest) </span><br /><span style="white-space: nowrap;">  [`<thermal-rated-stimulation>`](#LabBench.Core.Tests.Thermal.RatedStimulation.ThermalRatedStimulationTest) </span><br /><span style="white-space: nowrap;">  [`<thermal-threshold-estimation>`](#LabBench.Core.Tests.Thermal.ThresholdEstimation.ThermalThresholdEstimationTest) </span><br /><span style="white-space: nowrap;">  [`<questionnaire-constructor>`](#LabBench.Core.Tests.Meta.Survey.SurveyConstructor) </span><br /><span style="white-space: nowrap;">  [`<stimulation-sequence-constructor>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.EvokedPotentialsTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<sequential-constructor>`](#LabBench.Core.Tests.Meta.Sequential.SequentialTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-stimulus-response-constructor>`](#LabBench.Core.Tests.Algometry.StimulusResponse.AlgometryStimulusResponseTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-conditioned-pain-modulation-constructor>`](#LabBench.Core.Tests.Algometry.ConditionedPain.AlgometryConditionedPainTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-temporal-summation-constructor>`](#LabBench.Core.Tests.Algometry.TemporalSummation.AlgometryTemporalSummationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-static-temporal-summation-constructor>`](#LabBench.Core.Tests.Algometry.StaticTemporalSummation.AlgometryStaticTemporalSummationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-stimulus-rating-constructor>`](#LabBench.Core.Tests.Algometry.StimulusRating.AlgometryStimulusRatingTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-conditioned-pain-modulation-rating-constructor>`](#LabBench.Core.Tests.Algometry.ConditionedPainRating.AlgometryConditionedPainRatingTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-arbitrary-temporal-summation-constructor>`](#LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.AlgometryArbitraryTemporalSummationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-threshold-estimation-constructor>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ThresholdEstimationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-cold-pressor-constructor>`](#LabBench.Core.Tests.Psychophysics.ColdPresser.ColdPressorTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-manual-threshold-estimation-constructor>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualThresholdEstimationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-response-recording-constructor>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.ResponseRecordingTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-stimulus-presentation-constructor>`](#LabBench.Core.Tests.Psychophysics.StimulusPresentation.StimulusPresentationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<thermal-rated-stimulation-constructor>`](#LabBench.Core.Tests.Thermal.RatedStimulation.ThermalRatedStimulationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<thermal-threshold-estimation-constructor>`](#LabBench.Core.Tests.Thermal.ThresholdEstimation.ThermalThresholdEstimationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<foreach>`](#LabBench.Core.Tests.ForeachConstructor) </span><br /><span style="white-space: nowrap;">  [`<sequence>`](#LabBench.Core.Tests.SequenceConstructor) </span><br /><span style="white-space: nowrap;">  [`<if>`](#LabBench.Core.Tests.IfConstructor) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Survey.SurveyTest"></a>
### SurveyTest

<p>The questionnaire test allows either the operator or the participant to answer a set of questions.
The questionnaire can consist of the following types of questions:</p>
<ul>
<li><strong>Boolean Questions</strong>: questions that have mutually exclusive binary answer, which usually consists
of answering a true or false statement, but can also consist of dichotomies such as child/adult.</li>
<li><strong>Numerical Questions</strong>: are questions that can be answered with numerical answers.</li>
<li><strong>Text Questions</strong>: are questions that can be answered with either free or validated text.</li>
<li><strong>Likert Questions</strong>: A scale that captures how strongly someone agrees, disagrees, or feels about a
statement using a fixed set of ordered response options.</li>
<li><strong>List Questions</strong>: A set of binary statements that each can be either true or false.</li>
<li><strong>Time Questions</strong>: a date and time provided by the participant, entered by the operator.</li>
<li><strong>Map Questions</strong>: is answered by marking one or more regions, such as areas on a body map.</li>
<li><strong>Categorical Rating Questions</strong>: rating of a sensation on a categorical scale.</li>
<li><strong>Numerical Rating Questions</strong>: rating of a sensation on a numerical scale.</li>
<li><strong>Visual Rating Questions</strong>: rating of a sensation on a visual analog rating scale.</li>
</ul>
<p>All questions are identified with an id and have a title and an instruction. If the questionnaire is to be
answered by the participant, a <code>Questionnaire</code> instrument must be assigned to the test in the experimental setup.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>progress-format</p>|<p>optional</p>|<p>Controls the progress information that is provided by the test:</p> <ul> <li><code>none</code>: no progresss information is provided.</li> <li><code>percentage</code>: progress is provided as the percentage of completed questions.</li> <li><code>index</code>: progress is provided as [current question no] / [total number of questions].</li> </ul>|
|<p>control</p>|<p>optional</p>|<p>Sets whether the questionnaire is filled out by the operator or the participant:</p> <ul> <li><code>operator</code>: answers are provided by the operator.</li> <li><code>subject</code>: answers are provided by the participant. In this mode a Questionnaire instrument must be assigned to the test.</li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>[`<question-events>`](#LabBench.Core.Tests.Meta.Survey.QuestionEvents)</p> | <p>optional</p> |<p>Definition of calculated parameters that are executed when the state of questions changes; this makes it possible to extend the functionality of the Questionnaire test with additional functionality implemented in Python.</p>|
| <p>`<content>`</p> | <p>optional</p> |<p> The `<content>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.AreaQuestion"><code>&lt;map&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.TextQuestion"><code>&lt;text&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.BooleanQuestion"><code>&lt;boolean&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.NumericalQuestion"><code>&lt;numeric&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.LikertQuestion"><code>&lt;likert&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.DimensionalLikertQuestion"><code>&lt;dimensional-likert&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.BooleanListQuestion"><code>&lt;list&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.DateTimeQuestion"><code>&lt;time&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.InstructionQuestion"><code>&lt;instruction&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.VisualAnalogScaleQuestion"><code>&lt;visual-analog-scale&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.NumericalScaleQuestion"><code>&lt;numerical-scale&gt;</code></a> </span></li> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Meta.Survey.Questions.CategoricalScaleQuestion"><code>&lt;categorical-scale&gt;</code></a> </span></li> </ul> </p>|


<a id="LabBench.Core.Tests.TestEvents"></a>
### TestEvents

<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p>
<p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>start</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is started [ bool = Calculated(tc) ]. If False is returned the test will be aborted.</p>|
|<p>complete</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is completed [ bool = Calculated(tc) ]. If False is returned the test will be aborted.</p>|
|<p>abort</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is aborted [ bool = Calculated(tc) ]. Please note this calculated attribute must always return True.</p>|
|<p>selected</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is selected regardsless of its state [ bool = Calculated(tc) ]. Please note if a selected state is defined this will override the code provided in this attribute.</p>|
|<p>selected-blocked</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is selected and is in the blocked state [ bool = Calculated(tc) ].</p>|
|<p>selected-ready</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is selected and is in the ready state [ bool = Calculated(tc) ].</p>|
|<p>selected-completed</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is selected and is in the completed state [ bool = Calculated(tc) ].</p>|
|<p>selected-excluded</p>|<p>optional</p>|<p>Specifies code that will be executed when the test is selected and is in the excluded state [ bool = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<instrument>`](#LabBench.Core.Setup.DeviceDescription) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Setup.DeviceDescription"></a>
### DeviceDescription

<p>Defines an instrument that is made available to the test or embedded python code, such as a Stimulator, Button, or RatioScale.</p>
<p>The <code>name</code> attribute identifies the instrument for referencing elsewhere in the code, while the <code>interface</code> attribute specifies the type of the instrument to be made available.</p>
<p><strong>Attributes:</strong></p>
<ul>
<li><code>name</code>: An optional escriptive name for the instrument (e.g., <code>&quot;ImageDisplay&quot;</code>) [ Text ]. If no name is specified the name will be inferred from its interface type, by removing the <code>-</code> from interface type and making it Camel Case (i.e. <code>image-display</code> becomes <code>ImageDisplay</code>)</li>
<li><code>interface</code>: The insturment type to be provided (e.g., <code>&quot;image-display&quot;</code>).</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Instrument name of the instrument. There must be a device assignment with that instrument name of the correct instrument type.</p>|
|<p>interface</p>|<p>required</p>|<p>The insturment type to be provided (e.g., <code>image-display</code>)</p>|


<a id="LabBench.Core.Tests.TestProperties"></a>
### TestProperties

<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<auto-start>`](#LabBench.Core.XmlTools.BooleanValue)</p> | <p>optional</p> |<p>Start the test when it is selected automatically when the previous test in the protocol has been completed. The test is only started automatically if the completion of a previous test selects the test. It is not started automatically if the operator manually selects the test. This test property can be used to speed up the execution of protocols. The default value of this test property is &quot;false,&quot; meaning tests will not be automatically started.</p>|
| <p>[`<auto-advance>`](#LabBench.Core.XmlTools.BooleanValue)</p> | <p>optional</p> |<p>This element controls whether the next test in the protocol will be automatically selected when the current test is completed. The default value is &quot;true,&quot; meaning the next test will be automatically selected.</p>|
| <p>[`<time-constraint>`](#LabBench.Core.Tests.TimeConstraint)</p> | <p>optional</p> |<p>This element places a time constraint on when the test can be started based on either the start time or completion time of another test in the protocol. The time constraint can impose a minimum (min attribute is specified) or maximum time (max attribute is specified) that must elapse before the test can be started or a time window (both min and max attributes are specified) within which the time can be started.</p>|
| <p>[`<extended-data-collection>`](#LabBench.Core.XmlTools.BooleanValue)</p> | <p>optional</p> |<p>This element sets a flag that can inform tests to collect more extended data. The extra data, if any, collected depends on the tests, and the documentation for the specific tests must be consulted to determine which extended data will be collected by setting this flag.</p>|
| <p>[`<instructions>`](#LabBench.Core.Tests.TestInstructions)</p> | <p>optional</p> |<p>This element specifies instructions for the operator when the test is not running. They will be shown in the test window instead of the test-specific user interface.</p>|
| <p>[`<subject-instructions>`](#LabBench.Core.Tests.SubjectInstructions)</p> | <p>optional</p> |<p>This element specifies instructions for the subject. They will be shown on an ImageDisplay instrument that must be assigned to the test in a device assignment in the experimental setup.</p>|
| <p>[`<next>`](#LabBench.Core.Tests.TestLink)</p> | <p>optional</p> |<p>This attribute specifies the ID of the test that will be selected when the test is completed (DynamicText).</p>|
| <p>[`<previous>`](#LabBench.Core.Tests.TestLink)</p> | <p>optional</p> |<p>[DEPRECATED] This attribute is kept for backward compatibility but serves no function.</p>|
| <p>[`<annotations>`](#LabBench.Core.Tests.TestAnnotations)</p> | <p>optional</p> |<p>Custom data that can be added to test results either in the experiment definition file (*.expx) or by Python code.</p>|


<a id="LabBench.Core.Tests.TimeConstraint"></a>
### TimeConstraint

<p>This element places a time constraint on when the test can be started based on either the start time or completion time of another test in the protocol. The time constraint can impose a minimum (min attribute is specified) or maximum time (max attribute is specified) that must elapse before the test can be started or a time window (both min and max attributes are specified) within which the time can be started.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>test-id</p>|<p>required</p>|<p>This attribute specifies the ID of the test to which the timing constraint is relative.</p>|
|<p>min</p>|<p>optional</p>|<p>If this attribute is specified, it specifies the minimum time to pass before the test can be started. If the max attribute is also specified, the timing constraint is a time window in which the test can only be started within the minimum (min attribute) and maximum (max attribute) time values.</p>|
|<p>max</p>|<p>optional</p>|<p>If this attribute is specified, it specifies the maximum time that the test can be started. If the min attribute is also specified, the timing constraint is a time window in which the test can only be started within the minimum (min attribute) and maximum (max attribute) time values.</p>|
|<p>notification</p>|<p>optional</p>|<p>This attribute controls whether a beep should be sounded when the timing constraint is satisfied.</p>|
|<p>time-reference</p>|<p>optional</p>|<p>This attribute specifies whether the timing constraint is relative to a test's start or end (completion).</p>|


<a id="LabBench.Core.Tests.TestInstructions"></a>
### TestInstructions

<p>This element specifies instructions for the operator when the test is not running. They will be shown in the test window instead of the test-specific user interface.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>start-instruction</p>|<p>optional</p>|<p>Tooltip for the start button [ DynamicText]. If specified, this will override the default text.</p>|
|<p>override-results</p>|<p>optional</p>|<p>This attribute controls whether instructions will be shown instead of test results in the test window for completed tests. If set to true, instructions will be shown instead of the test results [ Boolean (true/false) ]. The default value is false.</p>|
|<p>default</p>|<p>optional</p>|<p>Instructions that will be shown if instructions are not specified for the current test state [ IAsset = Calculated(tc) ].</p>|
|<p>blocked</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its BLOCKED state. If this attribute is not specified, then the value of the default attribute will be shown instead [ IAsset = Calculated(tc) ]</p>|
|<p>ready</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its READY state. If this attribute is not specified, then the value of the default attribute will be shown instead [ IAsset = Calculated(tc) ].</p>|
|<p>excluded</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its EXCLUDED state. If this attribute is not specified, then the value of the default attribute will be shown instead [ IAsset = Calculated(tc) ].</p>|
|<p>completed</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its COMPLETED state. If this attribute is not specified, then the value of the default attribute will be shown instead [ IAsset = Calculated(tc) ].</p>|


<a id="LabBench.Core.Tests.SubjectInstructions"></a>
### SubjectInstructions

<p>This element specifies instructions for the subject. They will be shown on an ImageDisplay instrument that must be assigned to the test in a device assignment in the experimental setup.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>experimental-setup-id</p>|<p>required</p>|<p>This attribute specifies the experimental setup ID that will activate the assigned ImageDisplay [ Text ]. This ID can be different from the experimental setup ID for the test in general and will only be activated when the test is not running.</p>|
|<p>default</p>|<p>optional</p>|<p>Instructions that will be shown if instructions are not specified for the current test state [ IAsset = Calculated(tc) ].</p>|
|<p>blocked</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its BLOCKED state [ IAsset = Calculated(tc) ]. If this attribute is not specified, then the value of the default attribute will be shown instead.</p>|
|<p>ready</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its READY state [ IAsset = Calculated(tc) ]. If this attribute is not specified, then the value of the default attribute will be shown instead.</p>|
|<p>excluded</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its EXCLUDED state [ IAsset = Calculated(tc) ]. If this attribute is not specified, then the value of the default attribute will be shown instead.</p>|
|<p>completed</p>|<p>optional</p>|<p>Instructions that will be shown when the test is in its COMPLETED state [ IAsset = Calculated(tc) ]. If this attribute is not specified, then the value of the default attribute will be shown instead.</p>|


<a id="LabBench.Core.Tests.TestLink"></a>
### TestLink

<p>Link to another test within the protocol.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification (<code>id</code>) of the test that is linked to [ dynamic string ].</p>|


<a id="LabBench.Core.Tests.TestAnnotations"></a>
### TestAnnotations

<p>Custom data that can be added to test results either in the experiment definition file (*.expx) or
by Python code.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<bool>`](#LabBench.Core.XmlTools.BooleanValue) </span><br /><span style="white-space: nowrap;">  [`<bools>`](#LabBench.Core.XmlTools.BooleanListValue) </span><br /><span style="white-space: nowrap;">  [`<number>`](#LabBench.Core.XmlTools.NumberValue) </span><br /><span style="white-space: nowrap;">  [`<numbers>`](#LabBench.Core.XmlTools.NumberListValue) </span><br /><span style="white-space: nowrap;">  [`<string>`](#LabBench.Core.XmlTools.StringValue) </span><br /><span style="white-space: nowrap;">  [`<strings>`](#LabBench.Core.XmlTools.StringListValue) </span><br /><span style="white-space: nowrap;">  [`<integer>`](#LabBench.Core.XmlTools.IntegerValue) </span><br /><span style="white-space: nowrap;">  [`<integers>`](#LabBench.Core.XmlTools.IntegerListValue) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.XmlTools.BooleanListValue"></a>
### BooleanListValue

<p>bool[]</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<bool>`](#LabBench.Core.XmlTools.BooleanValue) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.XmlTools.NumberValue"></a>
### NumberValue

<p>double</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|
|<p>value</p>|<p>required</p>|<p>Value [ double ].</p>|


<a id="LabBench.Core.XmlTools.NumberListValue"></a>
### NumberListValue

<p>double[]</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<number>`](#LabBench.Core.XmlTools.NumberValue) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.XmlTools.StringValue"></a>
### StringValue

<p>string</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|
|<p>value</p>|<p>required</p>|<p>Value [ string ].</p>|


<a id="LabBench.Core.XmlTools.StringListValue"></a>
### StringListValue

<p>string[]</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<text>`](#LabBench.Core.XmlTools.StringValue) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.XmlTools.IntegerValue"></a>
### IntegerValue

<p>int</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|
|<p>value</p>|<p>required</p>|<p>Integer value [ int ].</p>|


<a id="LabBench.Core.XmlTools.IntegerListValue"></a>
### IntegerListValue

<p>int[]</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<number>`](#LabBench.Core.XmlTools.IntegerValue) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.TestDependency"></a>
### TestDependency

<p>Calculated parameters and Python code may use results from previously completed tests.
For example, a Stimulation sequence test may set the intensity (<code>x=&quot;[TestID].[ChannelID]</code>)of
the stimuli to thresholds determined in a completed Threshold Estimation test. However, if
the stimulation sequence test is started before the Threshold Estimation test has been completed,
the code above would result in a runtime error.</p>
<p>Consequently, it must be declared if the results of a test are used in another test. This declaration
is done with the <code>&lt;dependency&gt;</code> element within the <code>&lt;dependencies&gt;</code> element in the test definition.</p>
<p>These dependencies can be nonvirtual or virtual. If a test dependency is nonvirtual, rerunning
the dependency will invalidate the dependent's results, meaning that after the dependency has
completed, the dependent's results will be discarded. If a test dependency is virtual, it means
it is a logical dependency that does not invalidate the results of the dependent. Consequently,
in that case, the result of the dependent will not be discarded when the dependency is completed.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the test that the current test depends on [ string ].</p>|
|<p>virtual</p>|<p>optional</p>|<p>Is it a virtual dependency [ bool ].</p>|


<a id="LabBench.Core.Tests.Condition"></a>
### Condition

<p>Makes it possible to exclude tests based on the results of completed tests.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>expression</p>|<p>required</p>|<p>Condition on the execution of the test [ bool = Calculated(tc) ]. If this calculated attribute is True the test will be included, otherwise it will be excluded.</p>|
|<p>help</p>|<p>required</p>|<p>This attribute must provide an explanation for why a test has been excluded [ DynamicText ].</p>|


<a id="LabBench.Core.Tests.Meta.Survey.QuestionEvents"></a>
### QuestionEvents

<p>Definition of calculated parameters that are executed when the state of questions changes;
this makes it possible to extend the functionality of the Questionnaire test with additional
functionality implemented in Python.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>start</p>|<p>optional</p>|<p>Called when a question is started [ bool = Calculated(tc) ].</p>|
|<p>complete</p>|<p>optional</p>|<p>Called when a question is completed [ bool = Calculated(tc) ].</p>|
|<p>changed</p>|<p>optional</p>|<p>Called when a the answer to a question is changed [ bool = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<instrument>`](#LabBench.Core.Setup.DeviceDescription) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Survey.Questions.AreaQuestion"></a>
### AreaQuestion

<p>The <code>&lt;map&gt;</code> question lets users select areas on an image, such as marking pain on a body map.
If the map question is answered by the operator, they selected/deselected areas by clicking
on the image in the LabBench Runner test window. If the participants answer the question,
they will use a Button instrument to navigate between areas and to select/deselct them.</p>
<p>When participants answer the question, the following button functions must be defined in the
button configuration:</p>
<ul>
<li><code>up</code>, <code>down</code>, <code>left</code>, <code>right</code>: are used to navigate between areas.</li>
<li><code>increase</code> and <code>decrease</code>: are used to select/deselect areas.</li>
</ul>
<p>If the assigned device also implements the Joystick instrument, joystick movement can be used
to navigate between areas.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|
|<p>image-map</p>|<p>optional</p>|<p>An image that will provide the areas that can be selected [ image = Calculated(tc) ]. Each area must be uniformly colored with a single color, and an <code>&lt;area&gt;</code> element for that color must be defined for that. The question will then replace that color with either the selected-color, deselected-color, active-selected-color, or active-deselected-color, depending on whether that area is selected/deselected and active or inactive.</p>|
|<p>overlay-image</p>|<p>optional</p>|<p>An overlay image that will be added on top of the processed area image [ image = Calculated(tc) ]. Consequently, this image can be used to add information and a decal to the area image. For the areas to be visible, all pixels that do not provide information or a decal must be transparent.</p>|
|<p>selected-color</p>|<p>optional</p>|<p>The color of areas that the subject have selected, but which is currently not active [ string ]. The color must be specified in hex in the form of #RRGGBB.</p>|
|<p>deselected-color</p>|<p>optional</p>|<p>The color of areas that the subject has not selected and which are currently not active [ string ]. This color is typically the same as the background color of the image, meaning deselected/not active areas will not be colored. The color must be specified in hex in the form of #RRGGBB.</p>|
|<p>active-selected-color</p>|<p>optional</p>|<p>The color of areas that are selected and active [ string ]. The color must be specified in hex in the form of #RRGGBB. Please not that the concept of active/inactive areas is only used when the questionnaire is answered by the participant. If the operator answers the questionnaire then this attribute has no effect.</p>|
|<p>active-deselected-color</p>|<p>optional</p>|<p>The color of areas that are active but not selected [ string ]. The color must be specified in hex in the form of #RRGGBB. Please not that the concept of active/inactive areas is only used when the questionnaire is answered by the participant. If the operator answers the questionnaire then this attribute has no effect.</p>|
|<p>selection-mode</p>|<p>optional</p>|<p>Area selection mode:</p> <ul> <li><code>single</code>: one a single area can be selected. If an area is selected and another area is allready selected then the other area will be automatically deselected.</li> <li><code>multiple</code>: multiple areas can be selected simultaneously.</li> </ul>|
|<p>initial-active-area</p>|<p>optional</p>|<p>Sets which area is initially active [ string ]. This must be the ID of an <code>&lt;area&gt;</code> element.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<area>`](#LabBench.Core.Tests.Meta.Survey.Questions.Area) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Survey.Questions.Area"></a>
### Area

<p>An area on the image can be selected or deselected. Each area has an id and a <code>color</code>, which
matches the color of the pixels in that area. The operator or participant will not see this
color, as it will be replaced by one of the following:</p>
<ul>
<li><code>deselected-color</code>: an area that is neither selected nor active.</li>
<li><code>selected-color</code>: an area that has been selected by the operator/participant but is not active.</li>
<li><code>active-deselected-color</code>: an  area has not been selected and is active.</li>
<li><code>active-selected-color</code>: an  area has been selected and is active.</li>
</ul>
<p>The concept of an active/inactive area is relevant only when the participant completes the
questionnaire. In that mode, it is the area currently in focus, and pressing the increase/decrease
button selects/deselects the area, respectively.</p>
<p>When the participant answers the questionnaire, each area must also set up navigation to adjacent
areas, specifying which area will be made active when the up, down, left, or right button is
pressed. For each area, at least one button must be defined so the participant can’t get trapped
and can't navigate away from the area.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the area [ string ]. This <code>id</code> must be unique.</p>|
|<p>color</p>|<p>required</p>|<p>The color that defines the area on the image [ string ]. Must be specified as a hex value #RRGGBB.</p>|
|<p>up</p>|<p>optional</p>|<p>Which area should be activated when the <code>up</code> button is pressed [ string ]. Must be the <code>id</code> of an area.</p>|
|<p>down</p>|<p>optional</p>|<p>Which area should be activated when the <code>down</code> button is pressed [ string ]. Must be the <code>id</code> of an area.</p>|
|<p>left</p>|<p>optional</p>|<p>Which area should be activated when the <code>left</code> button is pressed [ string ]. Must be the <code>id</code> of an area.</p>|
|<p>right</p>|<p>optional</p>|<p>Which area should be activated when the <code>right</code> button is pressed [ string ]. Must be the <code>id</code> of an area.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.TextQuestion"></a>
### TextQuestion

<p>The <code>&lt;text&gt;</code> question allows the participant or operator to provide a verbal free-form
answer to a statement. The answer is in text that can be validated with a regular expression.</p>
<p>If the participant answers the question, the answer must be given verbally to the operator,
who then enters it into the questionnaire. The operator's entered value will be displayed
to the participant so they can confirm it is correct.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|
|<p>maximal-length</p>|<p>optional</p>|<p>Maximal length of the answer [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<validation>`](#LabBench.Core.TextValidator)</p> | <p>optional</p> |<p>A text validator can guard against invalid text input. Text is validated with regular expressions. This tutorial, <a href="https://regexlearn.com/">RegexLearn</a>, teaches how to write regular expressions. When writing regular expressions, it is beneficial to test them with a suitable tool <a href="https://regex101.com/">regex101</a>.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.BooleanQuestion"></a>
### BooleanQuestion

<p>The <code>&lt;boolean&gt;</code> question asks a statement that can either be true or false. If the participant
answers the question, the answer is selected with the <code>up</code> and <code>down</code> buttons.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|
|<p>true-label</p>|<p>required</p>|<p>Description of the true option [ dynamic string ].</p>|
|<p>false-label</p>|<p>required</p>|<p>Description of the false option [ dynamic string ].</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.NumericalQuestion"></a>
### NumericalQuestion

<p>The <code>&lt;numeric&gt;</code> question allows the participant or operator to provide a numerical
answer to a statement. The answer can be validated to be within a given range.</p>
<p>If the participant answers the question, the answer must be given verbally to the operator,
who then enters it into the questionnaire. The operator's entered value will be displayed
to the participant so they can confirm it is correct.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<validation>`](#LabBench.Core.NumberValidator)</p> | <p>optional</p> |<p>Validation that a number is within a given range.</p>|


<a id="LabBench.Core.NumberValidator"></a>
### NumberValidator

<p>Validation that a number is within a given range.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>max</p>|<p>optional</p>|<p>Maximal value for the number [ double ].</p>|
|<p>max-included</p>|<p>optional</p>|<p>Is the maximum included in the allowed range [ bool ].</p>|
|<p>min</p>|<p>optional</p>|<p>Minimum value for the number [ double ].</p>|
|<p>min-included</p>|<p>optional</p>|<p>Is the minimum included in the allowed range [ bool ].</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.LikertQuestion"></a>
### LikertQuestion

<p>The <code>&lt;likert&gt;</code> question enables participants or operators to indicate their level of agreement,
endorsement, or frequency using a Likert scale. A Likert scale is a symmetrically ordered set
of response categories, from which a single option may be selected.</p>
<p>In LabBench, Likert scales are presented vertically. This vertical orientation allows for
longer, more descriptive labels for response categories than horizontally displayed categorical
rating scales. Participants select their response using the <code>up</code> and <code>down</code> button.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<choice>`](#LabBench.Core.Tests.Meta.LikertChoice) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.LikertChoice"></a>
### LikertChoice

<p>Definition of a response category on the Likert scale. Each response category is quantified
by an integer value that corresponds to the Likert scale score if that category is selected.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>value</p>|<p>required</p>|<p>Likert scale score if that category is selected [ int ].</p>|
|<p>label</p>|<p>required</p>|<p>Description of the category [ dynamic string ].</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.DimensionalLikertQuestion"></a>
### DimensionalLikertQuestion

<p>The <code>&lt;dimensional-likert&gt;</code> question enables participants or operators to indicate their level of
agreement, endorsement, or frequency using multiple Likert scales. A Likert scale is a symmetrically
ordered set of response categories, from which a single option may be selected.</p>
<p>In LabBench, each Likert scale is presented horizontally. Participants select which Likert scale is
active using the <code>up</code> and <code>down</code> buttons, and perform their rating with the <code>increase</code> and <code>decrease</code> buttons.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<dimension>`](#LabBench.Core.Tests.Meta.LikertDimension) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.LikertDimension"></a>
### LikertDimension

<p>An individual Likert scale on the multi-dimensional Likert scale question.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Description of the Likert scale [ dynamic string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<choice>`](#LabBench.Core.Tests.Meta.LikertChoice) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Survey.Questions.BooleanListQuestion"></a>
### BooleanListQuestion

<p>The <code>&lt;list&gt;</code> question allows the participant or operator to provide answers to a set of statements,
each of which can be true or false.</p>
<p>If the participant answers the question, the <code>down</code> and <code>up</code> buttons will navigate between questions,
and pressing <code>increase</code>/<code>decrease</code> will set the answer to true/false, respectively.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<item>`](#LabBench.Core.Tests.Meta.Survey.Questions.BooleanListItem) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Survey.Questions.BooleanListItem"></a>
### BooleanListItem

<p>A statement that can either be true or false.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the statement [ string ]. This <code>id</code> must be unique.</p>|
|<p>question</p>|<p>required</p>|<p>A statement that the participant or operator can answer is either true or false [ dynamic string ].</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.DateTimeQuestion"></a>
### DateTimeQuestion

<p>The <code>&lt;time&gt;</code> question allows the participant or operator to provide answers to a question
when something occurred. The answer is in the form of a date and time.</p>
<p>If the participant answers the question, the answer must be given verbally to the operator,
who then enters it into the questionnaire. The operator's entered value will be displayed
to the participant so they can confirm it is correct.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.InstructionQuestion"></a>
### InstructionQuestion

<p>DEPRECATED: Do not use in the new protocols as this question will be removed in a future version of LabBench.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.VisualAnalogScaleQuestion"></a>
### VisualAnalogScaleQuestion

<p>The <code>&lt;visual-analog-scale&gt;</code> question asks the participant or operator to rate a sensation
on a visual analog rating scale. If the participant answers the question, the rating is
increased/decreased by pressing the <code>increase</code>/<code>decrease buttons</code>, respectively.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|
|<p>top-anchor</p>|<p>required</p>|<p>Top anchor for the scale [ dynamic text ].</p>|
|<p>bottom-anchor</p>|<p>required</p>|<p>Bottom anchor for the scale [ dynamic text ].</p>|
|<p>length</p>|<p>optional</p>|<p>Physical length of the scale in centimeters [ double ].</p>|
|<p>active-color</p>|<p>required</p>|<p>Color for the active part of the scale [ string ]. The string must encode a valid RGB color value, either in hex as #RRGGBB or as a rgb(RRR,GGG,BBB). For the rgb() notation the colors are in base 10.</p>|
|<p>inactive-color</p>|<p>required</p>|<p>Color for the inactive part of the scale [ string ]. The string must encode a valid RGB color value, either in hex as #RRGGBB or as a rgb(RRR,GGG,BBB). For the rgb() notation the colors are in base 10.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.NumericalScaleQuestion"></a>
### NumericalScaleQuestion

<p>The <code>&lt;numerical-scale&gt;</code> question asks the participant or operator to rate a sensation
on a numerical rating scale. If the participant answers the question, the rating is
increased/decreased by pressing the <code>increase</code>/<code>decrease buttons</code>, respectively.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|
|<p>top-anchor</p>|<p>required</p>|<p>Top anchor for the scale [ dynamic text ].</p>|
|<p>bottom-anchor</p>|<p>required</p>|<p>Bottom anchor for the scale [ dynamic text ].</p>|
|<p>maximum</p>|<p>required</p>|<p>The maximal value for the scale [ int ].</p>|
|<p>minimum</p>|<p>required</p>|<p>The minimum value for the scale [ int ].</p>|
|<p>active-color</p>|<p>required</p>|<p>Color for the active part of the scale [ string ]. The string must encode a valid RGB color value, either in hex as #RRGGBB or as a rgb(RRR,GGG,BBB). For the rgb() notation the colors are in base 10.</p>|
|<p>inactive-color</p>|<p>required</p>|<p>Color for the inactive part of the scale [ string ]. The string must encode a valid RGB color value, either in hex as #RRGGBB or as a rgb(RRR,GGG,BBB). For the rgb() notation the colors are in base 10.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.Questions.CategoricalScaleQuestion"></a>
### CategoricalScaleQuestion

<p>The <code>&lt;categorical-scale&gt;</code> question asks the participant or operator to rate a sensation
on a categorical rating scale. If the participant answers the question, the rating is
increased/decreased by pressing the <code>increase</code>/<code>decrease buttons</code>, respectively.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data.</p> <p>The answer can be referenced in calculated parameters as <code>[TestID].[QuestionID]</code>. The type of answer depends on the type of question. For example, the answer type for Boolean Questions is a bool, and a double for Numerical Questions.</p>|
|<p>title</p>|<p>optional</p>|<p>The title of the question [ dynamic string ].</p>|
|<p>instruction</p>|<p>optional</p>|<p>An instruction to the operator or participant on how to answer the question [ dynamic string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Places a condition on whether the question is asked [ bool = Calculated(tc) ]. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other tests in the protocol.</p>|
|<p>top-anchor</p>|<p>required</p>|<p>Top anchor for the scale [ dynamic text ].</p>|
|<p>bottom-anchor</p>|<p>required</p>|<p>Bottom anchor for the scale [ dynamic text ].</p>|
|<p>active-color</p>|<p>required</p>|<p>Color for the active part of the scale [ string ]. The string must encode a valid RGB color value, either in hex as #RRGGBB or as a rgb(RRR,GGG,BBB). For the rgb() notation the colors are in base 10.</p>|
|<p>inactive-color</p>|<p>required</p>|<p>Color for the inactive part of the scale [ string ]. The string must encode a valid RGB color value, either in hex as #RRGGBB or as a rgb(RRR,GGG,BBB). For the rgb() notation the colors are in base 10.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<category>`](#LabBench.Core.Tests.Meta.Category) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Category"></a>
### Category

<p>Category definition.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>value</p>|<p>required</p>|<p>Description that will be displayed to the participant [ dynamic text ].</p>|


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.EvokedPotentialsTest"></a>
### EvokedPotentialsTest

<p>The <code>&lt;stimulation-sequence&gt;</code> test generates stimulus sequences for evoked potentials, behavioral tasks,
or similar procedures. Construct the sequence by creating a stimulus pattern to control timing and a
stimulus set to define which stimuli are delivered.</p>
<p>The stimulation pattern <code>&lt;stimulation-pattern&gt;</code>is constructed from a composition of sequences, which
can be deterministic or random. However, to use this test, the stimulation pattern (number of stimuli
and randomization) is generated when the test starts. Consequently, it is not possible to change the
stimulation pattern while the test is running, so it cannot depend on participant performance during
the test. Use the <code>&lt;sequential&gt;</code> test if the stimulation pattern depends on the participant, as that
test is more versatile but also more complex to implement than this stimulation sequence test.</p>
<p>The stimulation pattern is first generated, yielding a set of temporal stimulation slots that can be
filled with stimuli; which stimuli are inserted into these stimulation slots is defined by the stimulus
set <code>&lt;stimuli&gt;</code>. The stimuli set defines a set of stimuli and controls their randomization. To fill
the stimulation pattern, a batch of stimuli is first generated by the stimulus set. This batch of
stimuli is inserted into the stimulation slots until all have been allocated, then a new batch is
generated. This process is repeated until all stimulation slots have been allocated a stimulus.</p>
<p>The test delivers stimuli via the stimulation component, which, by default, uses the Stimulator
and TriggerGenerator instruments to deliver stimuli and triggers, respectively. If more complex
or multimodal stimuli are required, a <code>&lt;stimulation-scripts&gt;</code> can be defined to generate the
stimuli/triggers from a Python script. When generations are done from a Python script, any visual,
auditory, or physical stimulus, and combinations thereof that are possible with LabBench can be generated.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>stimulus-update-rate</p>|<p>optional</p>|<p>Update rate for stimulus generation [ int = Calculated(tc) ].</p>|
|<p>trigger-update-rate</p>|<p>optional</p>|<p>Update rate for trigger generation [ int = Calculated(tc) ]. If not defined, the stimulus generation update rate will be used.</p>|
|<p>response-collection</p>|<p>optional</p>|<p>Type of response collection that will be performed:</p> <ul> <li><code>none</code>: <strong>no responses are collected</strong> for this test.</li> <li><code>yes-no</code>: <strong>binary response collection</strong> using a button device. An <code>Button</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>ratio-rating</code>: <strong>continuous ratio-scale rating</strong> using a ratio scale device. An <code>RatioScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>numerical-rating</code>: <strong>numerical rating collection</strong> using an interval scale device. An <code>IntervalScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>categorical-rating</code>: <strong>categorical response collection</strong> using an ordinal scale device. An <code>OrdinalScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>[`<configuration>`](#LabBench.Core.Components.ComponentConfiguration)</p> | <p>optional</p> |<p>Configuration of test components, which includes configuration of the stimulation, trigger, and sampling components that are used by the test.</p>|
| <p>[`<stimulation-scripts>`](#LabBench.Core.Components.Stimulation.ScriptedStimulation)</p> | <p>optional</p> |<p>Custom stimulation where the stimulation is implemented with calculated parameters that can either be a single-line Python statement or, more commonly, by calling a Python function in a script.</p>|
| <p>[`<stimulation-pattern>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulationPattern)</p> | <p>required</p> |<p>The <code>&lt;stimulation-pattern&gt;</code> element determines when stimuli are delivered. The pattern generates a set of time slots, each of which is either filled with stimuli from the <code>&lt;stimuli&gt;</code> set or with a pause.</p> <p>The stimulation pattern is generated from a composition of two types of sequences:</p> <ul> <li><code>&lt;sequence&gt;</code>: a sequence with deterministic parameters.</li> <li><code>&lt;uniformly-distributed-sequence&gt;</code>: a random sequence with an period that is uniformly distrubed between a minimum and maximal period.</li> </ul> <p>The time of a sequence is relative to the starting time of its parent sequence. If a sequence is root, meaning it has no parent, it is relative to time zero.</p> <p>For calcuated parameters the following variables will be in scope:</p> <ul> <li><code>NumberOfStimuli</code>: Number of stimuli that will be generated by the <code>&lt;stimuli&gt;</code> element each time a new batch of stimuli is required.</li> </ul>|
| <p>[`<stimuli>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulusSet)</p> | <p>required</p> |<p>The <code>&lt;stimuli&gt;</code> defines a set of stimuli. These will be inserted into the time slots generated by the <code>&lt;stimulation-pattern&gt;</code>. The set consists of a series of <code>&lt;stimulus&gt;</code> elements. Each element may produce multiple stimuli based on its <code>count</code> attribute.</p> <p>The test supports randomization of stimulation order based on the <code>order</code> attribute (<code>round-robin</code>, <code>random</code>, <code>block-random</code>, <code>latin-squares</code>, <code>generated</code>). Ensure that the number of stimulation time slots generated by the stimulation pattern is exactly divisible by the <code>NumberOfStimuli</code> in this element. Otherwise, any extra stimulation time slots that do not fit into a complete cycle defined by <code>NumberOfStimuli</code> will not be delivered.</p> <p>For calculated stimulus parameters and scripted stimulation, the stimulus <code>id</code> will be available as in the <code>StimulusName</code> variable. The currently active block is available in the <code>BlockNumber</code> variable.</p>|


<a id="LabBench.Core.Components.Stimulation.ScriptedStimulation"></a>
### ScriptedStimulation

<p>Custom stimulation where the stimulation is implemented with calculated parameters that can either be a single-line Python statement or, more commonly, by calling a Python function in a script.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>initialize</p>|<p>optional</p>|<p>Calculated parameter that will be called when the test is started [ bool = Calculated(ts) ]. If False is returned, the test will be aborted; otherwise, it will be started.</p>|
|<p>stimulate</p>|<p>required</p>|<p>Calculated parameter that is called for each stimulation and which must implement the stimulation [ bool = Calculated(ts, x) ]. If False is returned, the test will be aborted.</p>|
|<p>stimulus-description</p>|<p>optional</p>|<p>Description of the stimulus.</p>|
|<p>stimulus-unit</p>|<p>optional</p>|<p>Unit for the stimulation modulity.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<instrument>`](#LabBench.Core.Setup.DeviceDescription) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulationPattern"></a>
### StimulationPattern

<p>The <code>&lt;stimulation-pattern&gt;</code> element determines when stimuli are delivered. The pattern generates a
set of time slots, each of which is either filled with stimuli from the <code>&lt;stimuli&gt;</code> set or with a pause.</p>
<p>The stimulation pattern is generated from a composition of two types of sequences:</p>
<ul>
<li><code>&lt;sequence&gt;</code>: a sequence with deterministic parameters.</li>
<li><code>&lt;uniformly-distributed-sequence&gt;</code>: a random sequence with an period that is uniformly distrubed
between a minimum and maximal period.</li>
</ul>
<p>The time of a sequence is relative to the starting time of its parent sequence. If a sequence is root,
meaning it has no parent, it is relative to time zero.</p>
<p>For calcuated parameters the following variables will be in scope:</p>
<ul>
<li><code>NumberOfStimuli</code>: Number of stimuli that will be generated by the <code>&lt;stimuli&gt;</code> element each time a new batch of stimuli is required.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>time-base</p>|<p>optional</p>|<p>Timebase for enclosing elements:</p> <ul> <li><code>microseconds</code></li> <li><code>milliseconds</code></li> <li><code>seconds</code></li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.DeterministicSequence) </span><br /><span style="white-space: nowrap;">  [`<uniformly-distributed-sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.UniformlyDistributedSequence) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.DeterministicSequence"></a>
### DeterministicSequence

<p>Generate a deterministic sequence based on these parameters:</p>
<ul>
<li><code>Iterations</code>: indicates how many times to repeat the process for generating individual time slots. Each iteration produces one time slot inserted at a time according to the sequence attributes. If the 'Iterations' attribute is omitted, it defaults to 1.</li>
<li><code>Tperiod</code>: The period by which the sequence is repeated, meaning the time between the time slots that are generated by the sequence. If this attribute is omitted, the period will be automatically calculated based on the duration of the sequences it contains.</li>
<li><code>Toffset</code>: Time offset from the start of the sequence until insertion of the first time slot. Consequently, this attribute will offset all timeslots within the sequence.</li>
<li><code>stimulate</code>: Fill the time slot with a stimulus.</li>
<li><code>pause</code>: Insert a pause into the time slot.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>iterations</p>|<p>optional</p>|<p>Number of sequence iterations [ double = Calculated(tc) ]. For each sequence iteration, one time slot is generated.</p>|
|<p>stimulate</p>|<p>optional</p>|<p>Fill time slots with stimuli from the <code>&lt;stimuli&gt;</code> set [ bool ]. Please note that if <code>pause</code> is set to true, this attribute is ignored.</p>|
|<p>pause</p>|<p>optional</p>|<p>Fill time slots with pauses [ bool ]. Please note that this attribute will overrule the <code>stimulate</code> attribute.</p>|
|<p>Tperiod</p>|<p>optional</p>|<p>Period by which time slots are generated [ double = Calculated(tc) ].</p>|
|<p>Toffset</p>|<p>optional</p>|<p>Time offset by which all generated time slots are delayed [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.DeterministicSequence) </span><br /><span style="white-space: nowrap;">  [`<uniformly-distributed-sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.UniformlyDistributedSequence) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.UniformlyDistributedSequence"></a>
### UniformlyDistributedSequence

<p>Generate a uniformly distributed sequence based on these parameters:</p>
<ul>
<li><code>Iterations</code>: indicates how many times to repeat the process for generating individual time slots. Each iteration produces one time slot inserted at a time according to the sequence attributes. If the 'Iterations' attribute is omitted, it defaults to 1.</li>
<li><code>maxTperiod</code>: The maximal period by which the sequence is repeated, meaning the time between the time slots that are generated by the sequence. If this attribute is omitted, the period will be automatically calculated based on the duration of the sequences it contains. The period is uniformly distributed between minTperiod and maxTperiod.</li>
<li><code>minTperiod</code>: The minimal period by which the sequence is repeated, meaning the time between the time slots that are generated by the sequence. If this attribute is omitted, the period will be automatically calculated based on the duration of the sequences it contains. The period is uniformly distributed between minTperiod and maxTperiod.</li>
<li><code>Toffset</code>: Time offset from the start of the sequence until insertion of the first time slot. Consequently, this attribute will offset all timeslots within the sequence.</li>
<li><code>stimulate</code>: Fill the time slot with a stimulus.</li>
<li><code>pause</code>: Insert a pause into the time slot.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>iterations</p>|<p>optional</p>|<p>Number of sequence iterations [ double = Calculated(tc) ]. For each sequence iteration, one time slot is generated.</p>|
|<p>stimulate</p>|<p>optional</p>|<p>Fill time slots with stimuli from the <code>&lt;stimuli&gt;</code> set [ bool ]. Please note that if <code>pause</code> is set to true, this attribute is ignored.</p>|
|<p>pause</p>|<p>optional</p>|<p>Fill time slots with pauses [ bool ]. Please note that this attribute will overrule the <code>stimulate</code> attribute.</p>|
|<p>maxTperiod</p>|<p>required</p>|<p>Minimal value for the period [ double = Calculated(tc) ]. The period is uniformly distributed between minTperiod and maxTperiod.</p>|
|<p>minTperiod</p>|<p>required</p>|<p>Maximal value for the period [ double = Calculated(tc) ]. The period is uniformly distributed between minTperiod and maxTperiod.</p>|
|<p>Toffset</p>|<p>optional</p>|<p>Time offset by which all generated time slots are delayed [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.DeterministicSequence) </span><br /><span style="white-space: nowrap;">  [`<uniformly-distributed-sequence>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.UniformlyDistributedSequence) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulusSet"></a>
### StimulusSet

<p>The <code>&lt;stimuli&gt;</code> defines a set of stimuli. These will be inserted into the time slots generated
by the <code>&lt;stimulation-pattern&gt;</code>. The set consists of a series of <code>&lt;stimulus&gt;</code> elements. Each
element may produce multiple stimuli based on its <code>count</code> attribute.</p>
<p>The test supports randomization of stimulation order based on the <code>order</code> attribute (<code>round-robin</code>,
<code>random</code>, <code>block-random</code>, <code>latin-squares</code>, <code>generated</code>). Ensure that the number of stimulation
time slots generated by the stimulation pattern is exactly divisible by the <code>NumberOfStimuli</code>
in this element. Otherwise, any extra stimulation time slots that do not fit into a complete cycle
defined by <code>NumberOfStimuli</code> will not be delivered.</p>
<p>For calculated stimulus parameters and scripted stimulation, the stimulus <code>id</code> will be available
as in the <code>StimulusName</code> variable. The currently active block is available in the <code>BlockNumber</code> variable.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>order</p>|<p>optional</p>|<p>Method for generating a batch of stimuli from the stimulus set:</p> <ul> <li><code>round-robin</code>: stimuli are generated in the order they are defined in the stimulus set.</li> <li><code>random</code>: One batch of stimuli is generated such that the batch size matches the number of time slots to be filled. The stimuli in this batch are then randomized, ensuring that the order of stimulus presentation is fully randomized.</li> <li><code>block-random</code>: Multiple batches of stimuli are generated. Each batch contains all stimuli from the stimulus set (equal to the set size). After batch creation, the order of stimuli within each batch is randomized independently, meaning each batch is randomized but covers all stimuli.</li> <li><code>latin-squares</code>: Psydorandomization of the stimulation order. Like block-random multiple batches, but each batch is pseudorandomized with Latin squares. Latin squares are a counterbalancing method that uses a Latin square design to ensure each condition appears equally often in each ordinal position across all stimulus batches, while still presenting the sequence in a seemingly random order.</li> <li><code>generated</code>: the order of the stimuli is implemented in Python. The Python function must return a list of length <code>NumberOfStimuli</code> that contains the order in which the current batch of stimuli will be ordered. The stimuli are identified in the returned list by their name.</li> </ul>|
|<p>generator</p>|<p>optional</p>|<p>Order by which the stimuli in a batch are reorganized when the order attribute is set to <code>generated</code> [ string[] = Calculated(tc) ]. The list must be of length <code>NumberOfStimuli</code> and contain the names of the stimuli in the order they should be reordered.</p> <p>Consequently, the <code>generated</code> order can only be used for <code>&lt;stimuli&gt;</code> sets for which all stimuli have their <code>count</code> set to one (1), as otherwise the stimulus names in the set are not unique.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<stimulus>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulusDeclaration) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.StimulusDeclaration"></a>
### StimulusDeclaration

<p>Definition of a stimulus in the stimulus set.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name that will be used to identify the stimulus in results, calculated parameters, and Python scripts [ string ].</p>|
|<p>count</p>|<p>optional</p>|<p>Number of stimuli that will be generated from this stimulus declaration [ int = Calculated(tc) ].</p>|
|<p>intensity</p>|<p>optional</p>|<p>Intensity (<code>x</code>) of that will be passed to the stimulus in calculated parameters [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<triggers>`](#LabBench.Core.Components.Triggering.TriggerDefinition)</p> | <p>optional</p> |<p>Specifies a set of triggers to be generated. These triggers will all be generated with a given duration (<code>duration</code>) and delay (<code>Tdelay</code>). The delay is relative to the start time of its parent trigger sequence; if it has no parent trigger sequence, it is relative to time zero.</p> <p>A trigger may generate a trigger on multiple digital outputs. Each output is specified with a nested <code>&lt;code&gt;</code> element.</p>|
| <p>[`<stimulus>`](#LabBench.Core.Components.Stimulation.StimulusDefinition)</p> | <p>optional</p> |<p>Definition of a stimulus.</p>|


<a id="LabBench.Core.Components.Triggering.TriggerDefinition"></a>
### TriggerDefinition

<p>Specifies a set of triggers to be generated. These triggers will all be generated with a given
duration (<code>duration</code>) and delay (<code>Tdelay</code>). The delay is relative to the start time of its parent
trigger sequence; if it has no parent trigger sequence, it is relative to time zero.</p>
<p>A trigger may generate a trigger on multiple digital outputs. Each output is specified with a nested
<code>&lt;code&gt;</code> element.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<trigger>`](#LabBench.Core.Components.Triggering.TriggerSpecification) </span><br /><span style="white-space: nowrap;">  [`<repeated-trigger>`](#LabBench.Core.Components.Triggering.RepeatedTriggerSequence) </span><br /><span style="white-space: nowrap;">  [`<combined-triggers>`](#LabBench.Core.Components.Triggering.CombinedTriggerSequence) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.Triggering.TriggerSpecification"></a>
### TriggerSpecification

<p>Specifies a set of triggers to be generated. These triggers will all be generated with a given
duration (<code>duration</code>) and delay (<code>Tdelay</code>). The delay is relative to the start time of its parent
trigger sequence; if it has no parent trigger sequence, it is relative to time zero.</p>
<p>A trigger may generate a trigger on multiple digital outputs. Each output is specified with a nested
<code>&lt;code&gt;</code> element.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Tdelay</p>|<p>optional</p>|<p>Trigger delay relative to the starting time of its parent sequence [ double = Calculated(tc) ].</p>|
|<p>duration</p>|<p>required</p>|<p>Trigger duration [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<code>`](#LabBench.Core.Components.Triggering.TriggerCode) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Components.Triggering.TriggerCode"></a>
### TriggerCode

<p>Trigger definitions that are defined by <code>output</code> and <code>value</code>. The <code>output</code> controls
where the trigger is generated, and the <code>value</code> controls which trigger code is
generated. The <code>value</code> attribute is optional and is default set to one (1).</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>output</p>|<p>required</p>|<p>Controls where a trigger will be delivered and what types of triggers can be generated:</p> <ul> <li><code>Digital</code>: Trigger OUT digital output. This output is a 1-bit trigger output, meaning that any trigger code different from zero will result in an active high output being</li> <li><code>Stimulus</code>: Stimulator T digital output. This output is a 1-bit trigger output, meaning that any trigger code different from zero will result in an active high output being</li> <li><code>Code</code>: TRIGGER INTERFACE digital output. This is a 16-bit trigger output, meaning the trigger value will be generated.</li> </ul> <p>Please note that the logic convention (positive/negative) applies only to the <code>Code</code> output; all other outputs use positive logic.</p>|
|<p>value</p>|<p>optional</p>|<p>Trigger code to be generated [ int = Calculated(tc) ].</p>|


<a id="LabBench.Core.Components.Triggering.RepeatedTriggerSequence"></a>
### RepeatedTriggerSequence

<p>Repetition of enclosed triggers.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Tdelay</p>|<p>optional</p>|<p>The delay that the enclosed trigger sequence is delayed with before it is repeated <code>N</code> times with a period of <code>Tperiod</code> [ double = Calculated(tc) ].</p>|
|<p>Tperiod</p>|<p>required</p>|<p>The period by which the enclosed triggers are repeated [ double = Calculated(tc) ].</p>|
|<p>N</p>|<p>optional</p>|<p>The number of times the enclosed triggers are repeated [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<trigger>`](#LabBench.Core.Components.Triggering.TriggerSpecification) </span><br /><span style="white-space: nowrap;">  [`<repeated-trigger>`](#LabBench.Core.Components.Triggering.RepeatedTriggerSequence) </span><br /><span style="white-space: nowrap;">  [`<combined-trigger>`](#LabBench.Core.Components.Triggering.CombinedTriggerSequence) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.Triggering.CombinedTriggerSequence"></a>
### CombinedTriggerSequence

<p>Generation of triggers from a composition of triggers and trigger sequences.
The triggers of each enclosing trigger or trigger sequence will be merged
together in time.</p>
<p>This will fail if the enclosed triggers or trigger sequences contain incompatible
triggers, meaning that two or more distinct trigger codes are to be generated
simultaneously on the same trigger output.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Tdelay</p>|<p>optional</p>|<p>Delay that all enclosed triggers are delayed with [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<trigger>`](#LabBench.Core.Components.Triggering.TriggerSpecification) </span><br /><span style="white-space: nowrap;">  [`<repeated-trigger>`](#LabBench.Core.Components.Triggering.RepeatedTriggerSequence) </span><br /><span style="white-space: nowrap;">  [`<combined-triggers>`](#LabBench.Core.Components.Triggering.CombinedTriggerSequence) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Components.Stimulation.StimulusDefinition"></a>
### StimulusDefinition

<p>Definition of a stimulus.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<pulse>`](#LabBench.Core.Components.Stimulation.Pulse) </span><br /><span style="white-space: nowrap;">  [`<ramp>`](#LabBench.Core.Components.Stimulation.Ramp) </span><br /><span style="white-space: nowrap;">  [`<sine>`](#LabBench.Core.Components.Stimulation.Sine) </span><br /><span style="white-space: nowrap;">  [`<arbitrary>`](#LabBench.Core.Components.Stimulation.Arbitrary) </span><br /><span style="white-space: nowrap;">  [`<combined>`](#LabBench.Core.Components.Stimulation.CombinedStimulus) </span><br /><span style="white-space: nowrap;">  [`<repeated>`](#LabBench.Core.Components.Stimulation.RepeatedStimulus) </span><br /><span style="white-space: nowrap;">  [`<window>`](#LabBench.Core.Components.Stimulation.Window) </span><br /><span style="white-space: nowrap;">  [`<multiple-outputs>`](#LabBench.Core.Components.Stimulation.MultipleOutputStimulus) </span><br /><span style="white-space: nowrap;">  [`<linear-segments>`](#LabBench.Core.Components.Stimulation.LinearSegmentsStimulus) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.Stimulation.Pulse"></a>
### Pulse

<p>Rectangular stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Is</p>|<p>required</p>|<p>Stimulus intensity (Is)  [ double = Calculated(tc, x)].</p>|
|<p>Ts</p>|<p>required</p>|<p>Duration of the stimulus in milliseconds [ double = Calculated(tc, x) ].</p>|
|<p>Tdelay</p>|<p>optional</p>|<p>Delay of the stimulus in miliseconds [ double = Calculated(tc, x) ]</p>|


<a id="LabBench.Core.Components.Stimulation.Ramp"></a>
### Ramp

<p>A linearly increasing stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Is</p>|<p>required</p>|<p>Stimulus intensity (Is) is the change in the intensity at the end of the ramp from the stimulus offset (Ioffset) [ double = Calculated(tc, x)].</p>|
|<p>Ioffset</p>|<p>optional</p>|<p>Stimulus intensity offset (Ioffset) is the value that all stimulus intensities during the stimulus are offset with [ double = Calculated(tc, x)].</p>|
|<p>Ts</p>|<p>required</p>|<p>Duration of the stimulus in milliseconds [ double = Calculated(tc, x) ].</p>|
|<p>Tdelay</p>|<p>optional</p>|<p>Delay of the stimulus in miliseconds [ double = Calculated(tc, x) ]</p>|


<a id="LabBench.Core.Components.Stimulation.Sine"></a>
### Sine

<p>Sinusoidal stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Is</p>|<p>required</p>|<p>Stimulus intensity [ double = Calculated(tc, x) ].</p>|
|<p>Ts</p>|<p>required</p>|<p>Stimulus duration in milliseconds [ double = Calculated(tc, x) ].</p>|
|<p>Tdelay</p>|<p>optional</p>|<p>Delay in milliseconds of the stimulus relative to its parent stimulus [ double = Calculated(tc, x) ].</p>|
|<p>Frequency</p>|<p>required</p>|<p>Frequency of the sinusoidal stimulus [ double = Calculated(tc, x) ].</p>|


<a id="LabBench.Core.Components.Stimulation.Arbitrary"></a>
### Arbitrary

<p>An arbitrary stimulus that is defined by a mathematical expression.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Ts</p>|<p>required</p>|<p>Duration of the stimulus in milliseconds [ double = Calculated(tc, x) ].</p>|
|<p>Tdelay</p>|<p>optional</p>|<p>Delay of the stimulus in miliseconds [ double = Calculated(tc, x) ]</p>|
|<p>expression</p>|<p>required</p>|<p>A mathematical expression that defines the stimulus. The expression must be a single-line Python statement that returns a double. In the scope of this expression are the current time (t) in milliseconds, a free parameter (x), a set of mathematical functions, and the results and definitions of the current protocol.</p>|


<a id="LabBench.Core.Components.Stimulation.CombinedStimulus"></a>
### CombinedStimulus

<p>A combined stimulus is the summation of a set of individual stimuli. The stimulus duration and delays of each stimulus in the set are relative to the combined stimulus's starting time.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<pulse>`](#LabBench.Core.Components.Stimulation.Pulse) </span><br /><span style="white-space: nowrap;">  [`<ramp>`](#LabBench.Core.Components.Stimulation.Ramp) </span><br /><span style="white-space: nowrap;">  [`<sine>`](#LabBench.Core.Components.Stimulation.Sine) </span><br /><span style="white-space: nowrap;">  [`<arbitrary>`](#LabBench.Core.Components.Stimulation.Arbitrary) </span><br /><span style="white-space: nowrap;">  [`<combined>`](#LabBench.Core.Components.Stimulation.CombinedStimulus) </span><br /><span style="white-space: nowrap;">  [`<repeated>`](#LabBench.Core.Components.Stimulation.RepeatedStimulus) </span><br /><span style="white-space: nowrap;">  [`<window>`](#LabBench.Core.Components.Stimulation.Window) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Components.Stimulation.RepeatedStimulus"></a>
### RepeatedStimulus

<p>Repeats an enclosed stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>Tdelay</p>|<p>optional</p>|<p>Delay in milliseconds of the repeated stimulus relative to its parent stimulus [ double = Calculated(tc, x) ].</p>|
|<p>Tperiod</p>|<p>required</p>|<p>Period in milliseconds that the enclosed stimulus is repeated [ double = Calculated(tc, x) ].</p>|
|<p>N</p>|<p>optional</p>|<p>Number of times the enclosed stimulus is repeated [ int = Calculated(tc, x) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<pulse>`](#LabBench.Core.Components.Stimulation.Pulse) </span><br /><span style="white-space: nowrap;">  [`<ramp>`](#LabBench.Core.Components.Stimulation.Ramp) </span><br /><span style="white-space: nowrap;">  [`<sine>`](#LabBench.Core.Components.Stimulation.Sine) </span><br /><span style="white-space: nowrap;">  [`<arbitrary>`](#LabBench.Core.Components.Stimulation.Arbitrary) </span><br /><span style="white-space: nowrap;">  [`<combined>`](#LabBench.Core.Components.Stimulation.CombinedStimulus) </span><br /><span style="white-space: nowrap;">  [`<repeated>`](#LabBench.Core.Components.Stimulation.RepeatedStimulus) </span><br /><span style="white-space: nowrap;">  [`<window>`](#LabBench.Core.Components.Stimulation.Window) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.Stimulation.Window"></a>
### Window

<p>Window that gets multiplied on its enclosing stimuli.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>window</p>|<p>required</p>|<p>Type of window that the enclosing stimulus is windowed with.</p>|
|<p>parameter</p>|<p>optional</p>|<p>Parameter if any of the window function.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<pulse>`](#LabBench.Core.Components.Stimulation.Pulse) </span><br /><span style="white-space: nowrap;">  [`<ramp>`](#LabBench.Core.Components.Stimulation.Ramp) </span><br /><span style="white-space: nowrap;">  [`<sine>`](#LabBench.Core.Components.Stimulation.Sine) </span><br /><span style="white-space: nowrap;">  [`<arbitrary>`](#LabBench.Core.Components.Stimulation.Arbitrary) </span><br /><span style="white-space: nowrap;">  [`<combined>`](#LabBench.Core.Components.Stimulation.CombinedStimulus) </span><br /><span style="white-space: nowrap;">  [`<repeated>`](#LabBench.Core.Components.Stimulation.RepeatedStimulus) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.Stimulation.MultipleOutputStimulus"></a>
### MultipleOutputStimulus

<p>Represent a stimulus that spand over multiple stimulation outputs.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<output>`](#LabBench.Core.Components.Stimulation.AnalogOutput) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Components.Stimulation.AnalogOutput"></a>
### AnalogOutput

<p>An analog output channel in a multiple output stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>channel</p>|<p>required</p>|<p>Number of the output channel. The stimulation device determines the meaning of this number.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<pulse>`](#LabBench.Core.Components.Stimulation.Pulse) </span><br /><span style="white-space: nowrap;">  [`<ramp>`](#LabBench.Core.Components.Stimulation.Ramp) </span><br /><span style="white-space: nowrap;">  [`<sine>`](#LabBench.Core.Components.Stimulation.Sine) </span><br /><span style="white-space: nowrap;">  [`<arbitrary>`](#LabBench.Core.Components.Stimulation.Arbitrary) </span><br /><span style="white-space: nowrap;">  [`<combined>`](#LabBench.Core.Components.Stimulation.CombinedStimulus) </span><br /><span style="white-space: nowrap;">  [`<repeated>`](#LabBench.Core.Components.Stimulation.RepeatedStimulus) </span><br /><span style="white-space: nowrap;">  [`<window>`](#LabBench.Core.Components.Stimulation.Window) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.Stimulation.LinearSegmentsStimulus"></a>
### LinearSegmentsStimulus

<p>A stimulus created from piecewise linear segments.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>baseline</p>|<p>required</p>|<p>The baseline for the stimulus [ double = Calculated(tc, x) ]. This baseline is the stimulus intensity outside the linear segments, and the starting value for the linear segments.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<segment>`](#LabBench.Core.Components.Stimulation.Segment) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Components.Stimulation.Segment"></a>
### Segment

<p>Definition of a segment of a piecewise-linear stimulus. The segment is defined by its duration and intensity at its end. Its starting intensity is defined by the end intensity of the previous segment or by the baseline intensity of the piecewise-linear stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>duration</p>|<p>required</p>|<p>Duration of the segment in milliseconds [ double = Calculated(tc, x) ].</p>|
|<p>value</p>|<p>required</p>|<p>End intensity of the segment [ double = Calculated(ts, x) ].</p>|


<a id="LabBench.Core.Tests.Meta.Sequential.SequentialTest"></a>
### SequentialTest

<p>The sequential test makes it possible to use state machines to implement experimental procedures. Unlike most other tests, it has no base functionality that can be configured in the LabBench Language; instead, its functionality must be implemented by a Python script that is called from its test events and state events.</p>
<p>In most cases, you will have access to instruments from the Python script to implement the intended experimental procedure. This access is provided by declaring the instruments in the <code>&lt;test-events&gt;</code> element. The instruments declared that they will be available for both the test events and state events.</p>
<p>The states in the state machine are defined in the <code>&lt;states&gt;</code> element, which also makes it possible to define which Python functions are called for the <code>enter</code>, <code>leave</code>, and <code>update</code> state events.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p><span style="white-space: nowrap;">  [`<update-rate-deterministic>`](#LabBench.Core.DeterministicRateParameter) </span><br /><span style="white-space: nowrap;">  [`<update-rate-random>`](#LabBench.Core.UniformlyDistributedRateParameter) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |
| <p>[`<states>`](#LabBench.Core.Tests.Meta.Sequential.SequentialTestStateCollection)</p> | <p>required</p> |<p>Definition of the states in the state machine. The following state events define the functionality of these states:</p> <ul> <li><code>enter</code>: a calculated attribute, that is executed when the state is entered.</li> <li><code>leave</code>: a calculated attribute, that is executed when the state is left.</li> <li><code>update</code>: a calculated attribute that is executed periodically. This attribute must return a string that controls whether the state machine will; &quot;*&quot;) stay in the current state, State ID) go to the state with StateID, &quot;abort&quot;) abort the test, &quot;complete&quot;) complete the test.</li> </ul> <p>In the TestContext <code>tc</code>, both test events and state events have access to a <code>tc.CurrentState</code> object that provides:</p> <ul> <li><code>CurrentState.ID</code>: The State ID of the currently active state [ text(readonly)].</li> <li><code>CurrentState.RunningTime</code>: The running time in milliseconds of the currently active state  [ int(readonly) ].</li> <li><code>CurrentState.Name</code>: Name of the currently active state [ text(readonly) ].</li> <li><code>CurrentState.Status</code>: A text that will be shown to the operator in the test window. Can be set by the events to provide information to the operator.</li> <li><code>CurrentState.SetPlotter(lambda x, y)</code>: Events can set a Python function that must generate an image that will be shown to the operator in the test window.</li> </ul>|


<a id="LabBench.Core.Tests.Meta.Sequential.SequentialTestStateCollection"></a>
### SequentialTestStateCollection

<p>Definition of the states in the state machine. The following state events define the functionality of these states:</p>
<ul>
<li><code>enter</code>: a calculated attribute, that is executed when the state is entered.</li>
<li><code>leave</code>: a calculated attribute, that is executed when the state is left.</li>
<li><code>update</code>: a calculated attribute that is executed periodically. This attribute must return a string that controls whether the state machine will; &quot;*&quot;) stay in the current state, State ID) go to the state with StateID, &quot;abort&quot;) abort the test, &quot;complete&quot;) complete the test.</li>
</ul>
<p>In the TestContext <code>tc</code>, both test events and state events have access to a <code>tc.CurrentState</code> object that provides:</p>
<ul>
<li><code>CurrentState.ID</code>: The State ID of the currently active state [ text(readonly)].</li>
<li><code>CurrentState.RunningTime</code>: The running time in milliseconds of the currently active state  [ int(readonly) ].</li>
<li><code>CurrentState.Name</code>: Name of the currently active state [ text(readonly) ].</li>
<li><code>CurrentState.Status</code>: A text that will be shown to the operator in the test window. Can be set by the events to provide information to the operator.</li>
<li><code>CurrentState.SetPlotter(lambda x, y)</code>: Events can set a Python function that must generate an image that will be shown to the operator in the test window.</li>
</ul>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>enter</p>|<p>optional</p>|<p>Specifies code that will be executed when a state is entered [ bool = Calculated(tc) ]. If False is returned, the test will be aborted.</p>|
|<p>leave</p>|<p>optional</p>|<p>Specifies code that will be executed when a state is left [ bool = Calculated(tc) ]. If False is returned, the test will be aborted.</p>|
|<p>update</p>|<p>required</p>|<p>Specifies code that will be executed periodically while the test is active [ Text = Calculated(tc) ]. If text returned will control the next active state. How often the code is executed is controlled by the update rate of the test.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<state>`](#LabBench.Core.Tests.Meta.Sequential.SequentialTestState) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Meta.Sequential.SequentialTestState"></a>
### SequentialTestState

<p>Definition of a test state.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>ID of the test state. Must be unique, and not one of the reserved keywords for state or test transitions. These keywoards are, *, abort, and complete.</p>|
|<p>name</p>|<p>optional</p>|<p>This optional attribute specifies a human readable name for the test state. If it is not specified the ID of the test state will be used instead.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>This optional attribute, specifies the ID of the experimental setup that will be active will the test state is active. If none is specified the experimental setup for the test will be used instead.</p>|


<a id="LabBench.Core.Tests.Algometry.StimulusResponse.AlgometryStimulusResponseTest"></a>
### AlgometryStimulusResponseTest

<p>Stimulus-response tests determine the psychophysical rating (VAS Rating) to a linearly increasing pressure stimulus.
From this stimulus-response curve, several psychophysical parameters can be determined:</p>
<ol>
<li>PDT: The Pain Detection Threshold,</li>
<li>PTL: The Pain Tolerance Limit, and</li>
<li>PTT: The Pain Tolerance Threshold (PTT).</li>
</ol>
<p>The determined parameters depend on the test configuration and the subject's instructions.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>second-cuff</p>|<p>optional</p>|<p>Inflate the second cuff together with the primary cuff [ bool ]. If this attribute is set to true, the value of the primary cuff parameter is irrelevant. Placing the two cuffs adjacent to each other can be used to study spatial summation.</p>|
|<p>pressure-limit</p>|<p>optional</p>|<p>This attribute is the maximum pressure the device will deliver before it aborts the test [ double = Calculated(tc) ]. The maximal pressure for the device is 100kPa.</p>|
|<p>conditioning-time</p>|<p>optional</p>|<p>This attribute is the time from the test's start until the pressure starts to increase linearly [ double = Calculated(tc) ].</p>|
|<p>delta-pressure</p>|<p>optional</p>|<p>This attribute is the rate of increase [kPa/s] of the applied pressure [ double = Calculated(tc) ].</p>|
|<p>vas-pdt</p>|<p>optional</p>|<p>The VAS score is interpreted as the Pain Detection Threshold (PDT) [ double = Calculated(tc) ]. This attribute should be set to at least 0.1cm to allow for a small deadband in the button on the VAS meter, which is required so as not to risk that noise will accidentally trigger an early determination of the PDT. It can be set to higher than 0.1cm to allow for non-painful stimulations to be rated by the subject.</p>|
|<p>stop-mode</p>|<p>required</p>|<p>Stop mode for the test (stop-on-maximal-rating or stop-when-button-pressed). This attribute determines whether the VAS scale has two (2) or three anchor points (3). When set to stop-on-maximal-rating the VAS scale has two anchor points (pain detection threshold (PDT), pain tolerance threshold (PTT)). When set to stop-when-button-pressed the VAS scale has three anchor points (pain detection threshold (PDT), pain tolerance limit (PTL), pain tolerance threshold (PTT)).</p>|
|<p>primary-cuff</p>|<p>required</p>|<p>Determines which cuff (1 or 2) will be used for the pressure stimulation [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Algometry.ConditionedPain.AlgometryConditionedPainTest"></a>
### AlgometryConditionedPainTest

<p>With the conditioned pain modulation test, one cuff applies static pressure while the other determines a stimulus-response curve. The stimulus-response curve determines the psychophysical rating (VAS Rating) to a linearly increasing pressure stimulus.</p>
<p>From this stimulus-response curve, several psychophysical parameters can be determined:</p>
<ul>
<li>Pain Detection Threshold (PDT),</li>
<li>Pain Tolerance Limit (PTL),</li>
<li>Pain Tolerance Threshold (PTT).</li>
</ul>
<p>The determined parameters depend on the test configuration and the subject's instructions.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>conditional-pressure</p>|<p>required</p>|<p>This attribute is the pressure that will be applied with the conditioning cuff [ double = Calculated(tc) ].</p>|
|<p>delta-conditional-pressure</p>|<p>optional</p>|<p>This attribute is the rate of increase [kPa/s] of the applied conditioning pressure [ double = Calculated(tc) ].</p>|
|<p>conditioning-time</p>|<p>optional</p>|<p>This attribute is the time from the test's start until the pressure starts to increase linearly [ double = Calculated(tc) ].</p>|
|<p>pressure-limit</p>|<p>optional</p>|<p>This attribute is the maximum pressure the device will deliver before it aborts the test [ double = Calculated(tc) ]. The maximal pressure for the device is 100kPa.</p>|
|<p>delta-pressure</p>|<p>optional</p>|<p>This attribute is the rate of increase [kPa/s] of the applied pressure [ y = Calculated(tc) ].</p>|
|<p>vas-pdt</p>|<p>optional</p>|<p>The VAS score is interpreted as the Pain Detection Threshold (PDT) [ double = Calculated(tc) ]. This attribute should be set to at least 0.1cm to allow for a small deadband in the button on the VAS meter, which is required so as not to risk that noise will accidentally trigger an early determination of the PDT. It can be set to higher than 0.1cm to allow for non-painful stimulations to be rated by the subject.</p>|
|<p>stop-mode</p>|<p>required</p>|<p>Stop mode for the test (stop-on-maximal-rating or stop-when-button-pressed). This attribute determines whether the VAS scale has two (2) or three anchor points (3). When set to stop-on-maximal-rating the VAS scale has two anchor points (pain detection threshold (PDT), pain tolerance threshold (PTT)). When set to stop-when-button-pressed the VAS scale has three anchor points (pain detection threshold (PDT), pain tolerance limit (PTL), pain tolerance threshold (PTT)).</p>|
|<p>primary-cuff</p>|<p>required</p>|<p>Determines which cuff (1 or 2) will be used for the pressure stimulation [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Algometry.TemporalSummation.AlgometryTemporalSummationTest"></a>
### AlgometryTemporalSummationTest

<p>The temporal summation test applies a series of rectangular pressure stimuli to one or both cuffs. The subject is asked to rate the pain sensation of these stimuli on the VAS meter as soon as possible after
the cessation of a pressure stimulus. The VAS rating for a stimulus is recorded just before the next stimulus is given or would have been given if it had not been the last stimulus in the series.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>no-of-stimuli</p>|<p>optional</p>|<p>This attribute is the number of pressure stimuli applied during the test [ int = Calculated(tc) ].</p>|
|<p>t-on</p>|<p>optional</p>|<p>This attribute is the duration of the rectangular stimuli [ double = Calculated(tc) ].</p>|
|<p>t-off</p>|<p>optional</p>|<p>This attribute is the pause between the stimuli in the series [ double = Calculated(tc) ].</p>|
|<p>pressure-stimulate</p>|<p>optional</p>|<p>This attribute is the pressure that will be applied during the rectangular pressure stimuli [ double = Calculated(tc) ].</p>|
|<p>pressure-static</p>|<p>optional</p>|<p>This attribute is the pressure that will be applied in between the pressure stimuli [ double = Calculated(tc) ]. This value is included as a slight static pressure between the stimuli can prevent the cuff from shifting during the test.</p>|
|<p>second-cuff</p>|<p>optional</p>|<p>Inflate the second cuff together with the primary cuff [ bool ]. If this attribute is set to true, the value of the primary cuff parameter is irrelevant. Placing the two cuffs adjacent to each other can be used to study spatial summation.</p>|
|<p>primary-cuff</p>|<p>optional</p>|<p>Determines which cuff (1 or 2) will be used for the pressure stimulation [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Algometry.StaticTemporalSummation.AlgometryStaticTemporalSummationTest"></a>
### AlgometryStaticTemporalSummationTest

<p>The static temporal summation applies a constant pressure for a specified duration instead of a series of stimuli to determine the temporal summation of pressure stimulation.</p>
<p>During this pressure stimulation and for a period after the test, the subject's VAS score will be recorded as the result of the test.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>pressure-stimulate</p>|<p>optional</p>|<p>This attribute is the pressure that is applied during the static pressure stimulation [ double = Calculated(tc)  ].</p>|
|<p>stimulus-duration</p>|<p>optional</p>|<p>This attribute is the duration [s] of the constant pressure stimulation [ double = Calculated(tc) ].</p>|
|<p>tail-duration</p>|<p>optional</p>|<p>This attribute is the duration after the cessation of the pressure stimulation in which the VAS score is recorded [ double = Calculated(tc) ].</p>|
|<p>second-cuff</p>|<p>optional</p>|<p>Inflate the second cuff together with the primary cuff [ bool ]. If this attribute is set to true, the value of the primary cuff parameter is irrelevant. Placing the two cuffs adjacent to each other can be used to study spatial summation.</p>|
|<p>primary-cuff</p>|<p>optional</p>|<p>Determines which cuff (1 or 2) will be used for the pressure stimulation [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Algometry.StimulusRating.AlgometryStimulusRatingTest"></a>
### AlgometryStimulusRatingTest

<p>The stimulus rating test provides a way to determine the Pain Detection Threshold (PDT), the Pain Tolerance Threshold (PTT), or both with an attached button.</p>
<p>The test is executed in the same way as the stimulus-response test and is defined by the same parameters, with the exception that it does not have a stop-mode parameter but instead has a measurement parameter.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>second-cuff</p>|<p>optional</p>|<p>Inflate the second cuff together with the primary cuff [ bool ]. If this attribute is set to true, the value of the primary cuff parameter is irrelevant. Placing the two cuffs adjacent to each other can be used to study spatial summation.</p>|
|<p>pressure-limit</p>|<p>optional</p>|<p>This attribute is the maximum pressure the device will deliver before it aborts the test [ double = Calculated(tc) ]. The maximal pressure for the device is 100kPa.</p>|
|<p>conditioning-time</p>|<p>optional</p>|<p>This attribute is the time from the test's start until the pressure starts to increase linearly [ double = Calculated(tc) ].</p>|
|<p>delta-pressure</p>|<p>optional</p>|<p>This attribute is the rate of increase [kPa/s] of the applied pressure [ double = Calculated(tc) ].</p>|
|<p>primary-cuff</p>|<p>required</p>|<p>Determines which cuff (1 or 2) will be used for the pressure stimulation [ int = Calculated(tc) ].</p>|
|<p>measurement</p>|<p>required</p>|<p>Determine the Pain Detection Threshold (PDT), Pain Tolerance Threshold (PTT), or both. If the PDT or PTT is to be determined, the subject must press the button when the threshold is reached. If both the PDT and PTT are to be determined, the subject must press the button when the PDT is reached and release it when the PTT is reached.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Algometry.ConditionedPainRating.AlgometryConditionedPainRatingTest"></a>
### AlgometryConditionedPainRatingTest

<p>The conditioned pain modulation rating test is analogous to the conditioned pain modulation test that uses a button instead of the VAS to determine pain detection threshold (PDT), pain tolerance threshold (PTT), or both.</p>
<p>The same parameters define the test as the conditioned pain modulation test, with the addition of the measurement parameter that defines how the button is used to determine PDT, PTT, or both.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>conditional-pressure</p>|<p>required</p>|<p>This attribute is the pressure that will be applied with the conditioning cuff [ double = Calculated(tc) ].</p>|
|<p>delta-conditional-pressure</p>|<p>optional</p>|<p>This attribute is the rate of increase [kPa/s] of the conditioning pressure [ double = Calculated(tc) ].</p>|
|<p>conditioning-time</p>|<p>optional</p>|<p>This attribute is the time from the test's start until the pressure starts to increase linearly [ double = Calculated(tc) ].</p>|
|<p>pressure-limit</p>|<p>optional</p>|<p>This attribute is the maximum pressure the device will deliver before it aborts the test. The maximal pressure for the device is 100kPa.</p>|
|<p>delta-pressure</p>|<p>optional</p>|<p>This attribute is the rate of increase [kPa/s] of the applied pressure [ double = Calculated(tc) ].</p>|
|<p>primary-cuff</p>|<p>required</p>|<p>Determines which cuff (1 or 2) will be used for the pressure stimulation [ double = Calculated(tc) ].</p>|
|<p>measurement</p>|<p>required</p>|<p>Determine the Pain Detection Threshold (PDT), Pain Tolerance Threshold (PTT), or both. If the PDT or PTT is to be determined, the subject must press the button when the threshold is reached. If both the PDT and PTT are to be determined, the subject must press the button when the PDT is reached and release it when the PTT is reached.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.AlgometryArbitraryTemporalSummationTest"></a>
### AlgometryArbitraryTemporalSummationTest

<p>The arbitrary temporal summation test applies a series of rectangular pressure stimuli to one or both cuffs.</p>
<p>The subject is asked to rate the pain sensation of these stimuli on the VAS meter as soon as possible after the cessation of a pressure stimulus.</p>
<p>The VAS rating for a stimulus is recorded just before the next stimulus is given or would have been given if it had not been the last stimulus in the series. The arbitrary temporal summation test makes it possible to specify each stimulus in the series individually, and thus, each stimulus can have a different intensity and duration.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>pressure-static</p>|<p>optional</p>|<p>This attribute is the pressure that will be applied in between the pressure stimuli [ double = Calculated(tc) ]. This value is included as a slight static pressure between the stimuli can prevent the cuff from shifting during the test.</p>|
|<p>second-cuff</p>|<p>optional</p>|<p>Inflate together with the primary cuff [ bool ]. If this attribute is set to true, the value of the primary cuff parameter is irrelevant. Placing the two cuffs adjacent to each other can be used to study spatial summation.</p>|
|<p>primary-cuff</p>|<p>required</p>|<p>Determines which cuff [1 or 2] that will be used for the pressure stimulation [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>`<stimuli>`</p> | <p>optional</p> |<p> The `<stimuli>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.TemporalSummationStimulus"><code>&lt;stimulus&gt;</code></a> </span></li> </ul> </p>|


<a id="LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.TemporalSummationStimulus"></a>
### TemporalSummationStimulus

<p>Specification of a pressure stimulus in the series of pressure stimuli.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>pressure</p>|<p>required</p>|<p>Stimulation pressure  [ double = Calculated(tc) ].</p>|
|<p>t-on</p>|<p>required</p>|<p>Duration of the stimulus [ double = Calculated(tc) ]</p>|
|<p>t-off</p>|<p>required</p>|<p>Pause between stimulations [ double = Calculated(tc) ]</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ThresholdEstimationTest"></a>
### ThresholdEstimationTest

<p>The threshold estimation test is used to estimate thresholds/psychometric functions when LabBench controls the stimulus generation automatically. Estimation of these thresholds/psychometric functions consists of three parts: the stimulus modality, response task, and estimation algorithm:</p>
<ul>
<li><strong>Stimulus modality</strong>: the type of stimulus, such as tactile, thermal, pressure, or electrical, presented to the subject and for which a threshold/psychometric function is estimated.</li>
<li><strong>Response task</strong>: the perception task that the subject is asked to perform when the stimulus is presented. The outcome of this task is either true: the subject performed the task correctly, or false: the the subject failed to perform the task correctly.</li>
<li><strong>Estimation algorithm</strong>: the adaptive algorithm by which the threshold/psychometric function is estimated. This algorithm uses the outcome of the response task (correct/incorrect) to update the estimate of the threshold or psychometric function for each stimulus presentation.</li>
</ul>
<p>The thresholds or psychometric functions are estimated for an independent variable (x). An increase in x is assumed to increase the probability that the subject will correctly perform the response task. If there is an inverted relationship, the independent variable (x) inversion must be performed in the stimulus specification.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>stimulus-update-rate</p>|<p>required</p>|<p>Update rate for stimulus generation [ int = Calculated(tc) ].</p>|
|<p>trigger-update-rate</p>|<p>optional</p>|<p>Update rate for trigger generation [ int = Calculated(tc) ]. If not defined, the stimulus generation update rate will be used.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p><span style="white-space: nowrap;">  [`<update-rate-deterministic>`](#LabBench.Core.DeterministicRateParameter) </span><br /><span style="white-space: nowrap;">  [`<update-rate-random>`](#LabBench.Core.UniformlyDistributedRateParameter) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |
| <p>[`<configuration>`](#LabBench.Core.Components.ComponentConfiguration)</p> | <p>optional</p> |<p>Configuration of test components, which includes configuration of the stimulation, trigger, and sampling components that are used by the test.</p>|
| <p><span style="white-space: nowrap;">  [`<manual-yes-no-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualYesNoResponse) </span><br /><span style="white-space: nowrap;">  [`<yes-no-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.YesNoResponse) </span><br /><span style="white-space: nowrap;">  [`<forced-yes-no-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ForcedYesNoResponse) </span><br /><span style="white-space: nowrap;">  [`<manual-interval-rating-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualIntervalResponse) </span><br /><span style="white-space: nowrap;">  [`<interval-rating-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.IntervalResponse) </span><br /><span style="white-space: nowrap;">  [`<manual-categorical-rating-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualCategoricalResponse) </span><br /><span style="white-space: nowrap;">  [`<categorical-rating-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.CategoricalResponse) </span><br /><span style="white-space: nowrap;">  [`<ratio-rating-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.RatioResponse) </span><br /><span style="white-space: nowrap;">  [`<interval-forced-choice-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.IntervalForcedChoiceResponse) </span><br /><span style="white-space: nowrap;">  [`<alternative-forced-choice-task>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.AlternativeForcedChoiceResponse) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |
| <p>[`<stimulation-scripts>`](#LabBench.Core.Components.Stimulation.ScriptedStimulation)</p> | <p>optional</p> |<p>Custom stimulation where the stimulation is implemented with calculated parameters that can either be a single-line Python statement or, more commonly, by calling a Python function in a script.</p>|
| <p>`<channels>`</p> | <p>optional</p> |<p> The `<channels>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.StimulusChannel"><code>&lt;channel&gt;</code></a> </span></li> </ul> </p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualYesNoResponse"></a>
### ManualYesNoResponse

<p>In a Manual Yes/No response task, the experimenter asks the subject after each stimulation whether they felt the stimulus. This response is then entered into the algorithm manually by the experimenter. Consequently, the test will wait indefinitely until the subject has answered the experimenter.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>instruction</p>|<p>optional</p>|<p>Question that the experimenter must ask the subject that the subject must answer with either a Yes or No response [ string ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.YesNoResponse"></a>
### YesNoResponse

<p>In a Yes/No response task, the subject is asked to press the button each time a stimulus is felt. This response is timed, meaning that if the subject does not press the button before the next stimulus is given, then it will be assumed that the stimulus was not felt.</p>

<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ForcedYesNoResponse"></a>
### ForcedYesNoResponse

<p>In the forced yes/no task, the stimulus is first presented to the subject, along with a cue that prompts the subject to attend to it.</p>
<p>Then a probe image is presented to the subject, with instructions to answer Yes or No to a stimulus quality; for example, if one or two stimuli could be felt, the subject presses one button for Yes and another for No. The task will wait indefinitely until the subject has answered the question.</p>
<p>This task is usually used for stimuli that are always felt but whose quality changes with increasing intensity. Examples of such stimuli are two-point stimuli or stimuli used to determine a just noticeable difference.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>probe</p>|<p>required</p>|<p>Image that will be used to probe the subject for an answer to the Yes/No question [ Image = Calculated(tc) ].</p>|
|<p>cue</p>|<p>required</p>|<p>Image that will be used to cue the subject to pay attention to the stimulus [ Image = Calculated(tc) ].</p>|
|<p>display-duration</p>|<p>optional</p>|<p>The duration in milliseconds that the cue will be displayed to the subject [ int ].</p>|
|<p>display-interval</p>|<p>optional</p>|<p>The duration in milliseconds between the display of the cue and the display of the prompt [ int ]. The display-interval value must be greater than the display-duration value.</p>|
|<p>pause</p>|<p>optional</p>|<p>The delay in milliseconds between when the subject answered the question and the next stimulus is presented [ int ].</p>|
|<p>yes-button</p>|<p>required</p>|<p>Button that the subject will use to indicate a Yes answer to the question [ Button ].</p>|
|<p>no-button</p>|<p>required</p>|<p>Button that the subject will use to indicate a No answer to the question [ Button ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualIntervalResponse"></a>
### ManualIntervalResponse

<p>In the Manual Interval Rating Task, the subject is asked to rate the stimuli's sensations on an interval rating scale by the experimenter. The subject provides this rating verbally, which the experimenter then manually enters into the algorithm. The response task will wait indefinitely until the experimenter has entered the subject's rating into the algorithm. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False.</p>
<p>The Manual Interval Categorical Rating task is an example of a response task that enables determining the stimulus intensity required to evoke a supramaximal response, rather than determining the intensity required to evoke a threshold response, such as a perception or pain threshold.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>instruction</p>|<p>optional</p>|<p>Question that the experimenter must ask to prompt the subject to rate the sensation on the interval rating scale [ string ].</p>|
|<p>target</p>|<p>required</p>|<p>Target rating for the response task [ int = Calculated(tc) ].</p>|
|<p>minimum</p>|<p>optional</p>|<p>Minimum rating on the interval rating scale [ int ]. Default is 0.</p>|
|<p>maximum</p>|<p>optional</p>|<p>Maximal rating on the interval rating scale [ int ]. Default is 10.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.IntervalResponse"></a>
### IntervalResponse

<p>In the Interval Rating Task, the subject is asked to rate the stimuli's sensations on an interval rating scale. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False.</p>
<p>The Interval Rating task is an example of a response task that enables determining the stimulus intensity required to evoke a supramaximal response, rather than determining the intensity required to evoke a threshold response, such as a perception or pain threshold.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>target</p>|<p>required</p>|<p>Target rating for the response task [ int = Calculated(tc) ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualCategoricalResponse"></a>
### ManualCategoricalResponse

<p>@Schema.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualCategoricalResponse.md</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>instruction</p>|<p>optional</p>|<p>Question that the experimenter must ask to prompt the subject to rate the sensation on the categorical rating scale [ string ].</p>|
|<p>target</p>|<p>required</p>|<p>Target rating for the response task [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<category>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualCategory) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.ManualCategory"></a>
### ManualCategory

<p>In the Manual Categorial Rating Task, the subject is asked to rate the stimuli's sensations on a categorial rating scale by the experimenter. The subject provides this rating verbally, which the experimenter then manually enters into the algorithm. The response task will wait indefinitely until the experimenter has entered the subject's rating into the algorithm. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False.</p>
<p>The Manual Categorical Rating task is an example of a response task that enables determining the stimulus intensity required to evoke a supramaximal response, rather than determining the intensity required to evoke a threshold response, such as a perception or pain threshold.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>text</p>|<p>required</p>|<p>Description of the category [ Dynamic Text ]</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.CategoricalResponse"></a>
### CategoricalResponse

<p>In the Categorial Rating Task, the subject is asked to rate the stimuli's sensations on a categorial rating scale. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False.</p>
<p>The Categorical Rating task is an example of a response task that enables determining the stimulus intensity required to evoke a supramaximal response, in contrast to determining the intensity required to evoke a threshold response, such as a perception or pain threshold.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>target</p>|<p>required</p>|<p>Target rating for the response task [ int = Calculated(tc) ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.RatioResponse"></a>
### RatioResponse

<p>In the Ratio Rating Task, the subject is asked to rate the stimuli's sensations on a ratio rating scale/visual analog scale. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False.</p>
<p>The Ratio Rating task is an example of a response task that enables determining the stimulus intensity required to evoke a supramaximal response, rather than determining the intensity required to evoke a threshold response, such as a perception or pain threshold.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>target</p>|<p>required</p>|<p>Target rating for the response task [ double = Calculated(tc) ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.IntervalForcedChoiceResponse"></a>
### IntervalForcedChoiceResponse

<p>In an interval forced choice response task, the subject is presented with N time intervals in which the stimulus is given in one of them. The subject is asked to select the interval at which the stimulus was felt. If the subject can feel the stimulus, they will select the correct interval; if they cannot, they will have a 1/N chance to select the correct interval.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>probe</p>|<p>required</p>|<p>Image that will be used to probe the subject for an answer to which stimulus interval the stimulus was presented when the cue was shown[ Image = Calculated(tc) ].</p>|
|<p>display-duration</p>|<p>optional</p>|<p>The duration in milliseconds that the cue will be displayed to the subject [ int ].</p>|
|<p>display-interval</p>|<p>optional</p>|<p>The duration in milliseconds between the display of cues or the prompt [ int ]. The display-interval value must be greater than the display-duration value.</p>|
|<p>pause</p>|<p>optional</p>|<p>The delay in milliseconds between when the subject answered the question and the next stimulus is presented [ int ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<interval>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.StimulusInterval) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.AlternativeForcedChoiceResponse"></a>
### AlternativeForcedChoiceResponse

<p>In an alternative forced choice response task, the subject is presented with one stimulus randomly selected from a set of N stimulus alternatives. Once the stimulus is complete, the subject will be asked to choose the given stimulus from the set of stimulus alternatives. If the subject can feel the stimulus, they will select the correct one; if they cannot, they will have a 1/N chance to select the correct stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>probe</p>|<p>required</p>|<p>Image that will be used to probe the subject for an answer to which stimulus alternative was presented when the cue was shown[ Image = Calculated(tc) ].</p>|
|<p>cue</p>|<p>required</p>|<p>Image that will be used to cue the subject to pay attention to the stimulus [ Image = Calculated(tc) ].</p>|
|<p>display-duration</p>|<p>optional</p>|<p>The duration in milliseconds that the cue will be displayed to the subject [ int ].</p>|
|<p>display-interval</p>|<p>optional</p>|<p>The duration in milliseconds between the display of the cue and the display of the prompt [ int ]. The display-interval value must be greater than the display-duration value.</p>|
|<p>pause</p>|<p>optional</p>|<p>The delay in milliseconds between when the subject answered the question and the next stimulus is presented [ int ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<alternative>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.StimulusAlternative) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ResponseTasks.StimulusAlternative"></a>
### StimulusAlternative

<p>Configuration of a stimulus alternative where each is a different variant of the stimulus. For example, in a test that determines the just noticeable difference between three audible tones, there will be three different stimulus alternatives, for which either the first, middle, or last tone will be of a different intensity than the other tones.</p>
<p>For each trial, one stimulus alternative will be selected at random and presented to the subject. The selected one is available to calculated parameters in the StimulusAlternative parameter, whose value is the id attribute of the selected stimulus alternative.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Unique ID of the stimulus alternative [ string ].</p>|
|<p>button</p>|<p>required</p>|<p>Button that the subject will use to indicate if they felt this specific stimulus alternative.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.StimulusChannel"></a>
### StimulusChannel

<p>A stimulus channel estimates the threshold or psychometric function of a single stimulus. This threshold or psychometric function is estimated with a dedicated estimation method (Psi-method, Up/Down method, and similar) that maintains its own state for the channel but uses the same response task to determine the relationship between a stimulus parameter (x) and the probabilistic behavioral response of the participants (i.e., whether they can perform the response task correctly).</p>
<p>Once a threshold or psychometric function has been estimated, the result can be accessed by calculated parameters as <code>[Test ID].[Channel ID]</code>.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Unique ID of the stimulus channel [ string ].</p>|
|<p>name</p>|<p>required</p>|<p>Name of the channel [ string ].</p>|
|<p>Imin</p>|<p>optional</p>|<p>Minimal stimulus intensity for the channel [ double = Calculated(tc) ].</p>|
|<p>Imax</p>|<p>optional</p>|<p>Maximal stimulus intensity for the channel [ double = Calculated(tc) ].</p>|
|<p>confidence-level</p>|<p>optional</p>|<p>Confidence level when plotting estimated parameters for psychometric functions (alpha, beta, etc) [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<catch-trials>`](#LabBench.Core.Tests.Psychophysics.CatchTrials)</p> | <p>optional</p> |<p>Catch trials are intermittent trials in which the stimulus is presented at an unequivocally subthreshold level, allowing the experimenter to verify attention. By comparing responses on these impossible trials to their known correct outcomes, catch trials provide direct empirical estimates of guess rates, helping distinguish genuine perceptual limits from non-sensory errors.</p>|
| <p><span style="white-space: nowrap;">  [`<psi-method>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.PsiAlgorithm) </span><br /><span style="white-space: nowrap;">  [`<up-down-method>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.UpDownAlgorithm) </span><br /><span style="white-space: nowrap;">  [`<discrete-up-down-method>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.DiscreteUpDownAlgorithm) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |
| <p>[`<triggers>`](#LabBench.Core.Components.Triggering.TriggerDefinition)</p> | <p>optional</p> |<p>Specifies a set of triggers to be generated. These triggers will all be generated with a given duration (<code>duration</code>) and delay (<code>Tdelay</code>). The delay is relative to the start time of its parent trigger sequence; if it has no parent trigger sequence, it is relative to time zero.</p> <p>A trigger may generate a trigger on multiple digital outputs. Each output is specified with a nested <code>&lt;code&gt;</code> element.</p>|
| <p>[`<stimulus>`](#LabBench.Core.Components.Stimulation.StimulusDefinition)</p> | <p>optional</p> |<p>Definition of a stimulus.</p>|


<a id="LabBench.Core.Tests.Psychophysics.CatchTrials"></a>
### CatchTrials

<p><strong>Catch trials</strong> are predefined control trials incorporated into an experimental protocol. These trials
present either a stimulus with a known or obvious outcome or no stimulus, and serve to evaluate subject
attention, task comprehension, and response compliance. Catch trials do not contribute to the primary
experimental measurements.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>order</p>|<p>required</p>|<p>Randomization of the catch trial:</p> <ul> <li><strong>deterministic</strong>: Deterministic catch trials will occur with a fixed interval.</li> <li><strong>block-randomized</strong>: Block randomized will occur once within a block of interval number of stimuli.</li> <li><strong>randomized</strong>: Randomized catch trials will be generated with a probability of 1/interval.</li> </ul>|
|<p>interval</p>|<p>required</p>|<p>The interval, block-size, or probability with which the catch trial is generated [ int ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.PsiAlgorithm"></a>
### PsiAlgorithm

<p>This method implements the Psi method of Kontsevich &amp; Tyler (1999). The Psi method is a Bayesian adaptive procedure that maintains a full joint posterior distribution over the threshold and slope of the psychometric function, while holding the guess and lapse rates fixed.</p>
<p>On each trial, the algorithm evaluates a set of candidate stimulus intensities and, for each one, computes the expected reduction in entropy of the current posterior if that stimulus were presented. It then selects the stimulus level that maximizes expected information gain, presents it to the observer, records the binary response, and updates the posterior via Bayes� rule.</p>
<p>This iterative cycle - predict information gain =&gt; choose optimal stimulus =&gt; observe response =&gt; update posterior - allows the method to rapidly converge on precise estimates of threshold and slope with high efficiency compared to traditional staircases or other adaptive schemes.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>number-of-trials</p>|<p>required</p>|<p>Number of trials that are performed with the algorithm [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<quick>`](#LabBench.Psychophysics.PsychometricFunction)</p> | <p>required</p> |<p>The psychometric function that links stimulus intensity to the probability of a correct or “yes” response, providing a quantitative model of perceptual sensitivity.</p>|
| <p>[`<beta>`](#LabBench.Core.XmlTools.ArrayGenerator)</p> | <p>required</p> |<p>The beta range specifies the set of slope values considered in the posterior distribution, constraining the possible steepnesses of the psychometric function that the algorithm can infer.</p>|
| <p>[`<alpha>`](#LabBench.Core.XmlTools.ArrayGenerator)</p> | <p>required</p> |<p>The alpha range defines the set of threshold values over which the algorithm computes and updates its posterior, effectively bounding the possible thresholds it can estimate.</p>|
| <p>[`<intensity>`](#LabBench.Core.XmlTools.ArrayGenerator)</p> | <p>required</p> |<p>The intensity range defines the allowable stimulus levels the algorithm can choose from on each trial when selecting the next, most informative stimulus.</p>|


<a id="LabBench.Core.XmlTools.ArrayGenerator"></a>
### ArrayGenerator

<p>Generation of arrays.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>optional</p>|<p>Name of the variable [ string ].</p>|
|<p>type</p>|<p>optional</p>|<p>Algorithm to use for the generation of values:</p> <ul> <li><strong>linspace</strong>: the generated values are linearly spaced between the <code>x0</code> and <code>x1</code> values, both values included. A total of <code>n</code> values will be generated.</li> <li><strong>logspace</strong>: the values are given as <code>x_n = base^xl_n</code>, where <code>xl_n</code> are the values of a <code>linspace</code> generated values.</li> <li><strong>geomspace</strong>: the values are generated as a geometric progression between the <code>x0</code> and <code>x1</code> values, both values included. Consequently, each subsequent value <code>x_n + 1</code> is found as a common ratio <code>r</code> multiplied by the previous value <code>x_n</code>. The common ratio is calculated automatically, resulting in <code>n</code> values spaced geometrically between <code>x0</code> and <code>x1</code>.</li> <li><strong>array</strong>: the values are generated from a calculated parameter [ double[] = Calculated(tc) ].</li> </ul>|
|<p>n</p>|<p>optional</p>|<p>Number of samples to generate [ double = Calculated(tc) ]. Value will be rounded down to nearest integer.</p>|
|<p>x0</p>|<p>optional</p>|<p>Starting value for the generated values [ double = Calculated(tc) ].</p>|
|<p>x1</p>|<p>optional</p>|<p>End value for the generated values [ double = Calculated(tc) ].</p>|
|<p>base</p>|<p>optional</p>|<p>Base value for logspace generated values [ double = Calculated(tc) ].</p>|
|<p>value</p>|<p>optional</p>|<p>Value for array generated values [ double[] = Calculated(tc) ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.UpDownAlgorithm"></a>
### UpDownAlgorithm

<p>The up/down, also known as the staircase method, is an adaptive method that estimates a psychophysical threshold by increasing the intensity until the subject performs the response task correctly, then reversing the direction of intensity change and decreasing it until the subject fails to perform the response task correctly.</p>
<p>This pattern of increasing/decreasing the intensity until the subject either succeeds or fails the response task is repeated a set number of times. When complete, the algorithm finds the threshold as the average intensity at which the intensity change reversed, due to a change from failing (increasing threshold) to succeeding (decreasing threshold). The algorithm can be configured to either initially increase or decrease the intensity with the <code>initial-direction</code> attribute.</p>
<p>The step size of the intensity change can either be absolute or relative. If it is absolute, the step size is in the same unit as the intensity and changes the intensity by a fixed amount. If it is relative, its intensity changes by a given fraction of its current value. The step size can also be adaptive: initially higher to approach the threshold quickly, then decreasing with each reversal of the intensity change until a given maximal reduction is reached. When the step size is adaptive, the average will be weighted by the inverse of the step sizes.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>reversal-rule</p>|<p>optional</p>|<p>The number of times the participants must either succeed or fail for the intensity change to change direction [int = Calculated(tc)]. This attribute is used for both upward and downward directions unless either the <code>up-rule</code> or the <code>down-rule</code> is defined, respectively. The default value for this attribute is one (1).</p>|
|<p>up-rule</p>|<p>optional</p>|<p>The number of times the participants must succeed when the intensity is increased upward for the intensity change to change direction [int = Calculated(tc)]. The default value for this attribute is one (1).</p>|
|<p>down-rule</p>|<p>optional</p>|<p>The number of times the participants must fail when the intensity is decreased upward for the intensity change to change direction [int = Calculated(tc)]. The default value for this attribute is one (1).</p>|
|<p>step-size</p>|<p>optional</p>|<p>Will be used as the initial step size in both the up and down directions, unless the step-size-up or step-size-down is defined [double = Calculated(tc)]. Default value is 0.1.</p>|
|<p>step-size-up</p>|<p>optional</p>|<p>Will be used as the initial step size in the upward direction [double = Calculated(tc)]. If it is undefined, the step-size attribute will be used instead as the initial step size for the up direction.</p>|
|<p>step-size-down</p>|<p>optional</p>|<p>Will be used as the initial step size in the downward direction [double = Calculated(tc)]. If it is undefined, the step-size attribute will be used instead as the initial step size for the downward direction.</p>|
|<p>step-size-reduction</p>|<p>optional</p>|<p>Used to configure adaptive step sizes [ double = Calculated(tc) ]. The step size after a reversal will be <code>new-step-size</code> = (1 - <code>step-size-reduction</code>) * <code>old-step-size</code>. The default value is 0.5.</p>|
|<p>max-step-size-reduction</p>|<p>optional</p>|<p>The maximum by which step sizes will be reduced when adaptive step sizes are enabled by setting the <code>step-size-reduction</code> attribute to a non-zero value [ double = Calculated(tc) ].</p>|
|<p>step-size-type</p>|<p>optional</p>|<p>Type of step size: absolute, the step size is added or subtracted to the current intensity, or relative, the step size is relative to the current intensity.</p>|
|<p>stop-rule</p>|<p>optional</p>|<p>Number of reversals required before the algorithm is completed [ int = Calculated(tc) ].</p>|
|<p>skip-rule</p>|<p>optional</p>|<p>The number of initial reversals that are skipped when calculating the threshold as the average of the intensity at the reversals [ int = Calculated(tc) ]. Consequently, if this <code>skip-role</code> attribute is set to one (3) and the stop-rule is set to nine (9), the threshold will be calculated from the last six (6) reversals. The default value is zero (0).</p>|
|<p>start-intensity</p>|<p>required</p>|<p>Initial intensity for the algorithm [ double = Calculated(tc) ].</p>|
|<p>initial-direction</p>|<p>optional</p>|<p>Initial direction for the intensity change.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<quick>`](#LabBench.Psychophysics.PsychometricFunction)</p> | <p>optional</p> |<p>Psychometric function.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.Algorithms.DiscreteUpDownAlgorithm"></a>
### DiscreteUpDownAlgorithm

<p>The up/down method, also known as the staircase method, is an adaptive method that estimates a psychophysical threshold by increasing the intensity until the subject performs the response task correctly, then reversing the direction of intensity change and decreasing it until the subject fails to perform the response task correctly. This discrete version of the method <code>&lt;discrete-up-down-method&gt;</code> is different from the continuous version of the method  <code>&lt;up-down-method&gt;</code>  in that stimulus intensities can only take on values from a discrete set of values instead of from a continuum of values between the minimum and maximum intensity values.</p>
<p>This pattern of increasing/decreasing the intensity until the subject either succeeds or fails the response task is repeated a set number of times. When complete, the algorithm finds the threshold as the average intensity at which the intensity change reverses, from failing (increasing threshold) to succeeding (decreasing threshold). The algorithm can be configured to either initially increase or decrease the intensity with the <code>initial-direction</code> attribute.</p>
<p>The index of the currently selected intensity is available to calculated parameters as the <code>IntensityIndex</code> variable.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>stop-rule</p>|<p>required</p>|<p>Number of reversals required before the algorithm is completed [ int = Calculated(tc) ].</p>|
|<p>initial-intensity</p>|<p>required</p>|<p>This attribute is used to select the initial intensity from the set of allowed intensities ('intensities') [ double = Calculated(tc) ]. The initial intensity will be selected as the intensity in the set of allowed intensities closest to the value of this initial intensity attribute. If this attribute is not defined, the initial intensity will be set based on the initial direction. If the initial direction is upward, the smallest allowed intensity will be used; otherwise, the largest allowed intensity will be used.</p>|
|<p>intensities</p>|<p>required</p>|<p>The discrete set of allowed stimulus intensities in the form of an array of doubles [ double[] = Calculated(tc) ]. These values must be ordered from the smallest to the largest and must be within the bounds of the Imin and Imax attributes for the stimulus channel.</p>|
|<p>initial-direction</p>|<p>optional</p>|<p>Initial direction for the intensity change.</p>|
|<p>initial-step-size</p>|<p>optional</p>|<p>Sets the initial step size [ int = Calculated(tc) ]. The initial step size can be set to a value larger than one (1) to initially rapidly approach the threshold. Once a reversal has occurred, the step size will be set to one (1).</p>|
|<p>skip-rule</p>|<p>optional</p>|<p>The number of initial reversals that are skipped when calculating the threshold as the average of the intensity at the reversals [ int = Calculated(tc) ]. Consequently, if this <code>skip-role</code> attribute is set to one (3) and the stop-rule is set to nine (9), the threshold will be calculated from the last six (6) reversals. The default value is zero (0).</p>|


<a id="LabBench.Core.Tests.Psychophysics.ColdPresser.ColdPressorTest"></a>
### ColdPressorTest

<p>The Cold Pressor test is a standardized experimental pain paradigm in which a participant immerses a hand
or forearm in cold water to determine pain detection (PDT) and tolerance thresholds (PTT). The thresholds
are measured as the time to pain onset and the time to pain tolerance.</p>
<p>The test can be configured to measure PDT, PTT, or both. When a single threshold is measured, time
measurement is started with a button press when the hand is placed in the cold water and stopped with a
second button press when the hand is withdrawn from the water. When both thresholds are measured, the
second button press marks the PDT, and the third button press marks the PTT when the hand is withdrawn
from the water.</p>
<p>While the test is designed for the Cold Pressor test, it can be used for any task for which detection and
tolerance thresholds can be quantified by the time the participant experiences them. All instructions and
descriptive texts can be customized to adapt the test for other tasks.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>control</p>|<p>optional</p>|<p>Configuration of who marks the events with a press of a button: the operator or the participant.</p>|
|<p>measurement</p>|<p>required</p>|<p>This attribute controls how the test interprets button presses and can be used to determine the PDT, PTT,  or both:</p> <ul> <li><code>PDT</code>: Determination of a detection threshold.</li> <li><code>PTT</code>: Determination of a tolerance threshold.</li> <li><code>BOTH</code>: Determination of both a detection and tolerance threshold.</li> </ul> <p>For all measurements the first button press markes the start of the task.</p>|
|<p>time-limit</p>|<p>required</p>|<p>Time limit for the test in seconds [ double = Calculated(tc) ]. If the end event has been marked within this time limit, the test will end automatically, and the participant will be marked as a non-responder.</p>|
|<p>button</p>|<p>required</p>|<p>Configuration of the button used to mark events during the test.</p>|
|<p>ready-instruction</p>|<p>optional</p>|<p>Instructions to be used when the test is ready to run [ dynamic test ].</p> <p>The default text for this instruction is &quot;Test is ready to run&quot;.</p>|
|<p>completed-instruction</p>|<p>optional</p>|<p>The default text for this instruction is &quot;Test is completed&quot;.</p>|
|<p>pending-instruction</p>|<p>optional</p>|<p>Instructions to be used when the test is running and waiting for the first event to be marked [ dynamic text ]. For the cold-pressor test, the first event is when the participant's hand is placed in the water.</p> <p>The default text for this instruction is &quot;Press the button when the hand is placed in the water&quot;.</p>|
|<p>pain-instruction</p>|<p>optional</p>|<p>Instructions to be used when determining the pain detection threshold (PDT) [ dynamic text ]. This instruction applies to PDT and BOTH measurements.</p> <p>The default text for this instruction is &quot;Press the button when pain is felt&quot;.</p>|
|<p>completion-instruction</p>|<p>optional</p>|<p>Instructions to be used for the final event [ dynamic text ]. For the cold-pressor test, this event is the withdrawal of the hand from the water.</p> <p>The default text for this instruction is &quot;Press the button when the hand is withdrawn from the water&quot;.</p>|
|<p>pdt-label</p>|<p>optional</p>|<p>Label to be used for the PDT measurement [ dynamic text ]. The default value is cold pain detection threshold (CPD).</p>|
|<p>ptt-label</p>|<p>optional</p>|<p>Label to be used for the PTT measurement [ dynamic text ]. The default value is cold pain tolerance threshold (CPT)</p>|
|<p>non-responder-label</p>|<p>optional</p>|<p>Description of non-responders [ dynamic text ].</p>|
|<p>responder-label</p>|<p>optional</p>|<p>Description of responders [ dynamic text ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualThresholdEstimationTest"></a>
### ManualThresholdEstimationTest

<p>The manual threshold estimation test is used to estimate thresholds/psychometric functions when LabBench cannot control the stimulus, and instead, the experimenter must manually apply the stimulus to the subject. Estimation of these thresholds/psychometric functions consists of two parts: response task and estimation algorithm:</p>
<ul>
<li><strong>Response task</strong>: the perception task that the subject is asked to perform when the stimulus is presented. The outcome of this task is either correct: the subject perceived the stimulus correctly, or incorrect: the stimulus intensity was too low, and the subject failed to perceive the stimulus correctly.</li>
<li><strong>Estimation algorithm</strong>: the adaptive algorithm by which the threshold/psychometric function is estimated. This algorithm uses the outcome of the response task (correct/incorrect) to update the estimate of the threshold or psychometric function for each stimulus presentation.</li>
</ul>
<p>The stimulus is defined by the nature of the questions asked in the response task. The thresholds or psychometric functions are estimated for an independent variable (x). An increase in x is assumed to increase the probability that the subject will correctly perform the response task.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>stimulus-unit</p>|<p>required</p>|<p>Stimulus unit [ Text ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>[`<intensity-transformation>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.Transform)</p> | <p>optional</p> |<p>The test instructs the experimenter which stimulus intensity to apply to the subject for each iteration of the estimation.</p> <p>For specific mechanical stimulators, there can be an offset between the scale that the experimenter uses to set the stimulus intensity and the actual intensity given by the stimulator to the subject. For example, when a custom-made two-point discriminator is made from a caliper, there might be a constant offset between the distance indicated on the caliper scale and the distance between the tips of the custom-made prongs attached to the caliper.</p> <p>The intensity-transformation allows the intensity displayed to the experimenter to be linearly transformed before it is shown to the experimenter, meaning that the experimenter will not need to apply this transformation mentally while following the test's instructions.</p>|
| <p>[`<catch-trials>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualCatchTrials)</p> | <p>optional</p> |<p>A catch trial is a trial in which no stimulus or the equivalent of no stimulus is presented.It is included to estimate the participant's baseline tendency to respond positively without a stimulus.</p>|
| <p><span style="white-space: nowrap;">  [`<psi-algorithm>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.Algorithms.ManualPsiAlgorithm) </span><br /><span style="white-space: nowrap;">  [`<up-down-algorithm>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.Algorithms.ManualUpDownAlgorithm) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |
| <p><span style="white-space: nowrap;">  [`<yes-no-task>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ResponseTasks.ManualYesNoTask) </span><br /><span style="white-space: nowrap;">  [`<two-interval-forced-choice-task>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ResponseTasks.ManualTwoIntervalForcedChoiceTask) </span><br /><span style="white-space: nowrap;">  [`<one-interval-forced-choice-task>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ResponseTasks.ManualOneIntervalForcedChoiceTask) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualCatchTrials"></a>
### ManualCatchTrials

<p>A catch trial is a trial in which no stimulus or the equivalent of no stimulus is presented.It is included to estimate the participant's baseline tendency to respond positively without a stimulus.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>order</p>|<p>required</p>|<p>Randomization of the catch trial:</p> <ul> <li><strong>deterministic</strong>: Deterministic catch trials will occur with a fixed interval.</li> <li><strong>block-randomized</strong>: Block randomized will occur once within a block of interval number of stimuli.</li> <li><strong>randomized</strong>: Randomized catch trials will be generated with a probability of 1/interval.</li> </ul>|
|<p>interval</p>|<p>required</p>|<p>The interval, block-size, or probability with which the catch trial is generated [ int ].</p>|
|<p>image</p>|<p>optional</p>|<p>The image that is used to instruct the operator to perform a catch trial [ image = Calculated(tc) ]</p>|
|<p>instruction</p>|<p>optional</p>|<p>The instruction used to inform the operator to perform a catch trial [ DynamicText ]</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.Algorithms.ManualPsiAlgorithm"></a>
### ManualPsiAlgorithm

<p>The Psi Method, developed by <a href="https://www.sciencedirect.com/science/article/pii/S0042698998002855?via%3Dihub">Lenny Kontsevich and Christopher Tyler (1999)</a>, is a Bayesian adaptive psychometric procedure used to estimate perception thresholds and the shape of the psychometric function (like slope, lapse rate, etc.). It is more advanced than up/down staircases and offers greater efficiency and precision. The algorithm aims to estimate the full psychometric function for the perception of a stimulus instead of only determining a threshold. At each trial in the algorithm, a posterior probability distribution is maintained for the unknown parameters of the psychometric function (alpha, beta).</p>
<p>At each trial, the method will:</p>
<ol>
<li>The posterior probability distributions for correct and incorrect results are calculated based on Bayes's Theorem from the a priori probability distribution (the posterior probability distribution from the previous step in the algorithm).</li>
<li>Determine the optimal stimulus intensity that reveals the most information on the unknown parameters of the psychometric function. This optimal test intensity is determined by minimizing the entropy based on Shannon entropy (H) calculated from the posterior probability distributions that will result from both a correct and incorrect response.</li>
<li>The response task (Yes/No, One Interval Forced Choice, or Two Interval Forced Choice) tests the optimal stimulus intensity.</li>
<li>Depending on the participant's response to the response task, the posterior probability distribution for either the correct or incorrect response is selected as the a priori probability distribution for the next step in the algorithm.</li>
</ol>
<p>Consequently, the algorithm will iteratively update its information on the most probable psychometric function. The algorithm is set to perform a fixed set of steps; thus, the execution time is known and fixed, in contrast to the Up/Down algorithm, whose execution time depends on the participant's responses.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>intensities</p>|<p>required</p>|<p>Stimulation intensities [ double[] = Calculated(tc) ].</p>|
|<p>intensity-labels</p>|<p>optional</p>|<p>When specified, labels provided by this attribute will be displayed instead of intensities [ string[] = Calculated(tc) ]. The list of labels specified must have the same length as the list of intensities.</p>|
|<p>number-of-trials</p>|<p>required</p>|<p>Number of stimuli that will be presented to the subject [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<gumbel>`](#LabBench.Psychophysics.Function.Gumbel) </span><br /><span style="white-space: nowrap;">  [`<hyperbolic-secant>`](#LabBench.Psychophysics.Function.HyperbolicSecant) </span><br /><span style="white-space: nowrap;">  [`<logistics>`](#LabBench.Psychophysics.Function.Logistic) </span><br /><span style="white-space: nowrap;">  [`<log-quick>`](#LabBench.Psychophysics.Function.LogQuick) </span><br /><span style="white-space: nowrap;">  [`<normal>`](#LabBench.Psychophysics.Function.Normal) </span><br /><span style="white-space: nowrap;">  [`<quick>`](#LabBench.Psychophysics.Function.Quick) </span><br /><span style="white-space: nowrap;">  [`<weibull>`](#LabBench.Psychophysics.Function.Weibull) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |
| <p>[`<beta>`](#LabBench.Core.XmlTools.ArrayGenerator)</p> | <p>required</p> |<p>Range of beta parameters.</p>|
| <p>[`<alpha>`](#LabBench.Core.XmlTools.ArrayGenerator)</p> | <p>required</p> |<p>Range of alpha parameters.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.Algorithms.ManualUpDownAlgorithm"></a>
### ManualUpDownAlgorithm

<p>The up/down algorithm, also known as the staircase method, is an adaptive method for estimating psychophysical minimal intensity (threshold) at which a participant perceives a stimulus with 50% reliability. The algorithm adjusts the intensity based on the participant's response; if the response is correct, the intensity is decreased (the stimulus becomes harder to perceive); if it is incorrect, the intensity is increased (the stimulus becomes easier to perceive).</p>
<p>The algorithm will initially either increase (initial-direction=&quot;increasing&quot;) or decrease (initial-direction=&quot;decreasing&quot;) the intensity from the lowest or highest possible intensity, respectively. It will continue to do so until the subject answers correctly or incorrectly, depending on the direction of intensity change, after which the direction of intensity change is reversed. At each reversal, the intensity is stored, and the threshold is calculated as the average of these intensities where the direction of intensity change was reversed.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>intensities</p>|<p>required</p>|<p>Stimulation intensities [ double[] = Calculated(tc) ].</p>|
|<p>intensity-labels</p>|<p>optional</p>|<p>When specified, labels provided by this attribute will be displayed instead of intensities [ string[] = Calculated(tc) ]. The list of labels specified must have the same length as the list of intensities.</p>|
|<p>stop-rule</p>|<p>required</p>|<p>Number of intensity revarsel that must occur before the algorithm terminated [ int = Calculated(tc) ].</p>|
|<p>terminate-on-limit-reached</p>|<p>optional</p>|<p>[ DEPRECATED ]</p>|
|<p>initial-direction</p>|<p>optional</p>|<p>Initial direction of the intensity change [ increasing or decreasing ]. If not specified it is set to increasing.</p>|
|<p>initial-step-size</p>|<p>optional</p>|<p>Initial step size [ int = Calculated(tc) ]. Once a intensity reversal have occured the step size will be set to one (1).</p>|
|<p>skip-rule</p>|<p>optional</p>|<p>Number of initial intensity reversal that will be discarded in the threshold calculation [ int = Calculated(tc) ]. If not specified this attribute is set to zero.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ResponseTasks.ManualYesNoTask"></a>
### ManualYesNoTask

<p>A Yes/No response task can be performed when the stimulus can elicit a positive response (Yes) or negative response (No). It is performed by asking the subject a question. For example, for a two-point discrimination test, &quot;How many points did you feel touching the skin?&quot; to which the subject can answer either &quot;One&quot; or &quot;Two&quot;. In this example, if the subject answers Two, they correctly perceive the stimulus by answering positively.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>question</p>|<p>required</p>|<p>The question about the stimulus that the participants is required to answer [ DynamicText ].</p>|
|<p>task-illustration-image</p>|<p>required</p>|<p>The image that is used to illustrate the stimulation task for the operator [ image = Calculated(tc) ]</p>|
|<p>positive-answer</p>|<p>required</p>|<p>The expected answer for positive responses [ DynamicText ].</p>|
|<p>negative-answer</p>|<p>required</p>|<p>The expected answer for negative responses [ DynamicText ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ResponseTasks.ManualTwoIntervalForcedChoiceTask"></a>
### ManualTwoIntervalForcedChoiceTask

<p>In a two-interval forced-choice task, the stimulus is presented in one of two time intervals. The participant is then asked to answer in which time interval the stimulus was presented. If the intensity makes it possible for the participant to perceive the stimulus, they will choose the correct interval. However, if the intensity is too low to be perceived, the participant will be forced to answer and will thus have a 50% chance of answering correctly. Consequently, the two-interval forced choice task is usually used with the Psi-Method, which can estimate psychometric functions for which the guess rate (gamma) is 50%.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>question</p>|<p>required</p>|<p>The question about the stimulus that the participants is required to answer [ DynamicText ].</p>|
|<p>no-stimulus-image</p>|<p>required</p>|<p>Image used to illustrate an interval where no stimulus should be presented [ image = Calculated(tc) ].</p>|
|<p>stimulus-image</p>|<p>required</p>|<p>Image used to illustrate an interval where a stimulus should be presented [ image = Calculated(tc) ].</p>|
|<p>interval-a</p>|<p>required</p>|<p>Name of interval A [ DynamicText ].</p>|
|<p>interval-b</p>|<p>required</p>|<p>Name of interval B [ DynamicText ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ResponseTasks.ManualOneIntervalForcedChoiceTask"></a>
### ManualOneIntervalForcedChoiceTask

<p>In a one-interval forced-choice task, the participant is asked to choose between two alternatives based on the stimulus presented. If the intensity makes it possible for the participant to perceive the stimulus, they will choose the correct alternative. However, if the intensity is too low to be perceived, the participant will be forced to answer and will thus have a 50% chance of answering correctly. Consequently, the one-interval forced choice task is usually used with the Psi-Method, which can estimate psychometric functions for which the guess rate (gamma) is 50%.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>question</p>|<p>required</p>|<p>The question about the stimulus that the participants is required to answer [ DynamicText ].</p>|
|<p>alternative-a-image</p>|<p>required</p>|<p>Image used to demonstrate alternative A to the operator [ byte[] = Calculated(tc) ].</p>|
|<p>alternative-b-image</p>|<p>required</p>|<p>Image used to demonstrate alternative B to the operator [ byte[] = Calculated(tc) ].</p>|
|<p>alternative-a</p>|<p>required</p>|<p>Expected response when the participant can perceive alternative A [ DynamicText ].</p>|
|<p>alternative-b</p>|<p>required</p>|<p>Expected response when the participant can perceive alternative B [ DynamicText ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.ResponseRecordingTest"></a>
### ResponseRecordingTest

<p>The response recording test allows for the collection of psychophysiological ratings over a specified time period or until the experimenter indicates a particular event. During this process, ratings can be recorded while also capturing a set of signals and/or marking events with predefined markers.</p>
<p>To function, the test must be assigned a Scales instrument in the device-mapping element of the experimental setup. The number and types of psychophysical ratings that are collected by the test are defined by the psychophysical rating scales that are defined in the Scales instrument.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>duration</p>|<p>required</p>|<p>Sample duration for the response recoding [ double = Calculated(tc) ].</p>|
|<p>sample-rate</p>|<p>required</p>|<p>Sample rate for the response recording [ double = Calculated (tc) ]. This sample rate is used both for the psychophysical responses and the defined signals if any.</p>|
|<p>response-weight</p>|<p>optional</p>|<p>Weight given to the psychophysical ratings in the user interface [ int ]. Default value is 1.</p>|
|<p>signal-weight</p>|<p>optional</p>|<p>Weight given to the recorded signals in the user interface [ int ]. Default value is 0.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>[`<events-makers>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.EventMarkerCollection)</p> | <p>optional</p> |<p>Used to define the markers that an experimenter can use to mark events while the test is running. Events could be events such as a pain detection or a pain tolerance threshold. Events are organized into event groups, where only one event group can be active at any time. When the experimenter marks an event, then the marker can be configured to activate another event group. Consequently, this can be used to define the sequential logical flow of events, such as enforcing that a pain detection threshold is always before a pain tolerance threshold. When the test is started, the first defined event group will be active.</p>|
| <p>[`<signals>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.SignalGroupCollection)</p> | <p>optional</p> |<p>Defines the signals that will be sampled simultaneously with the collection of psychophysiological ratings and the script that will be called for each recording time to sample the signals.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.EventMarkerCollection"></a>
### EventMarkerCollection

<p>Used to define the markers that an experimenter can use to mark events while the test is running. Events could be events such as a pain detection or a pain tolerance threshold. Events are organized into event groups, where only one event group can be active at any time. When the experimenter marks an event, then the marker can be configured to activate another event group. Consequently, this can be used to define the sequential logical flow of events, such as enforcing that a pain detection threshold is always before a pain tolerance threshold. When the test is started, the first defined event group will be active.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<group>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.EventMarkerGroup) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.EventMarkerGroup"></a>
### EventMarkerGroup

<p>Defines a group of events that are active simultaneously.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Unique identifier for the event group [ Text ]. This identifier is used by event markers to identity the next active event group.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<marker>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.EventMarker) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.EventMarker"></a>
### EventMarker

<p>Defines a marker for an event.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Unique identifier for the event marker [ Text ].</p>|
|<p>name</p>|<p>optional</p>|<p>Name of the event [ Dynamic Text ]. If not specified the ID of the event will be used as its name.</p>|
|<p>complete</p>|<p>optional</p>|<p>Complete the test when the event is marked [ Boolean ]. Default value is false.</p>|
|<p>next-group</p>|<p>optional</p>|<p>Event group to activate when the event is marked [ Text ]. This must be an ID of an event group, if no next-group is specified the currently active event group will remain active.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.SignalGroupCollection"></a>
### SignalGroupCollection

<p>Defines the signals that will be sampled simultaneously with the collection of psychophysiological ratings and the script that will be called for each recording time to sample the signals.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>sample</p>|<p>required</p>|<p>This attribute specifies the script that will be used to sample the signals [ [double] = Calculated(tc) ]. The script must return a list of the same length as the number of defined signals and in the same order.</p>|
|<p>min</p>|<p>required</p>|<p>Global minimum value for the sampled signals [ double = Calculated(tc) ].</p>|
|<p>max</p>|<p>required</p>|<p>Global maximum value for the sampled signals [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<signal>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.SignalDeclaration) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.SignalDeclaration"></a>
### SignalDeclaration

<p>Definition of a signal that will be sampled in the sample script that is defined as an attribute on the <code>&lt;signals&gt;</code> element. This sample script must return a list of values with the same length as the number of signals defined in the signals element.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the signal [ Text ]. This identifier must be unique for all the defined signals.</p>|
|<p>name</p>|<p>optional</p>|<p>Name for the signal [ Dynamic Text ]. If no name is provided the ID of the signal will be used as its name.</p>|
|<p>type</p>|<p>optional</p>|<p>Type of signal that is sampled.</p>|
|<p>unit</p>|<p>optional</p>|<p>Unit of signal that is sampled [ Text ].</p>|


<a id="LabBench.Core.Tests.Psychophysics.StimulusPresentation.StimulusPresentationTest"></a>
### StimulusPresentationTest

<p>The Stimulus Presentation test allows a participant to become familiar with a stimulus and to
rate its sensation on a psychophysical rating scale.</p>
<p>The test can also be used to manually find thresholds, as the last tested intensity is available
in the calculated parameter <code>[TestID].Intensity</code> upon completion.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>stimulus-update-rate</p>|<p>required</p>|<p>The update rate for the generated stimuli [ int = Calculated(tc) ]. This update rate must be supported by the device that will deliver the stimuli.</p>|
|<p>trigger-update-rate</p>|<p>optional</p>|<p>The update rate for the generated triggers [ int = Calculated(tc) ]. This update rate must be supported by the device that will deliver the stimuli, and if it is unspecified, the stimulus update rate will be used as the update rate for the trigger generation.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>[`<configuration>`](#LabBench.Core.Components.ComponentConfiguration)</p> | <p>optional</p> |<p>Configuration of test components, which includes configuration of the stimulation, trigger, and sampling components that are used by the test.</p>|
| <p>[`<intensity>`](#LabBench.Core.XmlTools.ArrayGenerator)</p> | <p>required</p> |<p>Specification of the intensities for the stimuli that the experimenter can choose during a session.</p>|
| <p>[`<responses>`](#LabBench.Core.Components.ResponseEngine)</p> | <p>optional</p> |<p>This element defines the <strong>response engine</strong> used by a test to collect behavioral or rating-based responses from the subject.</p> <p>The response engine supports multiple response modalities, including:</p> <ul> <li>Binary responses (yes/no, button presses)</li> <li>Numerical ratings (interval scales)</li> <li>Ratio ratings (continuous scales)</li> <li>Categorical ratings (ordinal scales)</li> </ul> <p>If no response collection mode is specified, the response engine is disabled and no response device is required for the test.</p>|
| <p>[`<triggers>`](#LabBench.Core.Components.TriggerEngine)</p> | <p>optional</p> |<p>Trigger generation.</p>|
| <p>[`<stimulation>`](#LabBench.Core.Components.StimulationEngine)</p> | <p>optional</p> |<p>Stimulation configuration that can either be delivered with a Stimulator instrument, or with any combination of instruments when the `<scripts>´ element is defined.</p>|


<a id="LabBench.Core.Components.ResponseEngine"></a>
### ResponseEngine

<p>This element defines the <strong>response engine</strong> used by a test to collect behavioral or rating-based responses from the subject.</p>
<p>The response engine supports multiple response modalities, including:</p>
<ul>
<li>Binary responses (yes/no, button presses)</li>
<li>Numerical ratings (interval scales)</li>
<li>Ratio ratings (continuous scales)</li>
<li>Categorical ratings (ordinal scales)</li>
</ul>
<p>If no response collection mode is specified, the response engine is disabled and no response device is required for the test.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>response-collection</p>|<p>optional</p>|<p>Type of response collection that will be performed:</p> <ul> <li><code>none</code>: <strong>no responses are collected</strong> for this test.</li> <li><code>yes-no</code>: <strong>binary response collection</strong> using a button device. An <code>Button</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>ratio-rating</code>: <strong>continuous ratio-scale rating</strong> using a ratio scale device. An <code>RatioScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>numerical-rating</code>: <strong>numerical rating collection</strong> using an interval scale device. An <code>IntervalScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>categorical-rating</code>: <strong>categorical response collection</strong> using an ordinal scale device. An <code>OrdinalScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> </ul>|


<a id="LabBench.Core.Components.TriggerEngine"></a>
### TriggerEngine

<p>Trigger generation.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>start-triggger</p>|<p>optional</p>|<p>Timing or trigger source:</p> <ul> <li><code>none</code>: no source is configured.</li> <li><code>internal</code>: the source is an internal opration such as start of a stimulus.</li> <li><code>external</code>: a trigger event is received from external equipment.</li> <li><code>button</code>: a trigger event is received from a button press on a connected response device attached to any response port.</li> <li><code>response-port01</code>: a trigger is received on response port 1.</li> <li><code>response-port02</code>: a trigger is received on response port 2.</li> <li><code>response-port03</code>: a trigger is received on response port 3.</li> <li><code>response-port04</code>: a trigger is received on response port 4.</li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<trigger>`](#LabBench.Core.Components.Triggering.TriggerSpecification) </span><br /><span style="white-space: nowrap;">  [`<repeated-trigger>`](#LabBench.Core.Components.Triggering.RepeatedTriggerSequence) </span><br /><span style="white-space: nowrap;">  [`<combined-triggers>`](#LabBench.Core.Components.Triggering.CombinedTriggerSequence) </span></p> | <p>1</p> | <p>This definition requires that exactly one item be provided and that it be chosen from a fixed set of mutually exclusive alternatives. Only one alternative may appear, and all other alternatives must be absent. No alternative is mandatory on its own, but the choice as a whole is required, meaning the container is invalid unless exactly one of the allowed options is specified.</p> |


<a id="LabBench.Core.Components.StimulationEngine"></a>
### StimulationEngine

<p>Stimulation configuration that can either be delivered with a Stimulator instrument, or with
any combination of instruments when the `<scripts>´ element is defined.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>start-trigger</p>|<p>optional</p>|<p>Timing or trigger source:</p> <ul> <li><code>none</code>: no source is configured.</li> <li><code>internal</code>: the source is an internal opration such as start of a stimulus.</li> <li><code>external</code>: a trigger event is received from external equipment.</li> <li><code>button</code>: a trigger event is received from a button press on a connected response device attached to any response port.</li> <li><code>response-port01</code>: a trigger is received on response port 1.</li> <li><code>response-port02</code>: a trigger is received on response port 2.</li> <li><code>response-port03</code>: a trigger is received on response port 3.</li> <li><code>response-port04</code>: a trigger is received on response port 4.</li> </ul>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<scripts>`](#LabBench.Core.Components.Stimulation.ScriptedStimulation)</p> | <p>optional</p> |<p>Custom stimulation where the stimulation is implemented with calculated parameters that can either be a single-line Python statement or, more commonly, by calling a Python function in a script.</p>|
| <p>[`<stimulus>`](#LabBench.Core.Components.Stimulation.StimulusDefinition)</p> | <p>optional</p> |<p>Definition of a stimulus.</p>|


<a id="LabBench.Core.Tests.Thermal.RatedStimulation.ThermalRatedStimulationTest"></a>
### ThermalRatedStimulationTest

<p>The Thermal Rated Stimulation test allows a thermal stimulus to be delivered to a
participant while simultaneously recording the participant's psychophysical rating
of the sensation.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>response-collection</p>|<p>optional</p>|<p>Type of response collection that will be performed:</p> <ul> <li><code>none</code>: <strong>no responses are collected</strong> for this test.</li> <li><code>yes-no</code>: <strong>binary response collection</strong> using a button device. An <code>Button</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>ratio-rating</code>: <strong>continuous ratio-scale rating</strong> using a ratio scale device. An <code>RatioScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>numerical-rating</code>: <strong>numerical rating collection</strong> using an interval scale device. An <code>IntervalScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> <li><code>categorical-rating</code>: <strong>categorical response collection</strong> using an ordinal scale device. An <code>OrdinalScale</code> instrument will need to be assigned to the test with a <code>&lt;device-assignment&gt;</code>.</li> </ul>|
|<p>sample-times</p>|<p>optional</p>|<p>Must return a list of the times the participant's response should be sampled [ double[] = Calculated(tc) ]. This attribute is only used if the <code>response-collection</code> is not set to <code>none</code>.</p>|
|<p>intensity</p>|<p>required</p>|<p>Intensity (<code>x</code>) that will be passed to the stimulus defined by the <code>&lt;stimulus&gt;</code> element [ double = Calculated(tc) ].</p>|
|<p>minimal-display-temperature</p>|<p>optional</p>|<p>Used for displaying the thermal stimulus; it is the lower bound for the stimulation temperature [ double = Calculated(tc) ].</p>|
|<p>maximal-display-temperature</p>|<p>optional</p>|<p>Used for displaying the thermal stimulus; it is the upper bound for the stimulation temperature [ double = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|
| <p>[`<stimulus>`](#LabBench.Core.Components.Stimulation.StimulusDefinition)</p> | <p>optional</p> |<p>Definition of a stimulus.</p>|


<a id="LabBench.Core.Tests.Thermal.ThresholdEstimation.ThermalThresholdEstimationTest"></a>
### ThermalThresholdEstimationTest

<p>The Thermal Threshold Estimation Test determines cold and heat thresholds by decreasing/increasing the temperature until the participants press a button. The temperature at the time of the button press is taken as the temperature threshold.</p>
<p>This procedure can be repeated a set number of times, and the threshold is taken as an average of the repeated threshold measurements.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identifier for the test that must be unique within the protocol, and which must be a valid variable name.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the test that is shown to the operator in LabBench Runner.</p>|
|<p>session</p>|<p>optional</p>|<p>ID of the session that the test belongs to. This parameter must only be used if sessions are defined for the protocol. If sessions are defined then the operator will choose the active session when the protocol is initialized by LabBench Runner. LabBench Runner will then only show tests belonging to the current active session.</p>|
|<p>experimental-setup-id</p>|<p>optional</p>|<p>ID of the experimental setup configuration that will be selected when the test is performed.</p>|
|<p>threshold-type</p>|<p>required</p>|<p>Configuration of the thermal threshold to be determined.</p>|
|<p>stimulation-rate</p>|<p>required</p>|<p>The rate of temperature change for the determination of thresholds [ double = Calculated(tc) ].</p>|
|<p>maximal-temperature</p>|<p>required</p>|<p>Maximal temperature for the thermal stimulus [ double = Calculated(tc) ].</p> <p>Please note that this temperature is higher than the <code>neutral-temperature</code> for heat thresholds and lower for cold thresholds. This temperature must be within the output temperature range (<code>minimal-temperature</code> to <code>maximal-temperature</code>) of the Thermal Stimulator assigned to the test.</p>|
|<p>return-rate</p>|<p>optional</p>|<p>Rate by which the temperature is returned to the neutral temperature once the threshold has been reached [ double = Calculated(tc) ].</p>|
|<p>initial-stimulation-delay</p>|<p>required</p>|<p>Delay from start of the test in seconds to the start of the first threshold determination [ double = Calculated(tc) ].</p>|
|<p>stimulation-interval</p>|<p>required</p>|<p>Interval between threshold determinations in seconds [ double = Calculated(tc) ].</p>|
|<p>repetitions</p>|<p>required</p>|<p>Number of times the threshold is determined [ int = Calculated(tc) ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<test-events>`](#LabBench.Core.Tests.TestEvents)</p> | <p>optional</p> |<p>Defines the instruments involved in a test and specifies events that occur at the selection, start, completion, or abortion of the test.</p> <p>This element makes it possible to inject python code into a test that extends the base functionality that is provided by its LabBench implementation.</p>|
| <p>[`<properties>`](#LabBench.Core.Tests.TestProperties)</p> | <p>optional</p> |<p>Test properties can modify the selection and execution of tests, data collection, and provide instructions to the operator and participants.</p>|
| <p>`<dependencies>`</p> | <p>optional</p> |<p> The `<dependencies>` is an array element that can contain a sequence of elements. These  elements can be of the following types: <br /> <ul> <li><span style="white-space: nowrap;"> <a href="#LabBench.Core.Tests.TestDependency"><code>&lt;dependency&gt;</code></a> </span></li> </ul> </p>|
| <p>[`<condition>`](#LabBench.Core.Tests.Condition)</p> | <p>optional</p> |<p>Place a condition on the inclusion of the test into a session.</p>|


<a id="LabBench.Core.Tests.Meta.Survey.SurveyConstructor"></a>
### SurveyConstructor

<p>The questionnaire test allows either the operator or the participant to answer a set of questions.
The questionnaire can consist of the following types of questions:</p>
<ul>
<li><strong>Boolean Questions</strong>: questions that have mutually exclusive binary answer, which usually consists
of answering a true or false statement, but can also consist of dichotomies such as child/adult.</li>
<li><strong>Numerical Questions</strong>: are questions that can be answered with numerical answers.</li>
<li><strong>Text Questions</strong>: are questions that can be answered with either free or validated text.</li>
<li><strong>Likert Questions</strong>: A scale that captures how strongly someone agrees, disagrees, or feels about a
statement using a fixed set of ordered response options.</li>
<li><strong>List Questions</strong>: A set of binary statements that each can be either true or false.</li>
<li><strong>Time Questions</strong>: a date and time provided by the participant, entered by the operator.</li>
<li><strong>Map Questions</strong>: is answered by marking one or more regions, such as areas on a body map.</li>
<li><strong>Categorical Rating Questions</strong>: rating of a sensation on a categorical scale.</li>
<li><strong>Numerical Rating Questions</strong>: rating of a sensation on a numerical scale.</li>
<li><strong>Visual Rating Questions</strong>: rating of a sensation on a visual analog rating scale.</li>
</ul>
<p>All questions are identified with an id and have a title and an instruction. If the questionnaire is to be
answered by the participant, a <code>Questionnaire</code> instrument must be assigned to the test in the experimental setup.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.EvokedPotentialsTestConstructor"></a>
### EvokedPotentialsTestConstructor

<p>The <code>&lt;stimulation-sequence&gt;</code> test generates stimulus sequences for evoked potentials, behavioral tasks,
or similar procedures. Construct the sequence by creating a stimulus pattern to control timing and a
stimulus set to define which stimuli are delivered.</p>
<p>The stimulation pattern <code>&lt;stimulation-pattern&gt;</code>is constructed from a composition of sequences, which
can be deterministic or random. However, to use this test, the stimulation pattern (number of stimuli
and randomization) is generated when the test starts. Consequently, it is not possible to change the
stimulation pattern while the test is running, so it cannot depend on participant performance during
the test. Use the <code>&lt;sequential&gt;</code> test if the stimulation pattern depends on the participant, as that
test is more versatile but also more complex to implement than this stimulation sequence test.</p>
<p>The stimulation pattern is first generated, yielding a set of temporal stimulation slots that can be
filled with stimuli; which stimuli are inserted into these stimulation slots is defined by the stimulus
set <code>&lt;stimuli&gt;</code>. The stimuli set defines a set of stimuli and controls their randomization. To fill
the stimulation pattern, a batch of stimuli is first generated by the stimulus set. This batch of
stimuli is inserted into the stimulation slots until all have been allocated, then a new batch is
generated. This process is repeated until all stimulation slots have been allocated a stimulus.</p>
<p>The test delivers stimuli via the stimulation component, which, by default, uses the Stimulator
and TriggerGenerator instruments to deliver stimuli and triggers, respectively. If more complex
or multimodal stimuli are required, a <code>&lt;stimulation-scripts&gt;</code> can be defined to generate the
stimuli/triggers from a Python script. When generations are done from a Python script, any visual,
auditory, or physical stimulus, and combinations thereof that are possible with LabBench can be generated.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Meta.Sequential.SequentialTestConstructor"></a>
### SequentialTestConstructor

<p>The sequential test makes it possible to use state machines to implement experimental procedures. Unlike most other tests, it has no base functionality that can be configured in the LabBench Language; instead, its functionality must be implemented by a Python script that is called from its test events and state events.</p>
<p>In most cases, you will have access to instruments from the Python script to implement the intended experimental procedure. This access is provided by declaring the instruments in the <code>&lt;test-events&gt;</code> element. The instruments declared that they will be available for both the test events and state events.</p>
<p>The states in the state machine are defined in the <code>&lt;states&gt;</code> element, which also makes it possible to define which Python functions are called for the <code>enter</code>, <code>leave</code>, and <code>update</code> state events.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Algometry.StimulusResponse.AlgometryStimulusResponseTestConstructor"></a>
### AlgometryStimulusResponseTestConstructor

<p>Stimulus-response tests determine the psychophysical rating (VAS Rating) to a linearly increasing pressure stimulus.
From this stimulus-response curve, several psychophysical parameters can be determined:</p>
<ol>
<li>PDT: The Pain Detection Threshold,</li>
<li>PTL: The Pain Tolerance Limit, and</li>
<li>PTT: The Pain Tolerance Threshold (PTT).</li>
</ol>
<p>The determined parameters depend on the test configuration and the subject's instructions.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Algometry.ConditionedPain.AlgometryConditionedPainTestConstructor"></a>
### AlgometryConditionedPainTestConstructor

<p>With the conditioned pain modulation test, one cuff applies static pressure while the other determines a stimulus-response curve. The stimulus-response curve determines the psychophysical rating (VAS Rating) to a linearly increasing pressure stimulus.</p>
<p>From this stimulus-response curve, several psychophysical parameters can be determined:</p>
<ul>
<li>Pain Detection Threshold (PDT),</li>
<li>Pain Tolerance Limit (PTL),</li>
<li>Pain Tolerance Threshold (PTT).</li>
</ul>
<p>The determined parameters depend on the test configuration and the subject's instructions.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Algometry.TemporalSummation.AlgometryTemporalSummationTestConstructor"></a>
### AlgometryTemporalSummationTestConstructor

<p>The temporal summation test applies a series of rectangular pressure stimuli to one or both cuffs. The subject is asked to rate the pain sensation of these stimuli on the VAS meter as soon as possible after
the cessation of a pressure stimulus. The VAS rating for a stimulus is recorded just before the next stimulus is given or would have been given if it had not been the last stimulus in the series.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Algometry.StaticTemporalSummation.AlgometryStaticTemporalSummationTestConstructor"></a>
### AlgometryStaticTemporalSummationTestConstructor

<p>The static temporal summation applies a constant pressure for a specified duration instead of a series of stimuli to determine the temporal summation of pressure stimulation.</p>
<p>During this pressure stimulation and for a period after the test, the subject's VAS score will be recorded as the result of the test.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Algometry.StimulusRating.AlgometryStimulusRatingTestConstructor"></a>
### AlgometryStimulusRatingTestConstructor

<p>The stimulus rating test provides a way to determine the Pain Detection Threshold (PDT), the Pain Tolerance Threshold (PTT), or both with an attached button.</p>
<p>The test is executed in the same way as the stimulus-response test and is defined by the same parameters, with the exception that it does not have a stop-mode parameter but instead has a measurement parameter.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Algometry.ConditionedPainRating.AlgometryConditionedPainRatingTestConstructor"></a>
### AlgometryConditionedPainRatingTestConstructor

<p>The conditioned pain modulation rating test is analogous to the conditioned pain modulation test that uses a button instead of the VAS to determine pain detection threshold (PDT), pain tolerance threshold (PTT), or both.</p>
<p>The same parameters define the test as the conditioned pain modulation test, with the addition of the measurement parameter that defines how the button is used to determine PDT, PTT, or both.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.AlgometryArbitraryTemporalSummationTestConstructor"></a>
### AlgometryArbitraryTemporalSummationTestConstructor

<p>The arbitrary temporal summation test applies a series of rectangular pressure stimuli to one or both cuffs.</p>
<p>The subject is asked to rate the pain sensation of these stimuli on the VAS meter as soon as possible after the cessation of a pressure stimulus.</p>
<p>The VAS rating for a stimulus is recorded just before the next stimulus is given or would have been given if it had not been the last stimulus in the series. The arbitrary temporal summation test makes it possible to specify each stimulus in the series individually, and thus, each stimulus can have a different intensity and duration.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ThresholdEstimationTestConstructor"></a>
### ThresholdEstimationTestConstructor

<p>The threshold estimation test is used to estimate thresholds/psychometric functions when LabBench controls the stimulus generation automatically. Estimation of these thresholds/psychometric functions consists of three parts: the stimulus modality, response task, and estimation algorithm:</p>
<ul>
<li><strong>Stimulus modality</strong>: the type of stimulus, such as tactile, thermal, pressure, or electrical, presented to the subject and for which a threshold/psychometric function is estimated.</li>
<li><strong>Response task</strong>: the perception task that the subject is asked to perform when the stimulus is presented. The outcome of this task is either true: the subject performed the task correctly, or false: the the subject failed to perform the task correctly.</li>
<li><strong>Estimation algorithm</strong>: the adaptive algorithm by which the threshold/psychometric function is estimated. This algorithm uses the outcome of the response task (correct/incorrect) to update the estimate of the threshold or psychometric function for each stimulus presentation.</li>
</ul>
<p>The thresholds or psychometric functions are estimated for an independent variable (x). An increase in x is assumed to increase the probability that the subject will correctly perform the response task. If there is an inverted relationship, the independent variable (x) inversion must be performed in the stimulus specification.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ColdPresser.ColdPressorTestConstructor"></a>
### ColdPressorTestConstructor

<p>The Cold Pressor test is a standardized experimental pain paradigm in which a participant immerses a hand
or forearm in cold water to determine pain detection (PDT) and tolerance thresholds (PTT). The thresholds
are measured as the time to pain onset and the time to pain tolerance.</p>
<p>The test can be configured to measure PDT, PTT, or both. When a single threshold is measured, time
measurement is started with a button press when the hand is placed in the cold water and stopped with a
second button press when the hand is withdrawn from the water. When both thresholds are measured, the
second button press marks the PDT, and the third button press marks the PTT when the hand is withdrawn
from the water.</p>
<p>While the test is designed for the Cold Pressor test, it can be used for any task for which detection and
tolerance thresholds can be quantified by the time the participant experiences them. All instructions and
descriptive texts can be customized to adapt the test for other tasks.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualThresholdEstimationTestConstructor"></a>
### ManualThresholdEstimationTestConstructor

<p>The manual threshold estimation test is used to estimate thresholds/psychometric functions when LabBench cannot control the stimulus, and instead, the experimenter must manually apply the stimulus to the subject. Estimation of these thresholds/psychometric functions consists of two parts: response task and estimation algorithm:</p>
<ul>
<li><strong>Response task</strong>: the perception task that the subject is asked to perform when the stimulus is presented. The outcome of this task is either correct: the subject perceived the stimulus correctly, or incorrect: the stimulus intensity was too low, and the subject failed to perceive the stimulus correctly.</li>
<li><strong>Estimation algorithm</strong>: the adaptive algorithm by which the threshold/psychometric function is estimated. This algorithm uses the outcome of the response task (correct/incorrect) to update the estimate of the threshold or psychometric function for each stimulus presentation.</li>
</ul>
<p>The stimulus is defined by the nature of the questions asked in the response task. The thresholds or psychometric functions are estimated for an independent variable (x). An increase in x is assumed to increase the probability that the subject will correctly perform the response task.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Psychophysics.ResponseRecording.ResponseRecordingTestConstructor"></a>
### ResponseRecordingTestConstructor

<p>The response recording test allows for the collection of psychophysiological ratings over a specified time period or until the experimenter indicates a particular event. During this process, ratings can be recorded while also capturing a set of signals and/or marking events with predefined markers.</p>
<p>To function, the test must be assigned a Scales instrument in the device-mapping element of the experimental setup. The number and types of psychophysical ratings that are collected by the test are defined by the psychophysical rating scales that are defined in the Scales instrument.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Psychophysics.StimulusPresentation.StimulusPresentationTestConstructor"></a>
### StimulusPresentationTestConstructor

<p>The Stimulus Presentation test allows a participant to become familiar with a stimulus and to
rate its sensation on a psychophysical rating scale.</p>
<p>The test can also be used to manually find thresholds, as the last tested intensity is available
in the calculated parameter <code>[TestID].Intensity</code> upon completion.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Thermal.RatedStimulation.ThermalRatedStimulationTestConstructor"></a>
### ThermalRatedStimulationTestConstructor

<p>The Thermal Rated Stimulation test allows a thermal stimulus to be delivered to a
participant while simultaneously recording the participant's psychophysical rating
of the sensation.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.Thermal.ThresholdEstimation.ThermalThresholdEstimationTestConstructor"></a>
### ThermalThresholdEstimationTestConstructor

<p>The Thermal Threshold Estimation Test determines cold and heat thresholds by decreasing/increasing the temperature until the participants press a button. The temperature at the time of the button press is taken as the temperature threshold.</p>
<p>This procedure can be repeated a set number of times, and the threshold is taken as an average of the repeated threshold measurements.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Identification of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>name</p>|<p>required</p>|<p>Name of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>session</p>|<p>optional</p>|<p>Session of the constructed test [ string ]. This can be a <code>var:</code> expression that constructs the ID from a formatted string with template variables.</p>|
|<p>template</p>|<p>required</p>|<p>Identifier (<code>id</code>) of the template to be used for constructing the test [ string ].</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<variables>`](#LabBench.Core.Templating.VariableCollection)</p> | <p>optional</p> |<p>Definition of template variables. Template variables can be used to construct templates into protocol elements, such as tests, and lists of template variables can be iterated over in <code>foreach</code> statements to programmatically generate multiple protocol elements.</p>|


<a id="LabBench.Core.Tests.ForeachConstructor"></a>
### ForeachConstructor

<p>Loop through each element in a list template variable and generate tests for each element in this list.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>variable</p>|<p>required</p>|<p>Name of the variable used to hold the elements in the foreach loop [ Text ].</p>|
|<p>in</p>|<p>required</p>|<p>Name of the list variable whose elements the foreach will loop through. This list variable must be defined in the variables element of the protocols templates element [ Text ].</p>|
|<p>type</p>|<p>optional</p>|<p>The type of randomization performed on the generated tests:</p> <ul> <li><strong>deterministic</strong>: no randomization is performed. The tests will appear in the protocol in the same order as generated by the foreach loop.</li> <li><strong>random</strong>: the order of the tests will be completely randomized.</li> <li><strong>latin-squares</strong>: the order of the tests will be based on a row of a N x N Latin-square, where N is the number of tests generated by the foreach loop.</li> <li><strong>generated</strong>: the tests will be ordered by a sequence generated by a Python expression or Python backing script specified by the offset attribute.</li> </ul>|
|<p>offset</p>|<p>optional</p>|<p>This attribute is only used for Latin squares [ int = Calculated(tc) ]. It is the offset/number of the row in the Latin square. If the offset is larger than the square, then the offset will be the modules with the square's size. Typically, these offsets are calculated from the <strong>SubjectNumber</strong> variable, which is the number of the subject in the data set. Basing the offset on the <strong>SubjectNumber</strong> makes it possible to shift the latin-square row for each subject participating in the experiment.</p>|
|<p>generator</p>|<p>optional</p>|<p>This attribute is only used for generated randomizations [ int[] = Calculated(tc) ]. It must return an int array of length N, where N is the number of tests to be randomized.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<questionnaire-constructor>`](#LabBench.Core.Tests.Meta.Survey.SurveyConstructor) </span><br /><span style="white-space: nowrap;">  [`<sequential-constructor>`](#LabBench.Core.Tests.Meta.Sequential.SequentialTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-stimulus-response-constructor>`](#LabBench.Core.Tests.Algometry.StimulusResponse.AlgometryStimulusResponseTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-conditioned-pain-modulation-constructor>`](#LabBench.Core.Tests.Algometry.ConditionedPain.AlgometryConditionedPainTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-temporal-summation-constructor>`](#LabBench.Core.Tests.Algometry.TemporalSummation.AlgometryTemporalSummationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-static-temporal-summation-constructor>`](#LabBench.Core.Tests.Algometry.StaticTemporalSummation.AlgometryStaticTemporalSummationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-stimulus-rating-constructor>`](#LabBench.Core.Tests.Algometry.StimulusRating.AlgometryStimulusRatingTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-conditioned-pain-modulation-rating-constructor>`](#LabBench.Core.Tests.Algometry.ConditionedPainRating.AlgometryConditionedPainRatingTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-arbitrary-temporal-summation-constructor>`](#LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.AlgometryArbitraryTemporalSummationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-threshold-estimation-constructor>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ThresholdEstimationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-cold-pressor-constructor>`](#LabBench.Core.Tests.Psychophysics.ColdPresser.ColdPressorTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-manual-threshold-estimation-constructor>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualThresholdEstimationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-response-recording-constructor>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.ResponseRecordingTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-stimulus-presentation-constructor>`](#LabBench.Core.Tests.Psychophysics.StimulusPresentation.StimulusPresentationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<stimulation-sequence-constructor>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.EvokedPotentialsTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<thermal-rated-stimulation-constructor>`](#LabBench.Core.Tests.Thermal.RatedStimulation.ThermalRatedStimulationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<thermal-threshold-estimation-constructor>`](#LabBench.Core.Tests.Thermal.ThresholdEstimation.ThermalThresholdEstimationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<foreach>`](#LabBench.Core.Tests.ForeachConstructor) </span><br /><span style="white-space: nowrap;">  [`<sequence>`](#LabBench.Core.Tests.SequenceConstructor) </span><br /><span style="white-space: nowrap;">  [`<if>`](#LabBench.Core.Tests.IfConstructor) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.SequenceConstructor"></a>
### SequenceConstructor

<p>A sequence performs randomization of the elements within the sequence.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>type</p>|<p>required</p>|<p>The type of randomization performed on the generated tests:</p> <ul> <li><strong>deterministic</strong>: no randomization is performed. The tests will appear in the protocol in the same order as generated by the foreach loop.</li> <li><strong>random</strong>: the order of the tests will be completely randomized.</li> <li><strong>latin-squares</strong>: the order of the tests will be based on a row of a N x N Latin-square, where N is the number of tests generated by the foreach loop.</li> <li><strong>generated</strong>: the tests will be ordered by a sequence generated by a Python expression or Python backing script specified by the offset attribute.</li> </ul>|
|<p>offset</p>|<p>optional</p>|<p>This attribute is only used for Latin squares [ int = Calculated(tc) ]. It is the offset/number of the row in the Latin square. If the offset is larger than the square, then the offset will be the modules with the square's size. Typically, these offsets are calculated from the <strong>SubjectNumber</strong> variable, which is the number of the subject in the data set. Basing the offset on the <strong>SubjectNumber</strong> makes it possible to shift the latin-square row for each subject participating in the experiment.</p>|
|<p>generator</p>|<p>optional</p>|<p>This attribute is only used for generated randomizations [ int[] = Calculated(tc) ]. It must return an int array of length N, where N is the number of tests to be randomized.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<questionnaire-constructor>`](#LabBench.Core.Tests.Meta.Survey.SurveyConstructor) </span><br /><span style="white-space: nowrap;">  [`<sequential-contructor>`](#LabBench.Core.Tests.Meta.Sequential.SequentialTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-stimulus-response-constructor>`](#LabBench.Core.Tests.Algometry.StimulusResponse.AlgometryStimulusResponseTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-conditioned-pain-modulation-constructor>`](#LabBench.Core.Tests.Algometry.ConditionedPain.AlgometryConditionedPainTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-temporal-summation-constructor>`](#LabBench.Core.Tests.Algometry.TemporalSummation.AlgometryTemporalSummationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-static-temporal-summation-constructor>`](#LabBench.Core.Tests.Algometry.StaticTemporalSummation.AlgometryStaticTemporalSummationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-stimulus-rating-constructor>`](#LabBench.Core.Tests.Algometry.StimulusRating.AlgometryStimulusRatingTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-conditioned-pain-modulation-rating-constructor>`](#LabBench.Core.Tests.Algometry.ConditionedPainRating.AlgometryConditionedPainRatingTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-arbitrary-temporal-summation-constructor>`](#LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.AlgometryArbitraryTemporalSummationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-threshold-estimation-constructor>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ThresholdEstimationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-cold-pressor-constructor>`](#LabBench.Core.Tests.Psychophysics.ColdPresser.ColdPressorTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-manual-threshold-estimation-constructor>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualThresholdEstimationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-response-recording-constructor>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.ResponseRecordingTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-stimulus-presentation-constructor>`](#LabBench.Core.Tests.Psychophysics.StimulusPresentation.StimulusPresentationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<stimulation-sequence-constructor>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.EvokedPotentialsTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<thermal-rated-stimulation-constructor>`](#LabBench.Core.Tests.Thermal.RatedStimulation.ThermalRatedStimulationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<thermal-threshold-estimation-constructor>`](#LabBench.Core.Tests.Thermal.ThresholdEstimation.ThermalThresholdEstimationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<foreach>`](#LabBench.Core.Tests.ForeachConstructor) </span><br /><span style="white-space: nowrap;">  [`<sequence>`](#LabBench.Core.Tests.SequenceConstructor) </span><br /><span style="white-space: nowrap;">  [`<if>`](#LabBench.Core.Tests.IfConstructor) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Tests.IfConstructor"></a>
### IfConstructor

<p>Enable conditional generation of tests from test constructors.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>condition</p>|<p>required</p>|<p>Condition for generating tests [ bool = Calculated(tc) ]. The enclosed test constructors are only executed if the condition is true.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<questionnaire-constructor>`](#LabBench.Core.Tests.Meta.Survey.SurveyConstructor) </span><br /><span style="white-space: nowrap;">  [`<sequential-constructor>`](#LabBench.Core.Tests.Meta.Sequential.SequentialTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-stimulus-response-constructor>`](#LabBench.Core.Tests.Algometry.StimulusResponse.AlgometryStimulusResponseTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-conditioned-pain-modulation-constructor>`](#LabBench.Core.Tests.Algometry.ConditionedPain.AlgometryConditionedPainTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-temporal-summation-constructor>`](#LabBench.Core.Tests.Algometry.TemporalSummation.AlgometryTemporalSummationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-static-temporal-summation-constructor>`](#LabBench.Core.Tests.Algometry.StaticTemporalSummation.AlgometryStaticTemporalSummationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-stimulus-rating-constructor>`](#LabBench.Core.Tests.Algometry.StimulusRating.AlgometryStimulusRatingTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-conditioned-pain-modulation-rating-constructor>`](#LabBench.Core.Tests.Algometry.ConditionedPainRating.AlgometryConditionedPainRatingTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<algometry-arbitrary-temporal-summation-constructor>`](#LabBench.Core.Tests.Algometry.ArbitraryTemporalSummation.AlgometryArbitraryTemporalSummationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-threshold-estimation-constructor>`](#LabBench.Core.Tests.Psychophysics.ThresholdEstimation.ThresholdEstimationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-cold-pressor-constructor>`](#LabBench.Core.Tests.Psychophysics.ColdPresser.ColdPressorTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-manual-threshold-estimation-constructor>`](#LabBench.Core.Tests.Psychophysics.ManualThresholdEstimation.ManualThresholdEstimationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-response-recording-constructor>`](#LabBench.Core.Tests.Psychophysics.ResponseRecording.ResponseRecordingTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<psychophysics-stimulus-presentation-constructor>`](#LabBench.Core.Tests.Psychophysics.StimulusPresentation.StimulusPresentationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<stimulation-sequence-constructor>`](#LabBench.Core.Tests.ElectroPhysiology.EvokedPotentials.EvokedPotentialsTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<thermal-rated-stimulation-constructor>`](#LabBench.Core.Tests.Thermal.RatedStimulation.ThermalRatedStimulationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<thermal-threshold-estimation-constructor>`](#LabBench.Core.Tests.Thermal.ThresholdEstimation.ThermalThresholdEstimationTestConstructor) </span><br /><span style="white-space: nowrap;">  [`<foreach>`](#LabBench.Core.Tests.ForeachConstructor) </span><br /><span style="white-space: nowrap;">  [`<sequence>`](#LabBench.Core.Tests.SequenceConstructor) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Assets.AssetManager"></a>
### AssetManager

<p>Files can be included in experiments in the form of assets within the <code>&lt;assets&gt;</code> element in the Experiment Definition File. This element consists of a set of <code>&lt;file-asset&gt;</code> that can be used in tests and Python code.</p>
<p>The following assets can be included:</p>
<ul>
<li><strong>.py</strong>: Python code</li>
<li><strong>.md</strong>: Markdown Files</li>
<li><strong>.txt</strong>: Text Files</li>
<li><strong>.rtf</strong>: Rich Text Format</li>
<li><strong>.png</strong>: Portable Network Graphics</li>
<li><strong>.zip</strong>: Zip files</li>
<li><strong>.json</strong>: Data files</li>
<li><strong>.wav</strong>: Sound files</li>
<li><strong>.csv</strong>: Comma Separated Values</li>
<li><strong>.svg</strong>: Scalable Vector Graphics</li>
<li><strong>.ttf</strong>: True Type Fonts</li>
</ul>
<p>Within calculated parameters, assets can be referred to by the <code>id</code> with the following notation: <code>Asset.[AssetID]</code>. Files within zip archives can be further addressed as <code>Asset.[AssetID].[Name of file without extension]</code>. Please note that paths and extensions within zip files are not considered. Consequently, in a zip file, there must be only one file with a given name, regardless of its extension or location within the zip file.</p>

#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<file-asset>`](#LabBench.Core.Assets.Asset) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Assets.Asset"></a>
### Asset

<p>File that is included in the Experiment Definition File and which can be referred to by its <code>id</code>.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>optional</p>|<p>Identification of the file asset [ string ]. If this attribute is not set, the <code>id</code> will be its file name, excluding its extension.</p>|
|<p>file</p>|<p>required</p>|<p>File to include [ string ]. If the <code>id</code> is not set, the <code>id</code> will be its file name, excluding its extension.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<language>`](#LabBench.Core.Assets.AssetLocalized) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Assets.AssetLocalized"></a>
### AssetLocalized

<p>Files can be localized, meaning that if multiple languages are defined in the <code>&lt;languages&gt;</code> element
in the protocol, different files can be used depending on the selected language when a session starts.</p>
<p>When an asset is loaded, it first checks whether there is a localized file for the active language code.
If a localized file is found, then that file will be used instead of the file specified by the <code>file</code>
attribute on the <code>&lt;file-asset&gt;</code> element.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>code</p>|<p>required</p>|<p>This attribute is the language code (ISO 639) for which the asset is localized [ string ].</p>|
|<p>file</p>|<p>required</p>|<p>File to use for the localization [ string ].</p>|


<a id="LabBench.Core.Actions.CSVAction"></a>
### CSVAction

<p>Export of data to csv files.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name of the post-session action that will be used to identify the action in LabBench [ string ].</p>|
|<p>location</p>|<p>required</p>|<p>Location in the file system where the outputs of the post-session action will be saved [ string ].</p>|
|<p>filename</p>|<p>required</p>|<p>Name of the file [ string = Calculated(tc) ].</p>|
|<p>header</p>|<p>optional</p>|<p>Include header in the file [ bool ].</p>|
|<p>separator</p>|<p>optional</p>|<p>Separator to use for the csv file [ string ].</p>|
|<p>culture</p>|<p>optional</p>|<p>Culture strings follow the format: languagecode2-regioncode2. For example:</p> <ul> <li><strong>en-US</strong>: represents English (United States).</li> <li><strong>fr-FR</strong>: represents French (France).</li> <li><strong>zh-Hans</strong>: represents Simplified Chinese.</li> </ul> <p>The languagecode2 is based on <a href="https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes">ISO 639-1</a>, while regioncode2 is based on <a href="https://en.wikipedia.org/wiki/ISO_3166-1">ISO 3166-1</a>. Use of regioncode2 is optional. The default value is &quot;en&quot;.</p>|


#### Elements

| Name | Use | Description |
|:-----|:---:|:------------|
| <p><span style="white-space: nowrap;">  [`<item>`](#LabBench.Core.Actions.CSVElement) </span></p> | <p><span style="white-space: nowrap;"> 0 .. n </span></p> | <p>This definition describes a container that can hold an ordered list of zero or more items, where each item represents exactly one choice from a fixed set of allowed alternatives. Each item in the list is optional and independent, and the list itself has no upper limit on the number of items it may contain. For each position in the list, only one of the permitted alternatives may be present, and no other kinds of items are allowed. The container may also be empty, meaning none of the alternatives are specified.</p> |


<a id="LabBench.Core.Actions.CSVElement"></a>
### CSVElement

<p>Elements for the CSV file.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name of the variable [ string ].</p>|
|<p>value</p>|<p>required</p>|<p>Value for the element [ object = Calculated(tc) ].</p>|
|<p>default</p>|<p>optional</p>|<p>Value that will be inserted if the value calculation throws an error or if the element has been excluded with by its <code>condition</code> attribute [ string ].</p>|
|<p>condition</p>|<p>optional</p>|<p>Calculate the value or exclude this element [ bool = Calculated(tc) ]. This attribute makes it possible to exclude calculation of the value when tests are not completed.</p>|


<a id="LabBench.Core.Actions.ExportAction"></a>
### ExportAction

<p>Export of data to a single data file. Consequently, this post-session action enables the
creation of a single data file for each subject participating in a study.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name of the post-session action that will be used to identify the action in LabBench [ string ].</p>|
|<p>location</p>|<p>required</p>|<p>Location in the file system where the outputs of the post-session action will be saved [ string ].</p>|
|<p>filename</p>|<p>required</p>|<p>Name of the file [ string = Calculated(tc) ].</p>|
|<p>format</p>|<p>optional</p>|<p>Specifies the format of the exported data:</p> <ul> <li><code>json</code>: Javescript Object Notation</li> <li><code>hdf5</code>: Hierarchical Data Format version 5</li> <li><code>matlab</code>: Matlab File Format (Level 5)</li> </ul>|


<a id="LabBench.Core.Actions.ScriptAction"></a>
### ScriptAction

<p>Execution of a calculated parameter as a post-session action. As calculated parameters
can execute Python functions with the `func: [Python Script Asset].<a href="tc">Function Name</a>
allows you to use this post-session action to implement custom post-session actions.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name of the post-session action that will be used to identify the action in LabBench [ string ].</p>|
|<p>location</p>|<p>required</p>|<p>Location in the file system where the outputs of the post-session action will be saved [ string ].</p>|
|<p>script</p>|<p>required</p>|<p>Calculated parameter to execute as a post-session action [ bool = Calculated(tc) ]. Must return true if it completed successfully, otherwise false.</p>|


<a id="LabBench.Core.Actions.LogAction"></a>
### LogAction

<p>Export of the experimental log for a subject to a pdf file.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name of the post-session action that will be used to identify the action in LabBench [ string ].</p>|
|<p>location</p>|<p>required</p>|<p>Location in the file system where the outputs of the post-session action will be saved [ string ].</p>|
|<p>filename</p>|<p>required</p>|<p>Name of the file [ string = Calculated(tc) ].</p>|
|<p>level</p>|<p>optional</p>|<p>Setting the log level, all log entries lower than this log level will be discarded.</p>|
|<p>id</p>|<p>optional</p>|<p>Identifier that will be embedded in the header of all pages of the generated experimental log [ dynamic text ].</p>|


<a id="LabBench.Core.Actions.CopyAction"></a>
### CopyAction

<p>Copy a file from one directory (<code>source</code>) to another directory (<code>location</code>). The filename cannot be changed.</p>

#### Attributes

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>name</p>|<p>required</p>|<p>Name of the post-session action that will be used to identify the action in LabBench [ string ].</p>|
|<p>location</p>|<p>required</p>|<p>Location in the file system where the outputs of the post-session action will be saved [ string ].</p>|
|<p>source</p>|<p>required</p>|<p>Source directory for the file to be copied [ string ].</p>|
|<p>filename</p>|<p>required</p>|<p>Name of the file [ string = Calculated(tc) ].</p>|


## Statistics
* Number of elements: 658
* Number of documented elements: 658
* Number of undocumented elements: 0


## Undocumented elements

None

