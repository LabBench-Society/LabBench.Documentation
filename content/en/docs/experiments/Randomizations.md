---
title: Randomizations
description: Randomizations are variables that are created on subject creation and stays invariant for all sessions in a protocol.
weight: 20
---

{{% pageinfo %}}

Randomizations share characteristics with `defines` and can be used throughout a protocol wherever a define can be used. However, unlike defines that are created each time a session is started, randomizations are only created once when a subject is created and stay invariant for all sessions in a protocol. Furthermore, randomizations are saved to the resulting data set and are available for data analysis scripts. Saving to the data set means that randomizations have restrictions on their types, whereas `defines` can be of any type created by Python code. As the name indicates, `randomizations` are primarily intended for randomizing protocol elements, but they can be used for any purpose.

{{% /pageinfo %}}

Randomization variables are specified in the `<randomizations>` element:

```xml
<randomizations>
   <integer name="[Required: name of the variable]" 
            value="[Required: Calculated attribute that must return an integer]" />
   <integers name="[Required: name of the variable]" 
             value="[Required: Calculated attribute that must return an array of integers]" />
   <string name="[Required: name of the variable]" 
           value="[Required: Calculated attribute that must return a string]" />
   <strings name="[Required: name of the variable]" 
            value="[Required: Calculated attribute that must return an array of strings]" />
</randomizations>
```

Like `<defines>` randomizations are create in the order they appear in the `<randomizations>` element and previously created defines can be used in the `value` attribute of subsequently randomizations.