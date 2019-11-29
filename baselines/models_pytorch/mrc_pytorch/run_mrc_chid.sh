#!/usr/bin/env bash

CURRENT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
export MODEL_NAME=roberta_wwm_ext_large
export BERT_DIR=$CURRENT_DIR/prev_trained_model/$MODEL_NAME
export GLUE_DIR=$CURRENT_DIR/../../../glue/chineseGLUEdatasets/
TASK_NAME="CHID"

python run_multichoice_mrc.py \
  --gpu_ids="0,1,2,3" \
  --num_train_epochs=3 \
  --train_batch_size=16 \
  --predict_batch_size=16 \
  --learning_rate=2e-5 \
  --warmup_proportion=0.06 \
  --max_seq_length=64 \
  --vocab_file=$BERT_DIR/vocab.txt \
  --bert_config_file=$BERT_DIR/bert_config.json \
  --init_checkpoint=$BERT_DIR/pytorch_model.pth \
  --model_name=$MODEL_NAME \
  --input_dir=$GLUE_DIR/$TASK_NAME/ \
  --output_dir=$GLUE_DIR/$TASK_NAME/ \
  --train_file=$GLUE_DIR/$TASK_NAME/train.txt \
  --train_ans_file=$GLUE_DIR/$TASK_NAME/train_answer.csv \
  --predict_file=$GLUE_DIR/$TASK_NAME/dev.txt \
  --predict_ans_file=$GLUE_DIR/$TASK_NAME/dev_answer.csv