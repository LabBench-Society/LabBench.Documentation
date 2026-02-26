---
title: Experiments
description: The Experiment Page allows experiment management, which allows users to configure their experimental setups and export data.
weight: 40
---

Experiments are managed on the Experiments Page of LabBench Designer (see Figure 1). To the left, this page lists all the experiments that are currently present in the system. This list selects which experiment will be shown on the Experiment Panel on the right of the Experiments Page.

![](/images/Administration_Experiments/Slide1.PNG)

*Figure 1: The Experiments Page in the LabBench Designer.*

The Experiment Panel consists of tabs to the left that lets you choose between four tabs:

* **Protocol:** If a protocol description is available, it will be shown in this tab. This tab will allow you to read the description within LabBench Designer or to print it to a physical printer or a PDF file. If no protocol description is available, this tab will not be present for the experiment.
* **Setup:** The setup tab will always be present and allow you to configure the experiment. This includes configuring its validation of subject IDs, experimental setup, and post-session actions.
* **Data:** The data tab will always be present and show you a list of subjects. From this tab, it will be possible to delete subjects and export data from all subjects.
* **Errors:** This tab will only be present if there are errors, warnings or information regarding the experiment. 

From the header of the Experiment Panel, it is also possible to delete the experiment by clicking the Delete Experiment button. As this action will irrevocably delete all data, a warning dialog will first be displayed, where you must confirm your deletion of the experiments before the system will delete it.

## Protocol Panel

The protocol panel is only shown when a protocol description file can be retrieved from the repository (see Figure 2). A protocol description is an XML Paper Specification (*.xps) file that is located at the same location as the Experiment Definition File (*.expx) file with the same protocol ID/filename as the (*.expx) file.

![](/images/Administration_Experiments/Slide2.PNG)

*Figure 2: The Protocol Panel.*

The **Print and view controls** toolbar in the top of the Protocol panel makes it possible to:

1. Print the protocol description to a printer or save it as a PDF.
2. Copy text from the protocol description.
3. Increase/decrease the magnification.
4. Set view to:
    1. Reset to 100% magnification.
    2. Page Width.
    3. While Page.
    4. Two Pages.

## Setup Panel

The Setup Panel (see Figure 3) allows you to configure experiments and consists of sections for inspecting and configuring participant ID validation, operators, experimental setup, and post-session actions.

![](/images/Administration_Experiments/Slide3.PNG)

*Figure 3: The Setup Panel.*

### Participant ID

The participant ID section on the Setup tab provides information on the validation performed in the experiment (see Figure 2). If this validation has not been defined in the protocol then it can be enabled or changed by clicking the Configure validation button.

Clicking the **Configure participant validation** button will open a dialog to enter the validation rule and a help text that LabBench Runner will display when an operator enters an invalid participant ID (see Figure 4).

![](/images/Administration_Experiments/Slide5.PNG)

*Figure 4: Configuration dialogue for Participant ID validation.*

The rule must be specified as a regular expression. A useful tool for developing and testing regular expressions can be found at [Regex 101](https://regex101.com/) and tutorials to learn regular expressions at [Regex Learn](https://regexlearn.com/). Regular expressions are a very powerful albeit complex tool that can be used to search and validate text.

### Operators

The Operators section is available if Access Control has been enabled. The Operators section lets you add and remove researchers from the experiment.

To add a researcher click the **Add reseacher** button, this will open the dialogue shown in Figure 5.

![](/images/Administration_Experiments/Slide6.PNG)

*Figure 5: Adding researchers as operators.*

To remove a researcher click the **Remove researcher** button.

### Experimental setup

Most protocols will need access to a set of devices to run. This set of devices and their configuration is often called the experimental setup of a study, the term that LabBench uses. 

The devices used in the protocol for an experiment can be seen in the Experimental Setup section of the Setup tab (see Figure 4). Each device defined in the Experimental Setup must be assigned a device from the Device Page (see Figure 5). A default device assignment is created when the experimental is created from a protocol in a repository. This will assign the first available device to each device in the Experimental Setup. However, if more than one device of the same type is present in the system, this assignment may be incorrect. 

![](/images/administration/DialogConfigureDevices.png)

*Figure 5: Assignment of devices to logical devices in the protocol (Configure Devices Dialog).*

Clicking the Assign devices button will open the Configure Devices dialog (see Figure 5) that will allow you to change the assignment of devices.

Some devices also have a configuration that can be changed by click their Configure device button (see Figure 4). Currently, LabBench I/O, LabBench DISPLAY and Joystick devices has properties that can be configured in the LabBench Designer.

#### Joystick configuration

Subjects can use a standard USB Joystick to complete questionnaires and provide answers in response tasks to estimate psychophysical functions and/or thresholds. However, no standard exists for the codes assigned to the USB buttons. Consequently, protocols written for one brand of USB joystick are unlikely to work with other brands of USB buttons.

To make it possible to use a brand of Joystick different from the one a protocol was initially written for, it is possible to change the codes assigned to each button. To change the codes, click the Configure device button for the Joystick, which will open the dialog shown in Figure 7.

![](/images/administration/DialogConfigureJoystick.png)

*Figure 7: Configuration of Joystick parameters.*

When using this dialog, it is beneficial to have the joystick connected to the computer. This allows you to press buttons on the joystick and see their code(s) at the top of the dialog. This allows you to identify the correct codes to enter in the button map shown in the lower half of the dialog. Click OK to update the button maps; if you click Cancel, your changes will be discarded.

### Post-session actions

Post-session actions are actions that are performed when LabBench Runner are closed. Currently, it is possible to include the following post-session actions in protocols:

* **Export Data:** This action will export the data from a single subject in either MATLAB format (*.mat) or Java Script Object Notation format (*.json).
* **Export CSV:** This action will export selected data to a comma-separated values file (*.csv). A calculated parameter in the export action must define each value in the CSV file.
* **Export Log:** This action will export the experimental log for the subject as a PDF file.
* **Generate PDF:** This action will generate a PDF file defined in the protocol. This can be used to, for example, generate immutable audit records or reports of results.
* **Copy File:** This action will copy a file from one place in the filesystem to another. This can be used to for example copy generates files to a shared network drive, or similar.
* **Run Script:** This action will run a Python script that most likely can do anything impossible with one of the other post-session actions. 

The post-session actions can be configured and rerun from the Post-Session Action section of the Setup tab on the Experiment Panel (please see Figure 7).

![](/images/administration/ExperimentsActions.png)

*Figure 7: Post-session action section of the Setup tab on the Experiment Panel.*

The post-session action section allows you to set the output directory for each action. It also allows you to rerun an action on all subjects in an experiment. If, for some reason, a post-session action fails when LabBench Runner is closed, then rerunning the action from LabBench Designer can ensure that its data is generated for all subjects, including the subjects for which it failed.

## Data Panel

Data for an experiment can be managed on the Data panel (please see Figure 8). This tab contains a list of all the subjects that have participated in the experiment.

![](/images/Administration_Experiments/Slide4.PNG)

*Figure 8*

### Exporting data

To export data for all participants, click the **"Export data"** button. This will open a file save dialog for where to save the exported data file. 

The format for the data is determined by the file ending:

* **mat:** Data will be exported in MATLAB data format.
* **json:** Data will be exported in Java Script Object Notation.
* **hd5:** Data will be exported in Hierarchical Data Format.
* **csv:** This format is only available if a CSV export post-session action is defined in the protocol for the experiment. If present, this will export all subjects in the same CSV format as the single subject CSV export post-session action.

### Create participant

### Delete participant

Subjects can be deleted by clicking the Delete Subject button on the subject. Because this is an irrevocable action, you will be asked to confirm this deletion in a dialog before the subject is deleted. This is to guard against accidental clicks on the Delete subject button.

