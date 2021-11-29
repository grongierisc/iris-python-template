/// embedded python example
Class ObjectScript.Embbeded.Python
{

/// HelloWorld with a parameter
ClassMethod HelloWorld(name As %String) As %Boolean [ Language = python ]
{
    print("Hello "+name)
    return True
}

}
