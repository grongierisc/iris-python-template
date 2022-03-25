#!/bin/bash

set -m

/iris-main "$@" &

/usr/irissys/dev/Cloud/ICM/waitISC.sh

cd ${SRC_PATH}/src/Python/flask

${PYTHON_PATH} -m gunicorn --bind "0.0.0.0:8080" wsgi:app &

/home/irisowner/.local/bin/jupyter-notebook --no-browser --port=8888 --ip 0.0.0.0 --notebook-dir=/irisdev/app/src/Notebooks --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.disable_check_xsrf=True &

fg %1