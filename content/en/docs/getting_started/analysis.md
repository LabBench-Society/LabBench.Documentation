---
title: Analysing experimental data
description: >
  A brief introduction on how to analyze the data from the experiment.
weight: 3
---

Data from experiments can be exported either from the LabBench Designer or with post-session actions that are defined in the protocol.

The difference between exporting from LabBench Designer and with post-session actions is that the former will export all data for all subjects to a single file, whereas post-session actions will export data from each subject as individual files. Post-session actions are executed when the LabBench Runner is closed. However, if this fails, they can also be rerun from the LabBench Designer.

The present protocol has defined one post-session action named “Export to CSV”, the data created by this action is shown in Figure 18.

![](/images/getting_started/Figure18.png)

*Figure 18:*

This data can be imported into Excel, SPSS, R, or Python for further analysis and data visualization.
