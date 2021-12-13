# 1. iris-python-template
Template project with various Python code to be used with InterSystems IRIS community Edition docker container.

Featuring :
 * Notebook 
   * Embedded Python Kernel
   * ObjectScript Kernel
   * Vanilla Python Kernel
 * **Flask** + Embedded Python
 * IRIS Python Native APIs

![Diagram](https://user-images.githubusercontent.com/47849411/145866257-cc88109b-db0b-4fed-8886-fddb4c31947d.png)

# 2. Table of Contents

- [1. iris-python-template](#1-iris-python-template)
- [2. Table of Contents](#2-table-of-contents)
- [3. Installation](#3-installation)
  - [3.1. Docker](#31-docker)
- [4. How to start coding](#4-how-to-start-coding)
  - [4.1. Prerequisites](#41-prerequisites)
    - [4.1.1. Start coding in ObjectScript](#411-start-coding-in-objectscript)
    - [4.1.2. Start coding with Embedded Python](#412-start-coding-with-embedded-python)
    - [4.1.3. Start coding with Notebooks](#413-start-coding-with-notebooks)
- [5. What's inside the repository](#5-whats-inside-the-repository)
  - [5.1. Dockerfile](#51-dockerfile)
  - [5.2. .vscode/settings.json](#52-vscodesettingsjson)
  - [5.3. .vscode/launch.json](#53-vscodelaunchjson)
  - [5.4. .vscode/extensions.json](#54-vscodeextensionsjson)
  - [5.5. src folder](#55-src-folder)
    - [5.5.1. src/ObjectScript](#551-srcobjectscript)
      - [5.5.1.1. src/ObjectScript/Embedded/Python.cls](#5511-srcobjectscriptembeddedpythoncls)
      - [5.5.1.2. src/ObjectScript/Gateway/Python.cls](#5512-srcobjectscriptgatewaypythoncls)
    - [5.5.2. src/Python](#552-srcpython)
      - [5.5.2.1. src/Python/embedded/demo.cls](#5521-srcpythonembeddeddemocls)
      - [5.5.2.2. src/Python/native/demo.cls](#5522-srcpythonnativedemocls)
      - [5.5.2.3. src/Python/flask](#5523-srcpythonflask)
        - [5.5.2.3.1. How it works](#55231-how-it-works)
        - [5.5.2.3.2. Launching the flask server](#55232-launching-the-flask-server)
    - [5.5.3. src/Notebooks](#553-srcnotebooks)
      - [5.5.3.1. src/Notebooks/HelloWorldEmbedded.ipynb](#5531-srcnotebookshelloworldembeddedipynb)
      - [5.5.3.2. src/Notebooks/IrisNative.ipynb](#5532-srcnotebooksirisnativeipynb)
      - [5.5.3.3. src/Notebooks/ObjectScript.ipynb](#5533-srcnotebooksobjectscriptipynb)

# 3. Installation 

## 3.1. Docker
The repo is dockerised so you can  clone/git pull the repo into any local directory

```
$ git clone https://github.com/grongierisc/iris-python-template.git
```

Open the terminal in this directory and run:

```
$ docker-compose up -d
```
and open then http://localhost:8888/tree for Notebooks

Or, open the cloned folder in VSCode, start docker-compose and open the URL via VSCode menu:
<img width="1136" alt="VsCodeNotebooks" src="https://user-images.githubusercontent.com/47849411/145720162-9cb46af8-d780-4719-99ab-ad67a005b271.png">


# 4. How to start coding
## 4.1. Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/), [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.

### 4.1.1. Start coding in ObjectScript
Open /src/ObjectScript/Embedded/Python.cls class and try to make changes - it will be compiled in running IRIS docker container.

### 4.1.2. Start coding with Embedded Python
The easiest way is to run VsCode in the container.

To attach to a Docker container, either select **Remote-Containers: Attach to Running Container...** from the Command Palette (`kbstyle(F1)`) or use the **Remote Explorer** in the Activity Bar and from the **Containers** view, select the **Attach to Container** inline action on the container you want to connect to.

![Containers Explorer screenshot](https://github.com/microsoft/vscode-docs/raw/main/docs/remote/images/containers/containers-attach.png)

Then configure your python interpreter to /usr/irissys/bin/irispython

<img width="1614" alt="PythonInterpreter" src="https://user-images.githubusercontent.com/47849411/145864423-2de24aaa-036c-4beb-bda0-3a73fe15ccbd.png">

### 4.1.3. Start coding with Notebooks
Open this url : http://localhost:8888/tree

Then you have access to three different notebooks with three differents kernels.

 * One Embedded Python kernel
 * One ObjectScript kernel
 * One vanilla python3 kernel 

<img width="1219" alt="Notebooks" src="https://user-images.githubusercontent.com/47849411/145859252-f7324e89-2d68-4cf1-8e9d-e072c28a94cd.png">

# 5. What's inside the repository

## 5.1. Dockerfile

A dockerfile which install some python dependancies (pip, venv) and sudo in the container for conviencies.
Then it create the dev directory and copy in it this git repository.
It starts IRIS and imports Titanics csv files, then it's activate **%Service_CallIn** for **Python Shell**.
Use the related docker-compose.yml to easily setup additional parametes like port number and where you map keys and host folders.
Use .env/ file to adjust the dockerfile being used in docker-compose.


## 5.2. .vscode/settings.json

Settings file to let you immedietly code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript)

## 5.3. .vscode/launch.json
Config file if you want to debug with VSCode ObjectScript

[Read about all the files in this article](https://community.intersystems.com/post/dockerfile-and-friends-or-how-run-and-collaborate-objectscript-projects-intersystems-iris)

## 5.4. .vscode/extensions.json
Recommendation file to add extensions if you want to run with VSCode in the container.

[More information here](https://code.visualstudio.com/docs/remote/containers)

![Archiecture](https://code.visualstudio.com/assets/docs/remote/containers/architecture-containers.png)

This is very useful to work with embedded python.

## 5.5. src folder
This folder is devied in two parts, one for ObjectScript example and one for Python code.

### 5.5.1. src/ObjectScript
Different piece of code that shows how to use python in IRIS.

#### 5.5.1.1. src/ObjectScript/Embedded/Python.cls
All comments are in french to let you impove your French skills too.

```objectscript
/// embedded python example
Class ObjectScript.Embbeded.Python Extends %SwizzleObject
{

/// HelloWorld with a parameter
ClassMethod HelloWorld(name As %String = "toto") As %Boolean [ Language = python ]
{
    print("Hello",name)
    return True
}

/// Description
Method compare(modèle, chaine) As %Status [ Language = python ]
{
    import re

    # compare la chaîne [chaîne] au modèle [modèle]
    # affichage résultats
    print(f"\nRésultats({chaine},{modèle})")
    match = re.match(modèle, chaine)
    if match:
        print(match.groups())
    else:
        print(f"La chaîne [{chaine}] ne correspond pas au modèle [{modèle}]")
}

/// Description
Method compareObjectScript(modèle, chaine) As %Status
{
    w !,"Résultats("_chaine_","_modèle_")",!
    set matcher=##class(%Regex.Matcher).%New(modèle)                             
    set matcher.Text=chaine
    if matcher.Locate() {
        write matcher.GroupGet(1)
    }
    else {
        w "La chaîne ["_chaine_"] ne correspond pas au modèle ["_modèle_"]"
    }
}

/// Description
Method DemoPyhtonToPython() As %Status [ Language = python ]
{
    # expression régulières en python
    # récupérer les différents champs d'une chaîne
    # le modèle : une suite de chiffres entourée de caractères quelconques
    # on ne veut récupérer que la suite de chiffres
    modèle = r"^.*?(\d+).*?$"

    # on confronte la chaîne au modèle
    self.compare(modèle, "xyz1234abcd")
    self.compare(modèle, "12 34")
    self.compare(modèle, "abcd")
}

Method DemoPyhtonToObjectScript() As %Status [ Language = python ]
{
    # expression régulières en python
    # récupérer les différents champs d'une chaîne
    # le modèle : une suite de chiffres entourée de caractères quelconques
    # on ne veut récupérer que la suite de chiffres
    modèle = r"^.*?(\d+).*?$"

    # on confronte la chaîne au modèle
    self.compareObjectScript(modèle, "xyz1234abcd")
    self.compareObjectScript(modèle, "12 34")
    self.compareObjectScript(modèle, "abcd")
}

/// Description
Method DemoObjectScriptToPython() As %Status
{
    // le modèle - une date au format jj/mm/aa
    set modèle = "^\s*(\d\d)\/(\d\d)\/(\d\d)\s*$"
    do ..compare(modèle, "10/05/97")
    do ..compare(modèle, " 04/04/01 ")
    do ..compare(modèle, "5/1/01")
}

}
```

 * HelloWorld
   * Simple function to say Hello in python
   * It uses the ojectscript wrapper with the tag [ Language = python ]
 * compare
   * An python function that compare a string with a regx, if their is a match then print it, if not print that no match has been found
 * compareObjectScript
   * Same function as the python one but in ObjectScript
 * DemoPyhtonToPython
   * Show how to use a python function with python code wrapped in ObjectScript
```
USER>set demo = ##class(ObjectScript.Embbeded.Python).%New()

USER>zw demo.DemoPyhtonToPython()
```
 * DemoPyhtonToObjectScript
   * An python function who show how to call an ObjecScript function
 * DemoObjectScriptToPython
   * An ObjectScript function who show how to call an python function

#### 5.5.1.2. src/ObjectScript/Gateway/Python.cls
An ObjectScript class who show how to call an external phyton code with the gateway functionnality.
In this example python code is **not executed** in the same process of IRIS.

```objectscript
/// Description
Class Gateway.Python
{

/// Demo
ClassMethod Demo() As %Status
{
    Set sc = $$$OK

    set pyGate = $system.external.getPythonGateway()

    d pyGate.addToPath("/irisdev/app/src/Python/gateway/Address.py")

    set objectBase = ##class(%Net.Remote.Object).%New(pyGate,"Address")

    set street = objectBase.street
    
    zw street
    
    Return sc
}

}
```

### 5.5.2. src/Python
Different piece of python code that shows how to use embedded python in IRIS.

#### 5.5.2.1. src/Python/embedded/demo.cls
All comments are in french to let you impove your French skills too.

```python
import iris

person = iris.cls('Titanic.Table.Passenger')._OpenId(1)

print(person.__dict__)
```

First import iris module that enable embedded python capabilities.
Open an persistent class with cls function from iris module.
Note that all `%` function are replaced with `_`.

To run this example you have to use iris python shell :

```shell
/usr/irissys/bin/irispython /opt/irisapp/src/Python/embedded/demo.py
```

#### 5.5.2.2. src/Python/native/demo.cls
Show how to use native api in python code.

```python
import irisnative

# create database connection and IRIS instance
connection = irisnative.createConnection("localhost", 1972, "USER", "superuser", "SYS", sharedmemory = False)
myIris = irisnative.createIris(connection)

# classMethod
passenger = myIris.classMethodObject("Titanic.Table.Passenger","%OpenId",1)
print(passenger.get("name"))

# global
myIris.set("hello","myGlobal")
print(myIris.get("myGlobal"))
```

To import irisnative, you have to install the native api wheels in your python env.

```shell
pip3 install /usr/irissys/dev/python/intersystems_irispython-3.2.0-py3-none-any.whl
```

Then you can run this python code

```shell
/usr/bin/python3 /opt/irisapp/src/Python/native/demo.py
```

Note that in this case a connection is made to iris database, this mean, this code is executed in a different thread than the IRIS one.

#### 5.5.2.3. src/Python/flask

A full demo of the combiantion between embedded python and the micro framework flask.
You can test this end point : 

```
GET http://localhost:4040/api/passengers?currPage=1&pageSize=1
```

##### 5.5.2.3.1. How it works
In order to use embedded Python, we use `irispython` as a python interepreter, and do:
```python
import iris
```
Right at the beginning of the file. 

We will then be able to run methods such as:

![flaskExample](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/flaskExample.png)

As you can see, in order to GET a passenger with an ID, we just execute a query and use its result set. 

We can also directly use the IRIS objects:

![flaskObjectExample](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/flaskObjectExample.png)

Here, we use an SQL query to get all the IDs in the table, and we then retreive each passenger from the table with the `%OpenId()` method from the `Titanic.Table.Passenger` class (note that since `%` is an illegal character in Python, we use `_` instead).

Thanks to Flask, we implement all of our routes and methods that way. 

##### 5.5.2.3.2. Launching the flask server

To launch the server, we use `gunicorn` with `irispython`. 

In the docker-compose file, we add the following line:
````yaml
iris:
  command: -a "sh /opt/irisapp/server_start.sh"
````
That will launch, after the container is started (thanks to the `-a` flag), the following script:
````bash
#!/bin/bash

cd ${SRC_PATH}/src/Python/flask

${PYTHON_PATH} -m gunicorn --bind "0.0.0.0:8080" wsgi:app &

exit 1
````
With the environment variables defined in the Dockerfile as follows:
````dockerfile
ENV PYTHON_PATH=/usr/irissys/bin/irispython
ENV SRC_PATH=/opt/irisapp/
````

### 5.5.3. src/Notebooks
Three notebooks with three different kernels :

 * One python3 kernel to run native api
 * One embedded python kernel
 * One ObjectScript kernel

Notebooks can be access here http://localhost:8888/tree

<img width="1219" alt="Notebooks" src="https://user-images.githubusercontent.com/47849411/145859252-f7324e89-2d68-4cf1-8e9d-e072c28a94cd.png">

#### 5.5.3.1. src/Notebooks/HelloWorldEmbedded.ipynb
This notebook uses IRIS embedded python kernel.

It shows example to open and save persistent classes and how to run sql queries.

#### 5.5.3.2. src/Notebooks/IrisNative.ipynb
This notebook uses vanilla python kernel.

It shows example run iris native apis.

#### 5.5.3.3. src/Notebooks/ObjectScript.ipynb
This notebook uses ObjectScript kernel.

It shows example to run ObjectSCript code and how to use embedded pythoon in ObjectScript.

