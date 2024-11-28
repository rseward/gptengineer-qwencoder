FROM nvidia/cuda:12.4.1-devel-ubuntu22.04

## Add your own requirements.txt if desired and uncomment the two lines below
COPY ./requirements.txt .

RUN mkdir /workspace; mkdir /models/; \
    apt-get update && \
    apt-get -y install software-properties-common build-essential ninja-build python3 python3-pip && \
    pip install -r requirements.txt

WORKDIR /workspace

#Install llama-cpp-python with CUDA Support (and jupyterlab)
RUN CUDACXX=/usr/local/cuda/bin/nvcc CMAKE_ARGS="-DGGML_CUDA=on -DCMAKE_CUDA_ARCHITECTURES=all-major" FORCE_CMAKE=1 \
    pip install 'llama-cpp-python[server]' --no-cache-dir --force-reinstall --upgrade ;

COPY rtd-run.sh /workspace


CMD [ "/workspace/rtd-run.sh" ]
