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






## Defining templates

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

### Includes

### Template variables

### Protocol variables

### Procedure templates

### Assets

## Template construction

## Procedure constructors

### Foreach loops

### Conditional construction



