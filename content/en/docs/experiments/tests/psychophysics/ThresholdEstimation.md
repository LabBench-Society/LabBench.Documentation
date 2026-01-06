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

The recorded responses area is always shown and shows information about the tested stimulation intensities and subject responses. The psychometric function area is always shown and will show information on either the estimated psychometric functions or thresholds. The manual response task area is shown only when a manual response task is used and provides the operator with guidance on what to ask the participant, and allows the operator to enter the participant's response to the estimation algorithm.

## Test definition

A Response Recording test can be defined with the `<psychophysics-threshold-estimation>` element within the `<test>` element in the Experiment Definition File (`*.expx`):

```xml
<psychophysics-threshold-estimation id="yesNo"
    name="Yes/No Response Task"
    experimental-setup-id="image"                
    stimulus-update-rate="44100">

    <update-rate-deterministic value="2000" />
    
    <yes-no-task />

    <channels>
        <channel id="CH01" name="Beep">
            <up-down-method 
                start-intensity="Stimulator.Range/2 + Stimulator.Imin"
                initial-direction="decreasing"
                reversal-rule="1"
                skip-rule="1"
                stop-rule="7"
                step-size="0.15"
                max-step-size-reduction="0.25"
                step-size-reduction="0.5" />

            <stimulus>
                <sine Is="x" Ts="200" Frequency="1000" />
            </stimulus>
        </channel>
    </channels>
</psychophysics-threshold-estimation>
```

*Listing 1: Definition of a psychophysical threshold estimation test*

The `<psychophysics-threshold-estimation>` test has two test specific attributes:

| Attribute              | Type                 | Specification |
|------------------------|----------------------|---------------|
| `stimulus-update-rate` | int = Calculated(tc) | |
| `trigger-update-rate`  | int = Calculated(tc) | |

The `<psychophysics-threshold-estimation>` test has X test specific elements:

| Element              | Specification |
|----------------------|---------------|
| `<update-rate-deterministic>`, or `update-rate-random` | The inter-stimulus interval is the time between when stimuli and /or questions are presented to the subject. This element is only required for automatic response tasks. |
| `<configuration>` | Trigger configuration for the generation of stimuli and triggers. |
| `<manual-yes-no-task>`, `<yes-no-task>`, `<forced-yes-no-task>`, `<manual-interval-rating-task>`, `<interval-rating-task>`, `<manual-categorical-rating-task>`, `<categorical-rating-task>`, `<ratio-rating-task>`, `<interval-forced-choice-task>`, or `<alternative-forced-choice-task>` | Selection and configuration of the response task used for determining the psychometric performance of the subject, meaning whether they were able to perceive the stimulus or not. A wide selection of response tasks is available, encompassing both tasks in which the subject's response is sampled automatically or entered manually by the operator, threshold and supra-threshold perception tasks, and yes/no or forced-choice tasks. <br /><br /> Please see the **Response tasks** section for a detailed description of each task and how to configure them. |
| `<stimulation-scripts>` | The test uses a **Stimulator** instrument to deliver stimuli to the participants and a **TriggerGenerator** instrument to generate triggers to external equipment. <br /><br />  This <stimulation-scripts> element can be used to run Python scripts that deliver stimuli to participants when stimuli or triggers cannot be delivered with **Stimulator** or **TriggerGenerator** instruments. <br /><br /> Consequently, this element can be used to extend the test with stimulus modalities or triggers that are not natively supported by the test. |
| `<channels>` | Stimulus channels are a set of stimuli for which their psychometric function and/or thresholds are estimated concurrently. Each stimulus channel consists of a stimulus definition and an adaptive estimation algorithm. <br /><br /> When the test runs, it will alternate between each of these stimuli until the stop criteria for all stimuli are met. Consequently, the psychometric functions will be estimated concurrently, without the participant knowing which stimulus is being delivered. <br /><br /> All stimulus channels will use the same response task, as the instructions for the participant must be the same regardless of which stimulus is being delivered. |

## Adaptive methods

### Up/Down 

The up/down method (also known as a staircase procedure) is one of the most widely used adaptive methods in psychophysics for estimating perceptual thresholds. The method dynamically adjusts stimulus intensity based on the participant’s responses, focusing trials on the threshold region where responses transition from mostly incorrect to mostly correct.

The up/down method operates on the following principle:

* Correct response → decrease stimulus intensity
* Incorrect response → increase stimulus intensity

By repeatedly applying this rule, the stimulus intensity oscillates around the participant’s threshold, producing a sequence of reversals that can be used to estimate the threshold value. The Up/Down method is illustrated in *Figure 2*.

![](/images/experiments/tests/threshold-estimation/UpDown.png)

*Figure 2:*

#### Reversals and Threshold Estimation

A reversal is defined as a change in the direction of stimulus adjustment. For example:

* Incorrect → Correct (intensity switches from increasing to decreasing)
* Correct → Incorrect (intensity switches from decreasing to increasing)

After an initial transient phase, the stimulus values at reversal points cluster around the participant’s threshold. The threshold estimate is typically computed as: The mean of the reversal intensities, excluding a configurable number of initial reversals (the skip rule)


#### Step Size and Step Size Reduction

The step size determines how much the stimulus intensity changes after each response. Larger step sizes allow rapid convergence toward the threshold early in the procedure, while smaller step sizes improve precision near the threshold.

LabBench supports adaptive step size reduction, where: The step size is multiplied by a reduction factor after each reversal. A lower bound (max-step-size-reduction) prevents the step size from becoming too small. This strategy combines fast convergence with stable threshold estimation. If adaptive step size reduction is used the threshold average will be weighted with the inverse of the step sizes at the reversals.

#### Variants and Target Performance Level

The simplest up/down method (1-up/1-down) converges to the stimulus intensity corresponding to approximately 50% correct performance. More advanced variants (e.g., n-up/m-down or unequal up/down stepsizes) can target other points on the psychometric function.

#### Definition of the method

A stimulus channel `<channel>` can be configured to use the Up/Down estimation method with the `<up-down-method>` element:

```xml
<up-down-method 
    start-intensity="Stimulator.Range/2 + Stimulator.Imin"
    initial-direction="decreasing"
    reversal-rule="1"
    skip-rule="1"
    stop-rule="7"
    step-size="0.15"
    max-step-size-reduction="0.25"
    step-size-reduction="0.5" />
```

*Listing 2: Definition of the Up/Down method*

The method is configured with the following attributes:

| Attribute              | Type                    | Specification |
|------------------------|-------------------------|---------------|
| `start-intensity`      | double = Calculated(tc) | Initial intensity for the algorithm.        |
| `initial-direction`    | enum                    | Initial direction for the intensity change. |
| `reversal-rule`        | int = Calculated(tc)    | The number of times the participants must either succeed or fail for the intensity change to change direction. This attribute is used for both upward and downward directions unless either the `up-rule` or the `down-rule` is defined, respectively. The default value for this attribute is one (1). |
| `up-rule`              | int = Calculated(tc)    | The number of times the participants must succeed when the intensity is increased upward for the intensity change to change direction. The default value for this attribute is one (1). |
| `down-rule`            | int = Calculated(tc)    | The number of times the participants must fail when the intensity is decreased upward for the intensity change to change direction. The default value for this attribute is one (1). |
| `step-size`            | double = Calculated(tc) | Will be used as the initial step size in both the up and down directions, unless the step-size-up or step-size-down is defined. Default value is 0.1. |
| `step-size-up`         | double = Calculated(tc) | Will be used as the initial step size in the upward direction. If it is undefined, the step-size attribute will be used instead as the initial step size for the up direction. |
| `step-size-down` | double = Calculated(tc) | Will be used as the initial step size in the downward direction. If it is undefined, the step-size attribute will be used instead as the initial step size for the downward direction. |
| `step-size-reduction` | double = Calculated(tc) | Used to configure adaptive step sizes. The step size after a reversal will be `new-step-size` = (1 - `step-size-reduction`) * `old-step-size`. The default value is 0.5. |
| `max-step-size-reduction` | double = Calculated(tc) | The maximum by which step sizes will be reduced when adaptive step sizes are enabled by setting the `step-size-reduction` attribute to a non-zero value. |
| `step-size-type` | enum | Type of step size: absolute, the step size is added or subtracted to the current intensity, or relative, the step size is relative to the current intensity. |

Please note not all of these attributes are shown in the code example above.

### Discrete Up/Down

The discrete up/down method is a variant of the classical staircase procedure in which stimulus intensity is restricted to a finite, predefined set of discrete values. Instead of continuously adjusting the stimulus intensity by adding or subtracting a step size, the algorithm moves up or down within a list of allowed intensity levels.

This method is particularly useful when:

* The stimulus hardware only supports a limited set of intensity values
* The experiment requires standardized, repeatable stimulus levels
* The stimulus dimension is inherently categorical or ordinal

Conceptually, the discrete up/down method follows the same adaptive logic as the continuous version, but replaces arithmetic intensity updates with index-based transitions between predefined intensity levels. The Up/Down method is illustrated in *Figure 3*.

![](/images/experiments/tests/threshold-estimation/DiscreteUpDown.png)

*Figure 3:*

#### Discrete Intensity Set

The key defining feature of the discrete up/down method is the intensity set, provided as an ordered list:

```xml
intensities="[10, 20, 30, 40, 50, 60, 70, 80, 90, 100]"
```

The algorithm always selects intensities from this list and never interpolates between values.

#### Step Size in Discrete Space

Unlike the continuous up/down method, the step size in the discrete variant is defined in terms of index jumps within the intensity list.

For example: initial-step-size="2" means the algorithm moves two positions up or down the intensity list after each response. Once a reversal has occured, the  step size is reduced to one.

This approach allows rapid initial convergence while maintaining strict control over the allowed intensity values.

#### Reversals and Threshold Estimation

Reversals are detected when the direction of index movement changes. After discarding a configurable number of initial reversals (the skip rule), the remaining reversal intensities are used to estimate the threshold.

The threshold is computed as the mean of the intensities at the reversal points

#### Definition of the method

A stimulus channel `<channel>` can be configured to use the Up/Down estimation method with the `<discrete-up-down-method>` element:

```xml
<discrete-up-down-method 
    stop-rule="7" 
    initial-intensity="10" 
    initial-step-size="2"
    initial-direction="increasing"
    skip-rule="1"
    intensities="[10, 20, 30, 40, 50, 60, 70, 80, 90, 100]" />
```

*Listing 3: Definition of the Discrete Up/Down method*

The method is configured with the following attributes:

| Attribute              | Type                    | Specification |
|------------------------|-------------------------|---------------|
| `initial-intensity`    | double = Calculated(tc) | This attribute is used to select the initial intensity from the set of allowed intensities ('intensities'). The initial intensity will be selected as the intensity in the set of allowed intensities closest to the value of this initial intensity attribute. If this attribute is not defined, the initial intensity will be set based on the initial direction. If the initial direction is upward, the smallest allowed intensity will be used; otherwise, the largest allowed intensity will be used.| 
| `initial-direction`    | enum                    | Initial direction for the intensity change. |
| `initial-step-size`    | int = Calculated(tc)    | Sets the initial step size. The initial step size can be set to a value larger than one (1) to initially rapidly approach the threshold. Once a reversal has occurred, the step size will be set to one (1). |
| `stop-rule`            | int = Calculated(tc)    | Number of reversals required before the algorithm is completed.|
| `skip-rule`            | int = Calculated(tc)    | The number of initial reversals that are skipped when calculating the threshold as the average of the intensity at the reversals. Consequently, if this `skip-role` attribute is set to one (3) and the stop-rule is set to nine (9), the threshold will be calculated from the last six (6) reversals. The default value is zero (0). |
| `intensities`          | double[] = Calculated(tc) | The discrete set of allowed stimulus intensities in the form of an array of doubles. These values must be ordered from the smallest to the largest and must be within the bounds of the Imin and Imax attributes for the stimulus channel. |
  
### Psi-Method

The Psi method is a Bayesian adaptive procedure for efficiently estimating the parameters of a psychometric function. Unlike staircase methods, which primarily converge to a single threshold value, the Psi method explicitly models the entire psychometric function and selects stimulus intensities that maximize expected information gain on each trial. At each iteration, the Psi method evaluates the expected posterior entropy for all candidate stimulus intensities and selects the one that minimizes this entropy, thereby maximizing the expected reduction in uncertainty about the psychometric parameters.

For each trial, the Psi method performs the following steps:

1. **Posterior prediction**: For each candidate stimulus intensity, the method predicts the probability of a correct response under the current posterior.
2. **Expected entropy computation**: The expected posterior entropy is computed for each candidate intensity, marginalizing over possible responses.
3. **Optimal stimulus selection**: The stimulus intensity that minimizes expected entropy is selected for the next trial.
4. **Posterior update**: After observing the actual response, Bayes’ rule is used to update the posterior distribution over psychometric parameters.

This process is repeated until the predefined number of trials is reached. This method is illustrated in figure 4.

![](/images/experiments/tests/threshold-estimation/PsiMethod.png)

*Figure 4:*

#### Stimulus Intensity Normalization in the Psi Method

In the Psi method, stimulus intensities are normalized to the unit interval [0,1]. This normalization applies both to the candidate stimulus intensities considered by the algorithm and to the threshold parameter (𝛼) of the psychometric function. Normalization is a conceptual and computational step that separates the estimation logic of the Psi method from the physical units of the stimulus. 

The normalized intensity x ∈ [0,1] is mapped to a physical stimulus intensity (Istimulus) internally using the stimulus channel’s minimum and maximum intensities:

```
Istimulus = (Imax - Imin) * x + Imin
```

This mapping is performed automatically by LabBench and is transparent to the user once the stimulus range is defined. Intensity normalization significantly simplifies experiment design and reduces configuration errors.

#### Test definition 

```xml
<psi-method number-of-trials="30">
    <quick lambda="0.05" gamma="0.33" />
    <beta type="linspace" x0="-1.2" x1="1.2" n="24"/>
    <alpha type="linspace" x0="0" x1="1" n="100" />
    <intensity type="linspace" x0="0" x1="1" n="50" />
</psi-method>
```

*Listing 4: Definition of the Psi method*

## Response tasks

Each iteration of the adaptive method for estimating thresholds or psychometric functions requires an outcome from a response task, which, for all tasks, is either true (they performed the response task correctly) or false (they failed the response task). The response task is chosen based on several factors, such as the nature of the stimulus, the need to reduce response bias, and the requirements for speed and simplicity.

LabBench includes several built-in response tasks that can be configured and used with the threshold estimation test. These response tasks are divided into two categories: 1) automatic, the participant's response is collected automatically without requiring the involvement of the operator, and 2) manual, the operator needs to ask the subject and enter the response manually into LabBench. LabBench has the following built-in response tasks:

| Task                       | Type      | Description | Required Instruments |
|----------------------------|-----------|-------------|----------------------|
| Yes/No                     | Automatic | In a Yes/No response task, the subject is asked to press the button each time a stimulus is felt. This response is timed, meaning that if the subject does not press the button before the next stimulus is given, then it will be assumed that the stimulus was not felt. | Button |
| Manual Yes/No              | Manual    | In a Manual Yes/No response task, the experimenter asks the subject after each stimulation whether they felt the stimulus. This response is then entered into the algorithm manually by the experimenter. Consequently, the test will wait indefinitely until the subject has answered the experimenter. | None |
| Forced Yes/No              | Manual    | In the forced yes/no task, the stimulus is first presented to the subject, along with a cue that prompts the subject to attend to it. <br /><br /> Then a probe image is presented to the subject, with instructions to answer Yes or No to a stimulus quality; for example, if one or two stimuli could be felt, the subject presses one button for Yes and another for No. The task will wait indefinitely until the subject has answered the question. <br /><br /> This task is usually used for stimuli that are always felt but whose quality changes with increasing intensity. Examples of such stimuli are two-point stimuli or stimuli used to determine a just noticeable difference. | None |
| Interval Forced Choice     | Automatic | Configuration of a stimulus interval. Stimuli will be generated for each stimulus interval in the order they are defined; when the stimulus is generated, the cue for that stimulus interval will be shown to the subject. <br /><br />     For each trial, one stimulus interval will be randomly selected as the one in which the stimulus is to be present. For that interval, the stimulus intensity (x) will be set to the current intensity determined by the estimation algorithm; for all other intervals, the stimulus intensity (x) will be set to Imin for the stimulus channel. <br /><br /> For calculated parameters, the currently active stimulus interval and selected stimulus interval are also available as the StimulusInterval and SelectedStimulusInterval parameters, respectively. These parameters contain the stimulus interval IDs. | Button, ImageDisplay |
| Alternatives Forced Choice | Automatic | Configuration of a stimulus alternative where each is a different variant of the stimulus. For example, in a test that determines the just noticeable difference between three audible tones, there will be three different stimulus alternatives, for which either the first, middle, or last tone will be of a different intensity than the other tones. <br /><br /> For each trial, one stimulus alternative will be selected at random and presented to the subject. The selected one is available to calculated parameters in the StimulusAlternative parameter, whose value is the id attribute of the selected stimulus alternative. | Button, ImageDisplay |
| Ratio Rating               | Automatic | In the Ratio Rating Task, the subject is asked to rate the stimuli's sensations on a ratio rating scale/visual analog scale. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False. | RatioScale |
| Interval Rating           | Automatic | In the Interval Rating Task, the subject is asked to rate the stimuli's sensations on an interval rating scale. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False. | IntervalScale |
| Manual Interval Rating    | Manual    | In the Manual Interval Rating Task, the subject is asked to rate the stimuli's sensations on an interval rating scale by the experimenter. The subject provides this rating verbally, which the experimenter then manually enters into the algorithm. The response task will wait indefinitely until the experimenter has entered the subject's rating into the algorithm. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False. | None |
| Categorical Rating         | Automatic | In the Categorial Rating Task, the subject is asked to rate the stimuli's sensations on a categorial rating scale. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False. | OrdinalScale |
| Manual Categorical Rating  | Manual    | In the Manual Categorial Rating Task, the subject is asked to rate the stimuli's sensations on a categorial rating scale by the experimenter. The subject provides this rating verbally, which the experimenter then manually enters into the algorithm. The response task will wait indefinitely until the experimenter has entered the subject's rating into the algorithm. If the subject rate exceeds the target, the response task is successful and returns True; otherwise, it returns False. | None |

### Yes/No

```xml
<yes-no-task />
```

### Manual Yes/No

![](/images/experiments/tests/threshold-estimation/TaskManualYesNo.png)

*Figure 5:*


```xml

```

### Forced Yes/No

![](/images/experiments/tests/threshold-estimation/TaskFYN.png)

*Figure 6:*

```xml

```

### Interval Forced Choice

![](/images/experiments/tests/threshold-estimation/TaskIFC.png)

*Figure 7:*

```xml

```

### Alternatives Forced Choice

![](/images/experiments/tests/threshold-estimation/TaskAFC.png)

*Figure 8:*

```xml

```

### Ratio Rating

![](/images/experiments/tests/threshold-estimation/TaskVAS.png)

*Figure 9:*

```xml

```

### Numerical Rating 

![](/images/experiments/tests/threshold-estimation/TaskNRS.png)

*Figure 10:*

```xml

```

### Manual Numerical Rating

![](/images/experiments/tests/threshold-estimation/TaskManualNRS.png)

*Figure 11:*

```xml

```

### Categorical Rating

![](/images/experiments/tests/threshold-estimation/TaskCRS.png)

*Figure 12:*

```xml

```

### Manual Categorical Rating

![](/images/experiments/tests/threshold-estimation/TaskManualCRS.png)

*Figure 13:*
 
```xml

```


## Stimulation


## Scripting

### Properties

### Functions

## Test results


## Example protocols
