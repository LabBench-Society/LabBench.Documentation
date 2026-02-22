---
title: Participant validation
description: Instructions on how to validate participant identifiers (IDs)
weight: 5
---

{{% pageinfo %}}

Participants are central to how data is recorded and stored. Running an experiment with LabBench consists of collecting data from a series of participants that each is identified by an ID. 

{{% /pageinfo %}}

To ensure valid participant IDs, it is possible to specify their validation in the Experiment Definition File with the `participant-validator` element. Subject `ID` are validated with a regular expression that can be specified by the regex attribute of the `<participant-validator>` element. The `<participant-validator>` also has an `advice` attribute with text that will be displayed to the researcher if they enter an invalid ID. This attribute can be used to provide help to the operator on what is a valid participant ID in the experiment.

A regular expression is a versatile pattern-matching language for string manipulation tasks like searching, matching, and extracting information from text data. It's a sequence of characters that defines a search pattern. They provide a concise and flexible way to describe and match complex patterns within strings. In LabBench, it is used to validate session IDs by checking if the entered ID matches the regular expression. If there is a match the ID is valid.

Below is an example of a `participant-validator` that will ensure that session IDs are in the form “Sxxx” where x is a digit from 0-9:

```xml
<participant-validator regex="^S[0-9]{3}$"
                   advice="Please enter an ID in the form of SXXX, where X is a digit" />
```

This regular expression encodes the following rules:

* **^**: is the start of the string.
* **S**: The string must start with the letter S.
* **[0-9]**: Digits from 0-9.
* **{3}**: The letter S must be followed by precisely three digits.
* **$**: is the end of the string, meaning there cannot be any whitespace for letters after the three digits.

A full tutorial on regular expressions is beyond the scope of this introduction. Regular expressions are widespread and there are numerous excellent tutorials on the net for learning regular expressions (see for example: [RegexLearn](https://regexlearn.com/)), as well as online tools, such as [regex101](https://regex101.com/), that can greatly help in developing and testing regular expressions that can be used to validate participant IDs.
