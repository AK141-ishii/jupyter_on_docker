FROM ubuntu:latest
MAINTAINER AK141

ARG USER="ak141"
ARG UID="1000"
ARG GID="1000"
ARG PASS="asyoulike"

USER root

# Configure env
ENV CONDA_DIR=/opt/conda \
    SHELL=/bin/bash \
    USER=${USER}\
    UID=${UID} \
    GID=${GID} \
    LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=${CONDA_DIR}/bin:${PATH} \
    HOME=/home/${USER}

RUN set -x && \
# General Install
    apt update -y && apt upgrade -y && \
    apt install -y \
    sudo \
    wget \
    unzip \
    git \
    vim \
    build-essential \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* && \
# Create user
    groupadd ${USER} -g ${GID} && \
    useradd -m -s /bin/bash -N -u ${UID} -g ${GID} ${USER} && \
    echo "${USER}   ALL=(ALL)   ALL" >> /etc/sudoers && \
    echo "${USER}:${PASS}" |chpasswd && \
# Install Anaconda3
    touch ~/anaconda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-5.3.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    ${SHELL} ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
# Setting Jupyter
    conda update conda -y && \
    conda install -y \
    nodejs \
    && conda update --all -y \
    && jupyter labextension install jupyterlab_vim \
    && mkdir -p /home/ak141/.jupyter/lab/user-settings/@jupyterlab/apputils-extension \
    && echo '{"theme":"JupyterLab Dark"}' > /home/ak141/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings \
# Install Library
    && conda install -y pystan \
    && pip install flake8 optuna graphviz xgboost lightgbm

RUN chmod 731 /home/${USER}/.config
EXPOSE 8888:8888

USER ${USER}
WORKDIR /home/ak141

CMD ["jupyter-lab","--no-browser","--port=8888","--ip=0.0.0.0","--allow-root"]
