---
title: Response Recording
description: Recording of psychophysical responses. The recording can be combined with sampling of biophysical signals, stimulus delivery, and marking of events.
weight: 20
---

{{% pageinfo %}}



{{% /pageinfo %}}


## Test definition

A Response Recording test can be defined with the `<psychophysics-response-recording>` element within the <test> element in the Experiment Definition File (`*.expx`):

```xml
<psychophysics-response-recording id="vasRecording" 
      name="Recording (Visual Analog Scale)"
      duration="60" 
      sample-rate="4"
      response-weight="1"
      signal-weight="0"
      experimental-setup-id="vas" />
```

## Examples of experimental setups

### LabBench I/O


### USB Joystick



## Psychophysical Rating Scales

### Ratio Rating Scales

```xml
<composite-scale id="vas"
      experimental-setup-id="vas"
      controller-device="lio.scale">
      <visual-analog-scale id="pain"
         length="10"                                                                
         sample-period="200"
         timing-source="none">
         <anchors>
            <modality text="Pain" />
            <top-anchor text="10/Worst possible pain" />
            <bottom-anchor text="0/No pain" />
         </anchors>
      </visual-analog-scale>
</composite-scale>
```


### Interval Rating Scales

```xml
<composite-scale id="nrs"
      experimental-setup-id="nrs"
      controller-device="lio.scale">
      <numerical-scale id="nrs"
         minimum="0"
         maximum="10"
         sample-period="200"
         timing-source="none">
         <anchors>
            <modality text="Pain" />
            <top-anchor text="10/Worst possible pain" />
            <bottom-anchor text="0/No pain" />
         </anchors>
      </numerical-scale>
</composite-scale>
```


### Categorical Rating Scales

```xml
<composite-scale id="crs"
      experimental-setup-id="crs"
      controller-device="lio.scale">
      <categorical-scale id="pain">
         <anchors>
            <modality text="Pain" />
            <top-anchor text="10/Worst possible pain" />
            <bottom-anchor text="0/No pain" />
         </anchors>
         <categories>
            <category text="None" />
            <category text="Mild" />
            <category text="Moderate" />
            <category text="Severe" />
            <category text="Very severe" />
            <category text="Worst possible" />
         </categories>
      </categorical-scale>
</composite-scale>
```

## Sampling of signals

```xml
<psychophysics-response-recording id="vasSignals" 
      name="Recording ratings and signals (Visual Analog Scale)"
      duration="60" 
      sample-rate="20"
      response-weight="1"
      signal-weight="1"
      experimental-setup-id="vas">
      <test-events>
         <instrument interface="ratio-scale" />
      </test-events>
      <signals sample="Walk.Sample()" min="0" max="10">
         <signal id="CTRL" name="Control Signal" unit="cm" />
      </signals>
</psychophysics-response-recording>
```

```python
import random

class RandomWalk:
   def __init__(self, tc):
      self.tc = tc
      self.value = 0

   def Sample(self):
      scale = self.tc.Instruments.RatioScale
      x = scale.GetRatioRating() / scale.Length
      self.value = self.value - 0.2 if random.random() < x else self.value + 0.2
      self.value = max(0, min(scale.Length, self.value))
      return [self.value]

def CreateRandomWalk(tc):  
   return RandomWalk(tc)
```

```xml
<defines>
   <define name="Walk" value="func: Script.CreateRandomWalk(tc)" />
</defines>
```



## Marking of events

```xml
<psychophysics-response-recording id="vasEvents" 
      name="Recording with events (Visual Analog Scale)"
      duration="60" 
      sample-rate="4"
      response-weight="1"
      signal-weight="0"
      experimental-setup-id="vas">
      <events-makers>
         <group id="PDT">
            <marker id="PDT" name="Pain Detected" next-group="PTT" />
            <marker id="STOP" name="Hand withdrawn" complete="true" />
         </group>
         <group id="PTT">
            <marker id="STOP" name="Hand withdrawn" complete="true" />
         </group>
      </events-makers>
</psychophysics-response-recording>
```


```xml
<psychophysics-response-recording id="vasCombined" 
      name="Recording ratings and signals with events (Visual Analog Scale)"
      duration="60" 
      sample-rate="20"
      response-weight="1"
      signal-weight="2"
      experimental-setup-id="vas">
      <test-events>
         <instrument interface="ratio-scale" />
      </test-events>
      <events-makers>
         <group id="PDT">
            <marker id="PDT" name="Pain Detected" next-group="PTT" />
            <marker id="STOP" name="Hand withdrawn" complete="true" />
         </group>
         <group id="PTT">
            <marker id="STOP" name="Hand withdrawn" complete="true" />
         </group>
      </events-makers>
      <signals sample="Walk.Sample()" min="0" max="10">
         <signal id="CTRL" name="Control Signal" unit="cm" />
      </signals>
</psychophysics-response-recording>
```

## Scripting

### Properties

### Functions

## Test results
