---
title: Sound Player
description: Instructions on how to install LabBench
weight: 20
---

Provides audio stimulus playback by sending waveform data to an output device.

**Availability:**

```python
context.Instruments.<SoundPlayerName>
```

## Properties

*No public properties.*

## Methods

| Name     | Signature                                    | Description                                                                                                                                        |
| -------- | -------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Play`   | `Play(waveform: bytes)` → `None`             | Plays a waveform provided as raw byte data.                                                                                                        |
| `Play`   | `Play(waveform: Waveform)` → `None`          | Plays a single waveform object on the default output channel.                                                                                      |
| `Play`   | `Play(waveforms: List[Waveform])` → `None`   | Plays multiple waveforms simultaneously, where each waveform is mapped to a separate output channel (first → channel 1, second → channel 2, etc.). |
| `Playsc` | `Playsc(waveform: Waveform)` → `None`        | Plays a waveform scaled to full output amplitude on the default channel.                                                                           |
| `Playsc` | `Playsc(waveforms: List[Waveform])` → `None` | Plays multiple waveforms scaled to full output amplitude, each assigned to separate output channels.                                               |

## Typical usage example

```python
player = context.Instruments.SoundPlayer

# Play a single waveform on all output channels.
player.Play(waveform)

# Play on multiple channels
player.Play([waveform_left, waveform_right])

# Play scaled waveform on all output channels.
player.Playsc(waveform)
```

## Notes / gotchas

* When passing a list, each waveform is assigned to a separate channel in order.
* `Playsc` scales waveforms to full output amplitude before playback.
* Waveform format must match the expectations of the underlying device.
* Playback is triggered immediately when calling the method.
* Channel count is determined by the number of waveforms provided.
