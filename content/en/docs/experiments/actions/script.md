---
title: Scripts
description: Run a script at the completetion of a session
weight: 30
---

The `<export-script>` post-session action executes a calculated script after a session has completed.

- Used to implement custom post-session logic using calculated parameters.
- Supports execution of Python functions defined in file assets.
- Integrates with the LabBench blackboard for passing execution context.
- Can be executed per session or in batch across stored participants.

Execution behavior:

- Sets `ExportLocation` and `ExportName` on the context before execution.
- Executes the provided script expression.
- Expects the script to return `True` on success.
- Throws an exception if the script returns `False`.

## Definition

The `<export-script>` element defines a script-based post-session action.

```xml
<export-script name="Upload data" 
    location="C:\LabBenchExport\intro.postSessionActions" 
    script="Uploader.upload_file(f'{Participant}.csv')" />
```

which has the following attributes:

| Attribute | Type | Specification |
|----------|------|--------------|
| name | string | Identifier of the post-session action. Must be non-empty. |
| location | string | Directory where outputs are stored. Must exist at validation time. |
| script | string | Calculated parameter expression executed as the action. Must return a boolean indicating success. |

### file-asset

Almost invariably, <export-scripts> relies on executing Python code defined in scripts:

```xml
<file-asset file="Script.py" />
```

| Attribute | Type | Specification |
|----------|------|--------------|
| file | string | Path to the Python script asset. Makes functions available to calculated parameters. |

### variable

The example above uses an object that implements an FTP client and can upload a file. This client is instantiated as a protocol variable:

```xml
<variable name="Uploader" value="func: Script.CreateUploader(context)" />
```

## Integration Example

In this example, the `<export-script>` action depends on coordinated configuration:

- `<file-asset>` exposes Python functions.
- `<variable>` instantiates a Python object using `func:`.
- `<export-script>` invokes methods on that object.

Minimal Python interface required by the action:

```python
def CreateUploader(context):
    return AnonymousFTPClient(context, "127.0.0.1", port=2121)

class AnonymousFTPClient:
    def upload_file(self, local_filename):
        # Must return True on success
        return True
```

Key requirements:

- Functions referenced via `func:` must accept `context`.
- The script expression must evaluate to a boolean.
- `context.ExportLocation` is provided automatically before execution.

## Example protocol

