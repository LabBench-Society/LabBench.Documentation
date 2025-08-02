---
title: Setting up the experiment
description: >
  How to add the required devices, and create and configure an experiment.
weight: 1
---

Before you can run an experiment with LabBench you must first have a protocol. For this introduction you will use a protocol that is available in the public LabBench Protocol Repository, and consequently, we do not need to write this protocol before running the experiment. 

The LabBench Protocol Repository is a source of three types of protocols; 1) protocols like the present one that is intended to teach you how to use LabBench and how to write your own protocols, 2) template protocols that contains templates for experimental procedures that can be copy pasted into your own protocols and thus reducing the work involved in writing protocols, and 3) standard protocols that can be used in studies that are intended to ensure that studies are using the same protocol as an original reference study. 

Once, like for the present introduction, a protocol is available in a protocol repository the first step in a study is to setup an experiment based on this protocol. This setup is performed with the LabBench Designer program. LabBench consists of two programs:

* LabBench Designer is used for setting up and managing experiments.
* LabBench Runner is used for running experiments in the laboratory.

In short LabBench Runner is used in experimental sessions when a participant is present, and LabBench Designer is used at all other purposes.

## Experimental setup

LabBench is intended for experiments that takes place in a laboratory where equipment, such as rating scales, stimulators, visual displays are used to carry out experimental procedures. The set of equipment and their configuration for a study is referred to as the Experimental Setup of the study. 

For the present study we need an equipment setup that can be used for the subject to fill out the DASS questionnaire and to perform the Stop-Signal Task, and the protocol for the study defines two alternative experimental setups. The reason the protocol can define alternative experimental setups is that LabBench protocols does not rely on specific types of research equipment, instead they rely on abstract instruments that are implemented by research equipment in LabBench. 

In the present protocol we need to perform two experimental procedures; filling out a questionnaire, and performing a cognitive task based on visual stimuli (Stop-Signal Task). These two experimental procedures need the following instruments:

| Procedure | Instruments | Purpose |
|-----------|-------------|---------|
| DASS Questionnaire | Questionnaire | The Questionnaire instrument makes it possible to display series questions to the subject, such as Likert scales, multiple choice, Boolean questions, etc. For the DASS questionnaire in the present protocol only Likert questions are displayed to the subject. |
| | Button | The Button instrument makes it possible for the subject to give their answer to the questions in the DASS questionnaire. For the DASS questionnaire four buttons is defined; 1) Increase the Likert rating, 2) Decrease the Likert rating, 3) Go to the next question, and 4) Go to the previous question. |
| Stop-Signal Task | ImageDisplay | The ImageDisplay instrument makes it possible to display images to the subject. For the Stop-Signal Task it is used to display the visual stimuli in the Go and Stop Trials and to give feedback to subject on whether they answered correctly (WIN + Score) or incorrectly (LOSS + Score). |
| | Button | The Button instrument makes it possible for the subject to respond to the Go trials or to provide an incorrect answer (a response) in the Stop trials. |

These three instrument types that are a small subset of the instruments that are available for LabBench protocols. Please see the manual LabBench Instruments [] for a full overview of all the instruments and their capabilities that are available.

These instruments are provided by two alternative experimental setups; one based on the LabBench I/O device, and the other based on a standard USB joystick. This is possible as both a joystick and the LabBench I/O implements the Button instrument that is required for the protocol. In addition to either a joystick or an LabBench I/O both setups use a standard external monitor that implements the Questionnaire and ImageDisplay instruments.

### Experimental Setup: Joystick

The Joystick experimental setup is intended as a low-cost experimental setup that can be used for educational purposes, as it does not use specialized LabBench equipment. Instead, it relies on a standard USB joystick for PCs, which can be purchased for 25-35€. One joystick that has been used extensively is the Logitech F310 Gamepad. 

![](/images/getting_started/Figure01.png)

*Figure 1: Overview of the joystick experimental setup.*

An overview of the Joystick experimental setup can be seen in Figure 1. Caution must be observed when using this experimental setup as it is only intended for educational or evaluation purposes. The joystick does not provide means for synchronizing button presses with stimuli such as the visual stimuli in the Stop-Signal Task. Consequently, it has a low temporal precision and button presses can only be timestamped with a precision of 5-10ms. For neuroscience studies the LabBench I/O based setup is recommended.

### Experimental Setup: LabBench I/O

The LabBench I/O setup shown in Figure 2 is the recommended experimental setup for cognitive tasks such as the Stop-Signal Task that are used in the present protocol.

![](/images/getting_started/Figure02.png)

*Figure 2: Overview of the LabBench I/O experimental setup.*

The experimental setup consists of; 1) an LabBench PAD which implements the Button instrument, 2) a LabBench VTG which is used to timestamp button presses with respect to when the visual stimuli is shown on the display in the Stop-Signal Task, 3) An external monitor facing the subject that when configured for LabBench is termed a LabBench DISPLAY, and a LabBench I/O which is used to collect the responses from the subject. This setup has a high temporal resolution of < 1ms.

## Adding required equipment to LabBench

Before an experiment can be created using one of its experimental setups the devices for this setup must first be added to LabBench. Please note this is done only once, if the devices have already been added for previous experiment this step can be skipped.

To add the equipment to LabBench; 1) start the LabBench Designer program, 2) Select the Devices page, 3) Select the type of equipment you want to add (LabBench Display and Joystick), 4) Click the “Scan and add” button (please see Figure 3).

![](/images/getting_started/Figure03.png)

*Figure 3:*

Once the “Scan and add” button is pressed it will open a dialog window that allow you to scan for devices to add to the system (see Figure 4).

![](/images/getting_started/Figure04.png)

*Figure 4:*

## Creating an experiment

To create an experiment, we must install a protocol from a repository. To view and install protocols from repositories first select the Protocols page in the LabBench Designer. This page allows you to configure repositories, view their protocols, and install protocols as experiments.

In this case we want to install the Introduction to LabBench protocol from the LabBench Protocol Repository. The LabBench Protocol Repository is an open and online protocol repository that is added automatically to LabBench when the program is installed. Consequently, for the installation of the Introduction to LabBench protocol we do not need to first add a protocol repository to LabBench to access this protocol. However, if you need to develop your own protocols, you must first create a repository in which you place your protocols and then add this repository to LabBench (please see [] for a guide on how to create and manage protocol repositories).

![](/images/getting_started/Figure05.png)

*Figure 5:*

To install the Introduction to LabBench protocols; 1) fold out the LabBench Protocol Repository, 2) fold out the Getting Started category in that repository, 3) in that category, select the Introduction to LabBench protocol, and 4) click the “Install Protocol” button (see Figure 5).

![](/images/getting_started/Figure06.png)

*Figure 6:*

Once the “Install Protocol” button is clicked it will open the Create Experiment dialog (see Figure 6). This dialog allows you to create an experiment from the protocol in the protocol repository. To create an experiment, you must give it a unique ID, a name, and choose which experimental setup to use in the experiment.

The ID must be unique. The reason for the uniqueness is that the ID is what LabBench use to store all protocol assets and data in its internal database, and thus it must be unique. If there is not an experiment with the same ID as the ID of the protocol in the repository, then the ID filled will be prefilled with the protocol ID. However, if there is already an experiment with that ID then you must provide a valid unique experiment ID.

The protocol name is what identifies the experiment to operators when they start the LabBench Runner to run an experimental session. You can use any description as the name for the experiment, however, it too must be unique as otherwise it would be confusing to the operators and will risk that they select the wrong experiment.

The “Store experiment remotely in the repository” allows you to configure whether the protocol is copied into the LabBench database on the current computer or whether the protocol and its assets are kept in its repository. If the protocol is stored remotely, it means that it will be loaded from the repository every time the experiment is accessed from the LabBench Designer or LabBench Runner. **Storing the protocol remotely is an option that is intended ONLY as a convenience for the development protocols and should NEVER be used when running real experiments in the lab.** Consequently, in this case make sure the “Store experiment remotely …” option is not checked when creating the experiment.

When you have provided an ID, Name, and chosen the experimental setup that match the devices you have available, then click the CREATE button. Once you click the CREATE button, the experiment will be created, and you will be taken to its Experiment page on the Experiments tab of the LabBench Designer.

## Configuring the experiment

Once the experiment is created, some experiments will need to be configured if they use devices that will need a different configuration based on which laboratory computer is used for the experiment. They may also need configuration if they use post session actions. The “Introduction to LabBench” use an external monitor (LabBench DISPLAY) where its size and location of fiducials needs to be configured. Consequently, this protocol needs to be configured after the experiment is created.

![](/images/getting_started/Figure07.png)

*Figure 7:*

Configuration of and export of data from experiments takes place on the Experiments tab of the LabBench Designer (see Figure 7). This tab consists of to the left a list of all the experiments that are currently installed on the computer and two the right the Experiment page for the currently selected experiment. The experiment page consists of up three tabs:

![](/images/getting_started/Table01.png)

The experimental setup can be in the Setup tab and consists of a list of devices required by the experiment. 

![](/images/getting_started/Figure08.png)

*Figure 8:*

The protocol refers to each device by a Protocol Device ID for the device to which a physical device ID must be assigned. The physical device ID is the ID given to each device that are added to the computer on the Devices tab of the LabBench Designer. When the experiment was created, a default physical device assignment was created. If you have more than one of the same types of devices this assignment may be incorrect and may need to be corrected.

### Assignning equipment

To inspect and change the assignment of physical devices to Protocol Device IDs can be done by click the “Assign equipment” button. This will open the dialog shown in Figure 9.

![](/images/getting_started/Figure09.png)

*Figure 9:*

The “Configure Devices” dialog consists of a list of Protocol Device IDs on the left, and to the right a drop-down for each Protocol Device ID that allow you to assign a Physical Device ID to each Protocol Device ID. Once the correct device assignments have been made you can save and close the dialog by clicking the OK button.

### Configuring equipment

Most LabBench equipment is fully configured through the protocol and consequently does not need manual configuration by the experimenter. However, several generic 3rd party equipment does need to be manually configured. 

In the present protocol, the external screen that is used to display the visual stimuli required for the Stop-Signal Task needs to be configured.

For the stimuli to be presented correctly the size of the screen, its distance to the subject, and the location and size of fiducials need to be configured. The size of the screen needs to be known to for the location and size of fiducials to be calculated correctly. Fiducials are white markers that are embedded in the visual stimuli and used to trigger a photosensor (LabBench VTG device) that will provide precise timing of subject responses. 

The distance from the screen to the subject is not used in the present protocol. However, in protocols that requires elements that occupy a given visual angle for the subject it is used to calculate the size of these elements on the screen. Examples of such protocols are protocols that record psychophysical ratings with visual analog scales. The visual scale is usually required to be 10cm in length when viewed by a subject holding the scale in their hands. When the scale is displayed on an external screen at much larger distances, LabBench will automatically scale up the Visual Analog Scale, so it occupies the same visual angle for the subject as if they held the scale in their hands.

![](/images/getting_started/Figure10.png)

*Figure 10:*

To configure an equipment, click the “Configure the device” button on the device in the list of equipment in the Experimental Setup section. If this button is disabled, it means that the device does not need configuration.

Clicking this “Configure the device” button will open the configuration dialog for the device; the configuration dialog for the LabBench Display is shown in Figure 10. The values needed to be entered into this dialog can be determined with the Screen and Fiducial Calibration Protocol (`calibration.screenFiducial@labbench.io`) protocol that is available in the Calibration section of the LabBench Protocol Repository.

### Post-session actions

Post-session actions are optional protocol elements and are actions that are performed at the end of a session when LabBench Runner is closed. If a post-session action fails at the end of a session, it can also be rerun from the LabBench Designer. Reasons for the failure of post-session actions could be the absence of an internet connection for actions that for example saves data to a network share or upload data to an FTP server.

Currently, LabBench supports the following types of post-session actions:

1.	Export Data Action: will export session data in either the json or MATLAB file format.
2.	Export to CSV File Action: will export session data as comma-separated values. This action will also enable export to CSV for all the experimental data. In this case, when all experimental data is exported to a CSV file each subject will be a row in the CSV file.
3.	Create PDF File Action: This will create a PDF file from the session data. The format and data content of this PDF file needs to be specified in the Experiment Definition File (*.expx).
4.	Copy File Action: will copy a file in the file system. This action is useful to copy previously created PDF and/or data files to for example a network share or similar.
5.	Run Script Action: will run a python script. This action can be used to create actions that are not natively supported by LabBench. An example of such an action could be the upload of data to an FTP server or another 3rd party data backend service.

The dialog for configuration and rerunning post-session actions are shown in Figure 11.

![](/images/getting_started/Figure11.png)

*Figure 11:*

