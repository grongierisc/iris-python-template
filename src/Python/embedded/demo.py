import iris

person = iris.cls('Titanic.Table.Passenger')._OpenId(1)

print(person.__dict__)