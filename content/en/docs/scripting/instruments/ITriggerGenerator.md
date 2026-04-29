---
title: Trigger Generator
description: Generate triggers
weight: 20
---

Generates trigger sequences for synchronization, event marking, or control of external devices.

**Availability:**

```python
context.Instruments.<TriggerGeneratorName>
```

## Properties

*No public readable properties are defined.*

## Methods

| Name                      | Signature                                                                                     | Description                                                                       |
| ------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `GenerateTriggerSequence` | `GenerateTriggerSequence(startTrigger: str, triggers: List[ITrigger]) -> None`                | Generates a trigger sequence when the specified trigger source occurs.            |
| `GenerateTriggerSequence` | `GenerateTriggerSequence(startTrigger: str, restart: bool, triggers: List[ITrigger]) -> None` | Same as above, with control over whether an ongoing sequence should be restarted. |

### Parameters

* **startTrigger (`str`)**
  Defines when the trigger sequence should start. Supported values:

  | Value             | Description                                                   |
  | ----------------- | ------------------------------------------------------------- |
  | `none`            | Start immediately when called.                                |
  | `internal`        | Triggered internally by the device (e.g., another component). |
  | `external`        | Triggered by an external hardware signal.                     |
  | `button`          | Triggered by a button press.                                  |
  | `response-port01` | Trigger received on response port 1.                          |
  | `response-port02` | Trigger received on response port 2.                          |
  | `response-port03` | Trigger received on response port 3.                          |
  | `response-port04` | Trigger received on response port 4.                          |

* **restart (`bool`)**
  If `True`, any ongoing trigger sequence is restarted when a new trigger occurs.

* **triggers (`List[ITrigger]`)**
  Array of trigger definitions to execute as a sequence.


## Typical usage example

```python
tg = context.Instruments.TriggerGenerator

# Assume triggers is a list/array of ITrigger objects
tg.GenerateTriggerSequence("none", triggers)

# Start on external trigger and allow restart
tg.GenerateTriggerSequence("external", True, triggers)
```


## Notes / gotchas

* The trigger sequence will not start until the specified `startTrigger` condition is met.
* Using `restart=True` can interrupt ongoing sequences.
* Timing and synchronization depend on hardware configuration and connected devices.
* Trigger definitions (`ITrigger`) must be constructed beforehand (e.g., via toolkits or predefined components).
