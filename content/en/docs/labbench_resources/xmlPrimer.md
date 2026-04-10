---
title: Introduction to XML
description: Introduction to the format of experiment definition files
weight: 40
---

{{% pageinfo %}}

The Experiment Definition File is a plain text file, which means any text editor can be used. The format for these files is based on the eXtensible Markup Language (XML), a general-purpose markup language that can be used to implement domain specific languages, such as in this case the LabBench Language for Experiment Definition Files. 

{{% /pageinfo %}}

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


## Syntax

We will now give a brief but complete introduction to everything you need to know about XML for writing Experiment Definition Files. 

### Opening statement

The first line in Listing 1 identifies the file as an XML file and its encoding. All files include this line, and even though other character encodings exist today, there is little reason to use other encodings than UTF-8. As a result, the first line is invariant, and the Experiment Definition Files must always start with this line. 

### Elements

XML documents are built from a hierarchical structure of XML elements. All XML documents have one root element that may contain nested elements, which, in turn, can contain more nested elements in an arbitrary deep hierarchical structure. XML elements consist of a starting tag, a closing tag, and content between these tags. In Listing 1, the root element is an experiment element, with a starting tag of `<experiment>` and a closing tag of `</experiment>`. 

The exception to this rule is self-closing elements. The `<participant-validator>` is an example of a self-closing tag, as it is not followed by a `</participant-validator>` tag; instead, the starting tag ends with `/>`. Self-closing elements allow for a more concise and easier-to-read document. The use of self-closing elements is widespread in the LabBench Language.

The `<experiment>` element has other elements as its content: such as `<experimental-setup>`, `<protocol>` element, and `<post-actions>` elements. 

### Attributes 

XML elements can be adorned with characteristics in the form of XML attributes. In Listing 1, `regex` and `advice` are attributes of the `<participant-validator/>` element, which provides a regular expression to validate participant IDs and help the operator if a session ID fails this validation. 

Attributes are in the form of `name=”value of the attribute”` and are listed after the element's name and before the `>` character or `/>` character for self-closing elements.

Each attribute has a type. Currently, the following types are used in the LabBench Language:

|Type            | Description                                                                                             | Example                    |
|----------------|---------------------------------------------------------------------------------------------------------|----------------------------|
| string         | A string is a data type used to represent textual data.                                                 | `id="SR01"`                |
| int            | An int (integer) is a data type that represents whole numbers without fractional or decimal parts.      | `no-of-stimuli="10"`       |
| double          | A float (floating-point) is a data type that represents real numbers with fractional or decimal parts.  | ` vas-pdt="0.1"`           |
| bool           | A bool (boolean) is a data type that represents one of two truth values: true or false.                 | `second-cuff="false"`      |
| enum           | An enum (enumeration) is a data type that defines a set of named constant values for representing distinct options or states. | `stop-mode="stop-on-maximal-rating"` |
| calculated     | Is either a single line python statement, or a call to a python function in a python script. These must return a value of the correct type. | `pressure-stimulate="1.0 * SR01.PTT"` or `stimulate="func: Script.Stimulate(tc,x)` | 
| dynamic string | Is either a verbatim string or a single line calculated attribute that must return a string.            | `title="Please rate your pain."` or `title="dynamic: PainText['Title']"` |

Please see the Scripting session of this documentation site for more information about how to define and use calculated and dynamic string attributes.

### Comments 

The last XML syntax that may be useful for you are comments. Comments are text in the file that will be ignored by LabBench and can be used to add additional documentation to a protocol not supported by the language. No language, no matter how domain-specific, can hope to contain all constructs that are needed to describe its content fully. With comments, additional information such as an explanation for the rationale for the design of a protocol, references, and similar information can be added to protocols. In Listing 1, the text `<!-- Contents omitted for brevity -->` is a comment, and in general, LabBench will ignore everything written between the `<!-- and -->` tags.

The above description of the XML format is all the knowledge of XML itself needed to write Experiment Definition Files. Naturally, one needs significant additional knowledge of the LabBench Language, such as the correct content of the elements, etc. However, this knowledge does not need to be rote learning. The two additional attributes, `xmlns:xsi` and `xsi:schemaLocation`, are used to leverage existing tools from computer science that make rote learning of all the valid elements and attributes in the LabBench Language unnecessary.

