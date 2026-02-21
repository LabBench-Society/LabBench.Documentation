---
title: Persistent variables
description: Persistent variables that are created on subject creation and stays invariant for all sessions in a protocol.
weight: 20
---

{{% pageinfo %}}

Persistent variables share characteristics with `variables` and can be used throughout a protocol wherever a variable can be used. However, unlike variables that are created each time a session is started, persistent variables are only created once when a participant is created and stay invariant for all sessions in a protocol. Furthermore, persistent variables are saved to the resulting data set and are available for data analysis scripts. Saving to the data set means that persistent variables have restrictions on their types, whereas `variables` can be of any type created by Python code. As the name indicates, `persistent-variables` are primarily intended for randomizing protocol elements, but they can be used for any purpose.

{{% /pageinfo %}}

Persistent variables are specified in the `<persistent-variables>` element:

```xml
<persistent-variables>
   <integer name="[Required: name of the variable]" 
            value="[Required: Calculated attribute that must return an integer]" />
   <integers name="[Required: name of the variable]" 
             value="[Required: Calculated attribute that must return an array of integers]" />
   <string name="[Required: name of the variable]" 
           value="[Required: Calculated attribute that must return a string]" />
   <strings name="[Required: name of the variable]" 
            value="[Required: Calculated attribute that must return an array of strings]" />
</persistent-variables>
```

Like `<variables>` persistent-variables are create in the order they appear in the `<persistent-variables>` element and previously created defines can be used in the `value` attribute of subsequently randomizations.