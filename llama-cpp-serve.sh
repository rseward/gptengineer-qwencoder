#!/bin/bash

export LD_LIBRARY_PATH=/usr/local/cuda-12/lib64/

#python -m llama_cpp.server --model $HOME/codellama-13b.Q8_0.gguf --n_gpu_layers 1
set -x
#MODEL=/models/codellama-13b.Q6_K.gguf 
MODEL=/models/Qwen2.5-Coder-7B-Instruct-Q6_K.gguf
#python3 -m llama_cpp.server --model $MODEL --host 0.0.0.0 --port 8000 --n_gpu_layers=40
python3 -m llama_cpp.server --config_file /models/models.json --model $MODEL --host 0.0.0.0 --port 8000 --n_gpu_layers=40

