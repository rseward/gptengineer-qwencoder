build:
	podman build . -t llama_cpp

run:
	# --gpus all
	podman run -p=8000:8000 --device nvidia.com/gpu=all --security-opt=label=disable -v ./models:/models localhost/llama_cpp 

fetchmodels:	fetchqwen fetch_llamacode
	ls models/*.gguf | wc -l

fetchqwen:	models/Qwen2.5-Coder-7B-Instruct-Q6_K.gguf
	ls models/ | grep Qwen

models/Qwen2.5-Coder-7B-Instruct-Q6_K.gguf:
	wget https://huggingface.co/bartowski/Qwen2.5-Coder-7B-Instruct-GGUF/resolve/main/Qwen2.5-Coder-7B-Instruct-Q6_K.gguf
	mv *.gguf models/

fetch_llamacode:	models/codellama-13b.Q6_K.gguf
	ls models/ | grep codellama

models/codellama-13b.Q6_K.gguf:
	wget https://huggingface.co/TheBloke/CodeLlama-13B-GGUF/resolve/main/codellama-13b.Q6_K.gguf
	mv *.gguf models/
