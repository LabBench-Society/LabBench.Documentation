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

The procedure window for the `<psychophysics-manual-threshold-estimation>` is shown in Figure 1. 

![](/images/Experitments_Procedures_Psychophysics_ManualThresholdEstimation/Slide1.png)

*Figure 1: Procedure window for the manual threshold estimation procedure.*

The interface consists of three main areas:

**Intensity and Progress:**

At the top of the interface, the current **stimulus instruction** and **progress information** are displayed:

- **Intensity label**
  - Displays the current stimulus level (e.g., *Black* or a physical value such as *5 mm*).
  - May reflect transformed intensities or user-defined labels.

- **Iteration counter**
  - Indicates the current trial number (e.g., `[Iteration: 2]`).
  - Corresponds to the number of completed stimulus-response cycles.

This section provides the operator with clear guidance on **what stimulus intensity to apply next** and how far the procedure has progressed.

**Stimulus guidance (Options):**

The central panel presents **visual guidance** for the operator:

- Displays one or two images depending on the response task:
  - **Yes/No task**: a single illustration of the stimulus
  - **Forced choice tasks**:
    - One-interval: a single image (randomized internally)
    - Two-interval: two images representing intervals A and B

This section ensures that the operator applies the stimulus consistently across trials.

**Response question and answers:**

At the bottom of the interface, the operator is guided to collect and record the participant’s response:

- **Question**
  - A dynamically generated instruction (e.g., *“When did you feel two points?”*)
  - Defined in the response task configuration

- **Answer buttons**
  - Two response options labeled **A** and **B**
  - The meaning depends on the task:
    - Yes/No: typically mapped to negative/positive responses
    - Forced choice: corresponds to alternatives or intervals

- The operator selects the participant’s response by clicking the appropriate button.

## Interaction Flow

For each trial:

1. The operator reads the **intensity instruction**
2. Applies the stimulus manually
3. Uses the **visual guidance** as needed
4. Asks the **question** to the participant
5. Records the response using **A/B buttons**

After the response is recorded:
- Estimate is updated according to the estimation algorithm and the next intensity to be tested is selected, or the procedure terminates if the stop criterion is fullfilled.
- The interface updates to the next intensity
- Images and question change
- Progress is incremented


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