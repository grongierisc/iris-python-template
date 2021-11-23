/// embedded python example
Class ObjectScript.Python
{

/// HelloWorld
ClassMethod HelloWorld(name As %String) As %Boolean [ Language = python ]
{
    print("Hello "+name)
    return True
}

}
