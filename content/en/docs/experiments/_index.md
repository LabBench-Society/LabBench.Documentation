---
title: Experiments
description: Information on how to write LabBench experiments.
weight: 40
---

{{% pageinfo %}}

The minimum for running an experiment with LabBench is to write an Experiment Definition File (\verb|*.expx|). The Experiment Definition File consists of a definition of the experiment and its protocol. The protocol defines the experimental procedures. The protocol may contain localization of the protocol into different languages and additional files required by the protocol. Assets can be files such as images for visual stimuli, text files for instructions to the experimenter or subject, or scripts that extend the functionality of the built-in tests in LabBench. The Experiment Definition File also contains information required to run the protocol in a specific experiment. This includes information about the experimental setup, valid session IDs, data export, etc. 

{{% /pageinfo %}}


The Experiment Definition File is a plain text file, which means any text editor can be used. The format for these files is based on the eXtensible Markup Language (XML), a general-purpose markup language that can be used to implement DSL. 

The code listing below provides the structure of an Experiment Definition File:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<experiment xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://labbench.io https://labbench.io/xsd/4.0.0/experiment.xsd">
    <subject-validator regex="^S[0-9]{3}$"
                       advice="Please enter an ID in the form of SXXX, where X is a digit" />
    <experimental-setup>
        <devices> <!--  Contents omitted for brevity --> </devices>
        <device-mapping> <!--  Contents omitted for brevity --> </device-mapping>
    </experimental-setup>
    <protocol>
        <languages> <!--  Contents omitted for brevity --> </languages>
        <defines> <!--  Contents omitted for brevity --> </defines>
        <tests> <!--  Contents omitted for brevity --> </tests>
        <assets> <!--  Contents omitted for brevity --> </assets>
    </protocol>
    <post-actions> <!--  Contents omitted for brevity --> </post-actions>
</experiment>
```
_Listing 1: Structure of an experiment definition file_

## Syntax

We will now give a brief but complete introduction to what you need to know about XML for writing Experiment Definition Files. 

The first line in Listing 1 identifies the file as an XML file and its encoding. All files include this line, and even though other character encodings exist today, there is little reason to use other encodings than UTF-8. As a result, the first line is invariant, and the Experiment Definition Files must always start with this line. 

XML documents are built from a hierarchical structure of XML elements. All XML documents have one root element that may contain nested elements, which, in turn, can contain more nested elements in an arbitrary deep hierarchical structure. XML elements consist of a starting tag, a closing tag, and content between these tags. In Listing 1, the root element is an experiment element, with a starting tag of `<experiment>` and a closing tag of `</experiment>`. 

The exception to this rule is self-closing elements. The `<subject-validator>` is an example of a self-closing tag, as it is not followed by a `</subject-validator>` tag; instead, the starting tag ends with `/>`. Self-content tags allow for a more concise and easier-to-read document. The use of self-closing elements is widespread in the LabBench Language.

The `<experiment>` element has other elements as its content: a `<subject-validator>`, a `<experimental-setup>`, a `<protocol>` element, and a `<post-actions>` element. 

XML elements can be adorned with characteristics in the form of XML attributes. In Listing 1, `regex` and `advice` are attributes of the `<subject-validator/>` element, which provides a regular expression to validate session IDs and help the experimenter if a session ID fails this validation. Attributes are in the form of `name=”value of the attribute”` and are listed after the element's name and before the `>` character or `/>` character for self-closing elements.

The last XML syntax that may be useful for you are comments. Comments are text in the file that will be ignored by LabBench and can be used to add additional documentation to a protocol not supported by the language. No language, no matter how domain-specific, can hope to contain all constructs that are needed to describe its content fully. With comments, additional information such as an explanation for the rationale for the design of a protocol, references, and similar information can be added to protocols. In Listing 1, the text `<!-- Contents omitted for brevity -->` is a comment, and in general, LabBench will ignore everything written between the `<!-- and -->` tags.

The above description of the XML format is all the knowledge of XML itself needed to write Experiment Definition Files. Naturally, one needs significant additional knowledge of the LabBench Language, such as the correct content of the elements, etc. However, this knowledge does not need to be rote learning. The two additional attributes, `xmlns:xsi` and `xsi:schemaLocation`, are used to leverage existing tools from computer science that make rote learning of all the valid elements and attributes in the LabBench Language unnecessary.

## Development tools

For writing Experiment Definition Files, as well as Python scripts, an Integrated Development Environment (IDE) makes the process significantly easier due to code completion. Code completion means that you do not need to remember which XML elements or attributes are valid at a given place in your definition file. Instead, tap `CTRL + SPACE` (for Visual Studio Code) to get a list of valid elements or attributes Figure 1. Code completion also reduces the need for manual typing, as you can simply select the required element or attribute and then press enter, at which point the IDE will complete the code for you without requiring typing. 

![](/images/experiments/CodeCompletion.png)

## Visual Studio Code

To use Visual Studio Code to develop LabBench experiments, first download the installer from:

* [https://code.visualstudio.com/](https://code.visualstudio.com/) 

Then, install the program. However, Visual Studio Code does not support XML code completion without a suitable editor extension. The Red Hat XML extension can be recommended to enable XML code completion.

To install this extension: 1) open Visual Studio Code, 2) choose extensions by clicking the fifth icon in the leftmost pane in the editor, 3) search for XML and select the XML extension by Red Hat, and 4) click install. When the extension has been installed code completion will be available in Visual Studio Code by pressing \verb|CTRL + SPACE|.

![](/images/experiments/VSCodeRedharXML.png)
