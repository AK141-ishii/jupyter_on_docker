FROM jupyter/tensorflow-notebook

USER root

RUN apt update -y && apt upgrade -y && \
    apt install -y \
    vim \
    build-essential

USER ${NB_USER}

RUN conda update conda \
    && conda install -y \
    pystan \
    flake8 \
    lightgbm \
    pytest \
    && conda update --all -y

RUN jupyter labextension install jupyterlab_vim \
    && mkdir -p /home/${NB_USER}/.jupyter/lab/user-settings/@jupyterlab/apputils-extension \
    && echo '{"theme":"JupyterLab Dark"}' > /home/${NB_USER}/.jupyter/lab/user-settings/@jupyterlab/apputils-extension/themes.jupyterlab-settings

RUN mkdir ./setting
COPY setting ./setting
RUN chmod +x ~/setting \
    && bash ~/setting/adapt.sh

CMD ["jupyter-lab", "--no-browser","--port=8888","--ip=0.0.0.0","--allow-root"]