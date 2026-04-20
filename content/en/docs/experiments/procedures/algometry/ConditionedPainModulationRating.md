---
title: Conditioned Pain Modulation Rating
description: Determination of pain detection and/or tolerance thresholds to linearly increasing pressure conditioned by a second static pressure. Participants indicate the thresholds through button presses.
weight: 7
---

{{% pageinfo %}}

{{% /pageinfo %}}

The procedure window for the `<>` test is shown in Figure 1. The procedure window consists of two areas: applied pressure and recorded responses. 

![](/images/Experitments_Procedures_Algometry/Slide9.PNG)

*Figure 1: Procedure window of the temporal summation procedure*

The applied pressure area will display a legend indicating which cuff outlet(s) will be active and will plot the applied pressure over time. The pressure is annotated with the psychophysical rating of each pressure stimulus.

**Please see [Algometry](docs/experiments/procedures/algometry/) page for an introduction to the cuff pressure procedures and concepts that are common for these procedures before reading the rest of this procedure documentation.**

## Procedure definition

A temporal summation procedure can be defined with the `<>` element within the `<procedures>` element in the Experiment Definition File (*.expx):

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
