---
title: Templating
description: Information on how to use templates to construct procedures.
weight: 40
---

{{% pageinfo %}}

Templates provide a mechanism by which procedures can be constructed from procedure templates, which provides a mechanism for avoiding duplicate code in Experiment Definition Files (*.expx) and a mechanism by which repositories of template procedures can be included from other protocols.

{{% /pageinfo %}}

Templates are included in the LabBench language for two purposes:

1. To avoid duplicate code
2. To make it possible to construct protocols from templates in other protocols.

Without templates, the procedures that need to be repeated multiple times in a protocol would result in the same code being repeated each time the procedure is performed. Repetition of procedures is common in multiple-session studies, where the same set of procedures must be repeated for each session. 

Duplication (copy-paste) of code is a notorious code smell and a symptom of either bad programming or, if the programming language does not allow it, a badly designed programming language. One of the main reasons it is considered bad programming is that if the code needs to be changed, you will need to change it in multiple places. Experience has shown that, in most cases, code duplication is overlooked, leading to incorrect procedures. 

Templates make it possible to construct procedures from templates, meaning the code defining the procedure (the template) can be written once and then constructed with template constructors multiple times in a protocol. Because procedures must have unique identifiers (`id`), and procedures might need to be tailored to where they are used, the template constructors can modify the templates when they are constructed. Consequently, template constructors should be conceptually viewed as code that generates code.

Below is an example of a template defining a stop-signal task:

```xml
<procedure-templates>
    <stimulation-sequence id="StopSignalTrainingTemplate"
        experimental-setup-id="sstSetup"
        response-collection="none"
        stimulus-update-rate="44100">
        <dependencies>
            <dependency id="var: dependency" virtual="true" />
        </dependencies>
        <!-- Content omitted for brevity. -->
    </stimulation-sequence>
</procedure-templates>
```

*Code Listing 1*

which is then constructed in the `<procedures>` element of the Experiment Definition File (*.expx) with a template constructor:

```xml
<procedures>
    <stimulation-sequence-constructor id="StopSignalTraining" 
        name="Stop Signal Task (Training Task)" 
        template="StopSignalTrainingTemplate">
        <variables>
            <string name="dependency" value="" />
        </variables>
    </stimulation-sequence-constructor>
</procedures>
```

*Code Listing 2*

When the constructor runs, it takes the template, executes all template variable statements, and inserts the generated procedure at the location in the protocol where it is defined. Template variable statements are Python code that can be used in a template for string, dynamic text, and calculated attributes. These statements are identified with the `var:` keyword, for example, the id attribute in the template above is generated with the template variable statement: `id="var: dependency"`. In this statement, everything after the `var:` keyword is evaluated as a Python expression that must return a string. This example is the simplest form of template variable statement, where a template variable `dependency` is inserted verbatim and used as the value for the `id` attribute. We will later see examples of more complicated statements.

Templates are defined in the `<templates>` element and can be used to construct procedures in the `<procedures>` element of an Experiment Definition File (*.expx). However, it is also possible to include the `<templates>` element from other protocols in the same repository:

```xml
<includes>
    <include protocol-id="questionnaires.dass" />
    <include protocol-id="cogni.sst.game" />
</includes>
```

*Code Listing 4*

These include statements are from the <a href="https://github.com/LabBench-Society/Protocols/tree/main/intro.labbench" target="_blank">intro.labbench</a> protocol that includes a gamified version of the Stop-Signal Task and the Depression, Anxiety, and Stress Scales from the <a href="https://github.com/LabBench-Society/Protocols/tree/main/cogni.sst.game" target="_blank">cogni.sst.game</a> and <a href="https://github.com/LabBench-Society/Protocols/tree/main/questionnaires.dass" target="_blank">questionnaires.dass</a> protocols, respectively. This is an example of how repositories can contain collections of protocols that serve as building blocks for other protocols.

## Defining templates

Templates are defined with in the `<templates>` element:

```xml
<?xml version="1.0" encoding="utf-8" ?>
<experiment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:noNamespaceSchemaLocation="https://files.labbench.io/xsd/6.0/experiment.xsd">
    <experimental-setup-variants default="JOYSTICK">
        <!-- Experimental setups omitted for brevity. -->
   </experimental-setup-variants>                    
    <protocol>
        <templates>
            <includes>
                <!-- Inclusion of templates from other protocols -->
            </includes>
            <template-variables>             
                <!-- Definition of template variables in othermost scope -->   
            </template-variables>            
            <protocol-variables>
                <struct name="StopSignal">
                    <!-- Content omitted for brevity. -->
                </struct>
            </protocol-variables>
            <procedure-templates>
                <stimulation-sequence id="StopSignalTrainingTemplate"
                    experimental-setup-id="sstSetup"
                    response-collection="none"
                    stimulus-update-rate="44100">
                    <dependencies>
                        <dependency id="var: dependency" virtual="true" />
                    </dependencies>
                    <!-- Content omitted for brevity. -->
                </stimulation-sequence>

                <stimulation-sequence id="StopSignalGameTemplate"
                    experimental-setup-id="sstSetup"
                    response-collection="none"
                    stimulus-update-rate="44100">
                    <dependencies>
                        <dependency id="var: trainingProcedure" virtual="true" />
                    </dependencies>
                    <!-- Content omitted for brevity. -->
                </stimulation-sequence>    
            </procedure-templates>

            <assets>
                <file-asset file="StopSignalGameImages.zip">
                    <!-- Content omitted for brevity. -->
                </file-asset>
                <file-asset file="StopSignalGameScript.py" />
                <file-asset id="StopSignalFont" file="Roboto-Regular.ttf" />
            </assets>
        </templates>
        <procedures>
            <stimulation-sequence-constructor id="StopSignalTraining" 
                name="Stop Signal Task (Training Task)" 
                template="StopSignalTrainingTemplate">
                <variables>
                    <string name="dependency" value="" />
                </variables>
            </stimulation-sequence-constructor>

            <stimulation-sequence-constructor id="StopSignalGame" 
                name="Stop Signal Game" 
                template="StopSignalGameTemplate">
                <variables>
                    <string name="trainingProcedure" value="StopSignalTraining" />
                </variables>
            </stimulation-sequence-constructor>
        </procedures>
    </protocol>
</experiment>
```

*Code Listing 5*

The template element defines; templates included from other protocols <includes> element, template variables `<template-variables>` that can be used in template variable statements to construct string, dynamic string, and calculated attributes, protocol variables `<protocol-variables>`, procedure templates `<procedure-templates>`, and assets `<assets>` that will be required by the constructed procedures.

### Includes

The `<includes>` element makes it possible to include templates from other protocols within the same repository. The following `<includes>` element include `<include>` all the templates from the <a href="https://github.com/LabBench-Society/Protocols/tree/main/cogni.sst.game" target="_blank">cogni.sst.game</a> protocol into the <a href="https://github.com/LabBench-Society/Protocols/tree/main/intro.labbench" target="_blank">intro.labbench</a>:

```xml
<includes>
    <include protocol-id="cogni.sst.game" />
</includes>
```

*Code Listing 6*

What happens with the `<include>` in code listing 6 is that all the elements within the `<templates>` element of code listing 5 get imported into the `intro.labbench` protocol, which means that procedure constructors in the <procedure> element in the `intro.labbench` protocol can use templates from the `cogni.sst.game` protocol. 

### Template variables

The `<template-variables>` defines top-level template variables that can be used in template variable statements. Constructors may define further template variables that are added to the top-level template variables.

**Please note that not all template variables used in templates have to be included in this definition of top-level template variables.** A common paradigm is to defer the definition of template variables to constructors, providing them with a mechanism to customise the construction of templates.

As all template variables are used to construct strings, their only types are strings and arrays of strings, and structures of strings.

The simplest template variable definition is the definition of a string:

```xml
<string name="dependency" value="PARTICIPANT" />
```
*Code Listing 7*

Strings can be organised into arrays:

```xml
<strings name="Trials" value="T1;T2;T3;T4" />
```
*Code Listing 8*

Arrays are used in foreach loops (please see section [Foreach loops](/docs/experiments/templates/#foreach-loops) to generate multiple procedures within the foreach loop.

Strings variables can also be grouped into structs:

```xml
<struct name="Configuration">
    <string name="ID"             value="SLOT06"  />
    <string name="Previous"       value="SLOT05"  />
    <string name="TestSite"       value="SITE04"  />
    <string name="TimeConstraint" value="func: Script.GetTimeSlotDuration(tc)"  />
</struct>
```
*Code Listing 9*

Variables within a struct are accessed as `[Name of struct].[Name of variable]`.

Structs can also be organised into arrays:

```xml
<structs name="TimeSlots">
    <struct>
        <string name="ID"             value="SLOT01"  />
        <string name="Previous"       value=""  />
        <string name="TestSite"       value=""  />
        <string name="TimeConstraint" value="0"  />
    </struct>
    <struct>
        <string name="ID"             value="SLOT02"  />
        <string name="Previous"       value="SLOT01"  />
        <string name="TestSite"       value=""  />
        <string name="TimeConstraint" value="func: Script.GetTimeSlotDuration(context)" />
    </struct>
    <!-- SLOT03 to SLOT05 omitted for brevity -->
    <struct>
        <string name="ID"             value="SLOT06"  />
        <string name="Previous"       value="SLOT05"  />
        <string name="TestSite"       value="SITE04"  />
        <string name="TimeConstraint" value="func: Script.GetTimeSlotDuration(context)"  />
    </struct>
</structs>
```
*Code Listing 8*

Arrays of structs can also be used in foreach loops (please see the [Foreach loops](/docs/experiments/templates/#foreach-loops) section) to generate multiple procedures within the foreach loop.

### Protocol variables

Protocol variables can be specified in the <protocol-variables> element within the <templates> section. When the protocol is constructed, these variables are copied into the top <variables> element in the <protocol> element. 

Consequently, if the <procedure-templates> are only within the same protocol, there is no difference between defining the variables within the <template> element or in the top-level <variables> element. However, if the protocol is intended to be included in other protocols, the <protocol-variables> element allows you to define variables that are imported into those protocols.

Below is an example of variables that are defined for the Stop-Signal game:

```xml

```

### Procedure templates

### Assets

## Template construction


### Foreach loops

```xml
<foreach variable="Slot" in="TimeSlots">                    
    <questionnaire-constructor
        id="var: f'{Session}{Slot.ID}PREP'" 
        name="var: f'AREA PREPARATION ({Slot.ID})'" 
        session="var: Session"
        template="prepareTimeSlot">
        <variables>
            <string name="Previous" value="var: f'{Session}{Slot.Previous}PREP' if not Slot.Previous else ''" />
        </variables>
    </questionnaire-constructor>
</foreach>
```

### Conditional construction

```xml
<if condition="not Slot.TestSite">
    <questionnaire-constructor 
        id="var: f'{Session}{Slot.TestSite}APPLICATION'" 
        name="var: f'{Slot.TestSite} Pruritogen (Application)'" 
        session="var: Session"
        template="application" />
</if>
```


