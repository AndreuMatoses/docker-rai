#!/bin/bash

# Clone all the required repositories before!!, can be done with ./install_dep.sh --clone
# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -c|--clone)
            # Clone the required repositories
            git clone https://github.com/vhartman/rai.git
            git clone https://github.com/yuezhezhang/rai-robotModels.git
            git clone https://github.com/yuezhezhang/rai-manip.git 
            git clone https://github.com/yuezhezhang/valentin_robot_stippling.git
            shift # past argument
            ;;
        *)    # unknown option
            shift # past argument
            ;;
    esac
done

# Change to the rai directory
cd rai/

# Run the make command
yes | make -j1 installUbuntuAll

# VERY UGLY HACK: Comment the problematic lines 59-63 in rai/rai/ry/ry-LGP_Tree.cpp:
# Define the file path
LGP_Tree_path="rai/ry/ry-LGP_Tree.cpp"
# Check if the lines are already commented out
if ! grep -q "//" <(sed -n '59,63p' $LGP_Tree_path); then
    # If not, comment them out
    sed -i '59,63s/^/\/\//' $LGP_Tree_path
fi

# back to the main directory
cd ../

# change the rai path from `rai-fork` to `rai` in the Makefile in `rai-manip/PlanningSubroutines` and `rai-manip/Manip`.
# Define the file paths
Makefile_paths=("rai-manip/Manip/Makefile" "rai-manip/PlanningSubroutines/Makefile")
# Loop over the file paths
for Makefile_path in "${Makefile_paths[@]}"; do
    # Check if the required change has already been made
    if grep -q "^BASE = ../../rai-fork" $Makefile_path; then
        # If not, make the change
        sed -i 's/^BASE = ..\/..\/rai-fork/BASE = ..\/..\/rai/' $Makefile_path
    fi
done

cd valentin_robot_stippling/
# Run the make command
make -j8