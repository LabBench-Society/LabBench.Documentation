---
title: Cold Pressor
description: The cold pressor test is an experimental procedure in which a participant immerses a hand or forearm in ice-cold water to induce controlled pain or stress, allowing researchers to measure physiological and behavioral responses.
weight: 20
---

{{% pageinfo %}}

The cold pressor procedure measures pain detection (PDT) and/or pain tolerance (PTT) based on timed button presses during hand immersion in cold water. The procedure is event-driven and records the time between key events: immersion, pain onset, and withdrawal.

During execution, instructions are presented to guide the operator or participant through the task. Button presses mark transitions between phases, and timing is recorded automatically.

After completion, the result is visualized as a timeline, showing the measured thresholds and overall duration of the procedure.

{{% /pageinfo %}}



The procedure window is shown in *Figure 1* and provides a visual summary of the procedure:

- The **top bar** displays the operator instruction .
- The **center label** shows the responder classification (`responder-label` or `non-responder-label`), based on whether the participant completed the task within the specified time limit.
- The **circular chart** represents the temporal structure of the procedure:
  - The **blue segment** corresponds to the pain detection threshold (PDT), i.e., the time from immersion to first pain sensation.
  - The **red segment** corresponds to the pain tolerance threshold (PTT), i.e., the time until the participant withdraws from the stimulus.
  - Additional segments may represent remaining or contextual time relative to the configured time limit.
- The **legend** displays the measured values using the configured labels (`pdt-label`, `ptt-label`) along with their corresponding times.

![](/images/Experitments_Procedures_Psychophysics_ColdPressor/Slide1.PNG)

*Figure 1: Procedure window of the cold pressor procedure*

This visualization reflects the internal state transitions of the procedure and provides an intuitive overview of the participant’s response over time.

## Procedure definition

A cold pressor procedure can be defined with the `<psychophysics-cold-pressor>` element within the `<procedures>` element in the Experiment Definition File (`*.expx`):

```xml
<psychophysics-cold-pressor 
    id="T01" 
    experimental-setup-id="cpt"
    name="Cold Pressor Test (PDT, Operator Controlled)" 
    measurement="pdt" 
    completed-instruction="completed-instruction"
    completion-instruction="completion-instruction"
    non-responder-label="non-responder-label"
    pain-instruction="pain-instruction"
    pdt-label="pdt-label"
    pending-instruction="pending-instruction"
    ptt-label="ptt-label"
    ready-instruction="ready-instruction"
    responder-label="responder-label"
    control="operator"
    time-limit="60" 
    button="button-01" />            
```

The `<psychophysics-threshold-estimation>` procedure has these procedure specific attributes:

| Attribute                 | Type                           | Specification |
|---------------------------|--------------------------------|---------------|
| `control`                 | enum = [operator, participant] | Defines who controls the event marking via button presses. |
| `measurement`             | enum = [pdt, ptt, both]        | Specifies whether to measure pain detection threshold (PDT), pain tolerance threshold (PTT), or both. |
| `time-limit`              | double = Calculated(context)   | Maximum duration in seconds before the procedure automatically ends and the participant is marked as a non-responder. |
| `button`                  | ButtonID                       | Identifier of the button used to mark events during the procedure. |
| `ready-instruction`       | string = Calculated(context)   | Instruction shown when the procedure is ready to run. |
| `completed-instruction`   | string = Calculated(context)   | Instruction shown when the procedure has completed. |
| `pending-instruction`     | string = Calculated(context)   | Instruction shown while waiting for the first event (e.g., hand immersion). |
| `pain-instruction`        | string = Calculated(context)   | Instruction shown when marking pain detection (PDT). |
| `completion-instruction`  | string = Calculated(context)   | Instruction shown for the final event (e.g., hand withdrawal). |
| `pdt-label`               | string = Calculated(context)   | Label used for the pain detection threshold (PDT) result. |
| `ptt-label`               | string = Calculated(context)   | Label used for the pain tolerance threshold (PTT) result. |
| `non-responder-label`     | string = Calculated(context)   | Label used to describe participants who do not respond within the time limit. |
| `responder-label`         | string = Calculated(context)   | Label used to describe participants who complete the procedure within the time limit. |

## Measurement modes

The behavior of the cold pressor procedure depends on the `measurement` attribute, which determines which thresholds are recorded and how button presses are interpreted.

### Pain detection threshold (PDT)

When configured with `measurement="pdt"`, the procedure measures only the time to first pain sensation.

- **1st press**: Marks immersion and starts timing  
- **2nd press**: Marks pain detection → PDT is recorded and the procedure completes  

No tolerance measurement is performed.

---

### Pain tolerance threshold (PTT)

When configured with `measurement="ptt"`, the procedure measures only the time to withdrawal.

- **1st press**: Marks immersion and starts timing  
- **2nd press**: Marks withdrawal → PTT is recorded and the procedure completes  

PDT is not measured (recorded as 0).


### Both pain detection (PDT) and tolerance thresholds (PTT)

When configured with `measurement="both"`, the procedure measures both thresholds.

- **1st press**: Marks immersion and starts timing  
- **2nd press**: Marks pain detection → PDT is recorded  
- **3rd press**: Marks withdrawal → PTT is recorded and the procedure completes  

This mode captures both the onset of pain and the maximum tolerance duration.


### Time limit behavior

For all modes, if the `time-limit` is exceeded before the final event is recorded:

- The procedure ends automatically  
- The participant is marked as a **non-responder**  
- Any missing thresholds remain unrecorded  

## Extending the procedure beyond the cold pressor

While the procedure is designed for the cold-pressor test, it follows a general pattern for measuring time-based thresholds during sustained tasks. By recording the timing of button presses, it captures the onset of a sensation or event (PDT) and the point at which the task is terminated (PTT).

This makes the procedure applicable to a wide range of endurance- and threshold-based paradigms, in which participants experience a stimulus or perform a task over time.

### General principle

The procedure measures:

* Onset → time to first relevant experience or event (e.g., pain, fatigue, urge)
* Tolerance → time to termination or inability to continue

These two measures can be interpreted flexibly depending on the task.

### Example applications

The same procedure structure can be used in other domains:

* **Isometric muscle endurance:** Measure time to fatigue and task failure during sustained contraction.
* **Thermal stimulation (thermode-based):** Measure detection and tolerance thresholds during controlled temperature exposure.
* **Pressure pain (algometry):** Measure onset and tolerance during sustained pressure application. 
* **Breath-hold tasks:** Measure urge to breathe and total breath-hold duration.
* **Cognitive or stress endurance:** Measure the onset of fatigue and disengagement during prolonged tasks.

### Adapting the procedure

The procedure can be adapted without code changes by:

* Updating instructions (ready, pending, pain, completion) to match the task
* Renaming labels (pdt-label, ptt-label) to reflect the measured quantities
* Configuring the measurement mode (pdt, ptt, or both)
* Adjusting the time limit to suit the task duration

This flexibility allows the same implementation to support multiple experimental paradigms while maintaining consistent timing and data collection.

## Scripting

The following properties are available in calculated parameters as the result of a cold pressor procedure. These properties provide access to the measured thresholds, configuration, and outcome of the procedure.


| Name        | Type                         | Description |
|-------------|------------------------------|-------------|
| TimeLimit   | double                       | The configured time limit in seconds for the procedure. |
| Measurement | enum = [pdt, ptt, both]      | The measurement mode used for the procedure. |
| PDT         | double                       | Pain detection threshold in seconds. Represents the time from start to first pain sensation. Returns NaN if not recorded. |
| PTT         | double                       | Pain tolerance threshold in seconds. Represents the time from start to task termination. Returns NaN if not recorded. |
| Responder   | bool                         | Indicates whether the participant completed the procedure within the time limit. |
| Completed   | bool                         | Indicates whether the procedure was completed and accepted. |
| Failed      | bool                         | Indicates whether the procedure failed. |

**Notes:**

- `PDT` and `PTT` may be `NaN` depending on the selected measurement mode or if the participant did not reach the corresponding threshold.
- A participant is marked as a **non-responder** if the `TimeLimit` is exceeded before the final event is recorded.
- The result inherits common properties from `Result`, such as timing, identifiers, and instrument information, which are also available in scripting.
