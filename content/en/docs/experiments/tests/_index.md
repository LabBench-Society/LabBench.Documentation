---
title: Tests
description: Tests are the main building blocks of a protocol, which specifies the experimental procedures to be performed in a study.
weight: 30
---

{{% pageinfo %}}

LabBench tests are the basic building blocks of a protocol, where each test implements a specific type of experimental procedure that can be configured with parameters and extended by Python scripts. These tests are the central elements of the Experiment Definition File, which describes the experimental procedure that will be performed in the experiment. These procedures are written in the `<tests>` element of the Experiment Definition File, and in the LabBench Language, experimental procedures are referred to as tests. 

{{% /pageinfo %}}


Definition of tests consists of elements and attributes common to all tests regardless of their type and elements and attributes specific to the type of test being specified. The attributes and elements common for all tests are shown in the code listing below:

```xml
<test-type id="[Required: Identifier of the test]"
           name="[Required: Human understandable name of the test]"
           session="[Optional: ID of the session the test belongs to]"
           experimental-setup-id="[Optional: Experiment Setup Configuration Identifier]">
    <test-events> <!-- Contents omitted for brevity --> </test-events>        
    <properties> <!-- Contents omitted for brevity --> </properties>
    <dependencies> <!-- Contents omitted for brevity --> </dependencies>
    <condition> <!-- Contents omitted for brevity --> </condition>

    <!-- Additional test-specific elements -->
</test-type>
```

Tests have four common attributes:

| Attribute               | Type   | Function                                                                                        |
|-------------------------|--------|-------------------------------------------------------------------------------------------------|
| `id`                    | string | This required attribute is identifier (ID) of the test in the protocol. This ID must be unique. |
| `name`                  | string | This required attribute is the name of the test, which is the name that will be shown to the experimenter in the protocol window of the LabBench Runner program. |
| `session`               | string | This optional attribute specifies which session the test belong to. If specified the test will only be shown in the protocol window if the active session is equeal to the session specified by this attribute. |
| `experimental-setup-id` | string | This optional attribute sets which experimental setup device configuration that will be active while the test is running. |

## Dependencies

The `<dependencies>` element is used to prevent tests from running if the test depends on results from tests that have not yet been completed. 

## Exclusions

The second common element is the `<condition>` element. This element place a condition on the inclusion of a test experimental sessions, and thus makes it possible to excludes tests from a protocol if they cannot be performed. 

## Test events

The `<test-events>` element is used to specify Python scripts that are executed when tests are selected, started, completed, or aborted. This can be used to extend tests with functionality outside the scope of what the test was originally designed for. To illustrate their use, an example where the base functionality of a `<stimulation-sequence>` test is extended with test events is provided in the code listing below:

```xml
<stimulation-sequence ID="Cond"
                      name="Conditioning"
                      stimulus-update-rate="20000"
                      response-collection="none">
    <test-events start="func: Functions.Condition(tc)"
                 abort="func: Functions.Stop(tc)"
                 complete="func: Functions.Stop(tc)">
        <instrument interface="pressure-algometer" />
    </test-events>
    
    <stimulation-pattern time-base="seconds">
        <uniformly-distributed-sequence iterations="12"
                                        Toffset="5"
                                        minTperiod="10"
                                        maxTperiod="15" />
    </stimulation-pattern>
    
    <stimuli order="round-robin">
        <stimulus name="Stimulus"
                  count="1"
                  intensity="StimIntensity.Intensity">
            <!-- Stimulus specification omitted for brevity -->
        </stimulus>
    </stimuli>
</stimulation-sequence>
```

The `<stimulation-sequence>` test is intended to generate evoked potentials by presenting a set of stimuli to the subject according to a given stimulation pattern. The test is intended to work only with short electrical, auditory, visual, or tactile stimuli suitable for generating an evoked potential, which can be used, for example, EEG experiments with the oddball paradigm, electrically evoked potentials, etc. 

One research group wanted to study how electrically evoked potentials are modulated by a conditioning pressure pain stimulus, which the built-in functionality of the  `<stimulation-sequence>` test cannot do. The built-in functionality does have any mechanism that provides a way to apply a stimulus for the entire test duration, as it is only intended for short stimuli that are applied according to a stimulation pattern. 

In their study, they wanted to use a LabBench CPAR+ device to apply a conditioning pain stimulus while electrically evoked potentials were generated with a DS7 stimulator. This was made possible with a test event that ran a script starting the conditioning stimulus when the test was started and stopping it when the test was stopped or aborted. The `<test-event>` has three attributes `start`, `abort`, `complete` that is executed when the test is started, aborted, and completed, respectively. 

These attributes can contain either a single-line Python statement or reference a function in a Python script. Starting and stopping the pressure stimuli is too complicated to achieve in a single Python code line. Instead, a Python function was called to start and stop the stimulation. Using Python functions, and scripting in general, is first discussed in the section “Scripting”; however, for completeness, the code for these functions is provided in code listing below:

```python
def Condition(tc):
    dev = tc.Instruments.Algometer
    chan = dev.Channels[0]

    chan.SetStimulus(1, chan.CreateWaveform()
                            .Step(0.70 * tc.SR.PTT, 9.9 * 60))
    dev.ConfigurePressureOutput(0, dev.ChannelIDs.CH01)
    dev.ConfigurePressureOutput(1, dev.ChannelIDs.NoChannel)
    dev.StartStimulation(dev.StopCriterions.WhenButtonPressed, True)

    tc.Log.Information("Starting conditioning: {intensity}", 0.70 * tc.SR.PTT)
    return True

def Stop(tc):
    tc.Instruments.Algometer.StopStimulation()
    return True    
```

In the section “Scripting”, we will introduce in detail how Python is used for scripting protocols and to extend the functionality of LabBench. Consequently, if you have never programmed in Python, the code in the listing above may be new to you. 

The example in the code listing above defines (“`def`”) two functions, `Condition(tc)` and `Stop(tc)`, that is intended to start and stop the pressure stimulus, respectively. What causes these functions to be called from the `<test-event>` is that, for example, the `start` attribute contains `func: Functions.Condition(tc)`. The `func:` statement is a keyword that tells LabBench that a Python function must be called, which in this case is the `Condition(tc)` function located in the `Functions` script.

In this case, the test event is used to condition/modulate evoked potentials. However, as test events are common to all tests, this test event could be inserted into any other LabBench test. 

For example, if we wanted to see how a simultaneous painful stimulus influences the responses to the DASS scale, it could be inserted into the `<questionnaire>` test. Furthermore, test events do not need to be used to apply a stimulus to a subject. If we need general code to run when a test starts, we can run it in the `start` test event. 

The `start`test event could be used, for example, to initialize a random sequence of visual stimuli or similar, or if we want to add custom information to the log system, custom data to the data set, then that can also be accomplished with test events. 

## Properties

The `<properties>` element is an optional element that can be used for modifying the execution of tests. The code listing below provides an overview of all possible test properties and their attributes:

```xml
<properties>
    <next id="[Required: dynamic text]"/>
    <auto-start value="[Required: true or false]" />
    <extended-data-collection value="[Required: true or false]"/>
    <time-constraint [ attributes omitted for brevity ] />
    <instructions [ attributes omitted for brevity ]/>
    <subject-instructions [ attributes omitted for brevity ] />
    <annotations> <!-- Contents omitted for brevity --> </annotations>
</properties>    
```
### Selecting the next test in the protocol (`<next>`)

The `<next>` element is included to support the logical flow of the protocol when tests have been excluded. By default, when a test is completed, LabBench will select the next test in the protocol unless the `<next>` element is used for the completed test. 

If the `<next>` element is used, its value must be the ID of the next test to select when the test is completed and because this property can be scripted, it is possible to select this ID at runtime depending on the previous results in the protocol. 

Consequently, if the results of, for example, a `<questionnaire>` test have caused a test to be excluded, then the `<next>` element can be used to select the correct next test in the protocol instead of the test that has been excluded.

### Auto start (`<auto-start>`)

The `<auto-start>` property can be used to chain tests. LabBench will automatically select the test in the protocol when a test is completed. Setting the value attribute to `true` on the `<auto-start>` attribute will cause the test to start automatically when it is selected after the previous test has been completed. 

Combined with the `<next>` property, this can be used to create protocols that run automatically from their beginning to their end.

### Extended data collection

The effect of the `<extended-data-collection>` property depends on the type of test. Certain tests support an extended collection of data that will be enabled if this property is true.

### Instructions to the experienter 

All tests support displaying information to the researcher when they are selected and not running. The `<instructions>` element is used to enable the showing of instructions to the researcher. If used, the `default-instruction` attribute is mandatory and must provide the ID of the information file to display to the researcher. This instruction file is used if the test is blocked due to an unsatisfied dependency, has been excluded, or if the instructions attribute is not specified. If the `instruction` attribute is specified, then the information file specified by this attribute will be used when the test can run. The difference between the `default-instruction` and `instruction` attribute is that the latter can be scripted, while the former cannot. 

In our protocol, we could use the `instruction` attribute to select different instructions to present to the experimenter depending on whether the subject is right or left-handed. The \verb|override-results| attribute controls whether the results of a test or its instructions will be shown when the test is completed. By default, selecting a completed test will display its results; however, this behaviour can be overridden by the \verb|override-results| attribute to true, which will always display instructions when the test has been completed. The \verb|start-instruction| property can be used to modify the instruction given to the researcher when a test is selected and can start. By default, LabBench will display “Test is ready to start” when a test can be started, but if the \verb|start-instruction| attribute is used, then this can be used to display a custom message. As this attribute can be scripted, this message can also depend on previous results recorded in the protocol. 

### Instrucitions to the participants


### Test annotations

The \verb|<annotation>| property does not influence how a test is executed. Instead, it can add information to the test that will be exported with the results. This can be used, for example, if a strength-duration curve is determined to specify the duration of the stimuli used in the test. Adding numbers, Boolean values, text strings, and a list of numbers as annotations to a test is possible. Listing~\ref{lst:annotations} provides an example of all possible test annotations.

```xml
<annotations>
    <number name="ChargeBalRatio"
            value="4"/>
    <bool name="ChargeBalanced"
          value="true"/>
    <string name="string" value="This is the value of the text string"/>
    <numbers name="Ts">
        <number value="0.1"/>
        <number value="0.2"/>
        <number value="0.5"/>
        <number value="1.0"/>
    </numbers>
</annotations>    
```

Annotations can also be added programmatically to test results from a function defined in a Python script. This can be used to add data from, for example, the start test event.

## Test components

### Stimulation

### Trigger generation

### Psychophysical responses

