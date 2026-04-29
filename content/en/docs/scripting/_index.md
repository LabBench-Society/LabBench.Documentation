---
title: Scripting
description: Information on how use and call Python code.
weight: 70
---

{{% pageinfo %}}

Scripting in LabBench allows you to add executable logic to otherwise declarative XML protocols. 

{{% /pageinfo %}}

Throughout this documentation, you will have seen this notation `type = Calculated(context, x)` or `type = Calculated(context)` as the type for attributes. This notation means that the attribute is evaluated as either a single-line Python expression or a function call in a Python script. These attributes are referred to as calculated attributes.

The ability to evaluate expressions or call Python functions from an Experiment Definition File makes it possible to automate protocols, and this is where the LabBench language derives its power and versatility.

## Expressions

Unless any keywords are provided for a calculated attribute, it will be evaluated as a single-line Python expression.

### Syntax

General form:

```xml
<attribute>="expression"
```

Examples:

```xml
Istart="SR.PDT"
Ts="min(2, SD.Chronaxie)"
Imin="0.1 * Stimulator.Max"
```

An expression must:

* Be written as a single line
* Return a value of the expected type (e.g. int, double, string)
* Be valid Python syntax
* Be valid XML (reserved characters must be escaped)

### Scope

Single-line expressions are evaluated in a **constructed execution scope**. This scope defines exactly which variables, results, functions, and constants are available when the expression is executed. The scope is not a full Python environment—it is explicitly built by LabBench before evaluation.

When an expression is evaluated, LabBench creates a dictionary of variables and injects:

1. **Free parameter (`x`) if applicable**
2. **Results**
3. **Defines and variables**
4. **Instruments**
5. **Parameters**
6. **Assets**
7. **Built-in functions**
8. **Constants**

This combined scope is then used to execute the expression.

All results are injected in two ways:

```python
Test01.PDT
Results.Test01.PDT
```

| Name         | Description               |
| ------------ | ------------------------- |
| `Results`    | Collection of all results |
| `[ResultID]` | Direct access to a result |
| `Current`    | The result of the currently selected procedure |

All variables are available directly:

```python
MyVariable
Participant
```

| Name           | Description                              |
| -------------- | ---------------------------------------- |
| `[DefineName]` | Value defined in the protocol or runtime |


All instruments are injected directly into scope:

```python
Stimulator.Max
ImageDisplay.Show(...)
```

| Name               | Description         |
| ------------------ | ------------------- |
| `[InstrumentName]` | Instrument instance |

Procedure-specific parameters are also available:

```python
NumberOfStimuli
```

Assets are available both as a collection and directly:

```python
Assets.Images.Cue
Images.Cue
```

| Name        | Description            |
| ----------- | ---------------------- |
| `Assets`    | Asset manager          |
| `[AssetID]` | Direct access to asset |


#### Functions

The following functions are available in single-line expressions. All functions operate on `double` values unless otherwise noted.

| Signature                   | Return type | Description                                          | Edge conditions                                                             |
| --------------------------- | ----------- | ---------------------------------------------------- | --------------------------------------------------------------------------- |
| `exp(x)`                    | `double`    | Returns (e^x).                                       | Large positive `x` → `+∞`; large negative `x` → `0`; NaN propagates.        |
| `round(x)`                  | `double`    | Rounds to nearest integer using banker’s rounding.   | Midpoints round to nearest even; NaN propagates.                            |
| `ceiling(x)`                | `double`    | Smallest integer ≥ `x`.                              | `±∞` and NaN returned unchanged.                                            |
| `floor(x)`                  | `double`    | Largest integer ≤ `x`.                               | `±∞` and NaN returned unchanged.                                            |
| `truncate(x)`               | `double`    | Removes fractional part (toward zero).               | `±∞` and NaN returned unchanged.                                            |
| `log(x)`                    | `double`    | Natural logarithm.                                   | `x > 0` valid; `x = 0` → `-∞`; `x < 0` → NaN.                               |
| `log10(x)`                  | `double`    | Base-10 logarithm.                                   | Same domain as `log`.                                                       |
| `sin(x)`                    | `double`    | Sine of `x` (radians).                               | `±∞` → NaN; NaN propagates.                                                 |
| `sinh(x)`                   | `double`    | Hyperbolic sine.                                     | Large |x| may overflow to `±∞`; NaN propagates.                             |
| `asin(x)`                   | `double`    | Arcsine (radians).                                   | Domain: `-1 ≤ x ≤ 1`; outside → NaN.                                        |
| `cos(x)`                    | `double`    | Cosine of `x` (radians).                             | `±∞` → NaN; NaN propagates.                                                 |
| `cosh(x)`                   | `double`    | Hyperbolic cosine.                                   | Large |x| → `+∞`; NaN propagates.                                           |
| `acos(x)`                   | `double`    | Arccosine (radians).                                 | Domain: `-1 ≤ x ≤ 1`; outside → NaN.                                        |
| `tan(x)`                    | `double`    | Tangent of `x` (radians).                            | Undefined at odd multiples of π/2; returns large finite values; `±∞` → NaN. |
| `tanh(x)`                   | `double`    | Hyperbolic tangent.                                  | Approaches `±1` as `x → ±∞`; NaN propagates.                                |
| `abs(x)`                    | `double`    | Absolute value.                                      | `±∞` → `+∞`; NaN propagates.                                                |
| `sqrt(x)`                   | `double`    | Square root.                                         | `x ≥ 0` valid; `x < 0` → NaN; `+∞` → `+∞`.                                  |
| `max(x, y)`                 | `double`    | Returns larger of two values.                        | If either input is NaN → NaN.                                               |
| `min(x, y)`                 | `double`    | Returns smaller of two values.                       | If either input is NaN → NaN.                                               |
| `pow(x, y)`                 | `double`    | Returns (x^y).                                       | Negative `x` with non-integer `y` → NaN; `0^0 = 1`; overflow → `±∞`.        |
| `step(x)`                   | `double`    | Step function: returns `1` if `x ≥ 0`, else `0`.     | NaN → `0` (comparison false).                                               |
| `pulse(x, d)`               | `double`    | Rectangular pulse: `1` if `0 ≤ x < d`, else `0`.     | NaN in either argument → `0`.                                               |
| `linspace(x0, x1, n)`       | `double[]`  | Linearly spaced array from `x0` to `x1` (inclusive). | `n < 2` may cause division issues; NaN/∞ propagate to output.               |
| `geomspace(x0, x1, n)`      | `double[]`  | Geometric progression from `x0` to `x1`.             | `x0 ≤ 0` or `x1 ≤ 0` may produce invalid values; `n < 2` invalid.           |
| `logspace(x0, x1, base, n)` | `double[]`  | Values defined as (base^{linspace(x0,x1)}).          | Large exponents may overflow; invalid base or NaN inputs propagate.         |

#### Constants

| Name | Value |
| ---- | ----- |
| `PI` | π     |
| `E`  | e     |

#### Name resolution

Variables are added to the scope in sequence. If a name already exists:

* The new value is **not added**
* A debug log entry is generated

This means:

* Earlier entries take precedence
* Duplicate names can lead to unexpected behaviour


### Escaping characters

XML uses a small set of reserved characters to define its structure. These characters cannot be used directly inside attribute values or element content without being escaped, as they would otherwise be interpreted as part of the XML syntax.

This becomes particularly important in LabBench, where **calculated attributes often contain single-line Python expressions**. Many valid Python expressions include characters that must be escaped in XML, which can lead to subtle errors if not handled correctly.

The following characters must be escaped when used inside XML:

| Character | Meaning in XML                     | Escape sequence |
| --------- | ---------------------------------- | --------------- |
| `<`       | Start of a tag                     | `&lt;`          |
| `>`       | End of a tag                       | `&gt;`          |
| `&`       | Start of an entity                 | `&amp;`         |
| `"`       | Attribute delimiter (double quote) | `&quot;`        |

Calculated attributes are typically written like this:

```xml
<arbitrary Ts="50" expression="x < 5" />
```

This is **invalid XML**, because `<` is interpreted as the start of a new tag.

Correct version:

```xml
<arbitrary Ts="50" expression="x &lt; 5" />
```

which is hard to read and understand. **If escaped characters are needed it is often better to call a Python function in a script.**

**Practical guidance:**

* Always escape `<`, `>`, and `&` in expressions
* Be careful with quotes inside attributes
* Prefer simpler expressions where possible to reduce escaping complexity

**Gotchas:**

* **Silent XML parsing errors:** Invalid escaping may not produce clear errors—it can break parsing or cause attributes to be ignored.
* **Hard-to-read expressions:** Heavy escaping (`&lt;`, `&gt;`, etc.) can make expressions difficult to read and debug.
* **Double escaping mistakes:** Writing `&amp;lt;` instead of `&lt;` will produce incorrect results.
* **Mismatch between Python and XML syntax:**  A valid Python expression is not necessarily valid XML—always validate both layers.

#### Summary

When writing calculated attributes:

* You are writing **Python inside XML**
* The expression must be valid in **both contexts**
* XML escaping is required for certain characters

Understanding this dual constraint avoids a large class of subtle and frustrating errors.


## Functions

### Syntax

```python

```

```python

```

### Scope


## Dynamic text

### Syntax 

```python

```

### Formatted strings (f-strings)

**f-strings** (formatted string literals) are a concise way to embed expressions inside strings in Python. They are prefixed with `f` and evaluate expressions directly inside `{}`.

```xml
<variable name="value" value="3.14159">
```

```python
text = f'Value is {value}'
```

Expressions inside `{}` are evaluated at runtime:

```python
f'{2 + 2}'          # "4"
f'{value * 2}'      # "6.28318"
```

You can control formatting using a **format specifier** after a colon `:` inside the braces:

```python
f'{value:.2f}'   # "3.14"
```

General syntax:

```
{expression:format_spec}
```

**Common number formatting:**

| Format      | Description              | Example            | Result     |
| ----------- | ------------------------ | ------------------ | ---------- |
| `{x}`       | Default                  | `f'{3.14}'`        | `3.14`     |
| `{x:.2f}`   | Fixed-point (2 decimals) | `f'{3.14159:.2f}'` | `3.14`     |
| `{x:.0f}`   | No decimals (rounded)    | `f'{3.6:.0f}'`     | `4`        |
| `{x:6.2f}`  | Width + decimals         | `f'{3.14:6.2f}'`   | `"  3.14"` |
| `{x:06.2f}` | Zero-padded              | `f'{3.14:06.2f}'`  | `"003.14"` |
| `{x:+.2f}`  | Always show sign         | `f'{3.14:+.2f}'`   | `+3.14`    |
| `{x:.2e}`   | Scientific notation      | `f'{1234:.2e}'`    | `1.23e+03` |
| `{x:.1%}`   | Percentage               | `f'{0.256:.1%}'`   | `25.6%`    |
| `{x:b}`     | Binary                   | `f'{5:b}'`         | `101`      |
| `{x:x}`     | Hex (lowercase)          | `f'{255:x}'`       | `ff`       |
| `{x:X}`     | Hex (uppercase)          | `f'{255:X}'`       | `FF`       |

**Alignment and width:**

| Format   | Description    | Example      | Result     |
| -------- | -------------- | ------------ | ---------- |
| `{x:>6}` | Right aligned  | `f'{42:>6}'` | `'    42'` |
| `{x:<6}` | Left aligned   | `f'{42:<6}'` | `'42    '` |
| `{x:^6}` | Center aligned | `f'{42:^6}'` | `'  42  '` |

## The `context` object 

When a Python function is called from a calculated attribute, it receives a **context object** (named `context`) that provides access to the full state of the experiment at runtime.

This object is an instance of `ProcedureBlackboard` and acts as the central interface between your Python code and LabBench.

The context exposes several categories of data and functionality:

### Properties

The `context` object exposes both **automatically injected variables** and **public properties** that describe the current execution environment. These can be accessed directly from Python functions.

| Name                | Type                          | Description                                                        |
| ------------------- | ----------------------------- | ------------------------------------------------------------------ |
| `Language`          | `string`                      | Active language code for the session.                              |
| `Participant`       | `string`                      | Name or identifier of the participant.                             |
| `ParticipantNumber` | `int`                         | Participant number within the study. Can be used for example for generation of latin-squares. |
| `StartTime`         | `DateTime`                    | Timestamp when the session was initialized.                        |
| `ExperimentalSetup` | `string`                      | Identifier of the experimental setup.                              |
| `ActiveSession`     | `string`                      | Identifier of the currently active session.                        |
| `Current`           | `Result`                      | The currently executing procedure result.                          |
| `Results`           | `ItemCollection<Result>`      | Collection of all procedure results. Please note they are also exposed as `context.[Result ID]`. |
| `Variables`         | `ItemCollection<object>`      | Collection of all defined variables (defines + runtime variables). Please note they are also exposed as `context.[Variable Name]`. |
| `Parameters`        | `ItemCollection<object>`      | Collection of procedure-specific parameters. Please note they are also exposed as `context.[Parameter Name]`.|
| `Instruments`       | `ItemCollection<IInstrument>` | Collection of available instruments.                               |
| `Assets`            | `AssetManager`                | Access to protocol assets (images, scripts, etc.).                 |

These values can be accessed directly:

```python 
context.Participant
context.ParticipantNumber
context.Language
context.Current
```

Automatically injected variables behave like global values in expressions, while properties provide structured access to collections and services exposed by the runtime.

### Results

Access results from procedures:

```python
context.Results
context.Test01
context.Test01.PDT
```

* Each procedure result is accessible by its ID
* `context.Current` refers to the currently executing result

### Variables 

All variables and runtime variables are available directly:

```python
context.MyVariable
context.Participant
context.ParticipantNumber
context.Language
```

These include:

* Protocol variables
* Participant information
* Procedure parameters

### Instruments

Access instruments declared in the procedure:

```python
context.Instruments.Stimulator
context.Instruments.ImageDisplay
```

These are the same instruments declared via `<instrument>` elements.

### Toolkits

The context provides a set of **toolkits** for common operations:

| Toolkit                 | Description                  |
| ----------------------- | ---------------------------- |
| `context.Stimuli`       | Create stimuli |
| `context.Triggers`      | Generate trigger signals     |
| `context.Image`         | Display and generate images               |
| `context.Waveforms`     | Create waveform data      |
| `context.Psychophysics` | Psychophysical utilities     |
| `context.Scheduler`     | Schedule tasks               |
| `context.Keyboard`      | Keyboard input               |

### Logging 

The `context.Log` property is implemented with **Serilog**, a structured logging framework used throughout LabBench. Logging is useful for debugging, tracing execution, and recording runtime information during experiments.

LabBench supports multiple **log levels**, which indicate the severity or importance of a message:

| Level         | Description                                                          |
| ------------- | -------------------------------------------------------------------- |
| `Debug`       | Diagnostic information useful during protocol development.           |
| `Information` | General runtime information (normal operation).                      |
| `Error`       | An error occurred that affects part of the execution.                |

Example:

```python
context.Log.Information("Stimulus started")
context.Log.Warning("Intensity is near maximum")
context.Log.Error("Failed to generate stimulus")
```

#### Passing values to logs

Serilog uses **structured (semantic) logging**, where values are passed separately from the message template.

Instead of concatenating strings:

```python
# Avoid this
context.Log.Information("Intensity: " + str(x))
```

Use placeholders:

```python
context.Log.Information("Intensity: {Intensity}", x)
```

Multiple values:

```python
context.Log.Information("Stimulus {ID} at intensity {Intensity}", stimulus_id, x)
```

Named placeholders improve clarity:

```python
context.Log.Information(
    "Stimulus {StimulusID} delivered at {Intensity}",
    stimulus_id,
    x
)
```

Serilog uses **semantic logging**, meaning:

* The message is a **template**
* Values are stored as **structured data**, not just text

This allows logs to be:

* Easily searchable
* Filterable by fields (e.g. all logs where `Intensity > 5`)
* Machine-readable (for analysis and debugging tools)

Compared to plain text logging, this makes logs significantly more useful for diagnostics and data analysis.

#### Practical examples

Logging a value:

```python
context.Log.Debug("Current intensity: {Intensity}", x)
```

Logging multiple values:

```python
context.Log.Information(
    "Trial {Trial} completed in {Time}s",
    trial_number,
    duration
)
```

Logging errors:

```python
try:
    DoSomething()
except Exception as e:
    context.Log.Error("Error during stimulation: {Error}", str(e))
```

#### Gotchas

* **Do not use string concatenation:** You lose structured data and make logs harder to analyze.
* **Placeholder names matter:** Use meaningful names (`{Intensity}` instead of `{x}`).
* **Order matters:** Values are matched to placeholders in order.
* **Logging is not free:** Avoid excessive logging in high-frequency loops.


### Examples

Example using results:

```python 
def NextIntensity(context):
    return context.Test01.PDT * 1.2
```

Example using assets and instruments:

```python 
def Stimulate(context, x):
    context.Instruments.ImageDisplay.Display(context.Assets.Images.Cue, 200, True)
    context.Instruments.Stimulator.Generate("port1", context.Stimulus)
    return True
```

### Gotchas

* **Name collisions:** If a variable or result shares the same name, one may override the other in the scope.
* **Missing properties return `None`:** This can lead to silent failures if not checked.
* **Thread-safe but locked:** Access is internally synchronized—avoid long-running operations inside scripts.
* **Current result may be null:**  `context.Current` is only set during execution of a procedure.

## Python Standard Library


## Toolkits


## Instruments


## Calculated attributes

Calculated attributes define values using executable expressions or script functions that are evaluated at runtime. They are used throughout LabBench to compute parameters dynamically based on context, results, and inputs.

A calculated attribute can take one of two forms:

### 1. Expression

A single-line Python expression:

```xml
intensity="min(Stimulator.Max, ManualThreshold.Intensity)"
duration="10 * Ts"
```

Expressions are compiled once and evaluated using a runtime scope that includes:

* The current procedure context (blackboard)
* Defined variables and results
* The free parameter `x` (if provided)
* Built-in mathematical functions
* Constants `PI` and `E`

### 2. Function call

A reference to a Python function:

```xml
intensity="func: Script.Compute(context)"
stimulus="func: Script.Generate(context, x)"
```

Depending on the signature, functions are called as:

* `func: Script.Function(context)`
* `func: Script.Function(context, x)`

The system validates:

* That the script asset exists
* That it is a Python script
* That the function is defined

## Execution model

At runtime, a calculated attribute is:

1. **Parsed** into either:

   * An expression
   * A function call

2. **Compiled** (expressions or scripts)

3. **Executed** with:

   * `context` (procedure blackboard)
   * Optional `x` parameter

If execution is not possible (e.g. missing context or blocked state), a **default value** is returned.

## Scope and available values

During evaluation, the following are available:

### Variables

| Name            | Description                    |
| --------------- | ------------------------------ |
| `x`             | Free parameter (if applicable) |
| `[ProcedureID]` | Results from procedures        |
| `[DefineName]`  | Defined values                 |
| `C`             | Context object                 |

### Constants

| Name | Value |
| ---- | ----- |
| `PI` | π     |
| `E`  | e     |

### Functions

The following functions are available directly in expressions:

* `exp`, `log`, `log10`
* `sin`, `cos`, `tan`, `sinh`, `cosh`, `tanh`
* `asin`, `acos`
* `abs`, `sqrt`
* `round`, `floor`, `ceiling`, `truncate`
* `min`, `max`, `pow`
* `step(x)`
* `pulse(x, d)`

Array generators:

* `linspace(x0, x1, n)`
* `geomspace(x0, x1, n)`
* `logspace(x0, x1, base, n)`

## Type handling

Each calculated attribute enforces a return type (e.g. `int`, `double`, `string`, `double[]`).

The result of execution is:

* Converted to the required type
* Stored internally
* Returned to the caller

If conversion fails, a runtime error is raised.

## Error handling and validation

Calculated attributes are validated before execution:

* Expressions are syntax-checked
* Script references are verified
* Functions must exist in the script

At runtime:

* Exceptions are caught and reported with full Python trace
* Invalid usage (e.g. wrong `(context, x)` signature) raises explicit errors
* Invalid values (NaN, ±∞) may propagate unless explicitly handled

## Gotchas

* **Silent defaults:** If a parameter cannot execute (e.g. missing context), it falls back to a default value without crashing.
* **Signature mismatch:** `(context)` vs `(context, x)` must match exactly, or execution fails at runtime.
* **NaN propagation:** Many functions propagate NaN. One bad value can affect the entire calculation.
* **Array generation pitfalls:** `linspace`, `geomspace`, and `logspace` can fail if inputs are invalid (e.g. negative values in logspace).
* **IronPython limitations:** Only pure Python and .NET interop are supported. No CPython native libraries.

* **Controlled scope:**  Only variables provided by LabBench are available. Missing values usually mean they are not part of the execution scope.













## Scripting in LabBench

Scripting in LabBench provides a powerful way to extend and customize experimental behavior beyond what is possible with static XML configuration alone. While protocols (.expx files) are formally defined and validated using an XSD schema, many XML attributes can contain executable logic in the form of single-line Python expressions (calculated parameters) or references to Python functions defined in external script files. Together, this allows protocols to remain declarative and readable, while still supporting adaptive procedures, conditional logic, and dynamic parameter updates that are essential in modern psychophysics and neuroscience experiments.

Under the hood, LabBench is a .NET application that embeds IronPython as its scripting engine. XML elements are deserialized into strongly typed .NET objects, which are then exposed directly to the IronPython runtime. This tight integration makes it easy to access and manipulate experiment state, stimuli, devices, and parameters from Python code, all while staying within the execution model of LabBench. Script files are included explicitly in a protocol via the <file-assets> element, ensuring that experiments are self-contained and reproducible.

This scripting approach makes it straightforward to use LabBench functionality: protocol writers can automate protocols and extend the functionality of LabBench without modifying the core application. At the same time, it is essential to understand the limitations of the environment. IronPython does not use CPython and therefore does not support native extension modules or the broader ecosystem of packages typically installed via pip. Only pure-Python code and libraries compatible with IronPython—and the .NET framework—can be used. **The scripting system is thus best viewed as a domain-specific extension layer tightly coupled to LabBench, rather than a general-purpose Python environment.**

This section provides information on how to automate experimental protocols with calculated parameters and extend the functionality of LabBench with Python scripts. The concepts described here apply uniformly across all LabBench protocols and are independent of any specific test type.

## Attributes and types
Attributes are the primary mechanism for configuring experiments in LabBench. 

Each attribute has:
- A **name**
- A **value**
- An associated **type**

The LabBench Language supports a set of simple and structured types used across attributes, calculated expressions, and scripts.

### Simple Types
| Type | Description | Examples |
|-----|------------|----------|
| **Integer** | Whole numbers without fractional parts; may be positive, negative, or zero. | `1`, `2`, `42`, `-7` |
| **Floating-point** | Rational numbers represented with decimal precision. | `0.1`, `2.75`, `-1.2` |
| **Text** | Sequences of characters used to represent textual data (strings). | `"This is a text string"` |
| **Boolean** | Logical truth values with exactly two possible states. | `true`, `false` |
| **Enumeration (enum)** | A fixed set of named, discrete values representing categorical options. | `single-sample` |

### Structured Types

In addition to simple scalar types, LabBench supports **structured types** that allow complex data to be grouped, indexed, and accessed programmatically. Structured types can be used in:

- Calculated attributes
- Python scripts

The primary structured types are **lists** and **dictionaries**.

#### Lists

A list is an ordered collection of values accessed by a zero-based index. All elements in a list share the same type, which may be a simple or another structured type.

Lists are typically used when:
- Order matters
- Values are accessed by position
- The number of elements is fixed or known

Type notation:
```
type[]
```
Definition Example:

```xml
<define name="StimulusLevels" value="[0.1, 0.2, 0.3, 0.4]"/>
```

Access from a Single-Line Calculated Attribute:

```xml
stimulus-intensity="StimulusLevels[0]"
max-intensity="max(StimulusLevels)"
```
Access from Python Script:

```python
def ExampleFunction(tc):
    first_level = tc.StimulusLevels[0]
    last_level  = tc.StimulusLevels[-1]
    return first_level
```

#### Dictionaries
A dictionary stores values as key–value pairs. Elements are accessed using a key rather than a numeric index. Keys are simple types (most commonly text), and values may be simple or structured types.

Dictionaries are typically used when:
- Semantic labels identify values
- Order is not important
- Configuration or lookup tables are needed

Type notation:

```
key_type<value_type>
```


Definition Example:

```xml
<define name="Thresholds" value="{'low': 0.2, 'medium': 0.5, 'high': 0.8}"/>
```

Access from a Single-Line Calculated Attribute:

```xml
stimulus-intensity="Thresholds['medium']"
upper-limit="min(Thresholds['high'], Device.Imax)"
```

Access from Python Script:

```python
def ExampleFunction(tc):
    medium_threshold = tc.Thresholds['medium']
    return medium_threshold
```


#### Nested Structured Types

Structured types may be nested arbitrarily. For example, a dictionary may contain lists, and a list may contain dictionaries.


Access from a Single-Line Calculated Attribute:

```xml
stimulus-intensity="Results['Test01']['Metrics']['mean'][0]"
```

Access from Python Script:

```python
def ExampleFunction(tc):
    value = tc.Results['Test01']['Metrics']['mean'][0]
    return value
```

#### Summary

| Structured Type | Access Syntax | Typical Use Case |
|----------------|--------------|------------------|
| List | `values[index]` | Ordered collections |
| Dictionary | `values[key]` | Named lookup |

Lists and dictionaries can be used when writing both **single-line calculated attributes** and **Python scripts** for LabBench protocols. 


## Calculated Attributes
Most attributes in LabBench can be *calculated*, meaning their values are specified as expressions rather than fixed literals. 

Calculated attributes allow experiments to:
- Automate configuration steps
- React to results from earlier parts of the experiment
- Adapt dynamically during execution

A calculated attribute is written as a **single-line Python expression** enclosed in quotes. This expression is evaluated by the LabBench runtime.

Example:

```python
parameter="0.7 * PreviousTest.Result"
```

Calculated attributes make it possible to derive new values directly from:

- Results of earlier tests
- Instrument properties
- Defined constants
- Mathematical functions

### Available Variables in Calculated Attributes
Depending on where a calculated attribute is used, the following variables may be available:

- Results from previous tests (referenced by test ID)
- Instruments used by the test (referenced by instrument ID)
- Defines declared in the protocol
- Mathematical functions such as: exp, round, log, log10, sin, cos, tan, abs, sqrt, max, min, pow
- Free parameter x, when applicable (e.g., in tests that evaluate responses as a function of a changing parameter)
- Language, if the experiment is localized
- SESSION_NAME and SESSION_TIME, describing the active session

### Calculated attribute types
Calculated attributes must declare the type of value they return and the function signature when called from a Python script:

```
int calculated(tc) or int calculated(tc,x) – must return an integer
double calculated(tc) – must return a floating-point number
float[] calculated(tc) – must return a list of floats
any = calculated(tc) – may return any supported type
```

Returning a value of the wrong type or calling a Python function with the wrong function signature will result in a runtime error.

## Dynamic Text Attributes

Text is used extensively in experiments (instructions, labels, prompts). In many cases, text must be dynamic—depending on language, experimental state, or recorded results. Using full Python expressions for all text would require quoting text strings inside Python syntax, which is error-prone. 

To address this, LabBench introduces dynamic text attributes.

### Literal Text

Literal text can be written directly:

```xml
instruction= "Please respond when ready"
``` 

### Dynamic Text

If the text value begins with the keyword dynamic:, it is evaluated as a calculated text expression:

```xml
instruction="dynamic: Text['INSTRUCTION_01']"
```

This mechanism allows seamless mixing of literal text and calculated text without forcing all text to be expressed as Python strings.

## Defines

Experiments often require the same value to be reused across multiple attributes. Repeating literal values increases the risk of inconsistencies and errors. LabBench addresses this using defines, which implement the "Don't Repeat Yourself" (DRY) principle.

Defines are declared once and can then be referenced throughout the protocol, calculated attributes, and scripts.

Each define have:
- A **name** (used as the variable name)
- A **value** (literal or calculated)

Conceptually, defines act as global constants or configuration variables for the experiment.

Defines are available:
- In calculated attributes (by name)
- In Python scripts (via the test context)

## Python Scripts
Single-line calculated attributes are ideal for simple expressions, but they are insufficient for:

- Complex logic
- Conditional branching
- Reusable algorithms
- Extending test behavior

In these cases, LabBench supports Python scripts that can be called from calculated attributes. LabBench provides access to a full Python runtime, including the standard library.

### Calling Script Functions

To call a Python function from a calculated attribute, prefix the value with the keyword func::

```xml
attribute= "func: ScriptID.FunctionName(tc)"
```
Depending on the calculated parameter, a free parameter x can be passed :

```xml
attribute= "func: ScriptID.FunctionName(tc, x)"
```

Where:
- **ScriptID**: is the ID of the script as declared in the experiment assets
- **FunctionName**: is the Python function to call
- **tc** is the test context (always provided)
- **x** is a free parameter, such as stimulus intensity, etc.

Each calculated parameter specifies whether they expect a (tc) or (tc,x) function signature.

### Defining Functions

Functions callable by LabBench must:
- Be defined at the top level of the script
- Accept the test context (tc) or (tc,x) as their arguments depending on the expected function signature of the calculated parameter.
- Return a value compatible with the calculated attribute's declared type

Example structure:

```python
def ExampleFunction(tc):
    # custom logic
    return result
```

Returning an incorrect type will cause a runtime error during experiment execution.

## The Test Context (tc)

When a Python function is called, LabBench passes it a test context object (tc). 

This context provides structured access to all relevant information needed for advanced logic.

The test context includes:
Defines
All protocols defines are accessible as fields on tc, named after their define IDs:
tc.MyDefine
Results
Results from completed tests are accessible via the results namespace or directly when exposed by the test:
tc.[TestID].[Property or function of the result]
Parameters
Some tests expose additional parameters to simplify configuration logic. These are available as scoped defines that are only available for relevant calculated parameters:
tc.NumberOfStimuli
Devices
Instruments used by a test are accessible via the Devices struct:
tc.Instruments.Stimulator
tc.Instruments.Trigger
tc.Instruments.Display
Assets
Files and other assets declared in the experiment are accessible via:
tc.Assets.[Asset ID]
Localization and Session Information
If applicable, the test context also provides:
tc.Language
tc.SESSION_NAME
tc.SESSION_TIME


## How-to guides

### Constructing Strings with `str.format()` 

In LabBench, `str.format()` is the preferred way to construct clear and maintainable strings in calculated parameters and Python scripts. It replaces placeholders in a string with values provided explicitly, avoiding manual string concatenation and type conversions. Here is an example of its syntax  with positional placeholders:

``` python
"Hello {}, you have {} messages".format(name, count)
```

-   `{}` marks insertion points
- Arguments are applied in order
- Values are converted to strings automatically

Named placeholders can also be used and is recommended for complex strings:

``` python
"User {user} has {count} messages".format(user=name, count=count)
```

Using named placeholders makes format strings more readable than positional placeholders, allows arguments to be reordered freely, and reduces the risk of errors when the string changes over time. A second advantage is that values can be reused:

``` python
"{x} + {x} = {result}".format(x=2, result=4)
```

Values are formatted with format specifiers:

``` python
"Value: {:.2f}".format(3.14159)   # 'Value: 3.14'
"Hex: {:x}".format(255)           # 'Hex: ff'
```

Format specifiers: 

| Specifier | Meaning | Example | Result |
|----------|---------|---------|--------|
| `{}` | Default formatting | `"{}".format(42)` | `42` |
| `{s}` | String (same as default) | `"{:s}".format("hi")` | `hi` |
| `{d}` | Decimal integer | `"{:d}".format(42)` | `42` |
| `{b}` | Binary integer | `"{:b}".format(5)` | `101` |
| `{o}` | Octal integer | `"{:o}".format(8)` | `10` |
| `{x}` | Hexadecimal (lowercase) | `"{:x}".format(255)` | `ff` |
| `{X}` | Hexadecimal (uppercase) | `"{:X}".format(255)` | `FF` |
| `{f}` | Fixed-point float | `"{:f}".format(3.14)` | `3.140000` |
| `{.nf}` | Float with `n` decimals | `"{:.2f}".format(3.14159)` | `3.14` |
| `{e}` | Scientific notation | `"{:e}".format(1000)` | `1.000000e+03` |
| `{g}` | General format (compact) | `"{:g}".format(3.14000)` | `3.14` |
| `{c}` | Character from int | `"{:c}".format(65)` | `A` |
| `{%}` | Percentage | `"{:.1%}".format(0.25)` | `25.0%` |
| `{n}` | Number with locale | `"{:n}".format(1000000)` | `1,000,000`* |
| `{width}` | Minimum field width | `"{:5d}".format(42)` | `   42` |
| `{<width}` | Left-aligned | `"{:<5d}".format(42)` | `42   ` |
| `{>width}` | Right-aligned | `"{:>5d}".format(42)` | `   42` |
| `{^width}` | Center-aligned | `"{:^5d}".format(42)` | ` 42  ` |
| `{0width}` | Zero-padded | `"{:05d}".format(42)` | `00042` |
| `{+}` | Always show sign | `"{:+d}".format(42)` | `+42` |
| `{-}` | Show minus only | `"{:-d}".format(-42)` | `-42` |
| `{}` with attributes | Object attribute access | `"{u.name}".format(u=user)` | value |
| `{}` with keys | Dict key access | `"{cfg[port]}".format(cfg=cfg)` | value |


