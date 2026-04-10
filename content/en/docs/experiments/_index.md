---
title: Experiments
description: Information on how to write LabBench experiments.
weight: 40
---

{{% pageinfo %}}

The minimum for running an experiment with LabBench is to write an Experiment Definition File (`*.expx`). The Experiment Definition File consists of a definition of the experiment and its protocol. The protocol defines the experimental procedures. The protocol may contain localization of the protocol into different languages and additional files required by the protocol. Assets can be files such as images for visual stimuli, text files for instructions to the experimenter or subject, or scripts that extend the functionality of the built-in tests in LabBench. The Experiment Definition File also contains information required to run the protocol in a specific experiment. This includes information about the experimental setup, valid session IDs, data export, etc. 

{{% /pageinfo %}}


The Experiment Definition File is a plain text file, which means any text editor can be used. The format for these files is based on the eXtensible Markup Language (XML), a general-purpose markup language that can be used to implement domain specific languages, such as in this case the LabBench Language for Experiment Definition Files. 

The code listing below provides the structure of an Experiment Definition File:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<experiment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:noNamespaceSchemaLocation="https://files.labbench.io/xsd/6.0/experiment.xsd">
    <participant-validator regex="^S[0-9]{3}$|^TEST[0-9]{3}$"
                       advice="Please enter an ID in the form of SXXX, where X is a digit" />
    <experimental-setup-variants default="SetupID">
        <experimental-setup id="SetupID" name="Name of experimental setup">
            <devices>
                <!--  Please see page Experimental Setups -->
            </devices>
            <device-mapping>
                <!--  Please see page Experimental Setups -->
            </device-mapping>
        </experimental-setup>    
    </experimental-setup-variants>
    <protocol>
        <languages>
          <!--  Please see page Languages and Localization -->
        </languages>
        <sessions>
          <!--  Please see page Sessions -->
        </sessions>
        <properties>
          <!--  Please see page Protocol properties -->
        </properties>
        <persistent-variables>
          <!--  Please see page Persistent variables -->
        </persistent-variables>        
        <variables>
          <!--  Please see page Variables -->
        </variables>
        <templates>
              <includes>
                <!--  Please see page Templating -->
              </includes>
              <protocol-variables>
                <!--  Please see page Templating -->
              </protocol-variables>
              <template-variables>
                <!--  Please see page Templating -->
              </template-variables>
              <procedure-templates>
                <!--  Please see page Templating -->
              </procedure-templates>
              <assets>
                <!--  Please see page Templating -->
              </assets>           
        </templates>
        <procedures>
          <!--  Please see page Procedures -->
        </procedures>
        <assets>
          <!--  Contains files that are included in the protocol -->
        </assets>
    </protocol>
    <post-actions>
      <!--  Please see page Post-Session Actions -->
    </post-actions>
</experiment>
```

_Listing 1: Structure of an experiment definition file_

For an introduction to this format please see [Introduction to XML](/docs/labbench_resources/xmlprimer/)