#!/usr/bin/env bash
projDir=`git rev-parse --show-toplevel`
# you should first install virtualenv like `pip install --user virtualenv`

virtualenv --no-site-packages $projDir/env
source $projDir/env/bin/activate
pip3 install -r $projDir/requirements.txt
deactivate
