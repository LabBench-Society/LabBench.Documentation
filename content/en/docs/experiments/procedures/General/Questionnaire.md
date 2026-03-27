---
title: Questionnaire
description: A questionnaire is a series of questions to collect information in a consistent and organized way.
weight: 20
---

{{% pageinfo %}}

Questionnaires makes it possible to collect input during an experimental session. Conceptually, a questionnaire is a sequence of predefined questions that can be presented either to the operator or both the participant and operator, depending on the purpose of the questionnaire.

{{% /pageinfo %}}

While questionnaires naturally support classical psychometric instruments (e.g., standardised scales and surveys), their role in LabBench extends beyond this. They function as a general-purpose interface for structured data entry, enabling:

* Collection of participant metadata (e.g., demographics, screening criteria)
* Runtime configuration of experimental parameters
* Conditional branching and parameterisation of subsequent procedures

Each question in a questionnaire is uniquely identified by an id and includes: 1) a title (the prompt or label shown to the user), and 2) an instruction (guidance on how to interpret or answer the question). The id is used to identify the answer in the dataset, and to refer to it from calculated parameters.

The procedure panel and participant screen for the `<questionnaire>` is shown in Figure 1.

![](/images/Experitments_Procedures_General_Questionnaire/Slide1.PNG)

The participant screen is only displayed and used if the questionnaire is to be completed by the participant (`control="participant"`). The procedure pannel provides in the top of the panel the title and instruction for the question. Below the title of the instruction is the question that must be answered, and at the bottom is buttoms for going to the next and previous questions. It is only possible to go to the next question if the current question has been answered.

## Procedure definition

Questionnaires are defined with the `<questionnaire>` element:

```xml
<questionnaire id="PARTICIPANT" 
    name="Participant Controlled"
    experimental-setup-id="questionnaire"
    control="participant" 
    progress-format="percentage">

    <question-events start="True"
                     changed="True"
                     complete="True">
        <instrument interface="stimulator" />
    </question-events>

    <content>
        <!-- Content omitted for brevity -->
    </content>
</questionnaire>               
```

With the following procedure specific attributes:

| Attribute   | Type           | Definition |
|-------------|:--------------:|------------|
| progress-format | enum | Controls the progress information that is provided by the procedure.     |
| control         | enum | Sets whether the questionnaire is filled out by the operator or the participant. |

### Progress format

The procedure can display information on the progress of the questionnaire. The type of information provided is configured with theb `progress-format` attribute:

* `none`: no progresss information is provided.
* `percentage`: progress is provided as the percentage of completed questions.
* `index`: progress is provided as [current question no] / [total number of questions].

### Control

Questionnaires can be completed by either the operator or participant. When the operator completes the questionnaire, it is displayed only in the procedure panel and not to the participant. When the participant completes the questionnaire, it appears in both the procedure panel and a questionnaire instrument that must be assigned to the procedure. The participant will answer the questions using a Button instrument, which must also be assigned to the procedure. 

Whether the operator or participant answers is the questions is configured with the `control` attribute:

* `operator`: answers are provided by the operator.
* `participant`: answers are provided by the participant. In this mode, a Questionnaire
                    instrument must be assigned to the procedure.

An important note about the purpose of questionnaires in LabBench. The central idea in LabBench is that experiments must be as simple as possible for participants, which implies that **participants can only answer questions that require simple selection answers**, such as Likert scales, Yes/No statements, Body Maps, Rating Scales, etc. However, questions that require complex input, such as numeric , text, or time/date questions, must be answered by the operator asking the question and then entering the participant's answer.

### Question events

Question events make it possible to extend the functionality of the questionnaire procedure by executing calculated parameters (i.e., Python code) when questions are entered, left, or their answers are changed.

Questions events are defined with the `<question-events>` element:

```xml
<question-events start="True"
                    changed="True"
                    complete="True">
    <instrument interface="stimulator" />
</question-events>
```

which has the following attributes:

| Attribute   | Type                       | Definition                                         |
|-------------|:--------------------------:|----------------------------------------------------|
| `start`     | bool = Calculated(context) | Called when a question is started.                 |
| `changed`   | bool = Calculated(context) | Called when a the answer to a question is changed. |
| `complete`  | bool = Calculated(context) | Called when a question is completed.               |

Instruments can be made available for the `started`, `changed`, and `complete` calculated attributes by declaring `<instrument>` elements within the `<question-events>` element. These instruments must then be assigned to the procedure in the `<device-mapping>` of the experimental setup. 

## Questions

LabBench supports the following set of question types to accommodate different experimental needs:

| Name                    | Element                | Purpose                                                                            | Control |
|-------------------------|:----------------------:|------------------------------------------------------------------------------------|---|
| Boolean                 | `<boolean>`            | Binary, mutually exclusive responses (e.g., true/false, yes/no, child/adult).      | O/P | 
| Numerical               | `<numeric>`            | Free or validated numeric input. | O |
| Text                    | `<text>`               | Free-form or validated textual responses. | O |
| Likert                  | `<likert>`             | Ordered categorical scales that capture degrees of agreement or intensity.         | O/P |
| Dimensional Likert      | `<dimensional-likert>` | A set of ordered categorical scales that capture degrees of agreement or intensity.| O/P |
| List                    | `<list>`               | Sets of independent binary items (multiple true/false selections).                 | O/P |
| Time                    | `<time>`               | Date and/or time input.                                                            | O |
| Map                     | `<map>`                | Spatial responses are defined by marking regions (e.g., body maps).                | O/P |
| Categorical Rating      | `<categorical-scale>`  | Ratings on discrete categorical scales. | O/P |
| Numerical Rating        | `<numerical-scale>`    | Ratings on a bounded numerical scale. | O/P |
| Visual Analogue Rating  | `<visual-analogue-scale>` | Ratings on a visual analogue scale. | O/P |

Questions are defined within the `<content>` element. All questions have is defined wit the following format:

```xml
<question-type id="booleanQuestion" 
    title="Boolean Question"
    instruction="Answer yes or no."
    ... question-specific attributes ... >
    <question-specific-elements />
</question-type>

```

and have the following common attribytes:

| Attribute   | Type           | Definition |
|-------------|:--------------:|------------|
| id          | string         | Identifier for the question [ string ]. This identifier must be unique and is used to reference the answer in calculated parameters and in exported data. The answer can be referenced in calculated parameters as `[ProcedureID].[QuestionID]`. |
| title       | dynamic string | The title of the question. |
| instruction | dynamic string | An instruction to the operator or participant on how to answer the question. |
| condition   | bool = Calculated(pc) | Places a condition on whether the question is asked. If the calculated parameter returns True, the question is asked; otherwise, it is skipped. Consequently, this attribute can be used to omit questions based on answers to previous questions or on the results of other procedures in the protocol. |



### Boolean

The `<boolean>` question asks a statement that can either be true or false. If the participant 
answers the question, the answer is selected with the `up` and `down` buttons.

```xml
<boolean id="booleanQuestion" 
    title="Boolean Question"
    instruction="Answer yes or no."
    true-label="Ask the next text question" 
    false-label="Skip the next text question" />
```
with the following attributes:

| Attribute | Type | Definition |
|-----------|:----:|------------|


### Numerical

The `<numeric>` question allows the participant or operator to provide a numerical
answer to a statement. The answer can be validated to be within a given range.

If the participant answers the question, the answer must be given verbally to the operator, 
who then enters it into the questionnaire. The operator's entered value will be displayed 
to the participant so they can confirm it is correct.        

A `<numeric>` question is defined with:

```xml
<numeric id="numericQuestion"
    title="Numeric Question"
    instruction="Answer with a number.">
    <validation min="0" min-included="true"
                max="100" max-included="true"/>
</numeric>
```

with the following attributes:

| Attribute | Type | Definition |
|-----------|:----:|------------|

### Text

The `<text>` question allows the participant or operator to provide a verbal free-form 
answer to a statement. The answer is in text that can be validated with a regular expression.

If the participant answers the question, the answer must be given verbally to the operator, 
who then enters it into the questionnaire. The operator's entered value will be displayed 
to the participant so they can confirm it is correct.        

A `<text>` question is defined with:

```xml
<text id="textQuestion"
    title="Text Question"
    instruction="Answer with text."
    condition="Current.booleanQuestion">
    <validation regex="[\w\s]*" advice="Any text that consists of word charecters and whitespace."/>
</text>
```

with the following attributes:

| Attribute | Type | Definition |
|-----------|:----:|------------|

### Likert

The `<likert>` question enables participants or operators to indicate their level of agreement, 
endorsement, or frequency using a Likert scale. A Likert scale is a symmetrically ordered set 
of response categories, from which a single option may be selected.

In LabBench, Likert scales are presented vertically. This vertical orientation allows for 
longer, more descriptive labels for response categories than horizontally displayed categorical 
rating scales. Participants select their response using the `up` and `down` button.        

A `<likert>` question is defined with:

```xml
<likert id="likertQuestion"
    title="Likert Question"
    instruction="Answer on a likert scale.">
    <choice value="0" label="C1" />
    <choice value="1" label="C2" />
    <choice value="2" label="C3" />
    <choice value="3" label="C4" />
    <choice value="4" label="C5" />
</likert>
```

### Dimensional Likert

The `<dimensional-likert>` question enables participants or operators to indicate their level of 
agreement, endorsement, or frequency using multiple Likert scales. A Likert scale is a symmetrically 
ordered set of response categories, from which a single option may be selected.

In LabBench, each Likert scale is presented horizontally. Participants select which Likert scale is 
active using the `up` and `down` buttons, and perform their rating with the `increase` and `decrease` buttons.        

A `<dimensional-likert>` question is defined with:

```xml
<dimensional-likert id="dlikertQuestion"
    title="Dimensional Likert Question"
    instruction="Answer on a dimensional likert scale.">
    <dimension name="Pain">
        <choice value="0" label="C1" />
        <choice value="1" label="C2" />
        <choice value="2" label="C3" />
        <choice value="3" label="C4" />
        <choice value="4" label="C5" />
    </dimension>
    <dimension name="Itch">
        <choice value="0" label="C1" />
        <choice value="1" label="C2" />
        <choice value="2" label="C3" />
        <choice value="3" label="C4" />
        <choice value="4" label="C5" />
    </dimension>                        
</dimensional-likert>
```


### List

The `<list>` question asks a set of statement that can either be true or false. A statement is selected with the `up` and `down` buttons, and answered with the `decrease` and `increase` buttons, which makes the statement false and true, respectively.

A `<list>` question is defined with:

```xml
<list id="listQuestion"
    title="List Question"
    instruction="Answer a set of options.">
    <item id="Q0" question="Option 1" />
    <item id="Q1" question="Option 2" />
    <item id="Q2" question="Option 3" />
    <item id="Q4" question="Option 4" />
</list>
```

### Time

The `<time>` question allows the participant or operator to provide answers to a question 
when something occurred. The answer is in the form of a date and time.

If the participant answers the question, the answer must be given verbally to the operator, 
who then enters it into the questionnaire. The operator's entered value will be displayed 
to the participant so they can confirm it is correct.

A `<time>` question is defined with:

```xml
<time id="timeQuestion" 
    title="Time question"
    instruction="Please enter a time" />
```

### Map

An area on the image can be selected or deselected. Each area has an id and a `colour`, which 
matches the colour of the pixels in that area. The operator or participant will not see this 
color, as it will be replaced by one of the following:

* `deselected-colour`: an area that is neither selected nor active.
* `selected-colour`: an area that has been selected by the operator/participant but is not active.
* `active-deselected-colour`: an  area has not been selected and is active.
* `active-selected-colour`: an  area has been selected and is active.

The concept of an active/inactive area is relevant only when the participant completes the 
questionnaire. In that mode, it is the area currently in focus, and pressing the increase/decrease 
button selects/deselects the area, respectively.

When the participant answers the questionnaire, each area must also set up navigation to adjacent 
areas, specifying which area will be made active when the up, down, left, or right button is 
pressed. For each area, at least one button must be defined so the participant can’t get trapped 
and can't navigate away from the area.        

A `<map>` question is defined with:

```xml
<map id="mapQuestionSingle"
    title="Map Question (Single selection)"
    instruction="Makes it possible for operators to mark single areas"
    image-map="Assets.BodyMap.Areas"
    overlay-image="Assets.BodyMap.Overlay"
    initial-active-area="C01"
    selection-mode="single"
    selected-colour="#ADFFA6"
    active-selected-colour="#82BF7C"
    deselected-colour="#FFFFFF"
    active-deselected-colour="#E3E3E3">

    <area id="C01" colour="#FF0A0A" down="C02" />
    <area id="C02" colour="#FF1414" down="C03" up="C01"/>
    <area id="C03" colour="#FF1E1E" down="C04" up="C02" left="C14" right="C17" />
    <area id="C04" colour="#FF2828" down="C05" up="C03" />
    <area id="C05" colour="#FF3232" down="C06" up="C04" left="C15" right="C18"/>
    <area id="C06" colour="#FF3C3C" down="C07" up="C05" left="C10" />
    <area id="C07" colour="#FF4646" down="C08" up="C06" left="C11" />
    <area id="C08" colour="#FF5050" down="C09" up="C07" left="C12" />
    <area id="C09" colour="#FF5A5A"            up="C08" left="C13" />
    <area id="C10" colour="#FF6464" down="C11" up="C05" right="C06" />
    <area id="C11" colour="#FF6E6E" down="C12" up="C10" right="C07" />
    <area id="C12" colour="#FF7878" down="C13" up="C11" right="C08" />
    <area id="C13" colour="#FF8282"            up="C12" right="C09" />
    <area id="C14" colour="#FF8C8C" down="C15"          right="C05" />
    <area id="C15" colour="#FF9696" down="C16" up="C14" right="C05" />
    <area id="C16" colour="#FFA0A0"            up="C15" />
    <area id="C17" colour="#FFAAAA" down="C18"          left="C03" />
    <area id="C18" colour="#FFB4B4" down="C19" up="C17" left="C05" />
    <area id="C19" colour="#FFBEBE"            up="C18"  />
</map>
```

![](/images/Experitments_Procedures_General_Questionnaire/Slide2.PNG)


### Categorical Scale Rating

The `<categorical-scale>` question asks the participant or operator to rate a sensation 
on a categorical rating scale. If the participant answers the question, the rating is 
increased/decreased by pressing the `increase`/`decrease buttons`, respectively.

A `<categorical-scale>` question is defined with:

```xml
<categorical-scale id="categoricalScaleQuestion" 
    title="Categorical Rating Question"
    instruction="Please rate your sensation"
    top-anchor="Maximal Sensation" 
    bottom-anchor="No Sensation" 
    active-colour="rgb(255,0,0)" 
    inactive-colour="rgb(32,32,32)">
    <category value="C1" />
    <category value="C2" />
    <category value="C3" />
    <category value="C4" />
    <category value="C5" />
</categorical-scale>
```

### Numerical Scale Rating

The `<numerical-scale>` question asks the participant or operator to rate a sensation 
on a numerical rating scale. If the participant answers the question, the rating is 
increased/decreased by pressing the `increase`/`decrease buttons`, respectively.

A `<numerical-scale>` question is defined with:

```xml
<numerical-scale id="numericalScaleQuestion" 
    title="Numerical Rating Question"
    instruction="Please rate your sensation"
    maximum="10" 
    minimum="0" 
    top-anchor="Maximal Sensation" 
    bottom-anchor="No Sensation" 
    active-colour="rgb(255,0,0)" 
    inactive-colour="rgb(32,32,32)"/>
```

### Visual Analogue Scale Rating

The `<visual-analogue-scale>` question asks the participant or operator to rate a sensation 
on a visual analog rating scale. If the participant answers the question, the rating is 
increased/decreased by pressing the `increase`/`decrease buttons`, respectively.

A `<visual-analogue-scale>` question is defined with:

```xml
<visual-analogue-scale id="visualAnalogScaleQuestion" 
    title="Visual Analog Rating Question"
    instruction="Please rate your sensation"
    length="10"
    top-anchor="Maximal Sensation" 
    bottom-anchor="No Sensation" 
    active-colour="rgb(255,0,0)" 
    inactive-colour="rgb(32,32,32)"/>
```





