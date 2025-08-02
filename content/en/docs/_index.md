---
title: Documentation
linkTitle: Documentation
menu: {main: {weight: 20}}
---


{{% pageinfo %}}

Welcome to LabBench, a system for describing experimental protocols in a human—and machine-readable format that can reduce the complexity of running experiments. In this overview, we will introduce our motivation for creating LabBench and its main concepts.

{{% /pageinfo %}}

LabBench is a complex tool that is difficult to describe in a few words. One way to introduce LabBench is with the concept that LabBench is two things that work together: 1) the LabBench Language and 2) the LabBench Software.

The LabBench Language is designed to specify protocols with terminology and concepts that scientists are already familiar with when they describe experiments with more conventional tools, such as writing an experimental protocol in a text document.

The LabBench Software consists of two programs, the LabBench Designer and LabBench Runner. The LabBench Designer is used to set up and manage experiments and export data for analysis. The LabBench Runner is used to run experiments written in the LabBench Language.

It is also helpful to understand what LabBench is not. LabBench is not a system for analysing data. Today, there is excellent software for analysing scientific data. Python, R, MATLAB, and SPSS are non-exclusive choices for scientific data analysis. These are all excellent choices for data analysis, and there is no need for another tool. Consequently, LabBench focuses exclusively on running experiments and ensuring that data is in an efficient format for later analysis in other third-party analysis software.

## Why we created LabBench

LabBench is motivated by the ever-increasing complexity of research methods and their dissemination in research papers. A research paper is highly efficient at disseminating context, hypotheses, and discussion of research results but less efficient at disseminating research methods. Over the years, we have reproduced numerous studies from the literature. However, despite the very best efforts of everyone involved in their publication, we found that it is not uncommon for descriptions of research methods to be accidentally incomplete in manuscripts. A second problem comes from the complexity of contemporary research methods. It is not uncommon for study protocols to require numerous complex steps to be taken by the scientist during an experiment. Steps include recording data, performing analysis/interpretation of these results during the experiment, and using these results for subsequent steps in the experiment. All of these tasks require considerable attention from the researcher.

Both problems can be alleviated by executing studies with a computer system, as the study must then be described in a machine-readable and executable format. This ensures that all parameters and methods are wholly specified; otherwise, a computer cannot execute the study. Furthermore, as the computer must execute the study, it must have automatic control over all equipment. Thus, all manual steps that do not require the interpretation or control of the researcher can be automated. This significantly reduces the complexity of running the study for the researcher.

Technically, all the building blocks for creating self-contained and automated protocols are available from the field of computer science. The most essential building block is a suitable scripting language. Today, open, powerful, and relatively easy-to-learn scripting languages, such as Python, can be used for scripts to encode protocols into machine-executable and human-understandable formats. However, the strength of general-purpose scripting/programming languages is also their weakness. Because they are general-purpose languages, they are powerful, and basically, there is nothing you cannot create with them; with sufficient effort, you can completely automate an experiment. As general-purpose languages, they place no restrictions on what they can be used for; however, simultaneously, they do not assist in implementing any task. This leaves the architecture and implementation details entirely up to the researcher. In practice, this means that even though the language may be relatively easy to learn, a very steep learning curve must be overcome before implementing even the simplest experimental protocol.
Another problem is disseminating these protocols so that other researchers may use them. Without standards for their implementation, the protocols are unique to that specific experiment. This makes it challenging for other researchers to replicate experiments and extend them.

The problems inherent in general-purpose scripting languages can be alleviated by designing a domain-specific language (DSL) for protocols that can be extended with a general-purpose scripting language. A DSL is a language intended to capture expert knowledge of one specific domain or problem in a form that significantly simplifies using the language compared to a general-purpose language. In this case, the purpose of the DSL language is to describe protocols in a standard way that both humans and machines easily understand. Yet, in a format that is also flexible and extendable enough that most protocols can be described in this DSL language.

To fulfil the above aims, we have created a DSL called the LabBench Language for protocols, particularly neuroscience protocols, and an associated protocol runner called LabBench to execute these protocols.

## What can LabBench do?

LabBench can do many things on different levels, from simple experiments using preprogrammed blocks of procedures that can be set up in minutes to highly complex protocols with advanced scripting and logic. 

However, regardless of how you use LabBench, you should expect to:

1. Reduce the researcher's workload by moving as much of the decision-making from the experimental session to the study's planning phase.
2. Reduce the technical competencies required to take advantage of scripted protocols by eliminating or drastically reducing the amount and complexity of code required to implement automatic scripting of an experiment.
3. Ensure all data is recorded consistently by removing the save button from the program. Data are automatically saved according to the study protocol.
4. Ensure that detailed logs are created throughout the experiment by automatically logging every program action during a session. Events outside of the program can be added to the log by the experimenter.
5. Facilitate data analysis by automatically recording all data in a machine-readable format.
6. Ameliorate dissemination and reproducibility by describing protocols in a simultaneous human and machine-readable format that includes the structure, execution, and parameters of the study.

## Who is LabBench intended for?

To put it as succinctly as possible, LabBench is intended for any scientist who wants a way to make it easier to run experiments to reduce the change of errors and increase the reproducibility of their experiments. It is our experience that you do not need a background in technical sciences, such as computer science, to use and benefit from LabBench.

LabBench takes an entirely different approach than most contemporary software for non-technical professionals. No code platforms are everywhere, often accompanied by the statement "no programming skills are necessary", which is considered a quality statement. We will argue that it is the opposite of a quality statement. All no code software does is provide a graphical representation of code, which provides an additional layer of potential errors and misinterpretations of what the computer will do. It does not remove code but transforms it into another language you must learn. A language that has not matured from continuous improvement and experience stretching back 180 years to the very first programming language by Ada Lovelace in 1833.

It is our experience that a DSL, like the LabBench Language, is easier to learn than a visual "no code" programming environment and that it reduces the complexity of conventional programming to a level where anyone can reach sufficient proficiency in the same period as it takes to become truly proficient in a graphical "no code" programming environment.

Therefore, we believe that LabBench is for every researcher regardless of background. 

## What do I need to know to use LabBench?

That depends on your ambitions and needs, but LabBench is designed so you can progress in stages and that you will be able to run relevant research studies at each stage of proficiency.

In the first stage, a LabBench Protocol Repository is available through the LabBench Designer and on GitHub. You can install ready-made protocols from this repository, such as quantitative sensory testing, perception threshold tracking, psychophysical research tasks such as Stroop, Flanker, or Stop-Signal tasks, and similar research protocols. This will allow you to see what LabBench can do without having to write any code, and if your need is to run standardised protocols reproduced from published papers, then that may be all you will need to use and benefit from LabBench. 

The next stage is to develop your protocols using the preprogrammed research methods with LabBench. You will need to use and understand the LabBench Language at that stage. Using the LabBench Language consists of writing a text configuration file for the experiment in a format known as eXtensible Markup Language (XML). You will also be introduced to the first simple scripting at this stage. Part of the LabBench Language is that tests can be configured with the results of previous tests. This can be done by writing mathematical formulae of the same form as on a calculator in the text configuration file. Accessing the LabBench Protocol Repository on GitHub can also make this stage significantly more accessible, as it is easier to assemble a protocol from parts of existing protocols than to write a protocol from scratch.

Going further, preprogrammed research protocols that can be directly configured by the LabBench Language configuration file can be extended by writing Python scripts that are called from the configuration code. With this approach, you can implement truly advanced protocols. However, you will need to learn a bit of Python programming. We chose Python as the scripting language for LabBench as it is an easy-to-learn, very mature language for which numerous excellent textbooks exist. But you do not need to be an expert Python programmer. One of the advantages of combining Python with the LabBench Language is that it drastically reduces the amount and complexity of the code required to implement an experimental paradigm. 

## Overview of how to run a study

Before examining and discussing each element of a LabBench protocol, starting with a broad overview of all required to run an experiment with LabBench is often helpful.

The key steps and concepts that are required for any experiment, regardless of their complexity and scale, are the following:

1. An Experiment Definition File in the LabBench Language must be written. Depending on the complexity of the study, this may also involve writing one or more Python scripts called from the Experiment Definition File. Files such as images, instructions, sound files, and similar may also be included with and used by the Experiment Definition File.
2. The Experiment Definition File and its Python scripts and assets must be placed in a protocol repository and assigned a unique ID. This ensures that protocols can be uniquely identified when results are published.
\item An experiment is created with the LabBench Designer program from an Experiment Definition File in a protocol repository.
3. The experiment is performed using the LabBench Runner program.
4. When the experiment has been completed and all the sessions have been recorded, the data from the experiment is exported in the LabBench Designer program for analysis in 3rd party data analysis software.

All studies using LabBench will follow this series of steps, differing only in the complexity and scale of each step. Please note that if you use a standard [LabBench Protocol Repository](https://protocols.labbench.io/) protocol, there is essentially no work associated with steps 1 and 2. 


