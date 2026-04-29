---
title: Triggers
description: Toolkit for creating triggers in Python code
weight: 20
---

Provides programmatic construction of trigger signals and trigger sequences for synchronization and event marking.

**Availability:**

```python
context.Triggers
```

## Properties

*No public readable properties are defined.*

## Methods

| Name            | Signature                                        | Description                                          |
| --------------- | ------------------------------------------------ | ---------------------------------------------------- |
| `Sequence`      | `Sequence() -> TriggerSequence`                  | Creates a container for building a trigger sequence. |
| `CreateTrigger` | `CreateTrigger(duration: float) -> ValueTrigger` | Creates a trigger with a specified duration.         |

## Typical usage example

```python
trg = context.Triggers

trigger = trg.CreateTrigger(1.0) \
    .TriggerOut() \
    .Interface(16)

sequence = trg.Sequence() \
    .Add(trigger)

# sequence can be passed where ITrigger[] is expected
```

## Trigger Sequence (`TriggerSequence`)

### Description

Represents an ordered collection of triggers that can be passed as a trigger array.

### Availability

```python
context.Triggers.Sequence()
```

### Properties

*No public readable properties are defined.*

### Methods

| Name  | Signature                                   | Description                     |
| ----- | ------------------------------------------- | ------------------------------- |
| `Add` | `Add(trigger: ITrigger) -> TriggerSequence` | Adds a trigger to the sequence. |

## Value Trigger (`ValueTrigger`)

### Description

Defines a trigger signal with duration and one or more output codes.

### Availability

```python
context.Triggers.CreateTrigger(duration)
```

### Properties

| Name       | Type                 | Description                                   |
| ---------- | -------------------- | --------------------------------------------- |
| `Duration` | `float`              | Duration of the trigger (unit not specified). |
| `Codes`    | `List[ITriggerCode]` | Output codes associated with the trigger.     |

### Methods

| Name                 | Signature                                        | Description                                                           |
| -------------------- | ------------------------------------------------ | --------------------------------------------------------------------- |
| `TriggerOut`         | `TriggerOut() -> ValueTrigger`                   | Adds a standard trigger output signal.                                |
| `StimulusTriggerOut` | `StimulusTriggerOut() -> ValueTrigger`           | Adds a stimulator trigger output signal.                              |
| `Interface`          | `Interface(value: int) -> ValueTrigger`          | Adds a trigger code for the trigger interface with a specified value. |

## Trigger Code (`ValueTriggerCode`)

### Description

Represents a single trigger output with associated value.

### Availability

Returned via `ValueTrigger.Codes`

### Properties

| Name     | Type            | Description                               |
| -------- | --------------- | ----------------------------------------- |
| `Output` | `TriggerOutput` | Target output for the trigger signal.     |
| `Value`  | `int`           | Value associated with the trigger output. |

### Methods

| Name        | Signature            | Description                                      |
| ----------- | -------------------- | ------------------------------------------------ |
| `GetOutput` | `GetOutput() -> str` | Returns the string representation of the output. |

## Notes / gotchas

* `TriggerSequence` is implicitly converted to an array of triggers when used in generation APIs.
* A `ValueTrigger` can contain multiple output codes; all are emitted during the trigger duration.
* Duration is required; a trigger without codes will not produce output.
* Ordering in `TriggerSequence` determines execution order.

