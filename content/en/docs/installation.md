---
title: Installation
description: Instructions on how to install LabBench
weight: 20
---

The steps required for LabBench Installation depend on whether your users have administrative access to the laboratory computer. In both cases, you will need the LabBench installer, which can be downloaded from: 

Before LabBench installation, please read the Release Notes for the version you are installing, as they may contain additional information about the installation process that is not in this guide.

Once you have downloaded the installer, run this installer and accept all default choices.

## Registrering the license

Before LabBench can run experiments, it must be registered with a valid license code. To register a license, open the LabBench Designer and, on the System tab, scroll down to the License section.

![](/images/administration/SystemLicense.png)

*Figure 1: License section that allows for registration and deregistration of license keys.*

The license section contains three circular license registration buttons in the lower right part of the header: the two leftmost for offline registration and the rightmost for online registration of license keys. When no license key is registered, these will be enabled.

Below the header is information about the license key that is currently registered. Initially, as no key will have been registered, this section will read UNLICENSED.

## Online registration

The laboratory computer can register the license key online when it has internet access. This is the simplest and fastest registration method. To perform an online registration, click the Online Registration button to open the Online License Registration Dialog (please see Figure 2).

![](/images/administration/DialogLicenseEnterKey.png)

*Figure 2: Online license registration dialog.*

Once a key is entered, the REGISTER button will become enabled, as shown in Figure \ref{fig:LicenseDialog_Register}. Click the REGISTER button to register the license key with the license server.

![](/images/administration/DialogLicenseRegister.png)

*Figure 3: Online license registration dialog with key entered.*

After clicking REGISTER, the dialog shown will close, and the LICENSE section should now display the activated license key with information about the license.

## Offline registration

Offline registration must be used if the computer cannot access the internet. Offline registration consists of a two-step process:

1. Generation of a license activation request file `.req` and uploading it to the Offline License Portal.
2. This will generate a license file `*.lic`, which must then be loaded into LabBench Designer.

Click the Offline Registration Request button to generate a license activation request file `*.req`, this will open a File Save dialog, allowing you to save the file to a suitable location, such as a USB key.

Transfer the USB key to a computer with internet access and upload the file to:

* [Offline Registration Portal](https://offline.licensespring.com/)

If the key is not registered on another computer, this will generate a license file `*.lic` that can be saved on the USB key. 

Take the USB key to the laboratory computer and click the Offline Registration button to open a File Open dialog. In this File Open dialog, select the `*.lic` file and click open. LabBench should now be activated to run experiments in the LabBench Runner program.

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