ARG IMAGE=arti.iscinternal.com/intersystems/iris:2021.1.0PYTHON.336.0

FROM $IMAGE
# copy files
COPY key/iris.key /usr/irissys/mgr/iris.key

USER root

# Update package and install sudo
RUN apt-get update && apt-get install -y \
	nano \
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
ENV PIP_PATH=/usr/irissys/bin/irispip
ENV PYTHON_SRC_PATH=/opt/irisapp/src/Python
ENV IRISUSERNAME "SuperUser"
ENV IRISPASSWORD "SYS"
ENV PATH "/usr/irissys/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/irisowner/bin"

RUN ${PIP_PATH} install -r ${PYTHON_SRC_PATH}/requirements.txt

# Create embbede python kernel
COPY src/Python/kernel.json /usr/irissys/lib/python3.9/site-packages/IPython/kernel/kernel.json

# Durty hack to support sqlite3
RUN cp /usr/lib/python3.6/lib-dynload/_sqlite3.cpython-36m-x86_64-linux-gnu.so /usr/irissys/lib/python3.9/lib-dynload/_sqlite3.cpython-39-x86_64-linux-gnu.so