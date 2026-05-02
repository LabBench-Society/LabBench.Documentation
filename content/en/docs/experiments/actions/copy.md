---
title: Copy file
description: Copy a file between two locations in the file system.
weight: 40
---

* Copies a file from a source directory to the action `location`.
* Executed as part of the experiment action pipeline (e.g., post-session actions).
* The filename is preserved; renaming is not supported.
* Overwrites existing files at the destination.

## Definition

The `<copy>` element defines a file copy operation from a source directory to the configured `location`.

```xml
<copy name="Copy file" 
    location="C:\LabBenchExport" 
    source="C:\LabBenchExport\intro.postSessionActions" 
    filename="dynamic: f'{Participant}.csv'" />
```

which has the following attributes:

| Attribute | Type            | Specification                                                                          |
| --------- | --------------- |  ------------------------------------------------------------------------------------- |
| name      | string          | Name of the action                                                                     |
| location  | string          | Destination directory where the file will be copied. Must exist at execution time.     |
| source    | string          | Source directory containing the file to copy. Must exist at execution time.            |
| filename  | dynamic text    | Must resolve to the filename (not path). Required.                                     |
