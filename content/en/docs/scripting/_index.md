---
title: Scripting
description: Information on how call python code from LabBench protocols.
weight: 70
---

{{% pageinfo %}}

The purpose of this section is to provide information on how to administer a LabBench system.

{{% /pageinfo %}}


This section provides information on how to automate experimental protocols with calculated parameters and extend the functionality of LabBench with Python scripts.

The concepts described here apply uniformly across all LabBench protocols and are independent of any specific test type.

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


