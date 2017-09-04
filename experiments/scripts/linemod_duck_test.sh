#!/bin/bash

set -x
set -e

export PYTHONUNBUFFERED="True"
export CUDA_VISIBLE_DEVICES=$1

LOG="experiments/logs/linemod_duck_test.txt.`date +'%Y-%m-%d_%H-%M-%S'`"
exec &> >(tee -a "$LOG")
echo Logging output to "$LOG"

# test for semantic labeling
#time ./tools/test_net.py --gpu 0 \
#  --network vgg16_convs \
#  --model output/linemod/linemod_duck_train/vgg16_fcn_color_single_frame_linemod_duck_iter_40000.ckpt \
#  --imdb linemod_duck_test \
#  --cfg experiments/cfgs/linemod_duck.yml \
#  --cad data/LINEMOD/models.txt \
#  --pose data/LINEMOD/poses.txt \
#  --background data/cache/backgrounds.pkl

# test for pose regression
time ./tools/test_net.py --gpu 0 \
  --network vgg16_convs \
  --model output/linemod/linemod_duck_train/vgg16_fcn_color_single_frame_pose_linemod_duck_iter_40000.ckpt \
  --imdb linemod_duck_test \
  --cfg experiments/cfgs/linemod_duck_pose.yml \
  --cad data/LINEMOD/models.txt \
  --pose data/LINEMOD/poses.txt \
  --background data/cache/backgrounds.pkl
