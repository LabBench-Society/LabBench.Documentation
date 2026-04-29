---
title: Waveforms
description: Toolkit for creating waveforms in Python code
weight: 20
---

Provides utilities for creating and generating waveform objects for use in stimulus generation and playback.

**Availability:**

```python
context.Waveforms
```

## Properties

*No public readable properties are defined.*

## Methods

| Name         | Signature                                                                                       | Description                                             |
| ------------ | ----------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| `Arbitrary`  | `Arbitrary(values: Iterable[float]) -> Waveform`                                                | Creates a waveform from a sequence of sample values.    |
| `Zero`       | `Zero(length: int) -> Waveform`                                                                 | Creates a waveform with all samples set to 0.           |
| `Ones`       | `Ones(length: int) -> Waveform`                                                                 | Creates a waveform with all samples set to 1.           |
| `Sin`        | `Sin(amplitude: float, frequency: float, phase: float, length: float, rate: float) -> Waveform` | Creates a sinusoidal waveform and sets its sample rate. |
| `WhiteNoise` | `WhiteNoise(amplitude: float, length: int) -> Waveform`                                         | Creates white noise in range `[-amplitude, amplitude]`. |

## Typical usage example

```python
wf = context.Waveforms

w1 = wf.Arbitrary([0.0, 0.5, 1.0])
w2 = wf.Sin(1.0, 5.0, 0.0, 1000, 1000)
w3 = wf.WhiteNoise(0.2, 1000)

w = (w2 + w3).Normalize().SetSampleRate(2000)
```

## Notes / gotchas

* Arithmetic operations require equal waveform length.
* Default sample rate is `1000 Hz` unless changed.
* Many operations return new waveform instances.
* White noise is non-deterministic.

## Waveform (`Waveform`)

### Description

Represents a sampled signal with associated timing, metadata, and signal processing operations.

### Availability

Waveform objects are created via `context.Waveforms` or returned from instrument/toolkit operations.

### Properties

| Name         | Type      | Description                           |
| ------------ | --------- | ------------------------------------- |
| `Channel`    | `int`     | Output channel index.                 |
| `SampleRate` | `int`     | Samples per second (Hz).              |
| `Duration`   | `float`   | Total duration in seconds.            |
| `Name`       | `string`  | Optional identifier.                  |
| `Signal`     | `Signal`  | Signal classification.                |
| `Maximum`    | `float`   | Maximum value of the waveform.        |
| `Minimum`    | `float`   | Minimum value of the waveform.        |
| `PeakToPeak` | `float`   | Difference between max and min.       |
| `StartTime`  | `float`   | Start time in seconds.                |
| `Unit`       | `string`  | Physical unit of the signal.          |
| `Enabled`    | `bool`    | Whether the waveform is active.       |
| `Values`     | `float[]` | Sample values.                        |
| `Time`       | `float[]` | Time vector corresponding to samples. |
| `Length`     | `int`     | Number of samples.                    |

### Methods

| Name               | Signature                                             | Description                             |
| ------------------ | ----------------------------------------------------- | --------------------------------------- |
| `SetChannel`       | `SetChannel(channel: int) -> Waveform`                | Assigns output channel.                 |
| `SetSampleRate`    | `SetSampleRate(rate: int) -> Waveform`                | Sets sample rate and recomputes timing. |
| `SetName`          | `SetName(name: str) -> Waveform`                      | Sets waveform name.                     |
| `SetSignal`        | `SetSignal(signal: Signal) -> Waveform`               | Sets signal type.                       |
| `SetMaximum`       | `SetMaximum(max: float) -> Waveform`                  | Sets maximum value manually.            |
| `CalculateMaximum` | `CalculateMaximum() -> Waveform`                      | Computes max from values.               |
| `SetMinimum`       | `SetMinimum(min: float) -> Waveform`                  | Sets minimum value manually.            |
| `CalculateMinimum` | `CalculateMinimum() -> Waveform`                      | Computes min from values.               |
| `SetStartTime`     | `SetStartTime(t0: float, timebase) -> Waveform`       | Sets start time.                        |
| `SetUnit`          | `SetUnit(unit: str) -> Waveform`                      | Sets signal unit.                       |
| `SetEnabled`       | `SetEnabled(enabled: bool) -> Waveform`               | Enables/disables waveform.              |
| `Clone`            | `Clone() -> Waveform`                                 | Creates a deep copy.                    |
| `Extract`          | `Extract(t1: float, t2: float, timebase) -> Waveform` | Extracts a time segment.                |
| `Detrend`          | `Detrend(window: float, timebase) -> Waveform`        | Removes linear trend.                   |
| `Negate`           | `Negate() -> Waveform`                                | Inverts signal.                         |
| `Normalize`        | `Normalize() -> Waveform`                             | Scales signal to ±1.                    |
| `Add`              | `Add(w: Waveform) -> Waveform`                        | Adds another waveform.                  |
| `Subtract`         | `Subtract(w: Waveform) -> Waveform`                   | Subtracts another waveform.             |
| `Multiply`         | `Multiply(w: Waveform) -> Waveform`                   | Element-wise multiplication.            |
| `Multiply`         | `Multiply(x: float) -> Waveform`                      | Scalar multiplication.                  |
| `Divide`           | `Divide(w: Waveform) -> Waveform`                     | Element-wise division.                  |
| `Divide`           | `Divide(x: float) -> Waveform`                        | Scalar division.                        |
| `Inverse`          | `Inverse() -> Waveform`                               | Inverts values (`1/x`).                 |
| `Add`              | `Add(offset: int, w: Waveform) -> Waveform`           | Adds waveform at offset.                |
| `Subtract`         | `Subtract(offset: int, w: Waveform) -> Waveform`      | Subtracts waveform at offset.           |
| `Attenuate`        | `Attenuate(dbFS: float) -> Waveform`                  | Applies dB attenuation.                 |

### Operators

| Operator | Description                                    |
| -------- | ---------------------------------------------- |
| `+a`     | Returns waveform unchanged.                    |
| `-a`     | Negates waveform.                              |
| `a + b`  | Adds two waveforms.                            |
| `a - b`  | Subtracts two waveforms.                       |
| `a * b`  | Element-wise multiplication.                   |
| `a * x`  | Scalar multiplication.                         |
| `a / b`  | Element-wise division.                         |
| `a / x`  | Scalar division.                               |
| `x / a`  | Scalar divided by waveform (`x * inverse(a)`). |

### Typical usage example

```python
wf = context.Waveforms

w1 = wf.Sin(1.0, 10.0, 0.0, 1000, 1000)
w2 = wf.WhiteNoise(0.1, 1000)

w = (w1 + w2).Normalize()

segment = w.Extract(0, 500)
scaled = segment.Attenuate(-6)
```


### Notes / gotchas

* All element-wise operations require equal waveform length.
* `Extract` throws if requested range is outside signal bounds.
* `Inverse` will fail if values contain zero.
* `Normalize` uses max absolute value; zero signals remain zero.
* Time is derived from `SampleRate` and `StartTime`.
* Some operations (e.g., `Detrend`) depend on window size relative to signal length.
* Arithmetic operators return new waveform instances.
* Offset operations (`Add(offset, ...)`) must fit within signal length.
