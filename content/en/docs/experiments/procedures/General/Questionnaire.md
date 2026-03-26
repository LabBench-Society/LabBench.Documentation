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

This makes questionnaires an integral part of the experimental control flow rather than a standalone data-collection tool.

Each question in a questionnaire is uniquely identified by an id and includes:

* A title (the prompt or label shown to the user)
* An instruction (guidance on how to interpret or answer the question)

The id is used to identify the answer in the dataset, and to refer to it from calculated parameters.

The procedure window for the `<questionnaire>` is shown in Figure 1.

## Test definition

```xml

```

## Questions

LabBench supports the following set of question types to accommodate different experimental needs:



* Boolean 
Binary, mutually exclusive responses (e.g., true/false, yes/no, child/adult).
* Numerical 
Free or validated numeric input.
* Text 
Free-form or validated textual responses.
* Likert 
Ordered categorical scales that capture degrees of agreement or intensity.
* List 
Sets of independent binary items (multiple true/false selections).
* Time 
Date and/or time input, typically entered by the operator.
* Map 
Spatial responses are defined by marking regions (e.g., body maps).
* Categorical Rating
Ratings on discrete categorical scales.
* Numerical Rating 
Ratings on a bounded numerical scale.
* Visual Analogue Rating 
Continuous responses using a visual analogue scale.

### Boolean

The `<boolean>` question asks a statement that can either be true or false. If the participant 
answers the question, the answer is selected with the `up` and `down` buttons.

```xml

```

### Numerical

The `<numeric>` question allows the participant or operator to provide a numerical
answer to a statement. The answer can be validated to be within a given range.

If the participant answers the question, the answer must be given verbally to the operator, 
who then enters it into the questionnaire. The operator's entered value will be displayed 
to the participant so they can confirm it is correct.        

```xml

```

### Text

The `<text>` question allows the participant or operator to provide a verbal free-form 
answer to a statement. The answer is in text that can be validated with a regular expression.

If the participant answers the question, the answer must be given verbally to the operator, 
who then enters it into the questionnaire. The operator's entered value will be displayed 
to the participant so they can confirm it is correct.        

```xml

```

### Likert

The `<likert>` question enables participants or operators to indicate their level of agreement, 
endorsement, or frequency using a Likert scale. A Likert scale is a symmetrically ordered set 
of response categories, from which a single option may be selected.

In LabBench, Likert scales are presented vertically. This vertical orientation allows for 
longer, more descriptive labels for response categories than horizontally displayed categorical 
rating scales. Participants select their response using the `up` and `down` button.        

```xml

```

### Dimensional Likert

The `<dimensional-likert>` question enables participants or operators to indicate their level of 
agreement, endorsement, or frequency using multiple Likert scales. A Likert scale is a symmetrically 
ordered set of response categories, from which a single option may be selected.

In LabBench, each Likert scale is presented horizontally. Participants select which Likert scale is 
active using the `up` and `down` buttons, and perform their rating with the `increase` and `decrease` buttons.        

```xml

```


### List

The `<list>` question asks a set of statement that can either be true or false. A statement is selected with the `up` and `down` buttons, and answered with the `decrease` and `increase` buttons, which makes the statement false and true, respectively.

```xml

```

### Time

The `<time>` question allows the participant or operator to provide answers to a question 
when something occurred. The answer is in the form of a date and time.

If the participant answers the question, the answer must be given verbally to the operator, 
who then enters it into the questionnaire. The operator's entered value will be displayed 
to the participant so they can confirm it is correct.

```xml

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

```xml

```

### Categorical Scale Rating

The `<categorical-scale>` question asks the participant or operator to rate a sensation 
on a categorical rating scale. If the participant answers the question, the rating is 
increased/decreased by pressing the `increase`/`decrease buttons`, respectively.

```xml

```

### Numerical Scale Rating

The `<numerical-scale>` question asks the participant or operator to rate a sensation 
on a numerical rating scale. If the participant answers the question, the rating is 
increased/decreased by pressing the `increase`/`decrease buttons`, respectively.

```xml

```

### Visual Analogue Scale Rating

The `<visual-analogue-scale>` question asks the participant or operator to rate a sensation 
on a visual analog rating scale. If the participant answers the question, the rating is 
increased/decreased by pressing the `increase`/`decrease buttons`, respectively.

```xml

```





