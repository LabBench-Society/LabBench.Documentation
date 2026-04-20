---
title: Temporal Summation
description: Psychophysical rating of pressure stimuli given in quick succession that evokes temporal summation.
weight: 2
---

{{% pageinfo %}}
The temporal summation procedure applies a series of rectangular pressure stimuli to one or both cuffs. The participant is asked to rate the pain sensation of these stimuli on the VAS meter as soon as possible after the cessation of a pressure stimulus. The VAS rating for a stimulus is recorded just before the next stimulus is given or would have been given if it had not been the last stimulus in the series.
{{% /pageinfo %}}

The procedure window for the `<algometry-temporal-summation>` procedure is shown in Figure 1. The procedure window consists of two areas: applied pressure and recorded responses. 

![](/images/Experitments_Procedures_Algometry/Slide5.PNG)

*Figure 1: Procedure window of the temporal summation procedure*

The applied pressure area will display a legend indicating which cuff outlet(s) will be active and will plot the applied pressure over time. The pressure is annotated with the psychophysical rating of each pressure stimulus.

**Please see [Algometry](docs/experiments/procedures/algometry/) page for an introduction to the cuff pressure procedures and concepts that are common for these procedures before reading the rest of this procedure documentation.**

## Procedure definition

A temporal summation procedure can be defined with the `<algometry-temporal-summation>` element within the `<procedures>` element in the Experiment Definition File (*.expx):

```xml
<algometry-temporal-summation id="AP2TSum" 
    name="Temporal Summation (Stop on VAS 10) [Cuff 1]"
    experimental-setup-id="vas"
    no-of-stimuli="10"
    pressure-static="0"
    pressure-stimulate="AP2SR02.PTT"
    primary-cuff="1"
    second-cuff="false"
    t-on="1"
    t-off="1">
    <dependencies>
        <dependency id="AP2SR02"/>
    </dependencies>
</algometry-temporal-summation>
```

*Listing 1: Definition of a temporal summation procedure*

Listing 1 has the following procedure specific attributes:

| Attribute            | Type                    | Specification |
|----------------------|-------------------------|---------------|
| `no-of-stimuli`      | int = Calculated(context) | The number of pressure stimuli applied during the procedure |
| `pressure-static`    | double = Calculated(context) | The pressure that will be applied in between the pressure stimuli. This value is included as a slight static pressure between the stimuli can prevent the cuff from shifting during the procedure. |
| `pressure-stimulate` | double = Calculated(context) | The pressure that will be applied during the rectangular pressure stimuli. |
| `primary-cuff`      | int=Calculated(tc) | Determines which cuff (1 or 2) will be used for the pressure stimulation.|
| `second-cuff`       | bool | Inflate the second cuff together with the primary cuff. |
| `t-on`               | double = Calculated(context) | The duration of the rectangular stimuli. |
| `t-off`              | double = Calculated(context) | The pause between the stimuli in the series. |

## Scripting (Properties)

In addition to the properties that are common to all procedure results, the temporal summation procedure result has the following procedure specific properties:

| Name                        | Type           | Specification |
|-----------------------------|----------------|---------------|
| `SecondCuff`                | `bool`         | Was the second cuff inflated in parallel with the first cuffs (spatial summation). |
| `PrimaryChannel`            | `int`          | What was the primary cuff channel. Please note this is only relevant if `second-cuff` is False. |
| `MaximalPressure`           | `double`       | Maximal allowed pressure during the procedure. |
| `MaximalTime`               | `double`       | Maximal time of the procedure. Please note this will be longer than the actual running time if the participant was a responder. |
| `NominalStimulatingPressure` | `double` | Stimulating pressure. |
| `NumberOfStimuli`           | `int `         | The number of pressure stimuli applied during the procedure. |
| `TimeOn`               | `double` | The duration of the rectangular stimuli. |
| `TimeOff`              | `double` | The pause between the stimuli in the series. |
| `Responses`       | `List<double>` | Ratings of each stimulus in the temporal summation. |
| `ResponseTime`       | `List<double>` | Time points at which the ratings where sampled. |
| `StimulationPressure`       | `List<double>` | Stimulation pressure during the procedure. |
| `VAS`                       | `List<double>` | Rating of the stimulation pressure during the procedure. | 
| `Time`                      | `List<double>` | Time of the values in the `StimulationPressure` and `VAS` data points. |

## Example protocols

* <a href="https://github.com/LabBench-Society/Protocols/blob/main/intro.cpar/intro.cpar.expx" target="_blank" rel="noopener noreferrer">Introduction to Cuff Pressure Algometry</a>.
