---
title: Stimuli
description: Toolkit for creating stimuli in Python code
weight: 20
---

Provides programmatic construction of stimuli (pulse, ramp, sine, arbitrary, combined, repeated, multi-channel, and segmented waveforms).

**Availability:**

```python
context.Stimuli
```

## Properties

*No public readable properties are defined.*

## Methods

| Name             | Signature                                                                                                  | Description                                                        |
| ---------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| `Pulse`          | `Pulse(Is: float, Ts: float) -> PulseValueStimulus`                                                        | Creates a rectangular pulse with intensity `Is` and duration `Ts`. |
| `Pulse`          | `Pulse(Is: float, Ts: float, Tdelay: float) -> PulseValueStimulus`                                         | Same as above with delay `Tdelay`.                                 |
| `Ramp`           | `Ramp(intensity: float, duration: float) -> RampValueStimulus`                                             | Creates a linear ramp stimulus.                                    |
| `Ramp`           | `Ramp(intensity: float, duration: float, delay: float) -> RampValueStimulus`                               | Ramp with delay.                                                   |
| `Ramp`           | `Ramp(intensity: float, duration: float, delay: float, offset: float) -> RampValueStimulus`                | Ramp with delay and offset.                                        |
| `Sine`           | `Sine(intensity: float, duration: float, frequency: float) -> SineValueStimulus`                           | Creates a sinusoidal stimulus.                                     |
| `Sine`           | `Sine(intensity: float, duration: float, frequency: float, delay: float) -> SineValueStimulus`             | Sine with delay.                                                   |
| `Arbitrary`      | `Arbitrary(expression: Callable[[float], float], duration: float) -> ArbitraryValueStimulus`               | Creates a stimulus from a time-dependent function.                 |
| `Arbitrary`      | `Arbitrary(expression: Callable[[float], float], duration: float, delay: float) -> ArbitraryValueStimulus` | Same with delay.                                                   |
| `Combined`       | `Combined() -> CombinedValueStimulus`                                                                      | Creates a stimulus that sums multiple stimuli.                     |
| `Repeated`       | `Repeated(stimulus: IStimulus, repetitions: int, period: float, delay: float) -> RepeatedValueStimulus`    | Repeats a stimulus with period and delay.                          |
| `Repeated`       | `Repeated(stimulus: IStimulus, repetitions: int, period: float) -> RepeatedValueStimulus`                  | Repeats a stimulus with period.                                    |
| `Multiple`       | `Multiple() -> MultipleOutputValueStimulus`                                                                | Creates a multi-channel stimulus.                                  |
| `LinearStimulus` | `LinearStimulus() -> LinearSegmentValueStimulus`                                                           | Creates a piecewise linear stimulus.                               |

## Typical usage example

```python
stim = context.Stimuli

# Simple pulse
pulse = stim.Pulse(1.0, 5.0)

# Combined stimulus
combined = stim.Combined() \
    .Add(stim.Pulse(1.0, 5.0)) \
    .Add(stim.Sine(0.5, 10.0, 100))

# Repeated stimulus
rep = stim.Repeated(pulse, 5, 20.0)

# Arbitrary waveform
arb = stim.Arbitrary(lambda t: t * 0.1, 50.0)
```

## Combined Stimulus (`CombinedValueStimulus`)

### Description

Represents a stimulus formed by summing multiple stimuli.

### Availability

```python
context.Stimuli.Combined()
```

### Properties

| Name       | Type              | Description                |
| ---------- | ----------------- | -------------------------- |
| `Stimulus` | `List[IStimulus]` | List of contained stimuli. |

### Methods

| Name  | Signature                                           | Description                         |
| ----- | --------------------------------------------------- | ----------------------------------- |
| `Add` | `Add(stimulus: IStimulus) -> CombinedValueStimulus` | Adds a stimulus to the combination. |

## Multiple Output Stimulus (`MultipleOutputValueStimulus`)

### Description

Represents a stimulus distributed across multiple output channels.

### Availability

```python
context.Stimuli.Multiple()
```

### Properties

| Name      | Type                  | Description                      |
| --------- | --------------------- | -------------------------------- |
| `Outputs` | `List[IAnalogOutput]` | List of channel-output mappings. |

### Methods

| Name  | Signature                                                               | Description                                      |
| ----- | ----------------------------------------------------------------------- | ------------------------------------------------ |
| `Add` | `Add(channel: int, stimulus: IStimulus) -> MultipleOutputValueStimulus` | Assigns a stimulus to a specific output channel. |

## Linear Segment Stimulus (`LinearSegmentValueStimulus`)

### Description

Represents a piecewise linear stimulus constructed from sequential segments.

### Availability

```python
context.Stimuli.LinearStimulus()
```

### Properties

| Name       | Type             | Description                                               |
| ---------- | ---------------- | --------------------------------------------------------- |
| `Segments` | `List[ISegment]` | Sequence of defined segments.                             |
| `Baseline` | `float`          | Baseline value before first segment (unit not specified). |

### Methods

| Name      | Signature                                                              | Description                                    |
| --------- | ---------------------------------------------------------------------- | ---------------------------------------------- |
| `Segment` | `Segment(value: float, duration: float) -> LinearSegmentValueStimulus` | Adds a segment with target value and duration. |

## Notes / gotchas

* All stimuli represent time-dependent signals; durations and delays are in milliseconds.
* `Combined` sums values of all contained stimuli at each time point.
* `Multiple` assigns stimuli to separate output channels; channel indices must match device configuration.
* `Arbitrary` expressions must be valid Python callables taking time `t` as input.
* `LinearStimulus` interpolates between segment values; baseline is used before the first segment.
* No validation is performed; invalid configurations may fail at runtime or during device execution.
