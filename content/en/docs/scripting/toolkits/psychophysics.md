---
title: Psychophysics
description: Toolkit for estimation of psychometric functions
weight: 20
---

Provides builders for configuring psychophysical estimation methods (Psi, Up-Down, Discrete Up-Down) and access to predefined psychometric functions.

**Availability:**

```python
context.Psychophysics
```

## Properties

| Name        | Type               | Description                                                            |
| ----------- | ------------------ | ---------------------------------------------------------------------- |
| `Functions` | `FunctionsToolkit` | Factory for creating psychometric functions (e.g., Logistic, Weibull). |

## Methods

| Name                   | Signature                                               | Description                                                  |
| ---------------------- | ------------------------------------------------------- | ------------------------------------------------------------ |
| `PsiMethod`            | `PsiMethod() -> PsiMethodCreator`                       | Creates a builder for configuring a Psi method.              |
| `UpDownMethod`         | `UpDownMethod() -> UpDownMethodCreator`                 | Creates a builder for configuring an up-down method.         |
| `DiscreteUpDownMethod` | `DiscreteUpDownMethod() -> DiscreteUpDownMethodCreator` | Creates a builder for configuring a discrete up-down method. |

## Typical usage example

```python
# Create a Psi method
psi = context.Psychophysics.PsiMethod() \
    .NumberOfTrials(40) \
    .Alpha(0.1, 1.0, 10) \
    .Beta(0.5, 5.0, 10) \
    .Intensity(0.1, 1.0, 20) \
    .Function(context.Psychophysics.Functions.Logistic()) \
    .Create()

# Create an up-down method
ud = context.Psychophysics.UpDownMethod() \
    .Up(1) \
    .Down(2) \
    .StepSize(0.1) \
    .StartIntensity(0.5) \
    .Function(context.Psychophysics.Functions.Weibull()) \
    .Create()
```

## Psi Method Creator (`PsiMethodCreator`)

### Description

Builder for configuring a Psi adaptive psychophysical method.

### Availability

```python
context.Psychophysics.PsiMethod()
```

### Properties

*No public readable properties are defined.*

### Methods

| Name             | Signature                                                      | Description                                            |
| ---------------- | -------------------------------------------------------------- | ------------------------------------------------------ |
| `NumberOfTrials` | `NumberOfTrials(trials: int) -> PsiMethodCreator`              | Sets total number of trials.                           |
| `Function`       | `Function(function: PsychometricFunction) -> PsiMethodCreator` | Sets psychometric function.                            |
| `Alpha`          | `Alpha(x0: float, x1: float, n: int) -> PsiMethodCreator`      | Defines alpha parameter range using linear spacing.    |
| `Beta`           | `Beta(x0: float, x1: float, n: int) -> PsiMethodCreator`       | Defines beta parameter range using linear spacing.     |
| `Intensity`      | `Intensity(x0: float, x1: float, n: int) -> PsiMethodCreator`  | Defines stimulus intensity range using linear spacing. |
| `Create`         | `Create() -> object`                                           | Finalizes and returns the configured method.           |

## Up-Down Method Creator (`UpDownMethodCreator`)

### Description

Builder for configuring a standard up-down staircase method.

### Availability

```python
context.Psychophysics.UpDownMethod()
```

### Properties

*No public readable properties are defined.*

### Methods

| Name                         | Signature                                                                       | Description                                                               |
| ---------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| `Up`                         | `Up(value: int) -> UpDownMethodCreator`                                         | Number of consecutive correct responses required to increase intensity.   |
| `Down`                       | `Down(value: int) -> UpDownMethodCreator`                                       | Number of consecutive incorrect responses required to decrease intensity. |
| `IncreasingInitialDirection` | `IncreasingInitialDirection() -> UpDownMethodCreator`                           | Sets initial direction to increasing intensity.                           |
| `DecreasingInitialDirection` | `DecreasingInitialDirection() -> UpDownMethodCreator`                           | Sets initial direction to decreasing intensity.                           |
| `StepSize`                   | `StepSize(value: float) -> UpDownMethodCreator`                                 | Sets step size for both up and down directions.                           |
| `StepSizeRection`            | `StepSizeRection(reduction: float, maxReduction: float) -> UpDownMethodCreator` | Configures step size reduction behavior.                                  |
| `StepSizeRelative`           | `StepSizeRelative() -> UpDownMethodCreator`                                     | Uses relative step size.                                                  |
| `StepSizeAbsolute`           | `StepSizeAbsolute() -> UpDownMethodCreator`                                     | Uses absolute step size.                                                  |
| `StopRule`                   | `StopRule(value: int) -> UpDownMethodCreator`                                   | Defines stopping rule.                                                    |
| `SkipRule`                   | `SkipRule(value: int) -> UpDownMethodCreator`                                   | Defines skip rule.                                                        |
| `StartIntensity`             | `StartIntensity(value: float) -> UpDownMethodCreator`                           | Sets starting intensity.                                                  |
| `MaximalIntensity`           | `MaximalIntensity(value: float) -> UpDownMethodCreator`                         | Sets maximum allowed intensity.                                           |
| `MinimalIntensity`           | `MinimalIntensity(value: float) -> UpDownMethodCreator`                         | Sets minimum allowed intensity.                                           |
| `TerminateOnLimitReached`    | `TerminateOnLimitReached(value: bool) -> UpDownMethodCreator`                   | Enables termination when limits are reached.                              |
| `Function`                   | `Function(function: PsychometricFunction) -> UpDownMethodCreator`               | Sets psychometric function.                                               |
| `Create`                     | `Create() -> object`                                                            | Finalizes and returns the configured method.                              |

## Discrete Up-Down Method Creator (`DiscreteUpDownMethodCreator`)

### Description

Builder for configuring a discrete up-down method using predefined intensity levels.

### Availability

```python
context.Psychophysics.DiscreteUpDownMethod()
```

### Properties

*No public readable properties are defined.*

### Methods

| Name                         | Signature                                                                 | Description                                  |
| ---------------------------- | ------------------------------------------------------------------------- | -------------------------------------------- |
| `StopCriterion`              | `StopCriterion(value: int) -> DiscreteUpDownMethodCreator`                | Defines stopping criterion.                  |
| `SkipRule`                   | `SkipRule(value: int) -> DiscreteUpDownMethodCreator`                     | Defines skip rule.                           |
| `InitialStepSize`            | `InitialStepSize(value: int) -> DiscreteUpDownMethodCreator`              | Sets initial step size.                      |
| `IncreasingInitialDirection` | `IncreasingInitialDirection() -> DiscreteUpDownMethodCreator`             | Sets initial direction to increasing.        |
| `DecreasingInitialDirection` | `DecreasingInitialDirection() -> DiscreteUpDownMethodCreator`             | Sets initial direction to decreasing.        |
| `IntensityRange`             | `IntensityRange(values: Iterable[float]) -> DiscreteUpDownMethodCreator`  | Defines discrete intensity levels.           |
| `Function`                   | `Function(function: PsychometricFunction) -> DiscreteUpDownMethodCreator` | Sets psychometric function.                  |
| `Create`                     | `Create() -> object`                                                      | Finalizes and returns the configured method. |

## Functions Toolkit (`FunctionsToolkit`)

### Description

Factory for creating psychometric functions used by estimation methods.

### Availability

```python
context.Psychophysics.Functions
```

### Properties

*No public readable properties are defined.*

### Methods

| Name               | Signature                                                     | Description                             |
| ------------------ | ------------------------------------------------------------- | --------------------------------------- |
| `Gumbel`           | `Gumbel(alpha=0.5, beta=1, lambda=0.02, gamma=0.0)`           | Creates a Gumbel psychometric function. |
| `HyperbolicSecant` | `HyperbolicSecant(alpha=0.5, beta=1, lambda=0.02, gamma=0.0)` | Creates a hyperbolic secant function.   |
| `Logistic`         | `Logistic(alpha=0.5, beta=1, lambda=0.02, gamma=0.0)`         | Creates a logistic function.            |
| `LogQuick`         | `LogQuick(alpha=0.5, beta=1, lambda=0.02, gamma=0.0)`         | Creates a log-Quick function.           |
| `Normal`           | `Normal(alpha=0.5, beta=1, lambda=0.02, gamma=0.0)`           | Creates a normal (Gaussian) function.   |
| `Quick`            | `Quick(alpha=0.5, beta=1, lambda=0.02, gamma=0.0)`            | Creates a Quick function.               |
| `Weibull`          | `Weibull(alpha=0.5, beta=1, lambda=0.02, gamma=0.0)`          | Creates a Weibull function.             |

#### Parameters (common to all functions)

| Name     | Type    | Description                   |
| -------- | ------- | ----------------------------- |
| `alpha`  | `float` | Threshold/location parameter. |
| `beta`   | `float` | Slope parameter.              |
| `lambda` | `float` | Lapse rate.                   |
| `gamma`  | `float` | Guess rate.                   |


## Notes / gotchas

* All creators follow a **builder pattern** and must end with `.Create()` to produce a usable method.
* Parameter ranges (e.g., Alpha, Beta, Intensity) are generated using linear spacing.
* No validation is performed at this level; invalid configurations may fail later during execution.
* Functions must be compatible with the selected estimation method.
