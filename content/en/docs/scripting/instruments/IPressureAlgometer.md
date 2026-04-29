---
title: Pressure Algometer
description: Instrument for computerised cuff pressure algometry.
weight: 20
---

The `PressureAlgometer` instrument represent an abstraction of computerised cuff pressure algometry devices.

```python
context.Instruments.PressureAlgometer
```

## String Literals

### Outlet

| Value        | Definition |
|--------------|------------|
| `'outlet-1'` | Pressure outlet 1 |
| `'outlet-2'` | Pressure outlet 2 |

### Channel

| Value         | Definition |
|---------------|------------|
| `'none'`      | Used for declaring no waveform channel is mapped to an outlet. |
| `'channel-1'` | Waveform channel 1. |
| `'channel-2'` | Waveform channel 2. |


### Criterion

| Value                         | Definition |
|-------------------------------|------------|
| `'stop-on-maximal-rating'`    | Stimulation will stop on a VAS of 10cm. |
| `'stop-when-button-pressed'`  | Stimulation will stop when the button is pressed. |
| `'stop-when-button-released'` | Stimulation will stop when the button is released. |

## Properties

| Name                       | Type                      | Description                                           |
| -------------------------- | ------------------------- | ----------------------------------------------------- |
| `CompressorMode`           | `AlgometerCompressorMode` | Compressor operation mode (`auto` or `manual`).       |
| `MaximalPressure`          | `double`                  | Maximum pressure the device can generate.             |
| `Pressure`                 | `double[]`                | Current pressure values per channel.                  |
| `UpdateRate`               | `double`                  | Update rate for pressure generation.                  |
| `SamplePeriod`             | `double`                  | Sampling period for pressure and ratings.             |
| `State`                    | `AlgometerState`          | Current device state.                                 |
| `DeviceError`              | `string`                  | Error message if the device cannot start stimulation. |
| `SupplyPressure`           | `double`                  | Current supply pressure.                              |
| `FinalRating`              | `double`                  | Final VAS rating after stimulation.                   |
| `Rating`                   | `double`                  | Current VAS rating.                                   |
| `VasConnected`             | `bool`                    | Indicates if a VAS device is connected.               |
| `VasReady`                 | `bool`                    | Indicates if the VAS device is ready.                 |
| `PressureAvailable`        | `bool`                    | Indicates if sufficient pressure is available.        |
| `StopCondition`            | `AlgometerStopCondition`  | Stop condition that ended the stimulation.            |
| `NumberOfPressureChannels` | `int`                     | Number of available pressure channels.                |
| `Channels`                 | `IList<IPressureChannel>` | Available pressure channels.                          |

### Methods

| Name                      | Signature                                                         | Description                                                    |
| ------------------------- | ----------------------------------------------------------------- | -------------------------------------------------------------- |
| `GetCompressorMode`       | `GetCompressorMode()` → `str`                                     | Returns compressor mode as string (`"auto"` or `"manual"`).    |
| `GetState`                | `GetState()` → `str`                                              | Returns current state as string.                               |
| `GetStopCondition`        | `GetStopCondition()` → `str`                                      | Returns stop condition as string.                              |
| `ResetAlgometer`          | `ResetAlgometer()`                                                | Resets device configuration to default.                        |
| `ConfigurePressureOutput` | `ConfigurePressureOutput(outlet, channel)`                        | Maps a pressure channel to an outlet. |
| `StartStimulation`        | `StartStimulation(criterion, forcedStart, externalTrigger=False)` | Starts pressure stimulation with specified stop criterion.     |
| `StopStimulation`         | `StopStimulation()`                                               | Stops pressure stimulation.                                    |
| `StartUpdates`            | `StartUpdates()`                                                  | Starts streaming updates from the device.                      |
| `StopUpdates`             | `StopUpdates()`                                                   | Stops streaming updates.                                       |
| `GetUpdates`              | `GetUpdates()` → `list`                                           | Returns collected update data.                                 |
| `GetTime`                 | `GetTime(sample)` → `float`                                       | Returns time corresponding to a sample index.                  |

### Typical usage

```python
alg = context.Instruments.PressureAlgometer
alg.StartStimulation("stop-on-maximal-rating", forcedStart=False)

# Read current rating
rating = alg.Rating

alg.StopStimulation()
```

## Pressure Channel (`IPressureChannel`)

Represents a single pressure output channel capable of executing stimulus programs.

### Availability

```python
channel = context.Instruments.PressureAlgometer.Channels[0]
```

### Properties

| Name      | Type        | Description         |
| --------- | ----------- | ------------------- |
| `Name`    | `string`    | Channel name.       |
| `ID`      | `ChannelID` | Channel identifier. |
| `Channel` | `int`       | Channel index.      |

### Methods

| Name             | Signature                               | Description                                        |
| ---------------- | --------------------------------------- | -------------------------------------------------- |
| `SetStimulus`    | `SetStimulus(repeat, instructions)`     | Assigns a stimulus program using instruction list. |
| `SetStimulus`    | `SetStimulus(repeat, waveform)`         | Assigns a stimulus using a waveform object.        |
| `ClearStimulus`  | `ClearStimulus()`                       | Clears the assigned stimulus.                      |
| `CreateWaveform` | `CreateWaveform()` → `PressureWaveform` | Creates a new waveform builder.                    |

### Typical usage

```python
channel = context.Instruments.PressureAlgometer.Channels[0]

wave = channel.CreateWaveform() \
    .Step(50, 1) \
    .Increment(10, 2)

channel.SetStimulus(1, wave)
```

## Pressure Waveform (`PressureWaveform`)

Builder for constructing pressure stimulus waveforms using sequential instructions.

### Availability

```python
wave = channel.CreateWaveform()
```

### Methods

| Name        | Signature                                     | Description                              |
| ----------- | --------------------------------------------- | ---------------------------------------- |
| `Increment` | `Increment(delta, time)` → `PressureWaveform` | Increases pressure by `delta` over time. |
| `Decrement` | `Decrement(delta, time)` → `PressureWaveform` | Decreases pressure by `delta` over time. |
| `Step`      | `Step(pressure, time)` → `PressureWaveform`   | Sets pressure to a fixed value.          |
| `Zero`      | `Zero()` → `PressureWaveform`                 | Sets pressure to zero immediately.       |
| `Trigger`   | `Trigger(time)` → `PressureWaveform`          | Inserts a trigger event.                 |

### Typical usage

```python
wave = channel.CreateWaveform() \
    .Step(30, 1) \
    .Increment(10, 2)
```

**Notes:**

* Methods are chainable and mutate the same waveform instance.
* Execution depends on assigning the waveform to a channel via `SetStimulus`.

## AlgometerStatus

## Algometer Status (`IAlgometerStatus`)

### Description

Represents a snapshot of the pressure algometer state during updates, including pressures, ratings, and device status flags.

### Availability

Returned from:

```python
context.Instruments.PressureAlgometer.GetUpdates()
```

Each element in the returned list is an `IAlgometerStatus`.

### Properties

| Name                | Type                     | Description                                                  |
| ------------------- | ------------------------ | ------------------------------------------------------------ |
| `NumberOfChannels`  | `int`                    | Number of pressure channels in the device.                   |
| `State`             | `AlgometerState`         | Current device state.                                        |
| `VasConnected`      | `bool`                   | Indicates if the VAS device is connected.                    |
| `VasIsLow`          | `bool`                   | Indicates low VAS signal or condition.                       |
| `PowerOn`           | `bool`                   | Indicates if the device is powered on.                       |
| `CompressorRunning` | `bool`                   | Indicates if the compressor is currently running.            |
| `StartPossible`     | `bool`                   | Indicates if stimulation can be started.                     |
| `UpdateCounter`     | `int`                    | Incrementing counter for updates.                            |
| `StopCondition`     | `AlgometerStopCondition` | Stop condition associated with the current/last stimulation. |
| `VasScore`          | `double`                 | Current VAS score.                                           |
| `FinalVasScore`     | `double`                 | Final VAS score after stimulation.                           |
| `SupplyPressure`    | `double`                 | Current supply pressure.                                     |
| `ActualPressure`    | `IList<double>`          | Measured pressure values per channel.                        |
| `TargetPressure`    | `IList<double>`          | Target pressure values per channel.                          |
| `FinalPressure`     | `IList<double>`          | Final pressure values reached per channel.                   |
| `StopPressed`       | `bool`                   | Indicates if the stop button has been pressed.               |

### Methods

| Name               | Signature                    | Description                       |
| ------------------ | ---------------------------- | --------------------------------- |
| `GetState`         | `GetState()` → `str`         | Returns device state as string.   |
| `GetStopCondition` | `GetStopCondition()` → `str` | Returns stop condition as string. |


**Notes:**

* Requires `StartUpdates()` to be called before data is collected.
* Each call to `GetUpdates()` returns accumulated updates since last retrieval.
* Lists (`ActualPressure`, `TargetPressure`, etc.) are indexed per channel.
