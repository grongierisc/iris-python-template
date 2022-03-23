# 1. iris-python-template
Template project with various python code examples to be used with the InterSystems IRIS Community Edition docker container.

Featuring :
 * Notebooks 
   * Embedded Python Kernel
   * ObjectScript Kernel
   * Vanilla Python Kernel
 * Embedded Python
   * Code example
   * Flask demo
 * IRIS Python Native APIs
   * Code example

Architecture of the container:
![Diagram](https://user-images.githubusercontent.com/47849411/145866257-cc88109b-db0b-4fed-8886-fddb4c31947d.png)

# 2. Table of Contents

- [1. iris-python-template](#1-iris-python-template)
- [2. Table of Contents](#2-table-of-contents)
- [3. Installation](#3-installation)
- [4. How to start coding](#4-how-to-start-coding)
  - [4.1. Prerequisites](#41-prerequisites)
    - [4.1.1. Start coding in ObjectScript](#411-start-coding-in-objectscript)
    - [4.1.2. Start coding with Embedded Python](#412-start-coding-with-embedded-python)
    - [4.1.3. Start coding with Jupyter Notebooks in a web browser](#413-start-coding-with-jupyter-notebooks-in-a-web-browser)
    - [4.1.4. Start coding with VS Code's native notebook UI](#414-start-coding-with-vs-codes-native-notebook-ui)
- [5. What's inside the repository](#5-whats-inside-the-repository)
  - [5.1. Dockerfile](#51-dockerfile)
  - [5.2. .devcontainer/devcontainer.json](#52-vscodesettingsjson)
  - [5.3. .vscode/settings.json](#53-vscodesettingsjson)
  - [5.4. .vscode/launch.json](#54-vscodelaunchjson)
  - [5.5. .vscode/extensions.json](#55-vscodeextensionsjson)
  - [5.6. src folder](#56-src-folder)
    - [5.6.1. src/ObjectScript](#561-srcobjectscript)
      - [5.6.1.1. src/ObjectScript/Embedded/Python.cls](#5611-srcobjectscriptembeddedpythoncls)
      - [5.6.1.2. src/ObjectScript/Gateway/Python.cls](#5612-srcobjectscriptgatewaypythoncls)
    - [5.6.2. src/Python](#562-srcpython)
      - [5.6.2.1. src/Python/embedded/demo.cls](#5621-srcpythonembeddeddemocls)
      - [5.6.2.2. src/Python/native/demo.cls](#5622-srcpythonnativedemocls)
      - [5.6.2.3. src/Python/flask](#5623-srcpythonflask)
        - [5.6.2.3.1. How it works](#56231-how-it-works)
        - [5.6.2.3.2. Launching the flask server](#56232-launching-the-flask-server)
    - [5.6.3. src/Notebooks](#563-srcnotebooks)
      - [5.6.3.1. src/Notebooks/HelloWorldEmbedded.ipynb](#5631-srcnotebookshelloworldembeddedipynb)
      - [5.6.3.2. src/Notebooks/IrisNative.ipynb](#5632-srcnotebooksirisnativeipynb)
      - [5.6.3.3. src/Notebooks/ObjectScript.ipynb](#5633-srcnotebooksobjectscriptipynb)

# 3. Installation 

Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker Desktop](https://www.docker.com/products/docker-desktop) installed.

The git repo is dockerised so you can clone/pull it into any local directory:

```
git clone https://github.com/grongierisc/iris-python-template.git
```

To verify the installation, open a  terminal in `iris-python-template` directory this creates, and start the container by running:

```
docker-compose up -d
```

Open http://localhost:8888/tree to work in Jupyter Notebooks using a web browser.

Stop the container by running:

```
docker-compose down
```

# 4. Using VS Code

This repository is ready for [VS Code](https://code.visualstudio.com/).

Open the locally-cloned `iris-python-template` folder in VS Code.

If prompted (bottom right corner), install the recommended extensions.

When prompted, reopen the folder inside the container so you will be able to use the python components within it. The first time you do this it may take several minutes while the container is readied.

### 4.1.1. Start coding in ObjectScript

Open `/src/ObjectScript/Embedded/Python.cls` make changes and save. The class will be compiled in IRIS in the container.

### 4.1.2. Start coding with Embedded Python

By opening the folder remote you enable VS Code and any terminals you open within it to use the python components within the container. Configure these to use `/usr/irissys/bin/irispython`

<img width="1614" alt="PythonInterpreter" src="https://user-images.githubusercontent.com/47849411/145864423-2de24aaa-036c-4beb-bda0-3a73fe15ccbd.png">

### 4.1.3. Start coding with Jupyter Notebooks in a web browser
Open this URL from a browser: http://localhost:8888/tree

Or open it via the quickpick which appears when you click on the IRIS connection panel in the status bar:
<img width="1136" alt="VsCodeNotebooks" src="https://user-images.githubusercontent.com/47849411/145720162-9cb46af8-d780-4719-99ab-ad67a005b271.png">

Then you have access to three different notebooks, each using a different kernel.

 * Embedded Python kernel
 * ObjectScript kernel
 * Vanilla python3 kernel 

<img width="1219" alt="Notebooks" src="https://user-images.githubusercontent.com/47849411/145859252-f7324e89-2d68-4cf1-8e9d-e072c28a94cd.png">

### 4.1.4. Start coding with VS Code's native notebook UI

VS Code offers [native support for notebooks](https://code.visualstudio.com/docs/datascience/jupyter-notebooks#_create-or-open-a-jupyter-notebook), including Jupyter notebooks.

Open any of the `.ipynb` notebook files in the `src\Notebooks` folder in the Explorer panel.

# 5. What's inside the repository

## 5.1. Dockerfile

A dockerfile which install some python dependencies (pip, venv) and sudo into the container for convenience. Then it create the dev directory and copies into it this git repository.

It starts IRIS and imports the Titanic passenger list csv file, then it activates **%Service_CallIn** for **Python Shell**. Use the related docker-compose.yml to easily set up additional parameters like port number and where you map keys and host folders.

This dockerfile ends with the installation of requirements for python modules.

The last part is about installing jupyter notebook and its kernels.

Use .env/ file to adjust the dockerfile being used in docker-compose.

## 5.2. .devcontainer/devcontainer.json

File enabling VS Code to open the workspace remotely inside the container.

[More information here](https://code.visualstudio.com/docs/remote/containers)

![Architecture](https://code.visualstudio.com/assets/docs/remote/containers/architecture-containers.png)

This is very useful to work with IRIS Embedded Python.

## 5.3. .vscode/settings.json

Settings file to let you immediately code in VS Code with the [VS Code ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=intersystems-community.vscode-objectscript)

## 5.4. .vscode/launch.json
Config file if you want to debug with VS Code ObjectScript

[Read about all the files in this article](https://community.intersystems.com/post/dockerfile-and-friends-or-how-run-and-collaborate-objectscript-projects-intersystems-iris)

## 5.5. .vscode/extensions.json
Recommendation file to add extensions if you want to work with VS Code.

## 5.6. src folder
This folder is devied in two parts, one for ObjectScript example and one for python code.

### 5.6.1. src/ObjectScript
Different piece of code that shows how to use python in IRIS.

#### 5.6.1.1. src/ObjectScript/Embedded/Python.cls
Some comments are in French to let you improve your French skills too.

```objectscript
/// Embedded python example
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
Method DemoPythonToPython() As %Status [ Language = python ]
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

Method DemoPythonToObjectScript() As %Status [ Language = python ]
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
   * It uses the OjectScript wrapper with the tag [ Language = python ]
 * compare
   * An python function that compare a string with a regx, if their is a match then print it, if not print that no match has been found
 * compareObjectScript
   * Same function as the python one but in ObjectScript
 * DemoPythonToPython
   * Show how to use a python function with python code wrapped in ObjectScript
```objectscript
set demo = ##class(ObjectScript.Embbeded.Python).%New()

zw demo.DemoPythonToPython()
```
 * DemoPythonToObjectScript
   * An python function who show how to call an ObjecScript function
 * DemoObjectScriptToPython
   * An ObjectScript function who show how to call an python function

#### 5.6.1.2. src/ObjectScript/Gateway/Python.cls
An ObjectScript class who show how to call an external phyton code with the gateway functionnality.

In this example python code is **not executed** in the same process of IRIS.

```objectscript
/// Description
Class Gateway.Python
{

/// Demo of a python gateway to execute python code outside of an iris process.
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

### 5.6.2. src/Python
Different piece of python code that shows how to use IRIS Embedded Python.

#### 5.6.2.1. src/Python/embedded/demo.cls
Some comments are in French to let you impove your French skills too.

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

#### 5.6.2.2. src/Python/native/demo.cls
Show how to use native API in python code.

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

Note that in this case a connection is made to iris database, this mean, **this code is executed in a different thread than the IRIS one**.

#### 5.6.2.3. src/Python/flask

A full demo of the combination between IRIS Embedded Python and the micro framework flask. You can test this end point : 

```
GET http://localhost:4040/api/passengers?currPage=1&pageSize=1
```

##### 5.6.2.3.1. How it works
In order to use Embedded Python, we use `irispython` as a python interpreter, and do:
```python
import iris
```
Right at the beginning of the file. 

We will then be able to run methods such as:

![flaskExample](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/flaskExample.png)

As you can see, in order to GET a passenger with an ID, we just execute a query and use its result set. 

We can also directly use the IRIS objects:

![flaskObjectExample](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/flaskObjectExample.png)

Here, we use an SQL query to get all the IDs in the table, and we then retreive each passenger from the table with the `%OpenId()` method from the `Titanic.Table.Passenger` class (note that since `%` is an illegal character in python, we use `_` instead).

Thanks to Flask, we implement all of our routes and methods that way. 

##### 5.6.2.3.2. Launching the flask server

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

### 5.6.3. src/Notebooks
Three notebooks with three different kernels :

 * One Python3 kernel to run native APIs
 * One Embedded Python kernel
 * One ObjectScript kernel

Notebooks can be access here http://localhost:8888/tree or directly from VS Code's Explorer view.

<img width="1219" alt="Notebooks" src="https://user-images.githubusercontent.com/47849411/145859252-f7324e89-2d68-4cf1-8e9d-e072c28a94cd.png">

#### 5.6.3.1. src/Notebooks/HelloWorldEmbedded.ipynb
This notebook uses an IRIS Embedded Python kernel.

It shows example to open and save persistent classes and how to run SQL queries.

#### 5.6.3.2. src/Notebooks/IrisNative.ipynb
This notebook uses a vanilla python kernel.

It shows example run iris native apis.

#### 5.6.3.3. src/Notebooks/ObjectScript.ipynb
This notebook uses an ObjectScript kernel.

It shows example to run ObjectScript code and how to use Embedded Pythoon in ObjectScript.
