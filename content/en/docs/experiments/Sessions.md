---
title: Sessions
description: Protocols can be devided into sessions.
weight: 19
---

{{% pageinfo %}}

Protocols can be devided up into multiple sessions that typically are repeated at different time points/days during the study. When sessions are defined in a protocol each test in the protocol must specify which session it belongs to with its `session` attribute.

{{% /pageinfo %}}

Multi-session protocols are created by including a `<sessions>` element in the Experiment Definition File:

```xml
<sessions>
   <session id="SES01" name="Session 1" />
   <session id="SES02" name="Session 2" />
</sessions>
```

The `<sessions>` element consists of a series of `<session>` elements that each define a session in the protocol. Each `<session>` must specify two attributes; `id` which is the unique identifier (ID) that is used within the protocol to identify the session, and `name` which is the name of the session that will be shown to the experimenter when (s)he must choose which session to perform when the LabBench Runner executes the protocol.

When the `<sessions>` element is defined in a protocol each test must specify with its `session` attribute to which session the test belongs to:

```xml
<psychophysics-response-recording id="SES01COVAS"                    
                                  name="Session 1: COVAS (10min)"
                                  experimental-setup-id="vas"
                                  session="SES01"
                                  duration="10 * 60"
                                  sample-rate="1" />
```

When LabBench Runner executes the protocol only tests belonging to the currently active session will be shown in its protocol window. From calculated attributes the currently active session is available as the `ActiveSession` variable.