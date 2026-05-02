---
title: Export Data
description: Export data to one of the data formats supported by LabBench
weight: 30
---

* Defines a post-session action that exports participant data to a single file.
* Executes after a participant session has completed.
* Produces one output file per participant.
* The output format determines the file type and exporter used.

## Definition

The post-session action is defined with:

```xml 
<export-data name="Export data" 
            location="C:\LabBenchExport\intro.postSessionActions"
            format="json" 
            filename="dynamic: f'{Participant}.json'" />
```

and has the following attributes:

| Attribute | Type   | Specification                                                                                                             |
| --------- | ------ | ------------------------------------------------------------------------------------------------------------------------- |
| name      | string | Identifier of the post-session action. Required. Must be non-empty.                                                       |
| location  | string | File system directory where the exported file is written. Required. Must exist at validation time.                        |
| format    | enum   | Output format controlling file representation and default file extension. Supported values are defined in `ExportFormat`. |
| filename  | string | Script expression evaluated at runtime to produce the output file name. Required. Must pass script validation.            |

### format

| Value  | Description                        | Default Extension |
| ------ | ---------------------------------- | ----------------- |
| json   | Javescript Object Notation         | json              |
| hdf5   | Hierarchical Data Format version 5 | h5                |
| matlab | Matlab File Format (Level 5)       | mat               |
