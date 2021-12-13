# iris-python-template
Template project in Python with InterSystems IRIS community Edition docker container 

# Installation 

## Docker
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


# How to start coding
## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

This repository is ready to code in VSCode with ObjectScript plugin.
Install [VSCode](https://code.visualstudio.com/), [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) and [ObjectScript](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript) plugin and open the folder in VSCode.

### Start coding in ObjectScript
Open /src/ObjectScript/Embedded/Python.cls class and try to make changes - it will be compiled in running IRIS docker container.

### Start coding with Embedded Python
The easiest 

### Start coding with Notebooks
Open this url : http://localhost:8888/tree

Then you have access to three different notebooks with three differents kernels.

 * One Embedded Python kernel
 * One ObjectScript kernel
 * One vanilla python3 kernel 

<img width="1219" alt="Notebooks" src="https://user-images.githubusercontent.com/47849411/145859252-f7324e89-2d68-4cf1-8e9d-e072c28a94cd.png">

# What's inside the repository

## Dockerfile

A dockerfile which install some python dependancies (pip, venv) and sudo in the container for conviencies.
Then it create the dev directory and copy in it this git repository.
It starts IRIS and imports Titanics csv files, then it's activate **%Service_CallIn** for **Python Shell**.
Use the related docker-compose.yml to easily setup additional parametes like port number and where you map keys and host folders.
Use .env/ file to adjust the dockerfile being used in docker-compose.


## .vscode/settings.json

Settings file to let you immedietly code in VSCode with [VSCode ObjectScript plugin](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript))

## .vscode/launch.json
Config file if you want to debug with VSCode ObjectScript

[Read about all the files in this article](https://community.intersystems.com/post/dockerfile-and-friends-or-how-run-and-collaborate-objectscript-projects-intersystems-iris)

## .vscode/extensions.json
Recommenadation file to add extensions if you want to run with VSCode in the container.

[More information here](https://code.visualstudio.com/docs/remote/containers)

![Archiecture](https://code.visualstudio.com/assets/docs/remote/containers/architecture-containers.png)

This is very useful to work with embedded python.

## src folder
This folder is devied in two parts, one for ObjectScript example and one for Python code.

### src/ObjectScript
Different piece of code that shows how to use python in IRIS.

#### src/ObjectScript/Embedded/Python.cls
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

#### src/ObjectScript/Gateway/Python.cls
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

### src/Python
Different piece of python code that shows how to use embedded python in IRIS.

#### src/Python/embedded/demo.cls
All comments are in french to let you impove your French skills too.

```python
import iris

person = iris.cls('Titanic.Table.Passenger')._OpenId(1)

print(person.__dict__)
```

First import iris module that enable embedded python capabilities.
Open an persistent class with cls function from iris module.
Note that all "%" function are replaced with "_".

To run this example you have to use iris python shell :

```shell
/usr/irissys/bin/irispython /opt/irisapp/src/Python/embedded/demo.py
```

#### src/Python/native/demo.cls
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

#### src/Python/flask

A full demo of the combiantion between embedded python and the micro framework flask.
You can test this end point : 

```
GET http://localhost:4040/api/passengers?currPage=1&pageSize=1
```

#### src/Python/notebooks
Three notebooks with three different kernels :

 * One python3 kernel to run native api
 * One embedded python kernel
 * One ObjectScript kernel

Notebooks can be access here http://localhost:8888/tree

<img width="1219" alt="Notebooks" src="https://user-images.githubusercontent.com/47849411/145859252-f7324e89-2d68-4cf1-8e9d-e072c28a94cd.png">

#### src/Python/notebooks/HelloWorldEmbedded.ipynb
This notebook uses IRIS embedded python kernel.

It shows example to open and save persistent classes and how to run sql queries.

#### src/Python/notebooks/IrisNative.ipynb
This notebook uses vanilla python kernel.

It shows example run iris native apis.

#### src/Python/notebooks/ObjectScript.ipynb
This notebook uses ObjectScript kernel.

It shows example to run ObjectSCript code and how to use embedded pythoon in ObjectScript.

