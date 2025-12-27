---
title: Threshold Estimation
description: Estimation of thresholds and psychometric functions with adaptive algorithms where the stimuli can be automatically delivered to the subject.
weight: 20
---

{{% pageinfo %}}

The threshold estimation test uses adaptive methods to efficiently estimate a participant’s perceptual threshold or full psychometric function. Instead of presenting a fixed set of stimulus intensities, adaptive methods adjust stimulus levels in real time based on the participant’s responses. Adaptive methods allow the experimenter to concentrate trials around the most informative stimulus range—typically near the participant’s threshold—thereby reducing the total number of trials needed compared to non-adaptive (e.g., method of constant stimuli) approaches.

{{% /pageinfo %}}

The purpose of the `<threshold-estimation-test>` test is to estimate the psychometric function or threshold for a given stimulus modality with adaptive methods. These adaptive methods estimate the psychometric function or threshold based on whether or not the subject performed a response task correctly (result: True) or incorrectly (result: False).

Consequently, the algorithm performs the estimation iteratively:

1. The stimulus is presented to the subject according to the response task.
The subject answers a question about the stimulus, with the answer being either correct or incorrect.
2. The result of the response task is fed into the algorithm, which updates the estimate and, based on the response and algorithm state, selects the next stimulus intensity to be tested.
3. This loop continues until the adaptive algorithm's stop criterion is met. 

The test window for the `<threshold-estimation-test>` is shown in Figure 1. It consists of three areas: 1) recorded responses, 2) psychometric function, and 3) manual response task.

![](/images/experiments/tests/threshold-estimation/ThesholdEstimationUI.png)
*Figure 1: Test window of the threshold estimation test*


## Test definition



## Psychometric Functions



## Adaptive methods

### Up/Down 

### Psi-Method


## Response tasks

### Yes/No 

### Forced Yes/No

### Manual Yes/No

### Interval Forced Choice

### Alternatives Forced Choice

### Ratio Rating

### Numerical Rating 

### Manual Numerical Rating

### Categorical Rating

### Manual Categorical Rating


## Stimulation


## Scripting

### Properties

### Functions

## Test results


## Example protocols
