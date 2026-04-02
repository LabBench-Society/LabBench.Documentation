---
title: Stimuli
description: Toolkit for creating stimuli in Python code
weight: 20
---



## Stimulus creation

### `Pulse(double Is, double Ts)`

### `Pulse(double Is, double Ts, double Tdelay)`

### `Ramp(double intensity, double duration)`

### `Ramp(double intensity, double duration, double delay)`

### `Ramp(double intensity, double duration, double delay, double offset)`

### `Sine(double intensity, double duration, double frequence)`

### `Sine(double intensity, double duration, double frequence, double delay)`

### `Arbitrary(Func<double, double> expression, double duration)`

### `Arbitrary(Func<double, double> expression, double duration, double delay)`

### `Combined()`

### `Repeated(IStimulus stimulus, int repetitions, double period, double delay)`

### `Repeated(IStimulus stimulus, int repetitions, double period)`

### `Multiple()`

### `LinearStimulus()`

## Composite stimuli

### CombinedStimulus

#### `Add(IStimulus stimulus)`

### MultipleOutputStimulus

#### `Add(int channel, IStimulus stimulus)`

### LinearSegmentStimulus

#### `Segment(double value, double duration)`
