---
title: CSV Export
description: Export data to a CSV File
weight: 30
---

* Defines a post-session action that exports participant data to a CSV file.
* Executed after a participant session or across multiple sessions (batch mode).
* Supports dynamic file naming, conditional value evaluation, and culture-specific formatting.
* Writes a single row per session, or multiple rows when executed in batch mode.

## Definition

The post-session action is defined with:

```xml
        <export-to-csv name="Export to CSV" 
            location="C:\LabBenchExport\intro.postSessionActions" 
            filename="dynamic: f'{Participant}.csv'">
            <item name="ID" value="Participant" default="NA" />
            <item name="Participation" value="DATA.Participation" default="NA" condition="DATA.Completed" />
            <item name="Age" value="DATA.Age" default="NA" condition="DATA.Completed" />
        </export-to-csv>
```

and has the following attributes:

| Attribute  | Type   | Specification |
|------------|--------|----------------|
| name       | string | Required. Identifier for the action. Must be non-empty. |
| location   | string | Required. Directory path where the CSV file will be written. Must exist at validation time. |
| filename   | string | Required. Expression evaluated at runtime to produce the file name. |
| header     | bool   | Optional. Includes a header row with element names. Default is true. |
| separator  | string | Optional. Delimiter used between values. Default is ";". |
| culture    | string | Optional. Culture used for formatting values. Default is "en". |

### item

Each item defines a single column in the generated CSV file.

The order of item elements determines the column order in the output.
Each item evaluates its value script within the current blackboard context at execution time.
Conditional inclusion is controlled via the condition attribute.
Fallback behavior is handled through the default attribute if evaluation is skipped or fails.

The item is defined by:

```xml
<item name="ID" value="Participant" default="NA" />
```

and has the following attributes:

| Attribute | Type   | Specification |
|-----------|--------|----------------|
| name      | string | Required. Column name used in the header row. |
| value     | string | Required. Script evaluated against the blackboard context to produce the value. |
| default   | string | Optional. Value used if evaluation fails or the element is excluded. Default fallback is "NA" if this also fails. |
| condition | string | Optional. Boolean script determining whether the value is evaluated. If false, the default is used. |

## Culture

The `culture` attribute controls how values are formatted when written to the CSV file. This affects:

* Numeric formatting (decimal separators, digit grouping)
* Date and time formatting
* String formatting behavior for culture-sensitive values

LabBench uses the .NET `CultureInfo` system to interpret this value.

### Culture Code Format

Culture codes follow the standard .NET format:

* `languagecode2`  
* `languagecode2-regioncode2`

Where:

* `languagecode2` is a two-letter ISO 639-1 language code
* `regioncode2` is a two-letter ISO 3166-1 region code (optional)

Examples:

* `en` → English (neutral culture)
* `en-US` → English (United States)
* `en-GB` → English (United Kingdom)
* `fr-FR` → French (France)
* `de-DE` → German (Germany)
* `da-DK` → Danish (Denmark)

Neutral cultures (language only) use default formatting conventions for that language, while specific cultures (language + region) apply region-specific formatting.

### Formatting Behavior

* **Decimal separator**:
  * `en-US` → `.` (e.g. `3.14`)
  * `da-DK` → `,` (e.g. `3,14`)

* **List separator interaction**:
  * If `separator=";"` and culture uses `,` as decimal separator (e.g. `da-DK`), values remain unambiguous.
  * Using `separator=","` with such cultures can lead to ambiguous CSV structure.

* **Date formatting**:
  * `en-US` → `MM/dd/yyyy`
  * `da-DK` → `dd-MM-yyyy`

* **Number formatting**:
  * Grouping and precision follow the selected culture.

### Default Behavior

* If `culture` is not specified, the default is `"en"`.
* The culture is applied during value formatting using `String.Format(culture, "{0}", value)`.

### Constraints

* The culture string must be a valid .NET culture identifier.
* Invalid culture codes will result in a runtime exception during execution.

### Culture Code Reference

Culture identifiers are based on standardized language and region codes. The following standards define the components used in .NET culture codes:

* <a href="https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes" target="_blank">ISO 639-1 Language Codes</a>
* <a href="https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2" target="_blank">ISO 3166-1 Alpha-2 Country Codes</a>

A comprehensive combined table of language and region codes (commonly used to form culture identifiers such as `en-US`, `da-DK`) is available here:

* <a href="https://www.localeplanet.com/icu/" target="_blank">LocalePlanet ICU Locale Explorer</a>

This resource provides a searchable table of locale identifiers aligned with ICU and closely matching those used by .NET on modern platforms.