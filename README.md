# jupyter_on_docker
dockerfile for "jupyter_on_docker"

## IMAGE DETAILS

base : jupyter/tensorflow-notebook

+ apt
vim, build-essential

+ conda
pystan, flake8, lightgbm, pytest

+ JupyterLab Extension
jupyterlab_vim, theme:JupyterLab Dark

+ some settings
bashrc, vim, gitconfig
