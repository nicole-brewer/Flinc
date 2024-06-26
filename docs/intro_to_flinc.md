# Installing flinc

## AWS

```
ssh -i ~/.ssh/flinc_aws.pem ubuntu@ec2-54-166-244-124.compute-1.amazonaws.com
```

## Chameleon

```
ssh -i ~/.ssh/chameleon.pem cc@129.114.109.25
```

## SciUnit

SciUnit is a prerequisite of FLINC. It must be run on a Linux machine, preferably Ubuntu. 

Execute a python file with the following:

```
sciunit exec <python-file>.py
```

Executions will be stored in directories named "e1", "e2", etc. You can look at them with. 

```
sciunit list
sciunit show e1
```

### Re-executing Experiments

One of the features of SciUnit is that it can help you re-execute an experiment on another machine to test you SciUnit container in another environment. Conceptually, you want to copy and paste, remotely. See the [depaul-dice/sciunit Wiki](https://github.com/depaul-dice/sciunit/wiki/Documentation#continue-your-work-on-another-machine) for more details.

## Notebooks
Before Flinc, we used to turn notebooks into python files, which sort of defeated the purpose of the interactive notebook in the first place

## Flinc (Flexible Notebook Containerization)
Sciunit doens't handle interactivity. Flinc is built on top of SciUnit to capture execution information as notebooks are running. That is called the "audit phase".  

### Application virtualization
1. Audit phase - collects execution information as it is running
2. Repeat phase - notebook actions are re-executed as they were in the original audit phase

### Running Flinc

You may have kernels for different experiments. You can list them with

```
jupyter kernelspec list
```

which shows "availble kernels" and provides path the those kernels, for example

```
cc@flinc:~/Flinc$ jupyter kernelspec list
Available kernels:
python3 /home/cc/.local/share/jupyter/kernels/python3
```

The path - in the above example `/home/cc/.local/share/jupyter/kernels/python3`, is the only argument required to start flinc with the `install.sh` script.

```
./install.sh /home/cc/.local/share/jupyter/kernels/python3
```
