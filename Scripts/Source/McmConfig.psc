scriptName McmConfig hidden
{Interface for getting and setting configuration variables for McmConfig.}

string function GetString(string mod, string name) global
    return JMap.getStr(GetModValueMap(mod), name)
endFunction

function SetString(string mod, string name, string value) global
    JMap.setStr(GetModValueMap(mod), name, value)
endFunction

int function GetModDataStructure(string mod) global
    string modPath = ".mcmConfig." + mod
    int modData = JDB.solveObj(modPath)
    if ! modData
        modData = JMap.object()
        JDB.solveObjSetter(modPath, modData, createMissingKeys = true)
        JMap.setObj(modData, "pageFileNames", JMap.object())
        JMap.setObj(modData, "values", JMap.object())
        JMap.setObj(modData, "options", JIntMap.object())
    endIf
    return modData
endFunction

int function GetModValueMap(string mod) global
    return JMap.getObj(GetModDataStructure(mod), "values")
endFunction

int function GetModOptionMap(string mod) global
    return JMap.getObj(GetModDataStructure(mod), "options")
endFunction

function AddPageFileName(string mod, string pageName, string filePath) global
    int pageFilenames = JMap.getObj(GetModDataStructure(mod), "pageFileNames")
    JMap.setStr(pageFileNames, pageName, filePath)
endFunction

string function GetPageFileName(string mod, string pageName) global
    int pageFilenames = JMap.getObj(GetModDataStructure(mod), "pageFileNames")
    JValue.writeToFile(GetModDataStructure(mod), "WhyIsntItWorking.json")
    return JMap.getStr(pageFileNames, pageName)
endFunction
