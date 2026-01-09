---
title: Keyboard
description: Instructions on how to install LabBench
weight: 20
---

{{% pageinfo %}}
The Keyboard Toolkit provides a simple, deterministic way to handle keyboard input in LabBench experiments by exposing a latched key state rather than transient key-down events. It continuously monitors the system keyboard, records which keys have been pressed, and allows experiment logic to query those presses using clear, string-based key identifiers. Key presses remain available until explicitly cleared.
{{% /pageinfo %}}


## Keyboard Toolkit

The Keyboard Toolkit provides a simple, robust way to handle keyboard input in LabBench experiments, especially when controlling trial flow from Python via IronPython. Instead of reacting to instantaneous key-down events, the toolkit exposes a **latched key state** model. Once a key press is detected, it remains available to your code until you explicitly clear it.

This design is ideal for experimental state machines, where logic is evaluated repeatedly (for example, once per frame or scheduler step) and key presses must be handled **exactly once** and deterministically.

### How It Works

- The underlying keyboard device continuously monitors the system keyboard.
- When a key is detected as pressed, it is stored internally.
- Your Python code queries this state using `Keyboard.Pressed("KEY")`.
- After handling the input, you reset the keyboard state with `Keyboard.Clear()`.

This design avoids common timing problems such as missed key presses or repeated triggering caused by holding a key down across multiple evaluation cycles.

### Typical Usage Pattern

The following example shows how the Keyboard Toolkit is commonly used to control experimental flow during a rating phase:

```python
if id == "RATING":
    self.current = self.tc.Instruments.Scale.GetCurrentRating()
    self.tc.CurrentState.Changed = True

    if self.tc.Keyboard.Pressed("ESC"):
        return "abort"

    if self.tc.Keyboard.Pressed("INSERT"):
        self.ratings.append(self.current)
        return "complete"

    if self.tc.Keyboard.Pressed("ENTER"):
        self.ratings.append(self.current)
        return "CUE"

    return "*"
```

In this example:
- ESC is used as a global abort key.
- INSERT confirms the rating and completes the trial.
- ENTER confirms the rating and transitions to the next state.

The code can safely be executed repeatedly without accidentally re-triggering actions, because key presses are latched and explicitly cleared after processing. 

## Functions

### Pressed(key)

Checks whether a specific key has been pressed since the last time the keyboard state was cleared.  
This function queries the current `IKeyboard` implementation, which by default is backed by `KeyboardDevice`. The keyboard device continuously polls the system keyboard and records keys that are detected as down. Once a key is registered as pressed, it remains in the pressed state until `Clear()` is called.

This design makes `Pressed` especially suitable for experiment control and trial logic, where key presses should be latched and evaluated deterministically rather than relying on instantaneous key-down timing.

Key identifiers are provided as **case-insensitive strings** and are mapped internally to `System.Windows.Input.Key` values. If an unknown key string is provided, an exception is thrown describing the valid options.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| key  | string | The name of the key to check. This is a case-insensitive string such as `"A"`, `"SPACE"`, `"ENTER"`, `"LEFT"`, `"F1"`, `"CTRL"`, or `"OEMPERIOD"`. See below for supported key names. |

#### Supported Key Strings

| Category | Key Strings |
|---------|-------------|
| Letters | `A`–`Z` |
| Digits | `0`–`9` |
| Numpad | `NUM0`–`NUM9` |
| Function Keys | `F1`–`F12` |
| Modifiers | `SHIFT`, `LEFTSHIFT`, `RIGHTSHIFT`, `CTRL`, `LEFTCTRL`, `RIGHTCTRL`, `ALT`, `LEFTALT`, `RIGHTALT` |
| Special Keys | `ESC`, `ESCAPE`, `TAB`, `CAPSLOCK`, `ENTER`, `RETURN`, `SPACE`, `SPACEBAR`, `BACKSPACE`, `DELETE`, `INSERT`, `HOME`, `END`, `PAGEUP`, `PAGEDOWN` |
| Arrow Keys | `UP`, `DOWN`, `LEFT`, `RIGHT` |
| OEM / Punctuation | `OEM1`–`OEM8`, `OEM102`, `OEMPLUS`, `OEMMINUS`, `OEMCOMMA`, `OEMPERIOD` |

If an unsupported key string is used, an exception is raised listing all valid key names.

#### Return Value

Returns a boolean value.  
`true` if the specified key has been detected as pressed since the last call to `Clear()`; otherwise, `false`.

### Clear()

Clears the internal keyboard state by removing all previously registered key presses.  
This function resets the latched key state maintained by the underlying `IKeyboard` implementation. After calling `Clear()`, all keys will be reported as not pressed until they are detected again by the keyboard polling mechanism.

This function is typically called after handling user input (for example, at the end of a trial or frame) to ensure that key presses are not processed multiple times across iterations.

Calling `Clear()` does not affect the physical keyboard state; it only resets the internal record of keys that have been detected as pressed.

#### Parameters

| Name | Type | Description |
|------|------|-------------|
| — | — | This function takes no parameters. |

#### Return Value

This function does not return a value.
