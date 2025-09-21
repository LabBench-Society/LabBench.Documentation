---
title: Experiments
description: The Experiment Page allows experiment management, which allows users to configure their experimental setups and export data.
weight: 40
---

Experiments are managed on the Experiments Page of LabBench Designer (see Figure 1). To the left, this page lists all the experiments that are currently present in the system. This list selects which experiment will be shown on the Experiment Panel on the right of the Experiments Page.

The Experiment Panel consists of tabs to the left that lets you choose between four tabs:

* **Protocol:** If a protocol description is available, it will be shown in this tab. This tab will allow you to read the description within LabBench Designer or to print it to a physical printer or a PDF file. If no protocol description is available, this tab will not be present for the experiment.
* **Setup:** The setup tab will always be present and allow you to configure the experiment. This includes configuring its validation of subject IDs, experimental setup, and post-session actions.
* **Data:** The data tab will always be present and show you a list of subjects. From this tab, it will be possible to delete subjects and export data from all subjects.
* **Errors:** This tab will only be present if there are errors, warnings or information regarding the experiment. 

![](/images/administration/ExperimentsPage.png)

*Figure 1: The Experiments Page in the LabBench Designer.*

From the header of the Experiment Panel, it is also possible to delete the experiment by clicking the Delete Experiment button. As this action will irrevocably delete all data, a warning dialog will first be displayed, where you must confirm your deletion of the experiments before the system will delete it.

## Subject ID

The subject ID section on the Setup tab provides information on the subject ID validation performed in the experiment (see Figure 2). If this validation has not been defined in the protocol then it can be enabled or changed by clicking the Configure validation button.

![](/images/administration/ExperimentsSubjectID.png)

*Figure 2: Subject ID validation section on the Setup tab in the Experiment Panel.*

Clicking the Configure validation button will open a dialog to enter the validation rule and a help text that LabBench Runner will display if an operator enters an invalid subject ID (see Figure 3).

The rule must be specified as a regular expression. A useful tool for developing and testing regular expressions can be found at [Regex 101](https://regex101.com/) and tutorials to learn regular expressions at [Regex Learn](https://regexlearn.com/). Regular expressions are a very powerful albeit complex tool that can be used to search and validate text.

![](/images/administration/DialogSubjectID.png)

*Figure 3: Configuration of subject ID validation.*

## Experimental setup

Most protocols will need access to a set of devices to run. This set of devices and their configuration is often called the experimental setup of a study, the term that LabBench uses. 

![](/images/administration/ExperimentsSetup.png)

*Figure 4: Section with information about the experimental setup.*

The devices used in the protocol for an experiment can be seen in the Experimental Setup section of the Setup tab (see Figure 4). Each device defined in the Experimental Setup must be assigned a device from the Device Page (see Figure 5). A default device assignment is created when the experimental is created from a protocol in a repository. This will assign the first available device to each device in the Experimental Setup. However, if more than one device of the same type is present in the system, this assignment may be incorrect. 

![](/images/administration/DialogConfigureDevices.png)

*Figure 5: Assignment of devices to logical devices in the protocol (Configure Devices Dialog).*

Clicking the Assign devices button will open the Configure Devices dialog (see Figure 5) that will allow you to change the assignment of devices.

Some devices also have a configuration that can be changed by click their Configure device button (see Figure 4). Currently, LabBench I/O, LabBench DISPLAY and Joystick devices has properties that can be configured in the LabBench Designer.

### Display configuration

The configuration dialog for LabBench Devices is shown in Figure \ref{fig:DialogConfigureDisplay}. The LabBench DISPLAY is a second application window intended to be placed on a display shown to the subject. It can be used for multiple purposes, including displaying psychophysical rating scales, instructions to the subjects, images for visual stimuli, cognitive tests that require visual stimuli such as Stroop, Flanker, Stop-Signal tasks, and questionnaires.

The parameters that can be changed for the LabBench Display are:

\begin{itemize}
    \item \textbf{Display:} the display on which the application window will be opened. Typically, this will be the Secondary display. However, during the development and testing of a protocol, opening it on the Primary display may be beneficial, as this will allow you to test the protocol on a computer for which a secondary display is unavailable.
    \item \textbf{Positon:} The position on the display where the application window will be opened. This can be configured as Fullscreen, Upper Half, Lower Half, Upper Right Corner, Upper Left Corner, Lower Right Corner, or Lower Left Corner.
    \item \textbf{Size:} The physical diagonal size of the display.
    \item \textbf{Distance:} The distance from the eyes of the subject to the display.
\end{itemize}

\begin{figure}[htp]
    \centering
    \includegraphics[width=7cm]{illustrations/DialogConfigureDisplay.png}
    \caption{Configuration of LabBench DISPLAY parameters.}
    \label{fig:DialogConfigureDisplay}
\end{figure}

The \verb|Size| and \verb|Distance| parameters are used for visual angle calculations. For some experimental procedures, visual stimuli must occupy a given angle of the subject's visual field. This is the case of the display of visual analogue scales, where the size and distance are used to scale the size of the scale so it occupies the same visual angle as a 10cm scale would at a nominal distance of 40cm from the subject's eyes. The protocol's author defines the scale's nominal distance and physical size.

\subsubsection{Joystick configuration}

Subjects can use a standard USB Joystick to complete questionnaires and provide answers in response tasks to estimate psychophysical functions and/or thresholds. However, no standard exists for the codes assigned to the USB buttons. Consequently, protocols written for one brand of USB joystick are unlikely to work with other brands of USB buttons.

To make it possible to use a brand of Joystick different from the one a protocol was initially written for, it is possible to change the codes assigned to each button. To change the codes, click the Configure device button for the Joystick, which will open the dialog shown in Figure \ref{fig:DialogConfigureJoystick}.

\begin{figure}[htp]
    \centering
    \includegraphics[width=14cm]{illustrations/DialogConfigureJoystick.png}
    \caption{Figure caption.}
    \label{fig:DialogConfigureJoystick}
\end{figure}

When using this dialog, it is beneficial to have the joystick connected to the computer. This allows you to press buttons on the joystick and see their code(s) at the top of the dialog. This allows you to identify the correct codes to enter in the button map shown in the lower half of the dialog. Click OK to update the button maps; if you click Cancel, your changes will be discarded.

\subsection{Post-session actions}

Post-session actions are actions that are performed when LabBench Runner are closed. Currently, it is possible to include the following post-session actions in protocols:

\begin{itemize}
    \item \textbf{Export Data:} This action will export the data from a single subject in either MATLAB format (*.mat) or Java Script Object Notation format (*.json).
    \item \textbf{Export CSV:} This action will export selected data to a comma-separated values file (*.csv). A calculated parameter in the export action must define each value in the CSV file.
    \item \textbf{Export Log:} This action will export the experimental log for the subject as a PDF file.
    \item \textbf{Generate PDF:} This action will generate a PDF file defined in the protocol. This can be used to, for example, generate immutable audit records or reports of results.
    \item \textbf{Copy File:}
    \item \textbf{Run Script:} This action will run a Python script that most likely can do anything impossible with one of the other post-session actions. 
\end{itemize}

The post-session actions can be configured and rerun from the Post-Session Action section of the Setup tab on the Experiment Panel (please see Figure \ref{fig:ExperimentsActions}).

\begin{figure}[htp]
    \centering
    \includegraphics[width=14cm]{illustrations/ExperimentsActions.png}
    \caption{Post-session action section of the Setup tab on the Experiment Panel.}
    \label{fig:ExperimentsActions}
\end{figure}

The post-session action section allows you to set the output directory for each action. It also allows you to rerun an action on all subjects in an experiment. If, for some reason, a post-session action fails when LabBench Runner is closed, then rerunning the action from LabBench Designer can ensure that its data is generated for all subjects, including the subjects for which it failed.

\subsection{Managing experimental data}

Data for an experiment can be managed on the Data tab on the Experiment Panel (please see Figure \ref{fig:ExperimentsData}). This tab contains a list of all the subjects that have participated in the experiment.

\begin{figure}[htp]
    \centering
    \includegraphics[width=14cm]{illustrations/ExperimentsData.png}
    \caption{Figure caption.}
    \label{fig:ExperimentsData}
\end{figure}

\subsection{Exporting data}

To export data for all subjects, click the Export all subjects button. This will open a file save dialog for where to save the exported data file. The format for the data is determined by the file ending:

\begin{itemize}
    \item \textbf{mat}: Data will be exported in MATLAB data format.
    \item \textbf{json}: Data will be exported in Java Script Object Notation.
    \item \textbf{csv}: This format is only available if a CSV export post-session action is defined in the protocol for the experiment. If present, this will export all subjects in the same CSV format as the single subject CSV export post-session action.
\end{itemize}

\subsection{Deleting subjects}

Subjects can be deleted by clicking the Delete Subject button on the subject. Because this is an irrevocable action, you will be asked to confirm this deletion in a dialog before the subject is deleted. This is to guard against accidental clicks on the Delete subject button.

