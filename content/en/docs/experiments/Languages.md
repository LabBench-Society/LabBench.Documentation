---
title: Languages and Localization
description: Instructions on how to localize protocols.
weight: 20
---

Localization refers to adapting software to suit a specific region or culture, typically involving language, cultural norms, and regional preferences. Most importantly, this involves that subject-facing text is displayed in a language that the subject understands, but it may also involve customizing other aspects of the protocol, such as formats for dates, numbers, currency, and similar culture dependent items. 

Localization goes beyond mere translation and often requires a deep understanding of the subject's culture. For example, localizing questionnaires goes beyond a translation of the text in the questionnaire but also requires a validation that the translated text holds the same meaning to the subject as the original language of the questionnaire to native speakers. 

Internationalization, also often abbreviated as i18n, is the process of designing protocols in a way that facilitates adapting protocols to different cultures by separating culture-dependent content from the code and structure of the protocol. 

Protocols provide a mechanism for i18n in the form of the `<languages>` element that can be specified in protocols, for example: 

```xml
<languages>
    <language code="en" name="English"/>
    <language code="da" name="Danish"/>
</languages>
```

Specifying a `<languages>` element in a protocol creates a Language define (see section Defines) that can be used in calculated parameters to return different values depending on the language/culture selected by the experimenter when a session is started, and it will be possible to use different protocol assets depending on the selected language/culture. 

LabBench does not enforce any conventions for language codes. However, it is highly recommended that language codes from the “ISO 639-1” standard be used, as there is considerable work involved in localizing, for example, questionnaires, and by using standardized codes, it is possible to reuse a questionnaire implemented for one study in other studies that require the same questionnaire. 

Language codes for the ISO-639-1 standard can be found on the net by searching for “ISO 639-1 codes,” which are extensively used and commonly available. Please note that in the example above, only the language code was specified for English. It is also possible to specify the culture; for example, code=”en-gb” would have been the code for English as spoken in the United Kingdom.
