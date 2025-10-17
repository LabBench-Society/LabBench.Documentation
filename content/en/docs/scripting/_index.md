---
title: Scripting
description: Information on how call python code from LabBench protocols.
weight: 70
---

{{% pageinfo %}}

The purpose of this section is to provide information on how to administer a LabBench system.

{{% /pageinfo %}}

Throughout this guide, we have already used attributes extensively. For example, in Listing 7, attributes provide the data for the test annotations. Each attribute has a name and is assigned a value in the form of:

\verb|name_of_attribute="value of attribute"|. 

An attribute also has a type; for example, the value attribute of the number element in Listing~\ref{lst:assets} is of type float that represents rational numbers of the form 0.1, 1.2, etc. The LabBench Language has simple types for integers, floats (rational numbers), Boolean values, text strings, and value lists (enums). 

\subsection{Simple types}

\subsubsection{Integers}

An integer is a whole number, meaning it is a number that does not have any fractional or decimal parts. Integers can be either positive, negative, or zero. They represent values that can be counted or measured in whole units without fractions or decimals.

\verb|Example: 1, 2, 3, 4, -10|
\subsubsection{Floating numbers}

A float represents a rational number, which is a number that can be expressed as the quotient or fraction of two integers, where the numerator is an integer and the denominator is a non-zero integer.

\verb|Example: 2.8, -1.2, 0.1|
\subsubsection{Text}

Text variables, often referred to as a "string variable," are data types used to store and manipulate sequences of characters. 

\verb|Example: 'This is text string'|
\subsubsection{Boolean}

Boolean variables can only hold one of two possible values: "true" or "false."
v
\verb|Example: true, false (and nothing else)|

\subsubsection{Enumerations}

An \verb|enum|, short for "enumeration," is a data type in computer programming that defines a set of named constant values. Enumerations create a collection of symbolic names (enumerators) that represent a finite list of related, distinct values or options.

\verb|Example: single-sample|

\subsection{Data structures}
Besides the simple types in table TBD there are also types for structuring data. Data can be structured as lists (array), dictionaries (dict), and structures (struct).

\subsubsection{Arrays}

An array holds a list of values that are accessed by their index in the list. Each of the values in the array can be either a simple type or another structured type.

Nomenclature: \verb|array<type>|

Examples: \verb|intensity[2]|, \verb|answer[3]|
  
\subsubsection{Dictionaries}

A dictionary holds a set of (key, value) pairs where elements in the set is accessed by their key, and the value can be either a simple type or another structured type. The key is always a simple type, most often a text type.

Nomenclature: \verb|dictionary<key_type, value_type>|

Examples: \verb|SETUP[‘RECT’]|

\subsubsection{Structures}

A set of values where each value in the set is named. Each of the values in the array can be either a simple type or another structured type.

Nomenclature: \verb|struct(name1<type>,name2<type>,…,nameN<type>)|

Examples: \verb|SR.PTT, SR.PDT|

\subsection{Calculated attributes}

Most attributes are calculated, meaning they can be specified in a protocol with a mathematical expression. Calculated attributes in a protocol allow the LabBench Language to automate manual tasks during an experiment. As attributes configure tests, it is possible to configure tests from the results of previous tests in the protocol. 

The following example illustrates this. In our protocol on the relationship between DASS scores and pain sensitivity, we wish to determine the temporal summation of pressure stimuli. The intensity of the pressure stimuli must be set to 70\% of the Pain Tolerance Threshold (PTT) to linearly increasing pressure, which is determined by the <algometry-stimulus-response> test with ID="SR01". To do this, we will set the pressure of the stimuli (pressure-stimulate) in the <algometry-temporal-summation> test to:

\verb|pressure-stimulate="0.7 * SR01.PTT"|

We can do this because the text that is between the “ ” quotes of a calculated attribute is a single-line Python statement, which gets evaluated by the LabBench Runner, and when the code is specified in the Experiment Definition File, this is termed as a single-line calculated attribute, in contrast to a script calculated attribute that is evaluated by calling a Python function in a script. A second reason why calculated attributes can automate manual tasks is that from calculated parameters, we have access to a set of variables:

\begin{longtable}{|p{0.2\textwidth}|p{0.25\textwidth}|p{0.45\textwidth}|}
\hline
Variables & Name & Description \\
\hline
\endfirsthead

Results of tests in the protocol
& 
The ID of the test 
& 
Results of tests in the protocol. These variables are available to all calculated attributes except attributes of defines.

Examples:

pressure-stimulate="0.7 * SR01.PTT"

conditional-pressure="0.7 * SR02.PTT"

 \\
\hline
Instruments

  & ID within the test of the instrument.

  & Instruments that are used by the test. These variables are only available for calculated attributes of tests. Knowing their names requires looking up their names in the LabBench Language Specification [REF] to which Instruments each type of test requires and their ID within that specific type of test.

 Example:

Imax="Stimulator.Imax"

  \\
\hline
Defines

  & ID of the define 

  & Defines holds values used in multiple calculated attributes in a protocol. They are named after their ID in the list of defines.

 Example:

delta-pressure="DeltaPressure"

  \\
\hline
Mathematical functions

  & exp, round, log, log10, sin, sinh, asin, cos, cosh, tan, tanh, abs, sqrt, max, min, pow

  & Common mathematical functions.

 Examples:

exp(10)

round(1.67)

min(4 * SETUP[‘RECT’], Stimulator.Imax) \\
\hline
Free parameter

  & x & Only used tests for which a response is determined for a change in a free parameter. For example, the calculated attributes for a stimulus in a threshold estimation test will have access to the free parameter x.

 Example:

Is="x"

Is="-x/5"

  \\
\hline
Language & Language & If the experiment is localized with a <languages> element, then the selected language will be available as a variable named Language.

 Example:

Language == ‘en’

  \\
\hline
Session ID & SESSION\_NAME & ID of the current session. The type of the variable is text.

  \\
\hline
Session time & SESSION\_TIME & Time that the current session was started. The type of the variable is text.

  \\
\hline

\end{longtable}

A short note on nomenclature. Throughout the LabBench documentation, it is necessary to specify the types of attributes. A calculated attribute will be required to return either 1) a simple type, 2) a list, dictionary, or structure of simple types, or 3) a value of any type. 

The calculated attribute is specified as \verb|calculated<type>|, meaning that:

\begin{itemize}
    \item \verb|calculated<int>| is a calculated parameter that must return an integer, and
    \item \verb|calculated<list<float>>| is a calculated parameter that must return a list of floats and 
    \item \verb|calculated<any>| is a calculated attribute can return any type.
\end{itemize}
 
\subsection{Dynamic text attributes}

Text is used extensively in Experiment Definition Files and may be needed to customize the text based on either the localization of the protocol or results that have been recorded. These could be achieved with calculated attributes. However, in many cases, only literal text strings are needed. If calculated attributes were used directly for text attributes, then all text attributes would need to be specified as attribute-name=”’test’” because the value of the attribute would be a Python statement and, within Python, text is specified with single quotes (i.e.‘example text’). Using Python syntax for all the text that needs to be customized would be an inconvenience and a source of error because it would be very easy to forget the single quotes ’ within the double quotes “.

To solve this problem, the LabBench Language has a special calculated attribute type called dynamic text, which allows literal text to be specified as:

\verb|instruction="What is the reason for skipping the pressure tests?"|

But if a dynamic: keyword is added before the text, then it will be evaluated as a calculated<text> attribute:

\verb|instruction="dynamic: Text['I01']"|

Which, in the above example, returns the text that is stored in the dictionary Text under the key ‘I01’.

\subsection{Defines}

Often, you will need to use the same value for a parameter for multiple attributes in an Experiment Definition File. When the same values are repeated in multiple places, it is a common error that this value will be wrong in one or more places. A common principle in programming is the “Don’t Repeat Yourself” (DRY) principle. The DRY principle states that if you need the same information at multiple sites, a mechanism must be available to avoid that. 

To avoid this problem, the LabBench Language allows you to define variables in a protocol that can be used in subsequent definitions, tests, and post-session actions. 

Each define has two attributes: 1) a \verb|name| attribute that is the name the variable can be referred to in calculated attributes and scripts, and 2) its \verb|value|. Listing~\ref{lst:defines} provides an example of how three variables can be defined:

\begin{lstlisting}[language=XML, caption=The defines that are used in our protocol., label={lst:defines}]
<defines>
    <define name="DeltaPressure" value="1"/>
    <define name="VasPDT" value="0.1"/>
    <define name="Text" value="func: TEXT.CreateText(tc)"/>
</defines>
\end{lstlisting}

The variables defined in the \verb|<defines>| element can subsequently be used in defines, tests, and post-session actions. Below is an example of how the DeltaPressure variable is used in a \verb|<|algometry-stimulus-response\verb|>| test:

\begin{lstlisting}[language=XML, caption=Example of test attributes where the defines are used.]
<algometry-stimulus-response ID="SR01"
                             name="Stimulus-Response (Cuff 1)"
                             experimental-setup-id="blank"
                             delta-pressure="DeltaPressure"
                             pressure-limit="100"
                             primary-cuff="func: Setup.StimulatingCuff(tc)"
                             second-cuff="false"
                             stop-mode="STOP_CRITERION_ON_BUTTON_PRESSED"
                             vas-pdt="VasPDT">
    <!-- Content omitted for brevity -->
</algometry-stimulus-response>
\end{lstlisting}

\subsection{Scripts}

Single-line calculated attributes allow for simple calculations of attributes but fall short of implementing complex logic or extending the base functionality of tests. For more complex calculations and actions, you will need to use a Python script called from the Experiment Definition File.

\subsubsection{Calling a script}

LabBench provides access to a full Python scripting engine with the ability to use the Python standard library. This access makes it possible to call functions defined in a script from calculated attributes. Below is an example where a function is called to set which cuff to use as the primary cuff in an <algometry-stimulus-response> test:

\verb|primary-cuff="func: Setup.StimulatingCuff(tc)"|

The keyword \verb|func:| tells LabBench to call a function in a Python script instead of treating it as a single-line calculated attribute. When the value of the calculated attribute starts with this keyword, it will require that the rest of the line is of the form:

\verb|[ID of Script].[Function Name](tc)|, or 

\verb|[ID of Script].[Function Name](tc,x)|. 

The ID of the script is the ID of the script assigned to it in its \verb|<|file-asset\verb|>| element in the \verb|<assets>| section of the protocol. 

\subsubsection{Defining functions}

The StimulatingCuff function is defined in a script included in the Experiment Definition File that is implemented as:

\begin{lstlisting}[language=Python, caption=Definition of a function that can be called by LabBench.]
def StimulatingCuff(tc):
    retValue = 0
    
    if tc.SUBJECT['CLEARING'] == 3:   # Both sides cleared
        if tc.SUBJECT['HAND'] == 1:   # Right hand is dominant
            retValue = 2
        elif tc.SUBJECT['HAND'] == 2: # Left hand is dominant
            retValue = 1
        else:                         # Both hands are dominant
            retValue = 2
    elif tc.SUBJECT['CLEARING'] == 2: # Left side cleared
        retValue = 1
    elif tc.SUBJECT['CLEARING'] == 1: # Right side cleared
        retValue = 2
    
    return retValue;
\end{lstlisting}

This defines a function that must be called with one parameter, the test context (tc), and returns an integer. As this function is used for the calculated<int> primary-cuff attribute of the \verb|<|algometry-stimulus-response\verb|>| this will control which cuff will be inflated by the test based on the handedness of the subject and whether the subject is cleared for pressure algometry on both sides, the right or left side.

Since functions are always called from calculated attributes, all functions must return the correct type for the calculated attribute from which they are called. Returning the wrong type may result in an error when the experiment is performed.

\subsubsection{Test context}

For single-line calculated attributes, results, defines, and instruments can be used from the single-line statement as individual variables; however, for script calculated attributes, these variables and more are accessible through the Test Context. When the function is called, the test context (tc) is always passed as a parameter to the function, followed by the free parameter “x” if that variable is available to the calculated attribute.

The test context is a struct variable that gives access to the following variables:

\begin{longtable}{|p{0.2\textwidth}|p{0.25\textwidth}|p{0.45\textwidth}|}
\hline
Variable & Description & Access \\
\hline
\endfirsthead

defines &
Defines from the \verb|<defines>| element in the \verb|<protocol>|. &
Each define is a variable in the tc struct named by their id attribute in the \verb|<define>| element.

Example:
\verb|tc.DeltaPressure|

\\
\hline
results &
Results from each test in the protocol. &
Each result is a variable in the tc struct named by their id attribute in the \verb|<test>| element.

Example:

\verb|tc.SUBJECT['CLEARING']|
(the result from the ‘CLEARING’ question in the questionnaire with id=”SUBJECT”.

\\
\hline
parameters &
Parameters added by tests that make it easier to configure the tests based on other parts of its configuration. &
Each test-specific parameter is a variable in the tc struct with a name automatically assigned by the test.

Example:

\verb|tc.NumberOfStimuli|
(the number of stimuli in the stimulus set of an \verb|<|psychophysics-evoked-potentials\verb|>| test.

\\
\hline
devices &
Instruments that are used by the test. &
These instruments are available through a Devices variable in the tc structure. This Device variable is itself a struct where each instrument is named by the name it is identified within the test.

Examples:

\verb|tc.Devices.Stimulator|

\verb|tc.Devices.Trigger|

\verb|tc.Devices.Display|
\\
\hline
assets &
Assets from the \verb|<|assets\verb|>| element in the Experiment Definition file. &
Assets are available through a Assets variable ni the tc structure. This Assets variable is itself a struct where each Asset is named by its id attribute in its <file-asset> element.

Example:

\verb|tc.Assets.Images|

\\
\hline
Language &
If the experiment is localized the selected Language will be available. &
The selected language is available as a variable named Language in the tc struct.

Example:

\verb|tc.Language|

\\
\hline
Session ID &
The ID of the session. &
The session ID is available as a variable named \verb|SESSION_NAME| in the tc struct.

Example:

\verb|tc.SESSION_NAME|

\\
\hline
Session time &
The time the session was started. &
The session starting is available as a variable named \verb|SESSION_TIME| in the tc struct.

Example:

\verb|tc.SESSION_TIME|

\\
\hline
\end{longtable}

As variables cannot have the same name, it will be an error to give defines and tests the same ID, and it must be ensured that the IDs of defines, and tests are not the same as parameters and devices added automatically by the tests. As the names of parameters and devices are constant and given by the tests, there might be IDs that cannot be used based on which tests are included in the protocol. For example, the <psychophysics-threshold-estimation> test will add its Stimulator and Trigger devices to the test context, and this implies that defines and tests cannot have Stimulator or Trigger as their ID when the \verb|<|psychophysics-threshold-estimation\verb|>| test is used. 