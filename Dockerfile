FROM nvcr.io/nvidia/cuda:11.3.0-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y software-properties-common tzdata wget
ENV TZ=Asia/Tokyo
RUN apt-get update && apt-get install -y language-pack-ja && \
    update-locale LANG=ja_JP.UTF-8 && rm -rf /var/lib/apt/lists/*
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

ARG USER=user
ARG GROUP=app
ARG UID=1000
ARG GID=1000
ENV PATH ${PATH}:/home/${USER}/.local/bin
RUN groupadd -g ${GID} -o ${GROUP} \
    &&  useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USER}

WORKDIR /home/${USER}/DiffusionPO/

# ppa for python
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get -y install python3-dev python3-venv python3-distutils python3-pip python-is-python3

RUN python3 -m pip install torch torchvision torchaudio

COPY requirements.txt /home/${USER}/DiffusionPO/
RUN python3 -m pip install -r requirements.txt

USER ${USER}