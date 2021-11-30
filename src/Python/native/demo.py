import irisnative

# Modify connection info based on your environment
host = "localhost"
port = 1972
namespace = "USER"
username = "_SYSTEM"
password = "SYS"

# create database connection and IRIS instance
connection = irisnative.createConnection("localhost", 1972, "USER", "superuser", "SYS", sharedmemory = False)
myIris = irisnative.createIris(connection)

# classMethod
passenger = myIris.classMethodObject("Titanic.Table.Passenger","%OpenId",1)
print(passenger.get("name"))

# global
myIris.set("hello","myGlobal")
print(myIris.get("myGlobal"))
