---
title: Conditioned Pain Modulation Rating
description: Determination of pain detection and/or tolerance thresholds to linearly increasing pressure conditioned by a second static pressure. Participants indicate the thresholds through button presses.
weight: 7
---

{{% pageinfo %}}
The conditioned pain modulation rating procedure is analogous to the conditioned pain modulation procedure that uses a button instead of the VAS to determine pain detection threshold (PDT), pain tolerance threshold (PTT), or both.

The same parameters define the procedure as the conditioned pain modulation procedure, with the addition of the measurement parameter that defines how the button is used to determine PDT, PTT, or both.
{{% /pageinfo %}}

The procedure window for the `<algometry-conditioned-pain-modulation-rating>` procedure is shown in Figure 1. The procedure window consists of two areas: applied pressure and recorded responses. 

![](/images/Experitments_Procedures_Algometry/Slide9.PNG)

*Figure 1: Procedure window of the temporal summation procedure*

The applied pressure area will display a legend indicating which cuff outlet(s) will be active and will plot the applied pressure over time. 

**Please see [Algometry](docs/experiments/procedures/algometry/) page for an introduction to the cuff pressure procedures and concepts that are common for these procedures before reading the rest of this procedure documentation.**

## Procedure definition

A conditioned pain modulation rating procedure can be defined with the `<algometry-conditioned-pain-modulation-rating>` element within the `<procedures>` element in the Experiment Definition File (*.expx):

```xml
<algometry-conditioned-pain-modulation-rating id="rCPMPDT" 
    name="CPM (PDT) [Cuff 1]"
    experimental-setup-id="vas"
    conditioning-time="0"
    delta-conditional-pressure="10"
    conditional-pressure="0.7 * rSR02BOTH.PTT"
    delta-pressure="1"
    pressure-limit="100"
    primary-cuff="2"
    measurement="pdt">
    <dependencies>
        <dependency id="rSR02BOTH"/>
    </dependencies>
</algometry-conditioned-pain-modulation-rating>
```

*Listing 1: Definition of a conditioned pain modulation rating procedure*

Listing 1 has the following procedure specific attributes:

| Attribute         | Type                    | Specification |
|-------------------|-------------------------|---------------|
| `delta-pressure`    | double=Calculated(tc)   | This attribute is the rate of increase [kPa/s] of the applied pressure.  |
| `pressure-limit`    | double=Calculated(tc)   | This attribute is the maximum pressure the device will deliver before it aborts the test [ double = Calculated(tc) ]. The maximal pressure for the device is 100kPa. |
| `conditioning-time` | double=Calculated(tc)   | This attribute is the time from the test's start until the pressure starts to increase linearly. |
| `delta-conditional-pressure` | double=Calculated(tc) | The rate of increase [kPa/s] of the applied conditioning pressure. A value of zero means the application of the conditioning pressure will be instantaneous. |
| `conditional-pressure` | double=Calculated(tc) | The pressure that will be applied with the conditioning cuff. |
| `primary-cuff`      | int=Calculated(tc) | Determines which cuff (1 or 2) will be used for the pressure stimulation.|
| `second-cuff`       | bool | Inflate the second cuff together with the primary cuff. |
| `measurement`         | enum | Determine the Pain Detection Threshold (PDT), Pain Tolerance Threshold (PTT), or both. If the PDT or PTT is to be determined, the participant must press the button when the threshold is reached. If both the PDT and PTT are to be determined, the participant must press the button when the PDT is reached and release it when the PTT is reached. |


## Scripting (Properties)

In addition to the properties that are common to all procedure results, the conditioned pain modulation rating procedure result has the following procedure specific properties:

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
| `ConditioningPressure`       | `List<double>` | Conditioning pressure during the procedure. |
| `Time`                      | `List<double>` | Time of the values in the `StimulationPressure` and `ConditioningPressure` data points. |


## Scripting (Methods)

## Example protocols

* <a href="https://github.com/LabBench-Society/Protocols/blob/main/intro.cpar/intro.cpar.expx" target="_blank" rel="noopener noreferrer">Introduction to Cuff Pressure Algometry</a>.
