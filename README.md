# gptengineer-qwencoder

GPU Enabled llama-cpp-server container suitable for integration with gpt-engineer project

## Goal

Boot strap a GPU enabled docker container to run llama-cpp[server] suitable to host
the Qwen2.5-Coder model.

The gpt-engineer project is an early attempt of an GenAI project to auto generate code for simple projects. The project provides OpenAI
support out of the box. It also allows integration with open models as well. However the project's documentation is critical of
the CodeLlama model they developed against a year ago.

This project attempts to create a Docker (podman) container for hosting the newly released Qwen2.5-Coder model.

My experiments with this integration is reasonabley successful. I should note, I do not have an OpenAI account to compare the Qwen2.5-Coder
model against. But the four or so simple projects I have created so far, have produced code projects that are more or less ready to run.

No doubt OpenAI, Claude, Anthropic models are better. But if your primary goal is to use a local model, because you don't want:
1) the expense of cloud hosted models
2) or require the privacy of a local model
3) or would prefer the flexibility to experiement with a newly released model.

This project may be of value to you.

## How to use

This project leverages the nvidia-container-toolkit to enable CUDA / GPU support within the container.

- https://docs.nvidia.com/ai-enterprise/deployment/rhel-with-kvm/latest/podman.html

Install your nvidia GPU drivers and the nividia-container-toolkit on your host machine to use this project. On Fedora I use podman rather than docker. In theory either should work, but the specifics will vary slightly.

On Fedora I installed the following dnf packages:

```
dnf install nvidia-container-toolkit
```

Once you have installed:
- GNU make
- podman
- host OS nvidia GPU drivers
- nvidia-container-toolkit

You can execute the following commands:

### Fetchmodels

This step will fetch the gguf models used by llama-cpp.server to provide the LLM models to an OpenAI compatible interface.

```
make fetchmodels
```

### Build the container

This step will build the container to host the llama-cpp.server process within.

```
make build
```

### Run the container

This step will run the container built above to serve up the downloaded models.

```
make run
```

### Run gpt-engineer tests.

See the gpt-engineer llama integration notes found here:
- https://github.com/gpt-engineer-org/gpt-engineer/tree/main/docs/examples/open_llms

#### Copy and modify the myenv.example file to myenv

```
cp myenv.example myenv
edit myenv
source myenv
```

The myenv will look something like this:
```
export OPENAI_API_BASE="http://127.0.0.1:8000/v1"
export OPENAI_API_KEY="sk-xxx"
export MODEL_NAME="Qwen2.5-Coder"
```

#### Checkout the gpt-engineer project

- https://github.com/gpt-engineer-org/gpt-engineer/


Ensure the variables from the step above are set in your shell

```
git clone gpt-engineer

source myenv
cd gpt-engineer/docs

python examples/open_llms/openai_api_interface.py
python examples/open_llms/langchain_interface.py
```

With the QWEN model set, the two commands above return reasonable results in a reasonable amount of time.

However using the original LlamaCode model, the two gpt-engineer tests produce less than useful output and can take some time to run.
It is interesting to see this run if only to understand the gpt-engineer project's critism for local models.

I have found the QWEN model reasonable to work with in the context of gpt-engineer, but keep in mind I don't have an OpenAI key able to
support gpt-engineer. Perhaps in the future when the models reach a free tier of usage? In the meantime QWEN is fun to play with.

## How to extend

If you would like to experiment with other models. Add an entry to the models/models.json file. If there is a publicly available URL to obtain the .gguf
model file. Add a Makefile target for the model to download it. Or just copy the .gguf to the models directory.

If those steps were done correctly, your new model should available for use.

## Follow Up

If you found this project useful to you, I would appreciate a star on github to guage interest in the project.

Pull requests to the project are welcomed. There may be sub-optimal aspects to this project that could be improved. But hopefully it is a useful
starting point for using gpt-engineer with a local llama model.

## Author

rseward_at_bluestone-consulting.com

