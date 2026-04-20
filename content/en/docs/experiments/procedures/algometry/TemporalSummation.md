---
title: Temporal Summation
description: Psychophysical rating of pressure stimuli given in quick succession that evokes temporal summation.
weight: 2
---

{{% pageinfo %}}

{{% /pageinfo %}}

The procedure window for the `<>` test is shown in Figure 1. The procedure window consists of two areas: applied pressure and recorded responses. 

![](/images/Experitments_Procedures_Algometry/Slide5.PNG)

*Figure 1: Procedure window of the temporal summation procedure*

The applied pressure area will display a legend indicating which cuff outlet(s) will be active and will plot the applied pressure over time. The pressure is annotated with the psychophysical rating of each pressure stimulus.

**Please see [Algometry](docs/experiments/procedures/algometry/) page for an introduction to the cuff pressure procedures and concepts that are common for these procedures before reading the rest of this procedure documentation.**

## Procedure definition

A temporal summation procedure can be defined with the `<>` element within the `<procedures>` element in the Experiment Definition File (*.expx):

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

Listing 1 has the following test specific attributes:

| Attribute         | Type                    | Specification |
|-------------------|-------------------------|---------------|

## Scripting (Properties)

In addition to the properties that are common to all test results, the test result for the stimulus response test has the following test specific properties:

| Name                        | Type           | Specification |
|-----------------------------|----------------|---------------|


## Scripting (Methods)

## Example protocols

* <a href="https://github.com/LabBench-Society/Protocols/blob/main/intro.cpar/intro.cpar.expx" target="_blank" rel="noopener noreferrer">Introduction to Cuff Pressure Algometry</a>.
