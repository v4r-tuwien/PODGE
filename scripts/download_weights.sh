script_dir=$(dirname "$(realpath "$0")")
dataset_dir=$script_dir/../data/datasets
weights_dir=$script_dir/../data/weights

## GDRNPP + YOLO Weights and Models
mkdir -p $weights_dir/yolov8
mkdir -p $weights_dir/gdrnpp

# YCBV Dataset
mkdir -p $dataset_dir/ycbv

wget -O gdrnpp_ycbv_weights.zip "https://owncloud.tuwien.ac.at/index.php/s/fkCygRgrV9C7zDH/download"
unzip gdrnpp_ycbv_weights.zip
cp -r gdrnpp_ycbv_weights.pth $weights_dir/gdrnpp/gdrnpp_ycbv_weights.pth
rm -r gdrnpp_ycbv_weights.zip gdrnpp_ycbv_weights.pth

wget -O gdrnpp_ycbv_models.zip "https://owncloud.tuwien.ac.at/index.php/s/gUxThY2caSsvix2/download"
unzip gdrnpp_ycbv_models.zip
cp -r models $dataset_dir/ycbv/models
rm -r gdrnpp_ycbv_models.zip models

wget -O yolov8_ycbv.zip "https://owncloud.tuwien.ac.at/index.php/s/eh3qmWzuAsJiqr1/download"
# unzip yolov8_ycbv.zip
cp -r train/weights/last.pt $weights_dir/yolov8/ycbv.pt
rm -r train yolov8_ycbv.zip

# YCB-iChores Dataset
mkdir -p $dataset_dir/ycb_ichores

wget -O ycb_ichores.zip "https://owncloud.tuwien.ac.at/index.php/s/qTajYeAhCghzRl3/download"
unzip ycb_ichores.zip

unzip ycb_ichores/yolov8_weights/ycb_ichores.zip
cp -r train10/weights/last.pt $weights_dir/yolov8/ycb_ichores.pt
rm -r train10 ycb_ichores/yolov8_weights

cp -r ycb_ichores/gdrn_weight/model_final.pth $weights_dir/gdrnpp/gdrnpp_ycb_ichores_weights.pth
rm -r ycb_ichores/gdrn_weight 

cp -r ycb_ichores/models $dataset_dir/ycb_ichores/models
rm -r ycb_ichores.zip ycb_ichores

# Tracebot Canister Dataset
mkdir -p $dataset_dir/tracebot_canister

wget -O gdrnpp_tracebotcanister_weights.zip "https://tucloud.tuwien.ac.at/index.php/s/oBoTmNZxa6MGKrZ/download"
unzip gdrnpp_tracebotcanister_weights.zip
cp -r gdrnpp_tracebotcanister_weights.pth $weights_dir/gdrnpp/gdrnpp_tracebotcanister_weights.pth
rm -r gdrnpp_tracebotcanister_weights.zip gdrnpp_tracebotcanister_weights.pth

wget -O gdrnpp_tracebotcanister_models.zip "https://tucloud.tuwien.ac.at/index.php/s/nKEd74fYFPe9TQ7/download"
unzip gdrnpp_tracebotcanister_models.zip
cp -r models $dataset_dir/tracebot_canister/models
rm -r gdrnpp_tracebotcanister_models.zip models

wget -O yolov11_tracebotcanister.zip "https://tucloud.tuwien.ac.at/index.php/s/zYJbgLRN8QtgsZZ/download"
unzip yolov11_tracebotcanister.zip
cp tracebotcanister.pt $weights_dir/yolov8/tracebotcanister.pt
rm -r yolov11_tracebotcanister.zip tracebotcanister.pt

## Other objects detectors
object_detectors_dir=$script_dir/../object_detectors

# Grounded Sam 2
cd $object_detectors_dir/grounded_sam2_ros/checkpoints
bash download_ckpts.sh

cd $object_detectors_dir/grounded_sam2_ros/gdino_checkpoints
bash download_ckpts.sh
cd $script_dir

## Grasp Estimators
# Contact Graspnet
wget -O contact_graspnet_weights.zip "https://tucloud.tuwien.ac.at/index.php/s/wLBo7LBHPMAtD5P/download"
unzip contact_graspnet_weights.zip
cp -r contact_graspnet $weights_dir/contact_graspnet
rm -r contact_graspnet_weights.zip contact_graspnet
