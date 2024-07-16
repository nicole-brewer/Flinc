#!/bin/bash

# get the user kernel path
output=$(jupyter kernelspec list)
python3_path=$(echo "$output" | awk '/python3/ {print $2}')
echo "$python3_path"

sciunit create -f audit-kernel

# step 2: copy kernel.json file of user kernel
kernelfilepath="$python3_path/kernel.json"

auditkerneldir="audit-kernel"
mkdir -p ${auditkerneldir}
cp ${kernelfilepath} ${auditkerneldir}

# step 3: add script instructions
auditkernelpath="audit-kernel/kernel.json"
add="\\\t\"$(pwd)/handler.py\",\"sciunit\",\"exec\","
# sed -i "/prepend_and_launch.sh\",/a $add" ${auditkernelpath}
sed -i "/bin\/python/i $add" ${auditkernelpath}

# step 4: update kernel name
sed -i -E "s/(\"display_name\": \")(.+)\",/\1Sciunit Audit(\2)\",/" ${auditkernelpath}

# step 5: install the audit kernel
jupyter kernelspec install --user audit-kernel/
echo "Installed the audit kernel"

# step 6: update the repeat kernel
repeatkernelpath="repeat-kernel/kernel.json"
add="\\\t\"$(pwd)/repeat-handler.py\","
sed -i "/argv\": \[/a $add" ${repeatkernelpath}

# step 7: install the repeat kernel
jupyter kernelspec install --user repeat-kernel/
echo "Installed the repeat kernel"

# now just execute the notebook code with the audit and repeat kernels
