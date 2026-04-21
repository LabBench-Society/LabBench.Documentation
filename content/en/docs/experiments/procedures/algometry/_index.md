---
title: Cuff pressure algometry
description: Procedures for performing cuff pressure algometry.
weight: 30
---

Cuff pressure algometry provides pressure-pain stimuli by inflating tourniquet cuffs under computer control. This enables experimental procedures that are impossible with conventional handheld pressure algometry. A second advantage of tourniquet cuffs is that they induce pain throughout the extremity. This is more clinically relevant than the cutaneous and superficial pain induced by handheld pressure algometry.

Cuff pressure algometry does not rely on operator strength and is not controlled by the operator. This allows precise pressure application and the determination of supramaximal thresholds, such as pain tolerance thresholds. The precise pressure control also provides high temporal resolution. This enables experimental procedures such as temporal summation of pressure stimuli.

All cuff pressure algometry procedures use pressure stimuli rated by the subject. These procedures can be divided into two main categories. The first category of procedures (scaling procedures), pressure stimuli are rated on a visual analogue scale. In the second category of procedures (threshold procedures), pressure stimuli are rated by indicating perception thresholds, most commonly the pain detection and tolerance thresholds.

A second distinction is whether the pressure stimuli are unconditioned or conditioned by a second painful stimulus. This conditioning stimulus can be induced by a second tourniquet cuff under computer control or by an external stimulus, such as submersion of a hand or foot in a cold water bath.

## Algometry procedures 

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

The simplest experimental setup for cuff pressure algometry consists of the equipment shown in Figure X. The LabBench CPAR+ device is combined with either a LabBench SCALE (scaling algometry procedures) or a LabBench BUTTON (threshold algometry procedures). The LabBench CPAR+ device is controlled by LabBench running on a laboratory computer.

![](/images/Experitments_Procedures_Algometry/Slide1.PNG)

*Figure 1*


The `<experimental-setup>` element for this experimental setup is shown below:

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

The experimental setup for cuff pressure algometry can also be extended with an external display. An external display can show a calibrated VAS scale during scaling procedures, controlled by the participant with the LabBench SCALE device. The external display can also be used to provide participants with instructions throughout the experimental sessions.

![](/images/Experitments_Procedures_Algometry/Slide2.PNG)

*Figure 2*

The `<experimental-setup>` element for this experimental setup is shown below:

```xml
<experimental-setup name="LabBench CPAR+ (Scale on secondary monitor)">
   <devices>
      <cpar-plus id="dev"/>

      <display id="display" normative-distance="40">
         <typography active-colour="rgb(255,0,0)"
            background-colour="rgb(255,255,255)"
            inactive-colour="rgb(16,16,16)" />

         <configurations>
            <visual-analogue-scale
               id="vas"
               experimental-setup-id="vas"
               length="10"
               controller-device="dev">
               <anchors>
                  <modality text="" />
                  <top-anchor text="10/Worst imaginable itch" />
                  <bottom-anchor text="0/No itch" />
               </anchors>
            </visual-analogue-scale>
         </configurations>
      </display>
   </devices>
   <device-mapping>
      <device-assignment instrument-name="PressureAlgometer" device-id="dev" />
   </device-mapping>
</experimental-setup>    
```

An implementation of these experimental setup can be seen in the <a href="https://github.com/LabBench-Society/Protocols/blob/main/intro.cpar/intro.cpar.expx" target="_blank" rel="noopener noreferrer">Introduction to Cuff Pressure Algometry</a>.

## Spatial summation of procedures

Spatial summation can be studied by placing two cuffs adjacent to each other and inflating the cuffs in parallel. Inflating the cuffs in parallel can be achieved by setting the `second-cuff` attribute to `true`. The effect of setting the `second-cuff` attribute to `true` is shown in Figure 3.

![](/images/Experitments_Procedures_Algometry/Slide10.PNG)

*Figure 3: Illustration of how the `second-cuff` attribute can be used for spatial summation tests.*

## Conditioning of procedures

Conditioned pain modulation is a psychophysical mechanism in which a conditioning stimulus reduces the pain evoked by a second stimulus. It’s often summarised as “pain inhibits pain.” In LabBench procedures, the conditioning stimulus can be directly controlled by a LabBench device or provided externally. Stimulus Response and Stimulus Rating procedures use external conditioning stimuli, in which the subject experiences an external stimulus, such as cold water. In contrast, Conditioned Pain Modulation and Conditioned Pain Modulation Rating procedures use computer-controlled stimuli managed directly by the LabBench device. The outcome measure for these procedures is the change in psychophysical ratings and thresholds (PDT and PTT) induced by the conditioning stimulus relative to the unconditioned ratings and thresholds.

When the conditioning stimulus is external, the procedure is to present it to the participant while simultaneously starting the test. A common procedure is to apply the conditioning stimulus before the start of the stimulation pressure. For this purpose, all of these procedures have a `conditioning-time` attribute that delays the start of stimulation pressure. For computer-controlled conditioning stimuli, there is also a `delta-conditional-pressure` attribute that gradually increases the conditioning stimulus rather than applying it instantaneously. This is to avoid startling the participant by applying a sudden, highly painful stimulus. 

The effect of these two attributes is illustrated in Figure 4.

![](/images/Experitments_Procedures_Algometry/Slide11.PNG)

*Figure 4: Illustration of how the `conditioning-time` and `delta-conditional-pressure` controls the application of conditioning stimuli.*

## Attributes of scaling procedures

### Definition of anchor points 

For scaling procedures, participants rate the pressure stimuli on a visual analogue scale. To perform this rating, the scale's anchor points need to be defined for participants. For cuff pressure algometry, visual analogue scales have been used with either two or three anchor points, and the definition is determined by the `stop-mode` attribute in the scaling procedures.

The `stop-mode` attribute determines whether the VAS scale has two (2) or three anchor points (3):

* When set to `stop-on-maximal-rating`, the VAS scale has two anchor points (pain detection threshold (PDT), pain tolerance threshold (PTT)).
* When set to `stop-when-button-pressed`, the VAS scale has three anchor points (pain detection threshold (PDT), pain tolerance limit (PTL), pain tolerance threshold (PTT)).

The effect of the `stop-mode` on the determination of the PDT, PTT, and PTL thresholds is shown in Figure 5.


![](/images/Experitments_Procedures_Algometry/Slide12.PNG)

*Figure 5: Illustration of how the `stop-mode` attribute controls whether two or three anchor points are used for the visual analog scale.*

## Attributes of threshold procedures

### Definition of threshold estimation procedure

For threshold procedures, the outcome measures are pain detection and pain tolerance thresholds, indicated by the participant pressing a button. Which thresholds are determined is controlled by the measurement attribute:

* **PDT**: The participant pressed the button when they feel the slighest pain. The pressure at the button press is recorded as the pain detection threshold.

* **PTT**: The participant pressed the button when the pain becomes intolerable. The pressure at the button press is recorded as the pain tolerance threshold.

* **BOTH**: The participant press and hold the button when they feel the slighest pain and releases it when the pain becomes intolerable. The pressure at the time of button press is recorded as the pain detection threshold, and the pressure at release is recorded as the pain tolerance threshold.

The effect of this attribute is illustrated in Figure 6.

![](/images/Experitments_Procedures_Algometry/Slide13.PNG)

*Figure 6: Illustration of how the `measurement` attribute controls how and which thresholds are determined.*





