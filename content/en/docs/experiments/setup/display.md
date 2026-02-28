---
title: "LabBench DISPLAY"
description: "Setup of secondary computer monitors."
weight: 12
---

{{% pageinfo %}}

The LabBench DISPLAY defines a fixed, always-on-top window on a monitor connected to the laboratory computer. Within an experiment,
this window supports multiple instruments based on the selected procedure. Each instrument defines the experiment-setup-id
that activates it, and each procedure specifies which experiment-setup-id will be used while it is selected.

{{% /pageinfo %}}

The LabBench DISPLAY is included in experimental setups with an `<display>` element:

```xml
<display id="display" normative-distance="40"> 
    <typography active-colour="rgb(255,0,0)"
                inactive-colour="rgb(128,128,128)"
                foreground-colour="rgb(0,0,0)"
                background-colour="rgb(255,255,255)">
        <!-- Content omitted for brevity -->
    </typography>

    <configurations>
        <image-display id="image" 
            experimental-setup-id="image"
            background-colour="rgb(255,255,255)" />

        <questionnaire id="questionnaire" 
            experimental-setup-id="questionnaire" 
            controller-device="joystick" />

        <visual-analogue-scale id="vas" 
            experimental-setup-id="vas" 
            controller-device="joystick" 
            length="10">
            <!-- Content omitted for brevity -->
        </visual-analogue-scale>

        <numerical-scale id="nrs" 
            experimental-setup-id="nrs" 
            controller-device="joystick" 
            minimum="0" 
            maximum="10">
            <!-- Content omitted for brevity -->
        </numerical-scale>

        <categorical-scale id="crs" 
            experimental-setup-id="crs"  
            controller-device="joystick">
            <!-- Content omitted for brevity -->
        </categorical-scale>                    

        <composite-scale id="scales" 
            experimental-setup-id="cscale"  
            controller-device="joystick">
            <!-- Content omitted for brevity -->
        </composite-scale>
    </configurations>
</display>
```

**Attributes:**


## Typography

Typography establishes the global typographic and colour standards for on-screen textual elements in questionnaires and rating scales.
It defines default foreground, background, active, and inactive colours, as well as role-specific typography presets for titles,
instructions, answers, scale modalities, anchors, and category labels across various question and scale types.

```xml
<typography active-colour="rgb(255,0,0)"
            inactive-colour="rgb(128,128,128)"
            foreground-colour="rgb(0,0,0)"
            background-colour="rgb(255,255,255)">
    <title size="28" />
    <instruction size="28" />

    <answer size="28" />
    <text-answer size="28" />
    <time-answer size="28" />
    <likert-category size="28" />
    <numerical-answer size="28" />

    <scale-modality size="28" />
    <bottom-anchor size="28" />
    <top-anchor size="28" />                    
    <crs-category size="28" border-thickness="1" colour="#000000" style="normal" weight="normal"/>
    <nrs-category size="28" />
</typography>
```

**Attributes:**

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>background-colour</p>|<p>optional</p>|<p>Background colour [ Text (default: #FFFFFF) ].</p>|
|<p>foreground-colour</p>|<p>optional</p>|<p>Foreground colour [ Text (default: #000000) ].</p>|
|<p>active-colour</p>|<p>optional</p>|<p>Active colour [ Text (default: #FF0000) ].</p>|
|<p>inactive-colour</p>|<p>optional</p>|<p>Inactive colour [ Text (default: #161616) ].</p>|

**Elements:**

| Name | Use | Description |
|:-----|:---:|:------------|
| <p>[`<title>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for question titles in questionnaires.</p>|
| <p>[`<instruction>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for question instructions in questionnaires.</p>|
| <p>[`<answer>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for possible answers to boolean, list, and multiple-choice questions in questionnaires.</p>|
| <p>[`<likert-category>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for categories in likert and dimensional likert questions in questionnaires.</p>|
| <p>[`<numerical-answer>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for answers to numerical questions in questionnaires.</p>|
| <p>[`<text-answer>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for answers to text questions in questionnaires.</p>|
| <p>[`<time-answer>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for answers to time/date questions in questionnaires.</p>|
| <p>[`<scale-modality>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for scale modalities in numerical, categorical, and psychometric rating questions in questionnaires as well as for psychomeric rating scales.</p>|
| <p>[`<top-anchor>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for the top anchor in psychometric rating questions in questionnaires as well as for psychomeric rating scales.</p>|
| <p>[`<bottom-anchor>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for the bottom anchor in and psychometric rating questions in questionnaires as well as for psychomeric rating scales.</p>|
| <p>[`<crs-category>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for the categories in categorical rating questions in questionnaires as well as for categorical rating scales.</p>|
| <p>[`<nrs-category>`](#LabBench.Interface.Setup.Screen.ElementTypography)</p> | <p>optional</p> |<p>Typography for the categories in numerical rating questions in questionnaires as well as for numerical rating scales.</p>|

### Element typography 

**Attributes:**

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>size</p>|<p>required</p>|<p>Size of the font that is used for the element.</p>|
|<p>border-thickness</p>|<p>optional</p>|<p>Border thickness of the element.</p>|
|<p>style</p>|<p>optional</p>|<p>Style of the font, whether it is normal or in italic.</p>|
|<p>weight</p>|<p>optional</p>|<p>Indicates the visual weight (degree of blackness or thickness of strokes) of the characters in the font.</p>|
|<p>colour</p>|<p>optional</p>|<p>The colour of the element</p>|


## Device configurations

### Image Display

<p>An instrument that can be used for the display of images. This can be used either to display instructions to
participants when procedures are inactive or to display visual stimuli for experimental procedures such as visually
evoked potentials and behavioural procedures (Stroop, Flanker, Stop-Signal tasks, etc.).</p>


```xml
<image-display id="image" 
    experimental-setup-id="image"
    background-colour="rgb(255,255,255)" />
```

**Attributes:**

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Device identification that will be used to identify the sub-device in device assignments [ string ].</p>|
|<p>experimental-setup-id</p>|<p>required</p>|<p>Identification of the experimental setup state where this device will be active [ string ].</p>|
|<p>background-colour</p>|<p>optional</p>|<p>Setting this attribute will override the background colour defined by in the typography element for the display.</p>|


### Questionnaire

Displays questionnaires for participants to complete, which can be used to ask the participants to provide answers to:

* **Boolean Questions:** binary questions answered with either a true or false statement.
* **Numerical Questions:** numbers provided by the participant but entered by the operator.
* **Text Questions:** verbal answers provided by the participant but entered by the operator.
* **Likert Questions:** A scale that captures how strongly someone agrees, disagrees, or feels about a statement using a fixed set of ordered response options.
* **List Questions:** A set of binary statements that each can be either true or false.
* **Time Questions:** a date and time provided by the participant, entered by the operator.
* **Map Questions:** a set of regions, such as a body map, where each region can be marked.
* **Categorical Rating Questions:** rating of a sensation on a categorical scale.
* **Numerical Rating Questions:** rating of a sensation on a numerical scale.
* **Visual Rating Questions:** rating of a sensation on a visual analog rating scale.

For the participants to fill out these questions, the controller-device must define the following buttons:

* `up`, `down`: Is used by Boolean and Likert questions to set answers, and is used by List and Map questions to navigate between answers.* `left`, `right`: Is used by Map questions to navigate between answers.
* `increase`, `decrease`: Is used by Map, List, Likert, and Rating questions to set answers.
* `previous`, `next`: used to navigate between questions.

If the controller-device also implements the Joystick instrument, this joystick can be used to move between selected areas in map questions.

```xml
<questionnaire id="questionnaire" 
    experimental-setup-id="questionnaire" 
    controller-device="joystick" />
```

**Attributes:**

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Device identification that will be used to identify the sub-device in device assignments [ string ].</p>|
|<p>experimental-setup-id</p>|<p>required</p>|<p>Identification of the experimental setup state where this device will be active [ string ].</p>|
|<p>controller-device</p>|<p>required</p>|<p>Identification of the device used to control this device [ string ].</p>|

### Visual Analogue Scale

<p>A visual analogue scale (VAS) represents a ratio scale along which observers report the perceived magnitude of a subjective sensation.
A ratio scale means that responses are defined on a continuum, with a true zero corresponding to the absence of the perceptual quantity,
and equal distances along the scale correspond to equal increments in perceived magnitude. As a consequence, ratios between values are
interpretable (e.g., a response at 60 can be meaningfully understood as twice the perceived intensity of a response at 30, under the
assumptions of the scale).</p>
<p>The scale is defined by a  modality and the lower and upper anchors of the perceptual dimension. The lower anchor denotes the null
intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality. The scale
is also defined by its physical length, typically 10cm.</p>
<p>For its operation, its <code>controller-device</code> must implement a <code>Button</code> instrument with the following <code>button-assignments</code>:</p>
<ul>
<li><code>increase</code>: increase the rating on the scale.</li>
<li><code>decrease</code>: decrease the rating on the scale.</li>
</ul>

```xml
<visual-analogue-scale id="vas" 
    experimental-setup-id="vas" 
    controller-device="joystick" 
    length="10">
    <anchors>
        <modality text="Pain">
            <localized-text language="da" text="Smerte" />
        </modality>
        <bottom-anchor text="No Pain">
            <localized-text language="da" text="Ingen smerte" />
        </bottom-anchor>
        <top-anchor text="Maximal Pain">
            <localized-text language="da" text="Maksimal smerte" />
        </top-anchor>
    </anchors>
</visual-analogue-scale>
```

**Attributes:**

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Device identification that will be used to identify the sub-device in device assignments [ string ].</p>|
|<p>experimental-setup-id</p>|<p>required</p>|<p>Identification of the experimental setup state where this device will be active [ string ].</p>|
|<p>length</p>|<p>optional</p>|<p>Physical length of the scale in centimetres [ double ].</p>|
|<p>controller-device</p>|<p>required</p>|<p>Identification of the device used to control this device [ string ].</p>|


### Numerical Scale

<p>With a numerical rating scale (NRS), observers report the perceived magnitude of a subjective sensation by selecting
a value from an ordered numeric set. In LabBench, an NRS is treated as an interval scale, meaning that equal numeric
differences are intended to correspond to equal differences in perceived magnitude, but the zero point does not
constitute a true absence of the perceptual quantity in a measurement-theoretic sense. Consequently, differences
between values are interpretable, whereas ratios are not (e.g., the difference between ratings 6 and 8 is meaningful,
but a rating of 8 cannot be interpreted as “twice” the intensity of a rating of 4).</p>

<p>The scale is defined by a  modality and the lower and upper anchors of the perceptual dimension. The lower anchor denotes the null
intensity of the sensation, while the upper anchor denotes the maximum subjectively imaginable intensity for that modality. The anchors
serve as reference points for minimal and maximal perceived intensity, without implying a physically or perceptually absolute zero.
Responses are restricted to discrete steps between a minum and maximum integer value.</p>

<p>For its operation, its <code>controller-device</code> must implement a <code>Button</code> instrument with the following <code>button-assignments</code>:</p>

<ul>
<li><code>increase</code>: increase the rating on the scale.</li>
<li><code>decrease</code>: decrease the rating on the scale.</li>
</ul>


```xml
<numerical-scale id="nrs" 
    experimental-setup-id="nrs" 
    controller-device="joystick" 
    minimum="0" 
    maximum="10">

    <anchors>
        <modality text="Pain">
            <localized-text language="da" text="Smerte" />
        </modality>
        <bottom-anchor text="No Pain">
            <localized-text language="da" text="Ingen smerte" />
        </bottom-anchor>
        <top-anchor text="Maximal Pain">
            <localized-text language="da" text="Maksimal smerte" />
        </top-anchor>
    </anchors>                        
</numerical-scale>
```

**Attributes:**

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Device identification that will be used to identify the sub-device in device assignments [ string ].</p>|
|<p>experimental-setup-id</p>|<p>required</p>|<p>Identification of the experimental setup state where this device will be active [ string ].</p>|
|<p>maximum</p>|<p>required</p>|<p>The maximal value for the scale [ int ].</p>|
|<p>minimum</p>|<p>required</p>|<p>The minimum value for the scale [ int ].</p>|
|<p>controller-device</p>|<p>required</p>|<p>Identification of the device used to control this device [ string ].</p>|

### Categorical Scale

A categorical rating scale (CRS) represents an ordered set of discrete response categories used to report the perceived
magnitude or quality of a subjective sensation. CRS scales are ordinal scales, meaning that the ordering of categories
is meaningful, but neither the magnitude of differences between adjacent categories nor ratios between categories is
defined or assumed to be equal. As a result, comparisons are limited to statements of greater-than or less-than (e.g.,
category C indicates more perceived intensity than category B), without any metric interpretation of spacing.

The scale is defined by a modality and a finite set of semantically labelled categories spanning the response range from
minimal to maximal perceived intensity.

For its operation, its <code>controller-device</code> must implement a <code>Button</code> instrument with the following <code>button-assignments</code>:

* **increase:** increase the rating on the scale.
* **decrease:** decrease the rating on the scale.

```xml
<categorical-scale id="crs" 
    experimental-setup-id="crs" 
    controller-device="joystick">
    <anchors>
        <modality text="Pain">
            <localized-text language="da" text="Smerte" />
        </modality>
        <bottom-anchor text="No Pain">
            <localized-text language="da" text="Ingen smerte" />
        </bottom-anchor>
        <top-anchor text="Maximal Pain">
            <localized-text language="da" text="Maksimal smerte" />
        </top-anchor>
    </anchors>      
    <categories>
        <category text="None">
            <localized-text language="da" text="Ingen" />
        </category>
        <category text="Mild">
            <localized-text language="da" text="Mild" />
        </category>
        <category text="Moderate">
            <localized-text language="da" text="Moderat" />
        </category>
        <category text="Severe">
            <localized-text language="da" text="Alvorlig" />
        </category>
        <category text="Extreme">
            <localized-text language="da" text="Ekstrem" />
        </category>
    </categories>                  
</categorical-scale>                    
```

**Attributes:**

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Device identification that will be used to identify the sub-device in device assignments [ string ].</p>|
|<p>experimental-setup-id</p>|<p>required</p>|<p>Identification of the experimental setup state where this device will be active [ string ].</p>|
|<p>controller-device</p>|<p>required</p>|<p>Identification of the device used to control this device [ string ].</p>|

### Composite Scale

<p>A composite scale consists of one or more psychophysical rating scales, each of which can be a visual analog,
numerical, or categorical scale. It is possible, but not recommended, to mix scales; the most common
configuration is a single scale.</p>

<p>For its operation, it must be assigned a <code>controller-device</code> that must implement a <code>Button</code> instrument with
the following <code>button-assignments</code>:</p>

<ul>
<li><code>increase</code>: increase the rating on the currently active scale.</li>
<li><code>decrease</code>: decrease the rating on the current active scale.</li>
<li><code>previous</code>: activate the previous scale in the defined set of scales.</li>
<li><code>next</code>: activate the next scale in the defined set of scales.</li>
</ul>

<p>If only one scale is defined, the <code>previous</code> and <code>next</code> buttons will have no effect.</p>


```xml
<composite-scale id="scales" 
    experimental-setup-id="cscale" 
    controller-device="joystick">

    <visual-analogue-scale id="pain" length="10">
        <anchors>
            <!-- See visual analogue rating scale for an example on definition of scale anchors  -->
        </anchors>                                                                                                                
    </visual-analogue-scale>

    <numerical-scale id="nrs" 
        minimum="0" 
        maximum="10">
        <anchors>
            <!-- See numerical rating scale for an example on definition of scale anchors  -->
        </anchors>                        
    </numerical-scale>

    <categorical-scale id="crs">
        <anchors>
            <!-- See categorical scale for an example on definition of scale anchors  -->
        </anchors>      
        <categories>
            <!-- See categorical scale for an example on definition of scale categories  -->
        </categories>                  
    </categorical-scale>                    
</composite-scale>
```

**Attributes:**

| Name |Use | Description |
|:-----|:--:|:--------------|
|<p>id</p>|<p>required</p>|<p>Device identification that will be used to identify the sub-device in device assignments [ string ].</p>|
|<p>experimental-setup-id</p>|<p>required</p>|<p>Identification of the experimental setup state where this device will be active [ string ].</p>|
|<p>controller-device</p>|<p>required</p>|<p>Identification of the device used to control this device [ string ].</p>|

