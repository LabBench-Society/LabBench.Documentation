---
title: Ordinal Scale
description: Instructions on how to install LabBench
weight: 20
---

Represents a categorical rating scale where responses are selected from ordered categories without assuming equal spacing between them.

**Availability:**

```python
context.Instruments.<OrdinalScaleName>
```


## Properties

| Name                 | Type            | Description                                              |
| -------------------- | --------------- | -------------------------------------------------------- |
| `NumberOfCategories` | `int`           | Total number of categories available on the scale.       |
| `Categories`         | `List[IAnchor]` | List of category definitions (labels and enabled state). |


## Methods

| Name                  | Signature                                     | Description                                                    |
| --------------------- | --------------------------------------------- | -------------------------------------------------------------- |
| `GetSelectedCategory` | `GetSelectedCategory()` → `int`               | Returns the currently selected category index.                 |
| `SetSelectedCategory` | `SetSelectedCategory(category: int)` → `None` | Sets the selected category by index. Updates the device state. |

## Category (`IAnchor`)

Represents a single category on the ordinal scale.

### Properties

| Name      | Type   | Description                                   |
| --------- | ------ | --------------------------------------------- |
| `Enabled` | `bool` | Indicates whether the category is selectable. |
| `Label`   | `str`  | Text label describing the category.           |

## Typical usage example

```python
scale = context.Instruments.OrdinalScale

# Read selected category
selected = scale.GetSelectedCategory()

# Set category
scale.SetSelectedCategory(2)

# Inspect categories
for i, c in enumerate(scale.Categories):
    print(i, c.Label, c.Enabled)
```

---

## Notes / gotchas

* Category indices are integer-based; valid range depends on `NumberOfCategories`.
* No guarantee of equal spacing between categories; treat values as ordered labels.
* Disabled categories (`Enabled=False`) may still appear but should not be selected.
* `SetSelectedCategory` directly affects the device state and participant interface.
