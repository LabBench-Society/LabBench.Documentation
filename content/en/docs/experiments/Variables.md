---
title: Variables
description: Variables can be used in calculated and dynamic text attributes, and Python scripts.
weight: 20
---

{{% pageinfo %}}

Variables  can be used in calculated and dynamic text attributes, and Python scripts throughout a protocol. They enable the specification of parameters for test configuration (i.e., attribute values) that can be reused for multiple attributes, thereby eliminating the need for duplicate values. They also provide a convenient method for creating and using Python classes from single-line Python statements within Experiment Definition Files or from functions that are called from Python scripts. Python classes can significantly simplify the programming of advanced protocols. 

{{% /pageinfo %}}

Defines are specified in the `<variables>` element of an Experiment Definition File:

```xml
<variables>
   <!-- Up/Down Parameters -->
   <variable name="Imax" value="1">
   <variable name="ReversalRule" value="1" />
   <variable name="StartIntensity" value="0.001" />
   <variable name="StepSize" value="0.25" />
   <variable name="StepSizeReduction" value="0.5" />
   <variable name="MaxStepSizeReduction" value="0.25"/>
   <variable name="SkipRule" value="1"/>
   <variable name="StopRule" value="6"/>
</variables>
```

The `name` attribute is the name by which the variable can be used by in calculated and dynamic text attributes as well as in Python scripts (`tc.[Name of variable]`) The `value` attribute of the `<variable>` is a calculated attribute, which can consist of a single line Python expression or which can call a Python script.

Variables can also be grouped into structs:

```xml
<struct name="StopSignal">
   <variable name="TrainingStopSignals" value="2 if 'TEST' in Participant else 5"/> 
   <variable name="NumberOfStopSignals" value="5 if 'TEST' in Participant else 30"/> 
   <variable name="LowDelayLimit" value="50"/>
   <variable name="HighDelayLimit" value="750"/>
   <variable name="FixationDelay"  value="500"/>
   <variable name="ResponseTimeout"  value="1000"/>
   <variable name="FeedbackDelay" value="1000"/>            
   <variable name="FeedbackTime" value="1000"/>
   <variable name="Pause" value="1000"/>
   <variable name="Period" value="(StopSignal.FixationDelay + StopSignal.ResponseTimeout + StopSignal.FeedbackDelay + StopSignal.FeedbackTime + StopSignal.Pause)/1000"/>

   <variable name="Task" value="func: StopSignalGameScript.CreateTask(tc)"/>
</struct>
```

These variables can then be used in the attributes of a protocol and within Python scripts. Below is an example of how the defines listed above is used for the configuration of a `<psychophysics-threshold-estimation>` test:

```xml
<psychophysics-threshold-estimation ID="TEST" name="Test of subject response" stimulus-update-rate="20000">
   <update-rate-random min="2000" max="3000" />

   <yes-no-task />

   <channels>
      <channel ID="C01" name="Pulse 1" Imax="Imax">
         <up-down-method reversal-rule="ReversalRule"
                        skip-rule="SkipRule"
                        start-intensity="StartIntensity"
                        step-size="StepSize"
                        max-step-size-reduction="MaxStepSizeReduction"
                        step-size-reduction="StepSizeReduction"
                        stop-rule="StopRule" />

         <stimulus>
            <pulse Is="x" Ts="1" Tdelay="0"/>
         </stimulus>
      </channel>
   </channels>
</psychophysics-threshold-estimation>
```

Variables are create in the order they appear in the `<variables>` element and previously created defines can be used in the `value` attribute of subsequently variables.