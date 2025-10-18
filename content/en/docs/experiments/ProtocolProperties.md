---
title: Protocol properties
description: Control and configure the behavior of a protocol.
weight: 16
---

{{% pageinfo %}}

The behavior of a protocol when LabBench Runner executes it can be controlled with the use of protocol properties.

{{% /pageinfo %}}

Protocol properties is specified with the `<properties>` element in the `<protocol>` element of experiment definition files:

```xml
<properties>
   <rerun-policy message="[The message to be displayed to the operator]" 
                 require-reason="[true or false]"
                 force-warning="[true or false]" />
   <incomplete-protocol-warning value="[true or false]"/>
</properties>
```

## Re-run policy

The data set for a subject can store one result for each test in a protocol. If a test is rerun the previous result is replaced with the new result from the rerun. The `<rerun-policy>` element determines how LabBench Runner will handle rerunning tests in the protocol.

The `message` attribute is the message that will be displayed to the experimenter when a test is started if a previous result will be replaced at the completion of the test. This is a dynamic text attribute with a default value of "Rerunning the test will discard the current results.".

The `require-reason` attribute controls whether or not the experimenter is forced to provide an entry in the experimental log that explains the reason for rerunning the test before a rerun is allowed. This attribute is primarely used for clinical trials where there need to be an audit trail for why results have been discarded. The default value for this attribute is false, meaning the experimenter is per default not required to provide a reason for rerunning tests in the protocol.

The `force-warning` attribute only applies to tests that do not display a warning because their data is not replaced when they are rerun. The default behavior for these tests is not to display a warning. Setting the `force-warning` attribute to true would force a warning to be displayed for these tests. One example of such a test is Questionnaires; when they are rerun, their original data is displayed and can be modified in a rerun. When the data of a questionnaire is modified, the changes are automatically added to the experimental log, and thus an audit trail of the modifications is created.

## Incomplete protocol warning

If a session is closed and not all the tests in the session have been completed, then LabBench Runner will display an incomplete protocol warning. This incomplete protocol warning will not be displayed if the `incomplete-protocol-warning` element sets its `value` to false.