---
title: Pressure Algometer
description: Instrument for computerised cuff pressure algometry.
weight: 20
---

The `PressureAlgometer` instrument represent an abstraction of computerised cuff pressure algometry devices.

## String Literals

### Outlet

| Value        | Definition |
|--------------|------------|
| `'outlet-1'` | |
| `'outlet-2'` | |

### Channel

| Value         | Definition |
|---------------|------------|
| `'none'`      | |
| `'channel-1'` | |
| `'channel-2'` | |


### Criterion

| Value                         | Definition |
|-------------------------------|------------|
| `'stop-on-maximal-rating'`    | |
| `'stop-when-button-pressed'`  | |
| `'stop-when-button-released'` | |


## PressureAlgometer 

### Properties

| Name | Type | Description |
|------|------|-------------|
| Ping | bool | |
| UpdateRate | double | |
| DeviceError | string | |
| SupplyPressure | double | |
| FinalRating | double | |
| Rating  | double | |
| VasConnected | bool | |
| VasReady     | bool | |
| PressureAvailable | bool | |
| NumberOfPressureChannels | int | |
| Channels | PressureChannel[] | |


### Functions

#### `string GetCompressorMode()`


#### `string GetState()`

Returns the current state of the device:

| Value             | Definition |
|-------------------|------------|
| `'not-connected'` | |
| `'idle'`          | |
| `'stimulating'`   | |
| `'emergency'`     | |
| `'pending'`       | |


#### `string GetStopCondition()`


#### `void ConfigurePressureOutput(string outlet, string channel)`

#### `void StartStimulation(string criterion, bool forcedStart, bool externalTrigger = false)`

#### `void StopStimulation()`

#### `void StartUpdates()`

#### `void StopUpdates()`

#### `List<AlgometerStatus> GetUpdates()`

#### `double GetTime(int sample)`

## PressureChannel

### Functions 

#### `void SetStimulus(int repeat, List<Instruction> instructions)`

#### `void SetStimulus(int repeat, PressureWaveform waveform)`

#### `void ClearStimulus()`

#### `PressureWaveform CreateWaveform()`

## PressureWaveform

### Functions

#### `PressureWaveform Increment(double delta, double time)`

#### `PressureWaveform Decrement(double delta, double time)`

#### `PressureWaveform Step(double pressure, double time)`

#### `PressureWaveform Zero()`

#### `PressureWaveform Trigger(double time)`

## AlgometerStatus