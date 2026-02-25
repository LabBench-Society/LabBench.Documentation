---
title: Researchers
description: The Researchers page will only be visible if the User Access Control has been enabled on the Systems page. When enabled, the Researchers page allows users to add and delete Researchers and assign their level of access to the system (Administrator, Investigator, or Operator). 
weight: 5
---

LabBench uses role-based access control. When LabBench is installed, this system is disabled, meaning anyone opening LabBench has full access, including the ability to perform potentially destructive actions such as deleting data or entire studies.

For single-researcher environments or environments that can rely on computer logins, this may be acceptable. However, in multiple-researcher environments, it may be required to restrict access to certain actions, which can be accomplished by enabling the Access Control system.

## Roles and permissions

|             | Action                 | Operator | Investigator | Administrator |
|-------------|------------------------|:--------:|:------------:|:-------------:|
| **System**  |                        |          |              |    |
| | Configure logging                  |          |              | ✔ |
| | Configure access control           |          |              | ✔ |
| | Calibrate display                  |          |              | ✔ |
| | License management                 |          |              | ✔ |
| **Researchers**                      |          | | | |
| | Add researcher                     | | | ✔ |
| | Set your own password              | ✔ | ✔ | ✔ |
| | Set the password of any researcher | | | ✔ |
| | Delete researcher                  | | | ✔ |
| **Devices**                          |        | | | |
| | Add devices                        | ✔ | ✔ | ✔ |
| | Remove devices                     | ✔ | ✔ | ✔ |
| **Protocols**                        |        | |   | |
| | Configure reposities               | | | ✔ |
| | Create experiments                 | | | ✔ |
| **Experiments**                      |        | | | |
| | Add users to experiments           | | ✔★ | ✔ |
| | Delete experiments                 | | ✔★ | ✔ |
| | Export data                        | | ✔★ | ✔ |
| | Configure devices                  | | ✔★ | ✔ |
| | Rerun post-session actions         | | ✔★ | ✔ |
| | Run experiment in LabBench Runner  | ✔★ | ✔★ |   |


*★ only to experiments that the researcher has access to*

## Manageing researchers

### Adding researchers

### Setting passwords

### Deleting researchers

## Disabling access control