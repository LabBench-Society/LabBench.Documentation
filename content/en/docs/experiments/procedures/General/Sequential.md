---
title: Sequential
description: Custom-defined experimental procedures implemented with a state machine and functionality in Python code.
weight: 20
---

{{% pageinfo %}}

The sequential procedure enables state machines to implement experimental procedures. Unlike most other procedures, it has no base functionality that can be configured in the LabBench Language; instead, its functionality must be implemented by a Python script that is called from its procedure events and state events.

{{% /pageinfo %}}

The purpose of the sequential procedure is to allow you to define procedures for which there is no ready-made LabBench procedure. Consequently, it is fundamentally different from all other LabBench procedures: whereas other LabBench procedures allow you to extend their functionality with Python code, the functionality of a sequential procedure must be implemented in Python.

The procedure assumes that the procedures to be implemented can be described with state machines. State machines are a formal way of describing systems that can exist in a finite number of discrete states. The core concept is the transitions that move the system from one state to another. 

Transitions are triggered by specific conditions, such as:

* A timer reaching a threshold
* A participant response (e.g., button press)
* A variable reaching a certain value
* Input from or the completion of an action being executed by an instrument.



## Procedure definition




## Scripting

### Writing result data
Scripts can create or update named result entries using strongly typed setter methods. If an entry with the given name already exists, it is replaced; otherwise, it is added.

Scalar values:
- `SetBool(name, value)`
- `SetInteger(name, value)`
- `SetNumber(name, value)`
- `SetString(name, value)`

List values:
- `SetBools(name, values)`
- `SetIntegers(name, values)`
- `SetNumbers(name, values)`
- `SetStrings(name, values)`

Example:


```python
Result.SetNumber("threshold", current_level)
Result.SetNumbers("reversals", reversal_levels)
Result.SetBool("criterion_met", True)
```

### Accessing stored result data

Result data are accessed from scripting using **dot notation based on the test ID**, followed by the name of the stored result entry. Each named entry is exposed as a dynamic property and automatically converted to a native Python type (e.g. `bool`, `int`, `float`, `str`, or lists thereof).

The general access pattern is:

```
<TestID>.<name>
```

If the named result entry does not exist, the expression evaluates to `None`.

Example:

```python
def Start(tc):
    # Access a scalar result value
    threshold = tc.SequentialTest01.threshold

    # Use the value in a conditional expression
    if tc.SequentialTest01.criterion_met:
        print("Stopping criterion reached")

    # Access a list-valued result
    reversals = tc.SequentialTest01.reversals
```

Internally, this notation resolves to a dynamic property lookup on the underlying `SequentialResult` object and corresponds to calling `DoGetProperty(name)`. This mechanism allows result values to be accessed concisely and safely from IronPython without exposing the underlying XML data structures or requiring explicit getter calls.
