---
title: Stimulus Response
description: Psychophysical rating of linearly increasing pressure until the pain tolerance threshold or limit is reached. This test can be used to determine pressure pain detection and tolerance thresholds.
weight: 1
---

{{% pageinfo %}}
Stimulus-response tests determine the psychophysical rating (VAS Rating) to a linearly increasing pressure stimulus. 
From this stimulus-response curve, several psychophysical parameters can be determined: 

1. PDT: The Pain Detection Threshold, 
2. PTL: The Pain Tolerance Limit, and 
3. PTT: The Pain Tolerance Threshold (PTT). 

The determined parameters depend on the test configuration and the subject's instructions.
{{% /pageinfo %}}


![](/images/experiments/tests/algometry/StimulusResponseUI.png)

*Figure 1: Test window of the stimulus response test*



## Test definition

```xml
<algometry-stimulus-response id="AP2SR01" name="Stimulus Response (Stop on VAS 10) [Cuff 1]"
   delta-pressure="1"
   pressure-limit="100"
   primary-cuff="1"
   second-cuff="false"
   stop-mode="stop-on-maximal-rating"
   conditioning-time="0"
   vas-pdt="0.1" />
```

*Listing 1: Definition of a stimulus response test*

Listing 1 has the following test specific attributes:

| Attribute         | Type                    | Specification |
|-------------------|-------------------------|---------------|
| delta-pressure    | double=Calculated(tc)   | This attribute is the rate of increase [kPa/s] of the applied pressure.  |
| pressure-limit    | double=Calculated(tc)   | This attribute is the maximum pressure the device will deliver before it aborts the test [ double = Calculated(tc) ]. The maximal pressure for the device is 100kPa. |
| conditioning-time | double=Calculated(tc)   | This attribute is the time from the test's start until the pressure starts to increase linearly. |
| primary-cuff      | int=Calculated(tc) | Determines which cuff (1 or 2) will be used for the pressure stimulation.|
| second-cuff       | bool | Inflate the second cuff together with the primary cuff. |
| stop-mode         | enum | Stop mode for the test (stop-on-maximal-rating or stop-when-button-pressed).  |
| vas-pdt           | double=Calculated(tc)   | The VAS score is interpreted as the Pain Detection Threshold (PDT). It can be set to higher than 0.1cm to allow for non-painful stimulations to be rated by the subject. |

### Anchor points for the visual analog scale (`stop-mode`)

This attribute determines whether the VAS scale has two (2) or three anchor points (3). When set to stop-on-maximal-rating the VAS scale has two anchor points (pain detection threshold (PDT), pain tolerance threshold (PTT)). When set to stop-when-button-pressed the VAS scale has three anchor points (pain detection threshold (PDT), pain tolerance limit (PTL), pain tolerance threshold (PTT)).

![](/images/experiments/tests/algometry/StimulusResponseStopMode.png)

*Figure 2: Illustration of how the `stop-mode` attribute controls whether two or three anchor points are used for the visual analog scale.*

### Spatial Summation (`second-cuff`)

![](/images/experiments/tests/algometry/StimulusResponseSecondCuff.png)

*Figure 3: Illustration of how the `second-cuff` attribute can be used for spatial summation tests.*

### Conditioned Pain Modulation (`conditioning-time`)

![](/images/experiments/tests/algometry/StimulusResponseConditioningTime.png)

*Figure 4: Illustration of how the `conditioning-time` attribute can be used for conditioned pain modulation with an externally controlled conditioning stimulus.*

## Examples of experimental setups

### LabBench CPAR+

```xml
```

### LabBench CPAR+ with external rating device

```xml
```


### LabBench CPAR+ and LabBench DISPLAY


```xml
```

## Scripting (Properties)

In addition to the properties that are common to all test results, the test result for the stimulus response test has the following test specific properties:

| Name | Type | Specification |
|------|------|---------------|
| | | |

## Example protocols

* [Introduction to Cuff Pressure Algometry](https://github.com/LabBench-Society/Protocols/blob/main/intro.cpar/intro.cpar.expx) (_please note clicking this link will leave this site_).



