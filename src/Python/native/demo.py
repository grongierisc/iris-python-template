import iris

# Modify connection info based on your environment
host = "localhost"
port = 1972
namespace = "USER"
username = "_SYSTEM"
password = "SYS"

# create database connection and IRIS instance
connection = iris.createConnection("localhost", 1972, "USER", "superuser", "SYS", sharedmemory = False)
irisObject = iris.createIris(connection)
