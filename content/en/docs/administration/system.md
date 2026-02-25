---
title: System
description: "Overall system configuration: logging, access control, display calibration, and license management."
weight: 1
---


## Logging

LabBench has a built-in log system that automatically logs all events taken by LabBench or by the operator using the user interface. During experimental sessions, the operator can also add log entries manually for events that happen outside the control of LabBench.

The logging system is configured on the Logging page of the System tab in LabBench Designer (please see Figure 1).


![](/images/Administration_System/Slide1.PNG)

*Figure 1*

Log entries are timestamped and have a message and a level. The log level indicates the severity and type of information:

![](/images/Administration_System/Slide2.PNG)

Log events are saved to persistent storage and appear in the log panel of LabBench Runner when they occur during protocol execution.

LabBench have three types of persistent storage for log events:

* **The internal database of LabBench:** Log entries are always saved to this database and can later be exported with a post-session action for each participant in a study.
* **Local storage:** Log entries are always saved to local text files on the laboratory computer running LabBench.
* **Seq Log Server:** Log entries can be configured to be sent to an instance of the Seq Log Server that must be provided by the organisation running studies with LabBench.

The minimum log level that will be saved by each storage location can be configured individually. 

### LabBench Runner

LabBench Runner includes a log panel that displays log events during an experimental setup and allows the operator to enter log messages. Operator-entered log messages will have a level of Information.

The log level that can be configured for LabBench Runner is the minimal log level that will be shown in this log panel. For studies, the recommended log level is Information, as Debug may overload the operator during the session and risk that important log messages are overlooked.

### Local Logging

The Local Logging session allows you to configure where log files are stored and the minimum log level written to them.

The log level configured for Local Logging is also the minimum log level written to the internal LabBench database.

### Seq Log Server

The Seq Log Server is a 3rd-party log server that can be hosted locally by the organisation that uses LabBench. This makes it possible to collect logs from all LabBench instances used within an organisation and monitor them centrally. The advantage is that support personnel can be notified of potential problems in real time, and audit records for studies can be collected centrally and inspected by auditors without having to inspect each site locally.

The use and connection to a locally maintained Seq Log Server can be configured in the Seq Log Server section. Please refer to the Seq Log Server documentation for information on configuring the Address and API key.

A free version of Seq Log Server for single-computer use is available. When the Seq Log Server is enabled in LabBench Designer, LabBench will, by default, use such an installation.

## Access Control

LabBench uses role-based access control. When LabBench is installed, this system is disabled, meaning anyone opening LabBench has full access, including the ability to perform potentially destructive actions such as deleting data or entire studies.

For single-user environments or environments that can rely on computer logins, this may be acceptable. However, in multiple-user environments, it may be required to restrict access to certain actions, which can be accomplished by enabling the Access Control system. Access Control can be enabled on the Access Control page (please see Figure 2).


![](/images/Administration_System/Slide3.PNG)

*Figure 2*

For information on role-based access control and its configuration, please refer to [the Researchers page](/docs/administration/researchers/).

## Display Calibration



![](/images/Administration_System/Slide4.PNG)

*Figure 3*

## License

![](/images/Administration_System/Slide5.PNG)

*Figure 4*

### Registrering a license

### Deregistrering the license

### Refreshing the license
