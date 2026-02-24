---
title: Installation
description: Instructions on how to install LabBench
weight: 20
---

## Download installer

The installer can be downloaded from:

| Version | Installer | Release Notes |
|---------|-----------|---------------|
| 6.0.0 | [LabBench 6](https://files.labbench.io/sw/LabBenchR6.0.0.exe) | [Release Notes](https://labbench.io/labbench-release-notes.html#lb6_0_0) |


## Installation

The installation progress is automated, and requires one choice that depends on whether you have administrative access to the computer. The installation progress is illustrated in Figure 1.

![](/images/Installation/Slide1.PNG)

*Figure 1*

### License and installation path

When the installer starts, it will first ask you to choose the installation path and to review and accept the license. Accept the default installation path, unless your organisation have special requirements for the installation location of programs.

The license you will be asked to accept is for Academic, Non-Commercial use of the program. To continue the installation, please accept the "I agree to the License terms and conditions" option. 

Then click Next.

### Installation of prerequisites

To run LabBench, you need the .NET Desktop Runtime 10.0.2 or higher. The installer will automatically download and install that runtime if it is not already installed on the computer.

Please accept the default choice and click Next.

### Installation type



* **Only for me**:
* **Everybody (all users)**:

## Local data directory

| Location                 | Requirements and function        |
|--------------------------|----------------------------------|
| Documents\LabBench6      | |
| C:\LabBench6             | |
| C:\ProgramData\LabBench6 | |



## License

![](/images/Installation/Slide2.PNG)


### License types

* **Academic, non-commercial use**:
* **3rd-party equipment**:
* **Commercial use**:


### Registrering the license

Before LabBench can run experiments, it must be registered with a valid license code. To register a license, open the LabBench Designer and, on the System tab, select the License page (see Figure X).

![](/images/Installation/Slide3.PNG)

*Figure 2*

On the license page, click the "Register license" button and in the resulting dialogue, enter your license key and click Register (see Figure X).

![](/images/Installation/Slide4.PNG)

*Figure 2*

When you click the Register button, the license server will be contacted, and your license will be registered and locked to the computer you are currently using.

### Moving and updating the license

A license key can only be used on one computer at a time; however, it can be moved between computers as many times as needed. To move the license key, it must first be deregistered from the license server.

![](/images/Installation/Slide5.PNG)

*Figure 2*

To deregister a license, click the Deregister button as shown in Figure X. Once the license key has been deregistrered it can be used on a new computer.

For standard licenses, LabBench will not contact the license server after a license key is successfully registered. That means you must update the license manually if changes have been made, such as purchasing a commercial license or using 3rd-party equipment.

To update the license, click the "Refresh license" button.



## Next steps

## Registrering the license


![](/images/administration/SystemLicense.png)

*Figure 1: License section that allows for registration and deregistration of license keys.*

The license section contains three circular license registration buttons in the lower right part of the header: the two leftmost for offline registration and the rightmost for online registration of license keys. When no license key is registered, these will be enabled.

Below the header is information about the license key that is currently registered. Initially, as no key will have been registered, this section will read UNLICENSED.


## Moving the license

A LabBench License Key can only be used on one computer at a time; however, it can be moved between computers as many times as needed. To move the license key, the key must first be deregistered on the license server.

![](/images/administration/SystemLicenseDeregister.png)

*Figure 4: Deregistrering a license.*

To deregister a license, click the Deregister button as shown in Figure \ref{fig:LicenseDialog_Deregister}. The method of deregistering depends on the method used to register the license key. If the online registration method was used when registering the license key, then the license key will be automatically deregistered online; however, if the offline registration method was used, then a license deregistration request file \verb|*.req| will be generated that must be uploaded to:

* [Offline Registration Portal](https://offline.licensespring.com/)

When the license deregistration request file is uploaded, the license key is released for use on another laboratory computer.

## Log configuration}

LabBench has a logging system that logs events during an experiment. The system will automatically log as many events as it can, such as the start and completion of tests and errors. However, for events outside the control of LabBench can be manually added to the log by the operator. Consequently, this logging system is intended to replace manual logging by operators in, for example, study logbooks.

The Logging section on the Systems page (please see Figure 4) allows this logging system to be configured.

![](/images/administration/SystemLogging.png)

*Figure 4: Log configuration.*

Events during an experimental session will be displayed in the LabBench Runner program. Events are categorized according to log levels:

* **Verbose:** Is the lowest logging level intended for detailed tracing of protocol execution.
* **Debug:** Used for debugging purposes and to inspect run-time outcomes during protocol development. Usually, too detailed for experimental sessions.
* **Information:** Information about the normal execution of protocols, such as results, start and completion of tests and similar events.
* **Warning:** Warnings that can influence an experimental session's results but do not invalidate its results.
* **Error:** Errors in the execution 
* **Fatal:** Fatal errors from which LabBench cannot recover and an experimental session is invalid and must terminate. No fatal errors have been identified, and this log level will never be seen in an experimental session.

The Log Level in the LabBench Runner subsection configured the minimal log level that will be displayed to an operator in the LabBench Runner program during an experimental session. A suitable log level for experiments is usually \verb|Information|.

All events will also be written into a log file on the laboratory computer. The Local Logging subsection allows you to configure this file's log level and location.

Setting up a log server on the local network is also possible. LabBench supports sending log events to a Datalust Seq Log Server, which can be obtained from:

* [DataLust Seq Log Server](https://datalust.co/seq)

If your research group uses multiple LabBench systems, the Seq Log server provides a central location for monitoring all of them.