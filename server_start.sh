#!/bin/bash

cd ${SRC_PATH}/src/Python/flask

${PYTHON_PATH} -m gunicorn --bind "0.0.0.0:8080" wsgi:app 2>&1

/home/irisowner/.local/bin/jupyter-notebook --no-browser --port=8888 --ip 0.0.0.0 --notebook-dir=/irisdev/app/src/Python/notebooks --NotebookApp.token='' --NotebookApp.password='' &

exit 1