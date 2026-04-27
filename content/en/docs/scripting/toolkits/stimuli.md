---
title: Stimuli
description: Toolkit for creating stimuli in Python code
weight: 20
---

## Stimulus creation

### `Pulse(double Is, double Ts)`

Returns a pulse stimulus with constant intensity `Is` for the duration `Ts`.

### `Pulse(double Is, double Ts, double Tdelay)`

Returns a pulse stimulus with constant intensity `Is` for the duration `Ts`, starting after a delay of `Tdelay`.

### `Ramp(double intensity, double duration)`

Returns a ramp stimulus that changes linearly from 0 to `intensity` over the specified `duration`.

### `Ramp(double intensity, double duration, double delay)`

Returns a ramp stimulus that changes linearly from 0 to `intensity` over the specified `duration`, starting after a delay of `delay`.

### `Ramp(double intensity, double duration, double delay, double offset)`

Returns a ramp stimulus that changes linearly from `offset` to `offset + intensity` over the specified `duration`, starting after a delay of `delay`.


### `Sine(double intensity, double duration, double frequency)`

Returns a sinusoidal stimulus with amplitude `intensity` and frequency `frequency` over the specified `duration`.

### `Sine(double intensity, double duration, double frequence, double delay)`

Returns a sinusoidal stimulus with amplitude `intensity` and frequency `frequence` over the specified `duration`, starting after a delay of `delay`.

### `Arbitrary(Func<double, double> expression, double duration)`

Returns a stimulus defined by a mathematical expression of time. The expression is evaluated over the interval from 0 to `duration`.

### `Arbitrary(Func<double, double> expression, double duration, double delay)`

Returns a stimulus defined by a mathematical expression of time, evaluated over the interval from 0 to `duration`, starting after a delay of `delay`.

### `Combined()`

Returns a stimulus that represents the sum of multiple stimuli. Individual stimuli can be added and are combined by superposition over time.

### `Repeated(IStimulus stimulus, int repetitions, double period, double delay)`

Returns a stimulus that repeats the given `stimulus` `repetitions` times with a period of `period`, starting after a delay of `delay`.

### `Repeated(IStimulus stimulus, int repetitions, double period)`

Returns a stimulus that repeats the given `stimulus` `repetitions` times with a period of `period`.

## Composite stimuli

### CombinedStimulus

Represents a stimulus composed of multiple stimuli summed together over time.

#### `Add(IStimulus stimulus)`

Adds a stimulus to the combination.


### MultipleOutputStimulus

Represents a collection of stimuli mapped to different output channels.

#### `Add(int channel, IStimulus stimulus)`

Adds a stimulus to the specified output `channel`.

### LinearSegmentStimulus

Represents a stimulus constructed from sequential linear segments.

#### `Segment(double value, double duration)`

Adds a segment that linearly transitions to `value` over the specified `duration`.