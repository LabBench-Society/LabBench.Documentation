---
title: Manual Threshold Estimation
description: Threshold estimation where LabBench cannot automatically deliver the stimuli. Instead, the experimenter is guided through an adaptive algorithm on which stimuli to present to the subject.
weight: 20
---

{{% pageinfo %}}

The manual threshold estimation procedure is used when LabBench cannot control the stimulus directly, and the experimenter must apply it manually. It consists of a response task and an estimation algorithm: the participant performs a perception task in which responses are classified as correct or incorrect, and an adaptive algorithm uses these outcomes to update estimates of the threshold or psychometric function. The stimulus is implicitly defined by the response task, and estimation is performed over an independent variable (x), where increasing x is assumed to increase the probability of a correct response.

{{% /pageinfo %}}

The manual threshold estimation procedure is used to estimate thresholds/psychometric functions when LabBench cannot control the stimulus, and instead, the experimenter must manually apply the stimulus to the participant. Estimation of these thresholds/psychometric functions consists of two parts: response task and estimation algorithm:

* **Response task**: the perception task that the participant is asked to perform when the stimulus is presented. The outcome of this task is either correct: the participant perceived the stimulus correctly, or incorrect: the stimulus intensity was too low, and the participant failed to perceive the stimulus correctly.
* **Estimation algorithm**: the adaptive algorithm by which the threshold/psychometric function is estimated. This algorithm uses the outcome of the response task (correct/incorrect) to update the estimate of the threshold or psychometric function for each stimulus presentation.

The stimulus is defined by the nature of the questions asked in the response task. The thresholds or psychometric functions are estimated for an independent variable (x). An increase in x is assumed to increase the probability that the participant will correctly perform the response task. 


## Procedure definition

```xml

```


## Adaptive methods

### Up/Down 

```xml

```


### Psi-Method

```xml

```

## Response tasks

### Yes/No

```xml

```

### One Interval Forced Choice

```xml

```

### Two Interval Forced Choice

```xml

```

## Catch trials



## Scripting