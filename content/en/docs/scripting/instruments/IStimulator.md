---
title: Stimulator
description: Instrument for generating stimuli 
weight: 20
---

Provides generation of physical stimuli (e.g., electrical, thermal, mechanical) based on defined stimulus waveforms, with configurable triggering and output control.

**Availability:**

```python
context.Instruments.<StimulatorName>
```

## Properties

| Name       | Type       | Description                                             |
| ---------- | ---------- | ------------------------------------------------------- |
| `Modality` | `Modality` | Type of stimulus modality (e.g., electrical, pressure). |
| `Unit`     | `Unit`     | Unit of the stimulus intensity (e.g., mA, °C).          |
| `Imax`     | `float`    | Maximum allowed stimulus intensity.                     |
| `Max`      | `float`    | Alias for maximum intensity.                            |
| `Imin`     | `float`    | Minimum allowed stimulus intensity.                     |
| `Min`      | `float`    | Alias for minimum intensity.                            |
| `Ineutral` | `float`    | Neutral (baseline) intensity level.                     |
| `Neutral`  | `float`    | Alias for neutral intensity.                            |
| `Range`    | `float`    | Range of valid stimulus intensities (`Max - Min`).      |

## Methods

| Name               | Signature                                                                  | Description                                                                          |
| ------------------ | -------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| `GetModality`      | `GetModality()` → `str`                                                    | Returns the modality as a string.                                                    |
| `Initialize`       | `Initialize(setup: IStimulatorSetup)` → `None`                             | Initializes the stimulator with a specific setup configuration.                      |
| `Generate`         | `Generate(stimulus: IStimulus)` → `None`                                   | Generates a stimulus using the device’s default trigger and update rate.             |
| `Generate`         | `Generate(startTrigger: str, stimulus: IStimulus)` → `None`                | Generates a stimulus when triggered by the specified trigger source.                 |
| `Generate`         | `Generate(startTrigger: str, restart: bool, stimulus: IStimulus)` → `None` | Generates a stimulus with explicit control over trigger source and restart behavior. |
| `SetDefaultOutput` | `SetDefaultOutput(value: float)` → `None`                                  | Sets the default output level when no stimulus is active.                            |

## Trigger source (`startTrigger`)

The `startTrigger` argument specifies how stimulus generation is triggered.

| String       | Description                                         |
| ------------ | --------------------------------------------------- |
| `"none"`     | Start immediately without waiting for a trigger.    |
| `"internal"` | Triggered internally by the device or software.     |
| `"external"` | Triggered by an external hardware signal.           |
| `"button"`   | Triggered by a button press on any response device. |
| `"port1"`    | Triggered by input on response port 1.              |
| `"port2"`    | Triggered by input on response port 2.              |
| `"port3"`    | Triggered by input on response port 3.              |
| `"port4"`    | Triggered by input on response port 4.              |

## Typical usage example

```python
stim = context.Instruments.Stimulator

# Generate stimulus immediately
stim.Generate(stimulus)

# Generate stimulus on external trigger
stim.Generate("external", stimulus)

# Generate with restart enabled
stim.Generate("button", True, stimulus)

# Set baseline output
stim.SetDefaultOutput(0.0)
```

## Notes / gotchas

* Intensity values must be within `[Min, Max]`; exceeding limits may result in errors or undefined behavior.
* Trigger-based generation depends on correct hardware configuration and wiring.
* `restart=True` allows retriggering while a stimulus is already active.
* `SetDefaultOutput` affects the baseline output between stimuli.
* Timing and synchronization are controlled by the underlying device and trigger configuration.
