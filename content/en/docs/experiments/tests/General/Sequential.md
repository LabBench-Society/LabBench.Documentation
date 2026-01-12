---
title: Sequential
description: Custom-defined experimental procedures implemented with a state machine and functionality in Python code.
weight: 20
---

{{% pageinfo %}}


{{% /pageinfo %}}


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
