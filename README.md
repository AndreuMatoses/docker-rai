# Container to Run rai+tamp for multi-robot-collaboration
This repository creates a docker container + dev container for running [Valentin](https://github.com/vhartman/24-data-gen/tree/master)'s paper ["Towards computing low-makespan solutions for multi-arm multi-task planning problems"](https://arxiv.org/abs/2305.17527).

> [!TIP]
> Remember to enable `xhost +` in the host machine to allow the container to display the GUI.

# Installation 

> [!NOTE] 
> The code depends on the code of [rai](https://github.com/vhartman/rai), [rai-robotModels](https://github.com/vhartman/rai-robotModels) and [rai-manip](https://github.com/vhartman/rai-manip), which will be installed by the script install_dep.sh.

With VS code, open the folder and run the devcontainer. To do that, ctrl+shift+p and type "Remote-Containers: Reopen in Container", it will take one min. Once in the container, run the install_dep.sh script. :

```bash
./install_dep.sh --clone
```
Where the clone option is to clone the repositories necessary for the code to run. As the workspace is mounted in the host machine, you dont need to clone them again if you rebuild the container. 

If all ran successfully, you can test it by running the following command:

```bash
cd valentin_robot_stippling
./x.exe
```