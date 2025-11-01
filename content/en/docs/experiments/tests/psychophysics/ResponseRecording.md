---
title: Response Recording
description: Recording of psychophysical responses. The recording can be combined with sampling of biophysical signals, stimulus delivery, and marking of events.
weight: 20
---

{{% pageinfo %}}

The response recording test implements computerized psychophysical ratings that allow a subject to rate a sensation sampled continuously for either a fixed time or a time determined by events during the test. Computerized psychophysical ratings allow time-dependent quantification of psychophysiological responses, such as the area under the curve, the maximal rating, or the time of maximal rating. Optionally, the test can be amended to include simultaneous recording of signals, either stimuli (e.g., stimulation pressure) or biophysical signals (e.g., heart rate or galvanic skin response). It is also possible to define events that can occur during the test; this will allow the experimenter to mark the times these events occur in the test's recorded data.

{{% /pageinfo %}}

The test window for the `<psychophysics-response-recording>` test is shown in Figure 1. The test window consists of three areas for; the recorded responses, the recorded signals, and events that can be marked by the operator. Please note that the recorded signals and events are only shown if there are signals or events defined for the test, respectively.

![](/images/experiments/tests/response-recording/ResponseRecordingUI.png)
*Figure 1: Test window of the response recording test*




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

![](/images/experiments/tests/response-recording/VASRecording.png)
*Figure 2: Computerized recording of visual analog ratings.*



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

![](/images/experiments/tests/response-recording/NRSRecording.png)
*Figure 2: Computerized recording of numerical ratings.*


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

![](/images/experiments/tests/response-recording/CRSRecording.png)
*Figure 2: Computerized recording of categorical ratings.*


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


## Example protocols
