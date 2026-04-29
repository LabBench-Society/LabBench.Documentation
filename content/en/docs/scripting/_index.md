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

When the required functionality cannot be implemented with single-line expressions, you can call Python functions defined in script files. Calling functions enables the full power of the Python scripting engine, including defining and instantiating objects, using the Python standard library, and accessing the functionality provided by LabBench through the context object and Toolkits.

### Syntax

Use the func: keyword to call a Python function:

```python
stimulate="func: Script.Stimulate(context, x)
```

In this example, the calculated attribute expects the function to accept two parameters (context, x). The function must be defined as `def [Function Name ](context, x):`

```python
def Stimulate(context, x):
    context.Instruments.Stimulator.Generate("port2", context.Stimulus)
    context.Instruments.ImageDisplay.Display(context.Assets.Images.Cue, 250, True)
    return True
```

Script files must be included explicitly in a protocol by a <file-assets> element:

```xml
<assets>
    <file-asset file="Script.py" />
</assets>
```

### Scope

When Python scripts are used in LabBench (via `func: Script.Function(...)`), the script file is **compiled once and loaded into a persistent execution environment**. The functions defined in that file are then called repeatedly during the procedure.

This means that **standard Python scope rules apply**, with a few important implications for how scripts behave over time.

#### Module-level scope (persistent state)

All code defined at the top level of a script file lives in **module scope** and is **persistent across function calls**.

```python
counter = 0

def Increment(context):
    global counter
    counter += 1
    return counter
```

* The script is compiled once
* `counter` is created once
* Each call to `Increment` will reuse and modify the same variable

This allows scripts to maintain **state across trials or stimulations**

#### Function scope

Variables defined inside a function are **local to that function call**

```python
def Compute(context):
    value = 10
    return value
```

* `value` is recreated on each call
* It is not shared between calls
* It does not affect module-level variables unless explicitly returned or assigned

#### Global keyword

To modify module-level variables inside a function, you must use `global`:

```python
value = 0

def Update(context):
    global value
    value += 1
    return value
```

Without `global`, a new local variable is created instead.

#### Multiple functions share the same scope

All functions in the same script file share the same module scope:

```python
state = 0

def A(context):
    global state
    state += 1

def B(context):
    return state
```

* Calling `A` modifies `state`
* Calling `B` will see the updated value

#### No re-initialization between calls

Unlike typical scripting environments, **the script is not reloaded for each call**

This means:

* Initialization code at the top of the file runs only once
* State persists unless explicitly reset
* Bugs related to stale state can accumulate over time

#### Recommended pattern: explicit initialization

To avoid unintended state persistence, use an explicit initialization function:

```python
state = None

def Initialize(context):
    global state
    state = 0

def Step(context):
    global state
    state += 1
    return state
```

This makes lifecycle control explicit and predictable.

#### Gotchas

* **State persists silently:** Variables defined at module level are shared across all calls.
* **Missing `global` creates bugs:** Forgetting `global` results in a local variable instead of updating shared state.
* **Initialization runs once:** Do not assume top-level assignments reset between trials.
* **Functions are looked up by name:** If the function name in XML does not match exactly, execution will fail at runtime.
* **No automatic isolation:** All functions in a script share the same environment—there is no sandbox per call.

### Mental model

Think of a script file as:

> A loaded Python module that stays alive for the entire experimental session

* Top-level variables = persistent state
* Functions = entry points called from XML
* Execution = repeated calls into the same live module

Once you treat it like a long-lived Python module, the behavior becomes predictable.

## Dynamic text

Text is used extensively in experiments (instructions, labels, prompts). In many cases, text must be dynamic—depending on language, experimental state, or recorded results. Using full Python expressions for all text would require quoting text strings inside Python syntax, which is error-prone. To address this, LabBench introduces dynamic text attributes.

Dynamic text attributes are either a literal string or a calculated attribute that returns a string.

### Syntax 

Without the dynamic: keyword, a dynamic text attribute is just a string literal, like for example title=”Age”. With the dynamic: keyword, it is a calculated text attribute:

```python
title=”dynamic: TextDatabase.Age”
```

This calculated text attribute will follow all the rules for calculated attributes. Consequently, it can be either a single-line expression or a function call. To call a function, use the func: keyword after the dynamic: keyword as you would for conventional calculated attributes:

```python
title=”dynamic: func: Script.GetTitle(context)”
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

## Python compatibility

LabBench uses IronPython as its scripting engine. IronPython is **not a full modern CPython implementation**, and understanding its feature set is important for writing reliable scripts.

The IronPython used in LabBench is based on **Python 3.4**, but includes selected features from newer versions.

Most notably:

* Baseline: **Python 3.4 syntax and standard library**
* Backported features from newer versions:
  * **f-strings (Python 3.6)** ✅
  * Some improvements in formatting and standard library modules
  * Incremental compatibility improvements with CPython

This means you are working in a **hybrid environment**:

> Python 3.4 core + selected modern features (not a full Python 3.x runtime)

### What works well

These features are safe and recommended:

#### Core language

* Functions, classes, modules
* Lists, dictionaries, comprehensions
* Basic OOP patterns

#### String formatting (recommended)

```python
f"Intensity: {x:.2f}"
```

* f-strings are supported (even though they are newer than 3.4)
* `.format()` also works and is fully supported

### What is limited or missing

IronPython differs from the newest version of Python, not fully supported or missing:

* Many Python 3.6+ features (partial support only)
* `dataclasses`
* Full `async` / `await`
* Modern typing features (partial only)
* Some newer standard library modules

**External packages:**

* **No native CPython extensions**
  * NumPy ❌
  * SciPy ❌
* Pure Python modules may work (but not guaranteed)

**Runtime differences:**

* Runs on **.NET (DLR)**, not CPython
* Interacts with .NET objects directly

### Cheat sheet: Writing IronPython-compatible code

#### ✅ Do this

| Pattern                      | Example               | Why                        |
| ---------------------------- | --------------------- | -------------------------- |
| Use f-strings                | `f"{value:.2f}"`      | Supported and clean        |
| Use built-in types           | `list`, `dict`        | Fully supported            |
| Keep dependencies minimal    | —                     | Avoid compatibility issues |
| Use LabBench context objects | `context.Instruments` | Native integration         |

#### ⚠️ Be careful with

| Feature                           | Issue                               |
| --------------------------------- | ----------------------------------- |
| Advanced Python 3 features        | May not exist or behave differently |
| Typing (`typing` module)          | Only partially supported            |
| Generators with advanced patterns | Sometimes inconsistent              |
| Reflection / dynamic tricks       | May behave differently on .NET      |

#### ❌ Avoid this

| Pattern                           | Why                         |
| --------------------------------- | --------------------------- |
| NumPy / SciPy                     | Requires CPython extensions |
| Async frameworks                  | Not reliably supported      |
| Complex metaprogramming           | Unpredictable in DLR        |
| Relying on latest Python features | Not implemented             |

### Practical guidelines

* Treat IronPython as a **very stable but slightly old Python core**
* Prefer **clarity over cleverness**
* Keep scripts **small and focused**
* Use LabBench features (stimuli, triggers, context) instead of reimplementing logic

### Mental model

The safest way to think about IronPython in LabBench is:

> “Python 3.4 + a few modern conveniences (like f-strings), running on .NET”

If you stay within that mental model, your scripts will be predictable, portable, and robust.

## Python Standard Library

IronPython provides access to a **subset of the Python standard library**, along with deep integration into the .NET ecosystem. Many commonly used modules work as expected, but support is not complete—especially for modules that rely on CPython internals or native extensions.

As a rule of thumb:

> Pure Python modules → usually supported

> C-extension / CPython-dependent modules → not supported

### Supported modules

| Module            | Description                                          | IronPython support |
| ----------------- | ---------------------------------------------------- | -------------------|
| `math`            | Mathematical functions (sin, log, sqrt, etc.)        | ✅ Full    |
| `random`          | Random number generation                             | ✅ Full    |
| `datetime`        | Dates and times                                      | ✅ Full    |
| `itertools`       | Efficient iteration utilities                        | ✅ Full    |
| `operator`        | Functional operators (add, mul, etc.)                | ✅ Full    |
| `re`              | Regular expressions                                  | ✅ Full    |
| `string`          | String constants and helpers                         | ✅ Full    |
| `json`            | JSON encoding/decoding                               | ✅ Full    |
| `csv`             | CSV file handling                                    | ✅ Full    |
| `time`            | Time-related functions                               | ✅ Mostly  |
| `functools`       | Functional programming tools                         | ✅ Mostly  |
| `collections`     | Specialized containers (`deque`, `namedtuple`, etc.) | ✅ Mostly  |
| `sys`             | Interpreter interaction                              | ⚠️ Partial |
| `os`              | Operating system interface                           | ⚠️ Partial |
| `pathlib`         | Filesystem paths                                     | ⚠️ Partial |
| `io`              | Stream handling                                      | ⚠️ Partial |
| `typing`          | Type hints                                           | ⚠️ Partial |
| `inspect`         | Introspection utilities                              | ⚠️ Partial |
| `importlib`       | Import system utilities                              | ⚠️ Partial |

Documentation:
<a href="https://docs.python.org/3.4/library/index.html" target="_blank" rel="noopener noreferrer">
    Python 3.4 Standard Library Documentation
</a>

### Description of partially supported modules

The following modules are available in IronPython but only **partially supported**. In most cases, core functionality works, while features relying on CPython internals, OS-specific behavior, or advanced runtime features may be missing or behave differently.

#### `sys` — Interpreter interaction

Provides access to interpreter-level information and runtime configuration.

**Supported**

sys.version, sys.platform
sys.argv
sys.path (module search path)
Basic stdout/stderr access (sys.stdout, sys.stderr)

**Limitations**

No CPython-specific internals (e.g., reference counting details)
Limited support for low-level interpreter hooks
sys.getsizeof() may not behave as in CPython

**Recommendation**
Use for basic environment inspection and path management only.

#### `os` — Operating system interface

Provides functions for interacting with the file system and environment.

**Supported**

* File and directory operations (`os.listdir`, `os.mkdir`, `os.remove`)
* Path utilities (`os.path`)
* Environment variables (`os.environ`)

**Limitations**

* Process management is limited (`os.fork` not available)
* Some platform-specific features missing or inconsistent
* Permissions and low-level OS calls depend on .NET behavior

**Recommendation**
Safe for basic file and directory operations; avoid advanced OS/process control.

#### `pathlib` — Filesystem paths

Object-oriented filesystem path handling.

**Supported**

* Basic path construction (`Path("file.txt")`)
* File existence checks (`exists()`)
* Reading/writing files (`read_text()`, `write_text()`)

**Limitations**

* Some advanced methods may be missing or incomplete
* Behavior may differ slightly due to .NET filesystem handling
* Limited support for advanced path resolution features

**Recommendation**
Use for simple path manipulation; fall back to `os.path` if needed.

#### `io` — Stream handling

Provides tools for working with streams and file-like objects.

**Supported**

* Basic file I/O (`open`, text/binary modes)
* `StringIO` for in-memory streams

**Limitations**

* Some buffering and advanced stream types are incomplete
* Differences in encoding handling compared to CPython
* Integration depends on .NET stream implementations

**Recommendation**
Use for standard file operations; avoid complex stream manipulation.

#### `typing` — Type hints

Provides support for type annotations.

**Supported**

* Basic annotations (`List`, `Dict`, `Optional`)
* Function annotations syntax

**Limitations**

* No static type checking at runtime
* Advanced typing features (e.g., `Protocol`, `TypedDict`) missing or incomplete
* Limited tooling support

**Recommendation**
Use for readability/documentation only—not for enforcement.

#### `inspect` — Introspection utilities

Provides tools for inspecting objects, functions, and call stacks.

**Supported**

* Basic inspection (`inspect.getmembers`, `inspect.isfunction`)
* Function signature inspection (partial)

**Limitations**

* Stack inspection may be unreliable
* Some reflection features differ due to .NET runtime
* Source code retrieval (`getsource`) may fail

**Recommendation**
Use cautiously; avoid relying on deep introspection.

#### `importlib` — Import system utilities

Provides programmatic access to the import system.

**Supported**

* Basic module importing (`import_module`)
* Module loading in simple cases

**Limitations**

* Advanced import hooks not supported
* Custom loaders and finders may not work
* Behavior tied to IronPython’s import system, not CPython’s

**Recommendation**
Use only for simple dynamic imports.

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













