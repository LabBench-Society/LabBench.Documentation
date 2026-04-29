---
title: Button
description: Instructions on how to install LabBench
weight: 20
---

Represents a button-based response device used to capture discrete participant inputs (press/release events, active states, and reaction times).

**Availability:**

```python
context.Instruments.<ButtonName>
```

## Properties

| Name           | Type                      | Description                                                                                       |
| -------------- | ------------------------- | ------------------------------------------------------------------------------------------------- |
| `ReactionTime` | `float`                   | Reaction time associated with the most recent latched button activation (typically milliseconds). |
| `Activations`  | `List[IButtonActivation]` | List of recorded button activation events (press/release with timestamps).                        |

## Methods

| Name         | Signature                         | Description                                                         |
| ------------ | --------------------------------- | ------------------------------------------------------------------- |
| `Reset`      | `Reset()` → `None`                | Resets the button state and clears latched/active states.           |
| `GetActive`  | `GetActive()` → `str`             | Returns the currently active (pressed) button as a string.          |
| `IsActive`   | `IsActive(button: str)` → `bool`  | Returns `True` if the specified button is currently pressed.        |
| `GetLatched` | `GetLatched()` → `str`            | Returns the latched button (first detected press since last reset). |
| `IsLatched`  | `IsLatched(button: str)` → `bool` | Returns `True` if the specified button is latched.                  |

## Button identifiers

Button methods that take a `button: str` argument expect specific string literals. These correspond to physical buttons or logical controls.

| String        | Description        |
| ------------- | ------------------ |
| `"none"`      | No button          |
| `"1"` – `"8"` | Numbered buttons   |
| `"up"`        | Up direction       |
| `"down"`      | Down direction     |
| `"left"`      | Left direction     |
| `"right"`     | Right direction    |
| `"decrease"`  | Decrease control   |
| `"increase"`  | Increase control   |
| `"previous"`  | Previous selection |
| `"next"`      | Next selection     |
| `"clear"`     | Clear/reset action |

These values are returned by `GetActive()` and `GetLatched()` and must be used when calling `IsActive()` and `IsLatched()`.

## ButtonActivation (`IButtonActivation`)

Represents a single button event (press or release).

### Properties

| Name      | Type       | Description                                          |
| --------- | ---------- | ---------------------------------------------------- |
| `ID`      | `ButtonID` | Identifier of the button.                            |
| `Time`    | `float`    | Timestamp of the activation event.                   |
| `Pressed` | `bool`     | `True` if this event is a press, `False` if release. |

### Methods

| Name        | Signature             | Description                                                             |
| ----------- | --------------------- | ----------------------------------------------------------------------- |
| `GetButton` | `GetButton()` → `str` | Returns the button identifier as a string (same values as table above). |

## Typical usage

```python
button = context.Instruments.Button

# Check current state
if button.IsActive("1"):
    print("Button 1 is pressed")

# Check latched response
latched = button.GetLatched()
rt = button.ReactionTime

# Iterate over activations
for a in button.Activations:
    print(a.GetButton(), a.Time, a.Pressed)

# Reset between trials
button.Reset()
```

## Notes / gotchas

* `Reset()` should typically be called between trials to clear latched states.
* Latched state represents the first detected press since last reset.
* `ReactionTime` is only meaningful after a latched activation has occurred.
* Button identifiers must match the string literals listed above.
* `Activations` includes both press and release events; use `Pressed` to distinguish.
