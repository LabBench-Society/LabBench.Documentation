---
title: Stimulus Rating
description: Determination of pain detection and/or tolerance thresholds to linearly increasing pressure. Participants indicate the thresholds through button presses.
weight: 6
---

{{% pageinfo %}}
The stimulus rating procedure provides a way to determine the Pain Detection Threshold (PDT), the Pain Tolerance Threshold (PTT), or both with an attached button.

The procedure is executed in the same way as the stimulus-response procedure and is defined by the same parameters, with the exception that it does not have a stop-mode parameter but instead has a measurement parameter.
{{% /pageinfo %}}

The procedure window for the `<algometry-stimulus-rating>` procedure is shown in Figure 1. The procedure window consists of two areas: applied pressure and recorded responses. 

![](/images/Experitments_Procedures_Algometry/Slide8.PNG)

*Figure 1: Procedure window of the temporal summation procedure*

The applied pressure area will display a legend indicating which cuff outlet(s) will be active and will plot the applied pressure over time. 

**Please see [Algometry](docs/experiments/procedures/algometry/) page for an introduction to the cuff pressure procedures and concepts that are common for these procedures before reading the rest of this procedure documentation.**

## Procedure definition

A stimulus rating procedure can be defined with the `<algometry-stimulus-rating>` element within the `<procedures>` element in the Experiment Definition File (*.expx):

```xml
<algometry-stimulus-rating id="rSR01PDT" 
    name="Stimulus Rating (PTD) [Cuff 1]"
    experimental-setup-id="vas"
    delta-pressure="1"
    pressure-limit="100"
    second-cuff="false"
    primary-cuff="1"
    measurement="pdt"
    conditioning-time="0"/>
```

*Listing 1: Definition of a temporal summation procedure*

Listing 1 has the following test specific attributes:

| Attribute         | Type                    | Specification |
|-------------------|-------------------------|---------------|
| `delta-pressure`    | double=Calculated(tc)   | This attribute is the rate of increase [kPa/s] of the applied pressure.  |
| `pressure-limit`    | double=Calculated(tc)   | This attribute is the maximum pressure the device will deliver before it aborts the test [ double = Calculated(tc) ]. The maximal pressure for the device is 100kPa. |
| `conditioning-time` | double=Calculated(tc)   | This attribute is the time from the test's start until the pressure starts to increase linearly. |
| `primary-cuff`      | int=Calculated(tc) | Determines which cuff (1 or 2) will be used for the pressure stimulation.|
| `second-cuff`       | bool | Inflate the second cuff together with the primary cuff. |
| `measurement`         | enum | Determine the Pain Detection Threshold (PDT), Pain Tolerance Threshold (PTT), or both. If the PDT or PTT is to be determined, the participant must press the button when the threshold is reached. If both the PDT and PTT are to be determined, the participant must press the button when the PDT is reached and release it when the PTT is reached. |

## Scripting (Properties)

In addition to the properties that are common to all test results, the test result for the stimulus response test has the following test specific properties:

| Name                        | Type           | Specification |
|-----------------------------|----------------|---------------|
| `Responder`                 | `bool`         | Did the procedure complete according to its `measurement` attribute. |
| `PDT`                       | `double`       | Pain Detection Threshold. |
| `PTT`                       | `double`       | Pain Tolerance Threshold. |
| `SecondCuff`                | `bool`         | Was the second cuff inflated in parallel with the first cuffs (spatial summation). |
| `PrimaryChannel`            | `int`          | What was the primary cuff channel. Please note this is only relevant if `second-cuff` is False. |
| `VASPainDetectionThreshold` | `double`       | Rating threshold for the pain detection threshold. |
| `MaximalPressure`           | `double`       | Maximal allowed pressure during the procedure. |
| `MaximalTime`               | `double`       | Maximal time of the procedure. Please note this will be longer than the actual running time if the participant was a responder. |
| `Pressure`       | `List<double>` | Stimulation pressure during the procedure. |
| `Time`                      | `List<double>` | Time of the values in the `StimulationPressure` and `VAS` data points. |

## Example protocols

* <a href="https://github.com/LabBench-Society/Protocols/blob/main/intro.cpar/intro.cpar.expx" target="_blank" rel="noopener noreferrer">Introduction to Cuff Pressure Algometry</a>.
