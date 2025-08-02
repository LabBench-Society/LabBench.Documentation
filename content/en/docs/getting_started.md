---
title: Getting started
description: A demonstration of how to run an experiment with LabBench.
weight: 3
---

{{% pageinfo %}}

The purpose of this getting started guide is to demonstrate how to run an experiment that studies the relationship between Depression, Anxiety and Stress, and response inhibition.

{{% /pageinfo %}}



 Depression, Anxiety and Stress is assessed with the DASS scale from the Psychology Foundation of Australia []. The DASS scale measures three related emotional states of depression, anxiety, and stress on 42-item self-report questionnaire. 

Response inhibition is assessed with the use of a gamified version of the Stop-Signal Task. The classical Stop-Signal Task measures the ability to supress actions that are no longer required or appropriate. In the Stop-Signal Task participants are asked to perform a Go task that at random and infrequent times are interrupted by a Stop-Signal. Without a Stop-Signal the subjects see a Go signal of a left or right arrow and must press the left or right button respectively. In these Go-trials, not pressing a button is an error and the goal is to press the correct right or left button as fast as possible. However, when a Stop-Signal is presented with a delay after the Go-Signal, the participant must inhibit their response, and in these trials pressing a button is an error. The delay between the Go and Stop signals is adjusted throughout the test to find the minimal delay at which the participants can inhibit their response.

In the classical Stop-Signal Task the participants are told whether they responded correctly or incorrectly after each trial. However, in the present protocol the Stop-Signal Task has been turned into a game to demonstrate the capabilities of LabBench for dynamically generating visual stimuli. In this version the participants are awarded points depending on how fast and how many times they answer correctly on Go signals. However, if they fail to inhibit their response in Stop trials the additional points, they are answered for multiple correct Go trials answers are reset.

This getting started guide will explain how to setup, run, and analyse data from this experiment. This explanation will provide an overview of all the key concepts that needs to be known before you can use LabBench for your studies within neuroscience.

## Setting up the experiment

Before you can run an experiment with LabBench you must first have a protocol. For this introduction you will use a protocol that is available in the public LabBench Protocol Repository, and consequently, we do not need to write this protocol before running the experiment. 

The LabBench Protocol Repository is a source of three types of protocols; 1) protocols like the present one that is intended to teach you how to use LabBench and how to write your own protocols, 2) template protocols that contains templates for experimental procedures that can be copy pasted into your own protocols and thus reducing the work involved in writing protocols, and 3) standard protocols that can be used in studies that are intended to ensure that studies are using the same protocol as an original reference study. 

Once, like for the present introduction, a protocol is available in a protocol repository the first step in a study is to setup an experiment based on this protocol. This setup is performed with the LabBench Designer program. LabBench consists of two programs:

* LabBench Designer is used for setting up and managing experiments.
* LabBench Runner is used for running experiments in the laboratory.

In short LabBench Runner is used in experimental sessions when a participant is present, and LabBench Designer is used at all other purposes.

## Experimental setup

LabBench is intended for experiments that takes place in a laboratory where equipment, such as rating scales, stimulators, visual displays are used to carry out experimental procedures. The set of equipment and their configuration for a study is referred to as the Experimental Setup of the study. 

For the present study we need an equipment setup that can be used for the subject to fill out the DASS questionnaire and to perform the Stop-Signal Task, and the protocol for the study defines two alternative experimental setups. The reason the protocol can define alternative experimental setups is that LabBench protocols does not rely on specific types of research equipment, instead they rely on abstract instruments that are implemented by research equipment in LabBench. 

In the present protocol we need to perform two experimental procedures; filling out a questionnaire, and performing a cognitive task based on visual stimuli (Stop-Signal Task). These two experimental procedures need the following instruments:

| Procedure | Instruments | Purpose |
|-----------|-------------|---------|
| DASS Questionnaire | Questionnaire | The Questionnaire instrument makes it possible to display series questions to the subject, such as Likert scales, multiple choice, Boolean questions, etc. For the DASS questionnaire in the present protocol only Likert questions are displayed to the subject. |
| | Button | The Button instrument makes it possible for the subject to give their answer to the questions in the DASS questionnaire. For the DASS questionnaire four buttons is defined; 1) Increase the Likert rating, 2) Decrease the Likert rating, 3) Go to the next question, and 4) Go to the previous question. |
| Stop-Signal Task | ImageDisplay | The ImageDisplay instrument makes it possible to display images to the subject. For the Stop-Signal Task it is used to display the visual stimuli in the Go and Stop Trials and to give feedback to subject on whether they answered correctly (WIN + Score) or incorrectly (LOSS + Score). |
| | Button | The Button instrument makes it possible for the subject to respond to the Go trials or to provide an incorrect answer (a response) in the Stop trials. |

These three instrument types that are a small subset of the instruments that are available for LabBench protocols. Please see the manual LabBench Instruments [] for a full overview of all the instruments and their capabilities that are available.

These instruments are provided by two alternative experimental setups; one based on the LabBench I/O device, and the other based on a standard USB joystick. This is possible as both a joystick and the LabBench I/O implements the Button instrument that is required for the protocol. In addition to either a joystick or an LabBench I/O both setups use a standard external monitor that implements the Questionnaire and ImageDisplay instruments.

### Experimental Setup: Joystick

The Joystick experimental setup is intended as a low-cost experimental setup that can be used for educational purposes, as it does not use specialized LabBench equipment. Instead, it relies on a standard USB joystick for PCs, which can be purchased for 25-35€. One joystick that has been used extensively is the Logitech F310 Gamepad. 

![](/images/getting_started/Figure01.png)

*Figure 1: Overview of the joystick experimental setup.*

An overview of the Joystick experimental setup can be seen in Figure 1. Caution must be observed when using this experimental setup as it is only intended for educational or evaluation purposes. The joystick does not provide means for synchronizing button presses with stimuli such as the visual stimuli in the Stop-Signal Task. Consequently, it has a low temporal precision and button presses can only be timestamped with a precision of 5-10ms. For neuroscience studies the LabBench I/O based setup is recommended.

### Experimental Setup: LabBench I/O

The LabBench I/O setup shown in Figure 2 is the recommended experimental setup for cognitive tasks such as the Stop-Signal Task that are used in the present protocol.

![](/images/getting_started/Figure02.png)

*Figure 2: Overview of the LabBench I/O experimental setup.*

The experimental setup consists of; 1) an LabBench PAD which implements the Button instrument, 2) a LabBench VTG which is used to timestamp button presses with respect to when the visual stimuli is shown on the display in the Stop-Signal Task, 3) An external monitor facing the subject that when configured for LabBench is termed a LabBench DISPLAY, and a LabBench I/O which is used to collect the responses from the subject. This setup has a high temporal resolution of < 1ms.

## Where should I go next?

