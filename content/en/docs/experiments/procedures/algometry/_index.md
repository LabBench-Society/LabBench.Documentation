---
title: Algometry
description: Tests for performing pressure algometry.
weight: 30
---

Cuff pressure algometry provides pressure-pain stimuli by inflating tourniquet cuffs under computer control. This enables experimental procedures that are impossible with conventional handheld pressure algometry. A second advantage of tourniquet cuffs is that they induce pain throughout the extremity. This is more clinically relevant than the cutaneous and superficial pain induced by handheld pressure algometry.

Cuff pressure algometry does not rely on operator strength and is not controlled by the operator. This allows precise pressure application and the determination of supramaximal thresholds, such as pain tolerance thresholds. The precise pressure control also provides high temporal resolution. This enables experimental procedures such as temporal summation of pressure stimuli.

All cuff pressure algometry procedures use pressure stimuli rated by the subject. These procedures can be divided into two main categories. The first category of procedures (scaling procedures), pressure stimuli are rated on a visual analogue scale. In the second category of procedures (threshold procedures), pressure stimuli are rated by indicating perception thresholds, most commonly the pain detection and tolerance thresholds.

A second distinction is whether the pressure stimuli are unconditioned or conditioned by a second painful stimulus. This conditioning stimulus can be induced by a second tourniquet cuff under computer control or by an external stimulus, such as submersion of a hand or foot in a cold water bath.

Currently, the following cuff pressure algometry procedures are available:

|Name |Type | Description |
|-----|-----|-------------|
| [Stimulus Response](docs/experiments/procedures/algometry/stimulusresponse/) | Scaling | Stimulus-response procedures determine the psychophysical rating (VAS Rating) to a linearly increasing pressure stimulus.  |
| [Conditioned Pain Modulation](docs/experiments/procedures/algometry/conditionedpainmodulation/) | Scaling | With the conditioned pain modulation procedure, one cuff applies static pressure while the other determines a stimulus-response curve. The stimulus-response curve determines the psychophysical rating (VAS Rating) to a linearly increasing pressure stimulus. |
| [Temporal Summation](docs/experiments/procedures/algometry/temporalsummation/) | Scaling | The temporal summation procedure applies a series of rectangular pressure stimuli to one or both cuffs. The participant is asked to rate the pain sensation of these stimuli on the VAS meter as soon as possible after the cessation of a pressure stimulus. <br /><br />The VAS rating for a stimulus is recorded just before the next stimulus is given or would have been given if it had not been the last stimulus in the series. |
| [Arbitrary Temporal Summation](docs/experiments/procedures/algometry/arbitrarytemporalsummation/) | Scaling | The arbitrary temporal summation procedure applies a series of rectangular pressure stimuli to one or both cuffs.<br /><br />The participant is asked to rate the pain sensation of these stimuli on the VAS meter as soon as possible after the cessation of a pressure stimulus.<br /><br />The VAS rating for a stimulus is recorded just before the next stimulus is given or would have been given if it had not been the last stimulus in the series. The arbitrary temporal summation procedure makes it possible to specify each stimulus in the series individually, and thus, each stimulus can have a different intensity and duration. |
| [Static Temporal Summation](docs/experiments/procedures/algometry/statictemporalsummation/) | Scaling |         The static temporal summation applies a constant pressure for a specified duration instead of a series of stimuli to determine the temporal summation of pressure stimulation. <br /><br />During this pressure stimulation and for a period after the procedure, the participant's VAS score will be recorded as the result of the procedure. |
| [Stimulus Rating](docs/experiments/procedures/algometry/stimulusrating/) | Threshold | The stimulus rating procedure provides a way to determine the Pain Detection Threshold (PDT), the Pain Tolerance Threshold (PTT), or both with an attached button. <br /><br />The procedure is executed in the same way as the stimulus-response procedure and is defined by the same parameters, with the exception that it does not have a stop-mode parameter but instead has a measurement parameter. |
| [Conditioned Pain Modulation Rating](docs/experiments/procedures/algometry/conditionedpainmodulationrating/) | Threshold |     The conditioned pain modulation rating procedure is analogous to the conditioned pain modulation procedure that uses a button instead of the VAS to determine pain detection threshold (PDT), pain tolerance threshold (PTT), or both. <br /><br />The same parameters define the procedure as the conditioned pain modulation procedure, with the addition of the measurement parameter that defines how the button is used to determine PDT, PTT, or both.| 

## Examples of experimental setups

### LabBench CPAR+

```xml
<experimental-setup name="LabBench CPAR+">
<devices>
      <cpar-plus id="dev"/>
</devices>
<device-mapping>
   <device-assignment instrument-name="PressureAlgometer" device-id="dev" />
</device-mapping>
</experimental-setup>        
```

### LabBench CPAR+ and LabBench DISPLAY


```xml
<experimental-setup name="LabBench CPAR+ (Scale on secondary monitor)">
<devices>
   <cpar-plus id="dev"/>

   <display id="display">
         <configurations>
            <visual-analogue-scale id="vas"
                  experimental-setup-id="vas"
                  length="10"
                  controller-device="dev">
                  <anchors>
                     <modality text="" />
                     <top-anchor text="10/Worst imaginable pain" />
                     <bottom-anchor text="0/No pain" />
                  </anchors>
            </visual-analog-scale>
         </configurations>
      </display>
   </devices>
   <device-mapping>
      <device-assignment instrument-name="PressureAlgometer" device-id="dev" />
   </device-mapping>
</experimental-setup>    
```

An implementation of these experimental setup can be seen in the <a href="https://github.com/LabBench-Society/Protocols/blob/main/intro.cpar/intro.cpar.expx" target="_blank" rel="noopener noreferrer">Introduction to Cuff Pressure Algometry</a>.

## Definition of anchor points for rating procedures


## Spatial summation of procedures


## Conditioning of procedures

