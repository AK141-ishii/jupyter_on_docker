#!/bin/bash

HOME_PATH=/home/${NB_USER}
SETTING_PATH=${HOME_PATH}/setting

# bash
cp ${SETTING_PATH}/bashrc ${HOME_PATH}/.bashrc
cp ${SETTING_PATH}/bash_aliases ${HOME_PATH}/.bash_aliases
# vim
cp ${SETTING_PATH}/vimrc ${HOME_PATH}/.vimrc
cp -r ${SETTING_PATH}/vim ${HOME_PATH}/.vim
# git
cp -r ${SETTING_PATH}/gitplugin ${HOME_PATH}/.gitplugin
