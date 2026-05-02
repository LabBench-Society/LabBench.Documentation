---
title: Log
description: Export the log of a participant to a PDF file.
weight: 30
---

Exports the experimental log of a participant to a PDF file.

* Executed after a session using the post-session action system.
* Reads log entries from the participant session.
* Generates a formatted PDF containing filtered log entries.
* Output is written to a file in the specified location.

## Definition

The post-session action is defined with:

```xml
<export-log name="Log Export" 
            location="C:\LabBenchExport\intro.postSessionActions" 
            filename="dynamic: f'{Participant}.pdf'" 
            id="Inventors' Way"
            level="debug"/>
```

and has the following attributes:

| Attribute | Type         | Specification                                                                                |
| --------- | ------------ | -------------------------------------------------------------------------------------------- |
| name      | string       | Required. Identifier of the action. Must be non-empty.                                       |
| location  | string       | Required. Directory where the generated PDF will be saved. Must exist at validation time.    |
| filename  | dynamic text | Required. Expression evaluated at runtime to produce the output file name.                   |
| id        | dynamic text | Optional. Expression evaluated at runtime. If provided, rendered in the header of each page. |
| level     | LogLevel     | Optional. Minimum log level to include. Defaults to Information.                             |

