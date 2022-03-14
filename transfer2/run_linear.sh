# !/usr/bin/env bash
# !/bin/bash
# Base Folder
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# SCRIPT_DIR="${SCRIPT_DIR}/en_de.nmt_models"
# echo "print SCRIPT_DIR ${SCRIPT_DIR}"
# KIWI=$(dirname ${SCRIPT_DIR})
# echo "print KIWI ${KIWI}"
KIWI=$(dirname ${SCRIPT_DIR})
# echo "print KIWI ${KIWI}"
# STACK=${SCRIPT_DIR}/linear/stack_probabilities_for_linear.py

# Change this to -1  if you do not intend on using a GPU
GPU_ID=-1

# Track
TRACK="nmt"

# Dataset to be used (word_level or sentence_level)
WORD_LEVEL="word-level/en_de.${TRACK}"
SENT_LEVEL="sentence_level/en_de"
# Naming convention for model/language_pair release
DATASET_NAME="wmt18"


# The format flag of the files
FORMAT="wmt18"

DATA="${KIWI}/data"
PREDICTIONS_DIR="${KIWI}/predictions_transfer2"
WORD_DIR="${DATA}/${WORD_LEVEL}"
SENT_DIR="${DATA}/${SENT_LEVEL}"
# Create predictions folder

# for MODEL_DIR in $(find ${SCRIPT_DIR} -maxdepth 1 -mindepth 1 -type d)
# do
#     MODEL_NAME=$(basename ${MODEL_DIR})

#     for RUN_DIR in $(find ${MODEL_DIR} -maxdepth 1 -mindepth 1 -type d)
#     do
# 	RUN_NAME=$(basename ${RUN_DIR})
# 	OUTPUT_DIR=${PREDICTIONS_DIR}/${MODEL_NAME}/${RUN_NAME}
# 	mkdir -p ${OUTPUT_DIR}

# 	if [[ ${MODEL_NAME} == 'ape' ]]
# 	then
# 	    echo "Copying ape ${RUN_NAME} model predictions"
# 	    echo "============================================================"
# 	    for SIDE in $(find ${RUN_DIR} -maxdepth 1 -mindepth 1 -type d)
# 	    do
# 		echo "Copying $(basename ${SIDE}) set predictions"
# 		cp -r ${SIDE} ${OUTPUT_DIR}/
# 	    done

# 	elif [[ ${MODEL_NAME} != 'linear' ]]
# 	then
# 	    echo "Predicting with model ${MODEL_NAME}, run ${RUN_NAME}"
# 	    echo "============================================================"
# 	    echo "Generating dev set predictions..."
#  	    DEV_OUT=${OUTPUT_DIR}/dev
# 	    mkdir -p ${DEV_OUT}
# 	    kiwi predict --config ${RUN_DIR}/predict.yaml	\
# 		 --experiment-name "Official run for OpenKiwi"	\
# 		 --load-model ${RUN_DIR}/model.torch		\
# 		 --output-dir ${DEV_OUT}			\
# 		 --gpu-id ${GPU_ID}				\
# 		 --test-source ${WORD_DIR}/dev.src		\
# 		 --test-target ${WORD_DIR}/dev.mt		\
# 		 --quiet

# 	fi
#  	echo ""
# 	echo ""
#     done # RUN_DIR
# done # MODEL_DIR


TARGET_TAGS_DEV=$(find ${PREDICTIONS_DIR} -type f -name 'tags' | sort | grep dev | grep -v linear)

N_FILES=$(echo ${TARGET_TAGS_DEV} | tr ' ' '\n' | wc -l)

# echo "Stacking ${N_FILES} individual model predictions for linear"
# echo "============================================================"
# echo ""

LINEAR_DIR=${SCRIPT_DIR}/linear
LINEAR_OUT_DEV=${PREDICTIONS_DIR}/linear/dev
# echo "print LINEAR_OUT_DEV ${LINEAR_OUT_DEV}"
# echo "Stacking dev set predictions..."
# mkdir -p ${LINEAR_OUT_DEV}
TARGET_STACKED_DEV=${LINEAR_OUT_DEV}/tags.stacked
# python ${STACK} -o ${TARGET_STACKED_DEV} ${TARGET_TAGS_DEV}


# echo ""
# echo ""

echo "Predicting with model linear"
echo "============================================================"
echo "Generating dev set predictions..."
kiwi predict --config ${LINEAR_DIR}/predict.yaml	\
     --experiment-name "Official run for OpenKiwi"	\
     --load-model ${LINEAR_DIR}/model.torch		\
     --output-dir ${LINEAR_OUT_DEV}			\
     --gpu-id ${GPU_ID}					\
     --test-source ${WORD_DIR}/dev.src			\
     --test-target ${WORD_DIR}/dev.mt			\
     --test-alignments ${WORD_DIR}/dev.src-mt.alignments \
     --test-target-stacked ${TARGET_STACKED_DEV}	\
     --test-source-pos ${LINEAR_DIR}/dev.src.pos  \
     --test-target-pos ${LINEAR_DIR}/dev.mt.pos  \
     --test-target-ngram ${LINEAR_DIR}/dev.mt.ngrams  \
     --quiet

# TARGET_GOLD=${WORD_DIR}/dev.tags
# SOURCE_GOLD=${WORD_DIR}/dev.src_tags
# SENTENCE_GOLD=${SENT_DIR}/dev.${TRACK}.hter

# GAP_TAGS_DEV=$(find ${PREDICTIONS_DIR} -type f -name 'gap_tags' | grep dev)
# SOURCE_TAGS_DEV=$(find ${PREDICTIONS_DIR} -type f -name 'source_tags' | grep dev)
# SENTENCE_SCORES_DEV=$(find ${PREDICTIONS_DIR} -type f -name 'sentence_scores' | grep dev)
# echo ""
# echo ""
# echo "==========  Stacked Linear Model (target tags)  =========="
# kiwi evaluate						\
#      --pred-target ${PREDICTIONS_DIR}/linear/dev/tags	\
#      --gold-target ${TARGET_GOLD}			\
#      --format wmt18					\
#      --pred-format wmt17
# echo ""
# echo ""
# echo "==========  Average Ensemble Model (target tags)  =========="
# kiwi evaluate					\
#      --pred-target ${TARGET_TAGS_DEV}		\
#      --gold-target ${TARGET_GOLD}		\
#      --format wmt18				\
#      --pred-format wmt17

# echo ""
# echo ""
# echo "==========  Average Ensemble Model (gap tags)  =========="
# kiwi evaluate					\
#      --pred-gaps ${GAP_TAGS_DEV}		\
#      --gold-target ${TARGET_GOLD}		\
#      --format wmt18				\
#      --pred-format wmt17

# echo ""
# echo ""
# echo "==========  Average Ensemble Model (source tags)  =========="
# kiwi evaluate					\
#      --pred-source ${SOURCE_TAGS_DEV}		\
#      --gold-source ${SOURCE_GOLD}		\
#      --format wmt18				\
#      --pred-format wmt17

# echo ""
# echo ""
# echo "==========  Average Ensemble Model (sentence scores)  =========="
# kiwi evaluate					\
#      --pred-sents ${SENTENCE_SCORES_DEV}	\
#      --gold-sents ${SENTENCE_GOLD}		\
#      --format wmt18				\
#      --pred-format wmt17
