ARG IMAGE=arti.iscinternal.com/intersystems/iris:2022.1.0PYNEW.107.0
#ARG IMAGE=arti.iscinternal.com/intersystems/iris-community:2021.2.0.611.0

FROM $IMAGE
# copy files
COPY key/iris.key /usr/irissys/mgr/iris.key

USER root

# Update package and install sudo
RUN apt-get update && apt-get install -y \
	nano \
	python3-pip \
	python3-venv \
	sudo && \
	/bin/echo -e ${ISC_PACKAGE_MGRUSER}\\tALL=\(ALL\)\\tNOPASSWD: ALL >> /etc/sudoers && \
	sudo -u ${ISC_PACKAGE_MGRUSER} sudo echo enabled passwordless sudo-ing for ${ISC_PACKAGE_MGRUSER}

WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp
USER ${ISC_PACKAGE_MGRUSER}

# Copy source files to image
COPY . /opt/irisapp

# load demo stuff
RUN iris start IRIS \
	&& iris session IRIS < /opt/irisapp/iris.script && iris stop IRIS quietly

# create Python env
ENV PYTHON_PATH=/usr/irissys/bin/irispython
ENV SRC_PATH=/opt/irisapp
ENV IRISUSERNAME "SuperUser"
ENV IRISPASSWORD "SYS"
#ENV PATH "/usr/irissys/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/irisowner/bin"

# Requirement for embedded python
RUN ${PYTHON_PATH} -m pip install -r ${SRC_PATH}/src/Python/requirements.txt

# Install Native API
COPY misc/intersystems_irispython-3.2.0-py3-none-any.whl /usr/irissys/dev/python/intersystems_irispython-3.2.0-py3-none-any.whl
RUN pip3 install /usr/irissys/dev/python/intersystems_irispython-3.2.0-py3-none-any.whl

# Install Jupyter 
RUN pip3 install jupyter
# install irispython kernel
RUN /usr/irissys/bin/irispip install ipykernel
RUN mkdir /home/irisowner/.local/share/jupyter/kernels/irispython
COPY misc/kernels/irispython/* /home/irisowner/.local/share/jupyter/kernels/irispython/
# install objectscript kernel
RUN mkdir /home/irisowner/.local/share/jupyter/kernels/objectscript
COPY misc/kernels/objectscript/* /home/irisowner/.local/share/jupyter/kernels/objectscript/

# Durty hack to support sqlite3
# RUN cp /usr/lib/python3.6/lib-dynload/_sqlite3.cpython-36m-x86_64-linux-gnu.so /usr/irissys/lib/python3.9/lib-dynload/_sqlite3.cpython-39-x86_64-linux-gnu.so