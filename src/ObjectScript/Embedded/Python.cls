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
