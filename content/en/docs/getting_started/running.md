---
title: Running the experiment
description: >
  How to run the experiment with LabBench Runner
weight: 2
---

LabBench Runner is used to perform experimental sessions. One an experiment has been created and configured this experiment will become available in the LabBench Runner. 

## Starting a session

When LabBench Runner is started it will first display the Startup Wizard (Figure 12). The Startup Wizards consists of up to five steps depending on which protocol elements have been enabled. 

The Startup wizard will always start with the Experiment step, where you will be asked to select one of the experiments that are available on the computer. If the selected experiment has been localized then it will display the Language step, otherwise it will go to the Subject step. Localization refers to the tailoring of a protocol to a different cultures/language. When a protocol is localized all participant facing information can be shown according to the subjects’ language and culture.

The Subject step consists of either create a new Subject or selecting an existing subject. A new subject is created by specifying a subject ID that does not yet exist. It is possible to validate subject IDs with a rule that will prevent invalid IDs from being created.

![](/images/getting_started/Figure12.png)

*Figure 12:*

Once the subject is either created or selected, the Startup Wizard will go to the Session steps if the experiment consists of multiple sessions, otherwise it will go to the Devices step. If the experiment does not contain sessions or devices the Startup Wizard will be completed once the subject is created or selected, and the main user interface of LabBench Runner will be open.

An experiment may contain of multiple sessions, each consisting of an individual set of experimental procedures (tests) for each session. These procedures/tests do not need to be identical for all sessions, and by selecting the current session in the Session step only procedures/tests belonging to that session will be displayed while the session is performed.

If the experiment requires devices to run, the Startup Wizard will end with the Devices step. In this step it will connect to an configure all required devices. If there errors with one or more devices the operator will be instructed in how to resolve these errors. Once all devices has been connected, configured and all errors if present has been resolved the Startup Wizard can be closed.

## Overview of LabBench Runner

Once the Startup Wizard is closed the main user interface of the LabBench Runner will be opened. This user interface consists of four areas/windows; the Protocol Window, Test control and Information Window, Test Window, and Log window (see Figure 13)

![](/images/getting_started/Figure13.png)

*Figure 13:*

### Protocol

The Protocol Panel lists the tests that are included in the protocol. Each test provides information of the current test state, test name, and test instruction (please see Figure 14).

![](/images/getting_started/Figure14.png)

*Figure 14:*

When a test is not running, tests can be selected by clicking on the test in the Protocol Panel. For each test the following information is displayed; 1) the Test Name, 2) Test Instruction, and 3) Test State. 

The Test Name describes what is to be performed in protocol. The Test Instruction informs whether the test is ready to run. In case it is not ready to run, the Test Instruction will inform the operator as to what actions are required to Unlock the test to make it ready to run. 

All tests have a state, which can be either inactive or an active state. Inactive states are Locked, Unlocked, Completed, and Excluded states, and the active state is the Running state.

Only one test at a time can be in the Running state, and if a test is in the running state the Protocol Panel will be disabled, meaning it is not possible to select another test than the currently active test.

Below is a specification of the different test states:

![](/images/getting_started/Table02.png)

### Test control and information

The Test Control and Information makes it possible to start and abort tests (see Figure 15).

![](/images/getting_started/Figure15.png)

*Figure 15:*

![](/images/getting_started/Table03.png)

### Test window

The content of the test window is dynamic, and change based on which test is selected in the Protocol Window. The general principle is that it will be configured to what is required to perform the currently selected test. Consequently, this principle is what simplifies the user interface of LabBench Runner as it will always only contain the user interface elements required to perform the tests that are in the protocol and nothing else. 

![](/images/getting_started/Figure16.png)

*Figure 16:*

### Log window

LabBench has an extensive log system that automatically records log entries for all actions taken through the UI during an experiment, the execution of the experimental procedures, and the collection of experimental results. For events beyond the knowledge of LabBench, the experimenter can add manual entries to the log. 

During an experiment the log is available in the Log Window, which is a list of log entries with the newest log entry on the top. These log entries are also stored in the internal data storage of LabBench, which contains all log entries for a given subject. However, the Log Window will only contain the log entries that have occurred since the start of the LabBench Runner.

![](/images/getting_started/Figure17.png)

*Figure 17:*
