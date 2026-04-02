---
title: Stimulator
description: Instrument for generating stimuli 
weight: 20
---


## String Literals

### startTrigger

| Value        | Definition |
|--------------|------------|
| `'none'`     | | 
| `'internal'` | |
| `'external'` | |
| `'button'`   | |
| `'port1'`    | |
| `'port2'`    | |
| `'port3'`    | |
| `'port4'`    | |

## Stimulator

### Properties

| Name    | Type | Description |
|---------|------|-------------|
| Max     |      |             |
| Min     |      |             |
| Neutral |      |             |
| Range   |      |             |

### Functions

#### `string GetModality()`

#### `void Generate(IStimulus stimulus)`

#### `void Generate(string startTrigger, IStimulus stimulus)`

#### `void Generate(string startTrigger, bool restart, IStimulus stimulus)`

