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
Run `./install.sh` to start Flinc and make kernels available.

### Confirm setup

The successful execution of the above script will result in the 
installation of sciunit, audit kernel, and repeat kernel.

You may confirm the kernel installations by running:
   
   `jupyter kernelspec list`


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

## Suggested Processes

When reproducing experiments on Trovi, we want to work out of the `~/work` folder so that our files are accessible by the file viewer. 

### Download Flinc
```
mkdir -p ~/work
cd ~/work
git clone -b chameleon https://github.com/nicole-brewer/Flinc.git
cd Flinc
./startup.sh
./install.sh
jupyter kernelspec list
```

### Copying audit-kernel

```
sciunit copy -n
# move zip file to a location accessible by the JupyterLab file browser
mv ~/sciunit/audit-kernel.zip ~/work
# 1. Use JupyterLab to download the zip file
# 2. Move to the correct location in local storage, for example...
#    mv ~/Downloads/audit-kernel.zip ~/Repos/nicole-brewer/flinc-artifacts/<project-folder>/<notebook-name>.ipynb
read -p "Press Enter to continue..."
```

### Remove audit-kernel

In response to https://github.com/depaul-dice/Flinc/issues/6, we use the following process to fully remove the audit kernel before opening a new notebook. 

```
sciunit rm e1
jupyter kernelspec remove audit-kernel
jupyter kernelspec remove repeat-kernel
rm -rf ~/sciunit/audit-kernel/
cd ~/Flinc
./install.sh
```


## Uninstalling FLINC

1. Uninstall sciunit with `pip3 uninstall sciunit2`
2. Remove audit and repeat kernels with `jupyter kernelspec remove audit-kernel` and `jupyter kernelspec remove repeat-kernel`
3. Remove Flinc directory: `rm -rf Flinc`
