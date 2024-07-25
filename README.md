# Reproducible Notebook Containers using Application Virtualization

## Installing Flinc
### Clone the Chameleon branch of this repo
```
# we want to specifically clone the chameleon branch 
git clone -b chameleon https://github.com/nicole-brewer/Flinc.git
cd Flinc
```
### Install Flinc on Ubuntu 20.04
Run `./startup.sh` on starting a new node to install the prerequisites (SciUnit) and install flinc. Most specific instructions below.

### Setup Audit and Repeat Kernels
Run `./install.sh' to start Flinc and make kernels available.

### Confirm setup

The successful execution of the above script will result in the 
installation of sciunit, audit kernel, and repeat kernel.

You may confirm the kernel installations by running:
   
   `jupyter kernelspec list`

### All Together
```
git clone -b chameleon https://github.com/nicole-brewer/Flinc.git
cd Flinc
./startup.sh
./install.sh
jupyter kernelspec list
```

## Using FLINC

1. Select the audit kernel from within the notebook and execute your notebook 
code. After execution completes, select 'No Kernel' from the list or shutdown the kernel and wait 30 seconds to 1 minute to complete the auditing.
2. Repeat your notebook code on the same or different machine by selecting 
the repeat kernel.
3. After using the repeat kernel, select No Kernel again to finish.
4. Sciunit will store your notebook as an executable which you can 
view using:

   `sciunit list`

**NOTES**
1. The install.sh script must only be executed once.
   Once the audit and repeat kernels have been installed, the script 
should not be run again.
2. No existing file should be deleted or modified in the Flinc directory.
3. Run one notebook in a Sciunit project with the audit and repeat kernels. If you have multiple notebooks to audit, create separate Sciunit projects for each notebook.
4. If you run your code using the audit kernel on machine #1, you can repeat it using the repeat kernel on machine #2. To do this, first execute your code using audit kernel, and then run 'sciunit copy' to obtain a unique code. Take that code and run `sciunit open <code>`. This transfers the contents of the notebook container to machine #2 from machine #1.
