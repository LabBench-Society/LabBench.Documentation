---
title: Static Temporal Summation
description: Psychophysical rating of a rectangular static pressure stimulus.
weight: 4
---

{{% pageinfo %}}
The static temporal summation applies a constant pressure for a specified duration instead of a series of stimuli to determine the temporal summation of pressure stimulation.

During this pressure stimulation and for a period after the procedure, the participant's VAS score will be recorded as the result of the procedure.
{{% /pageinfo %}}

The procedure window for the `<algometry-static-temporal-summation>` procedure is shown in Figure 1. The procedure window consists of two areas: applied pressure and recorded responses. 

![](/images/Experitments_Procedures_Algometry/Slide7.PNG)

*Figure 1: Procedure window of the temporal summation procedure*

The applied pressure area will display a legend indicating which cuff outlet(s) will be active and will plot the applied pressure over time. 

**Please see [Algometry](docs/experiments/procedures/algometry/) page for an introduction to the cuff pressure procedures and concepts that are common for these procedures before reading the rest of this procedure documentation.**

## Procedure definition

A static temporal summation procedure can be defined with the `<algometry-static-temporal-summation>` element within the `<procedures>` element in the Experiment Definition File (*.expx):

```xml
<algometry-static-temporal-summation id="AP2STSum" 
    name="Static Temporal Summation (Stop on VAS 10) [Cuff 1]"
    experimental-setup-id="vas"
    pressure-stimulate="AP2SR01.PTT"
    primary-cuff="1"
    second-cuff="false"
    stimulus-duration="60"
    tail-duration="20">
    <dependencies>
        <dependency id="AP2SR01"/>
    </dependencies>
</algometry-static-temporal-summation>
```

*Listing 1: Definition of a static temporal summation procedure*

Listing 1 has the following procedure specific attributes:

| Attribute         | Type                    | Specification |
|-------------------|-------------------------|---------------|
| `pressure-stimulate` | double = Calculated(context) | The pressure that will be applied during the rectangular pressure stimuli. |
| `primary-cuff`       | int=Calculated(tc) | Determines which cuff (1 or 2) will be used for the pressure stimulation.|
| `second-cuff`        | bool | Inflate the second cuff together with the primary cuff. |
| `stimulus-duration`  | double = Calculated(context) | The duration [s] of the constant pressure stimulation. |
| `tail-duration`      | double = Calculated(context) | The duration after the cessation of the pressure stimulation in which the VAS score is recorded. |

## Scripting (Properties)

In addition to the properties that are common to all procedure results, the procedure result for the stimulus response procedure has the following procedure specific properties:

| Name                        | Type           | Specification |
|-----------------------------|----------------|---------------|
| `NominalStimulatingPressure` | `double` | Stimulating pressure. |
| `SecondCuff`                | `bool`         | Was the second cuff inflated in parallel with the first cuffs (spatial summation). |
| `PrimaryChannel`            | `int`          | What was the primary cuff channel. Please note this is only relevant if 
| `AbortCount` | `int` | Number of samples in the tail of the recording (after the cessatation of the stimulus). |
| `AverageVASStimulation` | `double` | Average VAS rating during the stimulation. |
| `AverageVASTail` | `double` | Average VAS rating in the tail of the recording. |
| `AverageVAS` | `double` | Average VAS rating during the entire recording. |
| `VASEndOfStimulation` | `double` | VAS rating at the end of the stimulation. |
| `VASEndOfTail` | `double` | VAS rating at the end of the recording. |
| `VASAreaStimulation` | `double` | Area under the curve (AUC) of the ratings during the stimulation. |
| `VASAreaTail` | `double` | Area under the curve (AUC) of the ratings during the tail. |
| `VASArea` | `double` | Area under the curve (AUC) of the ratings during the entire recording. |
| `StimulationPressure`       | `List<double>` | Stimulation pressure during the procedure. |
| `VAS`                       | `List<double>` | Rating of the stimulation pressure during the procedure. | 
| `Time`                      | `List<double>` | Time of the values in the `StimulationPressure` and `VAS` data points. |


## Example protocols

* <a href="https://github.com/LabBench-Society/Protocols/blob/main/intro.cpar/intro.cpar.expx" target="_blank" rel="noopener noreferrer">Introduction to Cuff Pressure Algometry</a>.
