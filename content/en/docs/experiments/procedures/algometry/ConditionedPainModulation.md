---
title: Conditioned Pain Modulation
description: Psychophysical rating of linearly increasing pressure that is being conditioned by a second continuous pressure stimulus until the pain tolerance threshold or limit is reached. This test can be used to determine pressure pain detection and tolerance thresholds.
weight: 5
---

{{% pageinfo %}}
With the conditioned pain modulation procedure, one cuff applies static pressure while the other determines a stimulus-response curve. The stimulus-response curve determines the psychophysical rating (VAS Rating) to a linearly increasing pressure stimulus. 

From this stimulus-response curve, several psychophysical parameters can be determined: 
- Pain Detection Threshold (PDT), 
- Pain Tolerance Limit (PTL), 
- Pain Tolerance Threshold (PTT). 

The determined parameters depend on the procedure configuration and the participant's instructions.              
{{% /pageinfo %}}

The procedure window for the `<algometry-conditioned-pain-modulation>` procedure is shown in Figure 1. The procedure window consists of two areas: applied pressure and recorded responses. 

![](/images/Experitments_Procedures_Algometry/Slide4.PNG)

*Figure 1: Procedure window of the temporal summation procedure*

The applied pressure area will display a legend indicating which cuff outlet(s) will be active and will plot the applied pressure over time. The pressure is annotated with the Pain Detection Threshold (PDT) and Pain Tolerance Threshold (PTT) if determined by the test.

**Please see [Algometry](docs/experiments/procedures/algometry/) page for an introduction to the cuff pressure procedures and concepts that are common for these procedures before reading the rest of this procedure documentation.**

## Procedure definition

A conditioned pain modulation procedure can be defined with the `<algometry-conditioned-pain-modulation>` element within the `<procedures>` element in the Experiment Definition File (*.expx):

```xml
<algometry-conditioned-pain-modulation id="AP2CPM" 
    name="CPM Test (Stop on VAS 10)"
    experimental-setup-id="vas"
    conditioning-time="0"
    delta-conditional-pressure="10"
    conditional-pressure="0.7 * AP2SR02.PTT"
    delta-pressure="1"
    pressure-limit="100"
    primary-cuff="1"
    stop-mode="stop-on-maximal-rating"
    vas-pdt="0.1">
    <dependencies>
        <dependency id="AP2SR02"/>
    </dependencies>
</algometry-conditioned-pain-modulation>
```

*Listing 1: Definition of a conditioned pain modulation procedure*

Listing 1 has the following procedure specific attributes:

| Attribute         | Type                    | Specification |
|-------------------|-------------------------|---------------|
| `delta-pressure`    | double=Calculated(tc)   | This attribute is the rate of increase [kPa/s] of the applied pressure.  |
| `pressure-limit`    | double=Calculated(tc)   | This attribute is the maximum pressure the device will deliver before it aborts the test [ double = Calculated(tc) ]. The maximal pressure for the device is 100kPa. |
| `conditioning-time` | double=Calculated(tc)   | This attribute is the time from the test's start until the pressure starts to increase linearly. Ths include the time it takes for the conditioning pressure to increase from zero to `conditional-pressure`.|
| `delta-conditional-pressure` | double=Calculated(tc) | The rate of increase [kPa/s] of the applied conditioning pressure. A value of zero means the application of the conditioning pressure will be instantaneous. |
| `conditional-pressure` |double=Calculated(tc) | The pressure that will be applied with the conditioning cuff. |
| `primary-cuff`      | int=Calculated(tc) | Determines which cuff (1 or 2) will be used for the pressure stimulation.|
| `second-cuff`       | bool | Inflate the second cuff together with the primary cuff. |
| `stop-mode`         | enum | Stop mode for the test (`stop-on-maximal-rating` or `stop-when-button-pressed`).  |
| `vas-pdt`           | double=Calculated(tc)   | The VAS score is interpreted as the Pain Detection Threshold (PDT). It can be set to higher than 0.1cm to allow for non-painful stimulations to be rated by the subject. |

## Scripting (Properties)

In addition to the properties that are common to all test results, the test result for the stimulus response test has the following test specific properties:

| Name                        | Type           | Specification |
|-----------------------------|----------------|---------------|
| `Responder`                 | `bool`         | Did the procedure complete according to its `stop-mode` (`stop-on-maximal-rating` or `stop-when-button-pressed`) [ True ] or did it complete because the maximal pressure was reached [ False ]. |
| `PDT`                       | `double`       | Pain Detection Threshold. |
| `PTT`                       | `double`       | Pain Tolerance Threshold. |
| `PTL`                       | `double`       | Pain Tolerance Limit. |
| `SecondCuff`                | `bool`         | Was the second cuff inflated in parallel with the first cuffs (spatial summation). |
| `PrimaryChannel`            | `int`          | What was the primary cuff channel. Please note this is only relevant if `second-cuff` is False. |
| `VASPainDetectionThreshold` | `double`       | Rating threshold for the pain detection threshold. |
| `MaximalPressure`           | `double`       | Maximal allowed pressure during the procedure. |
| `MaximalTime`               | `double`       | Maximal time of the procedure. Please note this will be longer than the actual running time if the participant was a responder. |
| `StimulationPressure`       | `List<double>` | Stimulation pressure during the procedure. |
| `VAS`                       | `List<double>` | Rating of the stimulation pressure during the procedure. | 
| `Time`                      | `List<double>` | Time of the values in the `StimulationPressure` and `VAS` data points. |


## Scripting (Methods)

### `double GetPressureFromPerception(double score)`

### `bool IsScoreAvailable(double score)`

## Example protocols

* <a href="https://github.com/LabBench-Society/Protocols/blob/main/intro.cpar/intro.cpar.expx" target="_blank" rel="noopener noreferrer">Introduction to Cuff Pressure Algometry</a>.
