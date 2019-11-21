#!/usr/bin/env bash

# you should first install virtualenv like `pip install --user virtualenv`

virtualenv --no-site-packages ../env
source ../env/bin/activate
pip3 install -r ../requirements.txt
deactivate
