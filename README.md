# PODGE (Pose estimation, Object Detection, Grasp Estimation) (Title not final)

This repository serves as a central hub for multiple grasp estimators, object detectors and pose estimators. It is heavily based on [DOPE](https://github.com/lexihaberl/DOPE.git).

To-Do List:
- Add CNOS downloads and docker integration
- Add ZS6D downloads and docker integration

## Cloning the repository

To clone this repository with all its submodules:
```bash
git clone --recurse-submodules git@github.com:v4r-tuwien/PODGE.git
```

If you have already cloned the repository without the submodules, you can initialize and update them with:
```bash
git submodule update --init --recursive
```

## Downloading model weights
You can download the pretrained model weights with the following command:
```bash
bash scripts/download_weights.sh
```
Models and weights used by YOLO and GRDNPP will be placed in the `data/datasets` and `data/weights` folders, respectively. Other models (e.g., weights for Grounded SAM 2) will be placed in the folders corresponding to their respective repositories. Please refer to the official documentation for further details.

Make sure to double-check that the files were correctly copied to the aforementioned folders, as this command may fail if the folders were previously created by another user. If the download link has expired, please contact any of the V4R members for assistance.

## Config setup
Before running any container, make sure to setup the config files:

**ros.env:**

Change the `ROS_IP` to your PC’s IP address.  
You can find your IP address by running the following command:
```bash
hostname -I
```
If you are connected to the V4R network, the IP address should be in the format:  
    `10.0.0.xxx`.

**params_[camera].yaml:**

If you plan to use a camera that isn't yet included in the configuration, make sure to create a custom `params_[camera].yaml` file and add the relevant parameters to it.

## Running the containers
GRAPED includes numerous other GitHub repositories. The goal of GRAPED is to have a collection of docker compose files, which can easily be start from here. In order to start the containers, use the docker compose files provided in the `docker_compose` folder instead of the corresponding repositories. 

### YOLOv8 and GDRNPP
To start the YOLOv8 and GDRNPP containers, use the following command:
```bash
xhost local:docker
DATASET=ycbv CONFIG=params_sasha.yaml docker compose -f docker_compose/gdrnpp_yolov8.yml up
```

Change `DATASET` to your desired dataet (ycbv, ycb_ichores, fluidcontainer). If you want to test GDR-Net run:

```bash
xhost local:docker
DATASET=ycbv CONFIG=params_sasha.yaml docker compose -f docker_compose/gdrnpp_yolov8_test.yml up
```

**Note**: If you plan to use GDRNPP and YOLO frequently, it may be helpful to add an alias to your `.bashrc`. You can do so by running the following command (remember to adjust the path as needed):

```bash
echo "alias GDRNPP='cd ~/$(USER)/Workspace/DOPE/ && xhost local:docker && echo \"DATASET is set to: \$DATASET\" && DATASET=\$DATASET CONFIG=params_sasha.yaml docker-compose -f docker_compose/gdrnpp_yolov8_test.yml up'" >> ~/.bashrc
```

After sourcing your `.bashrc`, you can simply run the alias (depending on your dataset):
```bash
export DATASET=ycbv
GDRNPP
```

**Additional note**: Although this section refers to YOLOv8, the model used for fluid container detection was actually trained using YOLOv11.

### Grounded SAM2
To start the GSAM2 container, use the following command:
```bash
xhost local:docker
docker compose -f docker_compose/gsam2.yml up
```

### CNOS and ZS6D
To start the CNOS and ZS6D containers, use the following command:
```bash
xhost local:docker
docker compose -f docker_compose/cnos_zs6d.yml up
```
**Note**: The weight download and setup of both CNOS and ZS6D has **not** been fully added to PODGE. Please read the documetnation of corresponding repositories for the full setup.


### Contact Graspnet
To start the Contact Graspnet container, use the following command:
```bash
xhost local:docker
CONFIG=params_sasha.yaml docker compose -f docker_compose/contact_graspnet.yml up
```

