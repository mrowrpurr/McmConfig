scriptName McmConfig hidden
{Interface for getting and setting configuration variables for McmConfig.}

string function GetString(string mod, string name) global
    return JMap.getStr(GetModValueMap(mod), name)
endFunction

function SetString(string mod, string name, string value) global
    JMap.setStr(GetModValueMap(mod), name, value)
endFunction

int function GetInt(string mod, string name) global
    return JMap.getInt(GetModValueMap(mod), name)
endFunction

function SetInt(string mod, string name, int value) global
    JMap.setInt(GetModValueMap(mod), name, value)
endFunction

float function GetFloat(string mod, string name) global
    return JMap.getFlt(GetModValueMap(mod), name)
endFunction

function SetFloat(string mod, string name, float value) global
    JMap.setFlt(GetModValueMap(mod), name, value)
endFunction

bool function GetBool(string mod, string name) global
    return JMap.getInt(GetModValueMap(mod), name) == 1
endFunction

function SetBool(string mod, string name, bool value) global
    if value
        JMap.setInt(GetModValueMap(mod), name, 1)
    else
        JMap.setInt(GetModValueMap(mod), name, 0)
    endIf
endFunction

; Set/Get Form

; Set/Get ARRAYS

bool function ConfigVariableExists(string mod, string name) global
    return JMap.hasKey(GetModValueMap(mod), name)
endFunction

int function GetModDataStructure(string mod) global
    string modPath = ".mcmConfig." + mod
    int modData = JDB.solveObj(modPath)
    if ! modData
        modData = JMap.object()
        JDB.solveObjSetter(modPath, modData, createMissingKeys = true)
        JMap.setObj(modData, "pagesByName", JMap.object())
        JMap.setObj(modData, "pageFileNames", JMap.object())
        JMap.setObj(modData, "values", JMap.object())
        JMap.setObj(modData, "options", JIntMap.object())
        JMap.setObj(modData, "optionIds", JMap.object())
    endIf
    return modData
endFunction

int function GetModValueMap(string mod) global
    return JMap.getObj(GetModDataStructure(mod), "values")
endFunction

int function GetModOptionMap(string mod) global
    return JMap.getObj(GetModDataStructure(mod), "options")
endFunction

int function GetModOptionIdsMap(string mod) global
    return JMap.getObj(GetModDataStructure(mod), "optionIds")
endFunction

int function GetPagesByName(string mod) global
    return JMap.getObj(GetModDataStructure(mod), "pagesByName")
endFunction

int function GetPage(string mod, string name) global
    return JMap.getObj(GetPagesByName(mod), name)
endFunction

function AddPageFileName(string mod, string pageName, string filePath) global
    int pageFilenames = JMap.getObj(GetModDataStructure(mod), "pageFileNames")
    JMap.setStr(pageFileNames, pageName, filePath)
endFunction

string function GetPageFileName(string mod, string pageName) global
    int pageFilenames = JMap.getObj(GetModDataStructure(mod), "pageFileNames")
    return JMap.getStr(pageFileNames, pageName)
endFunction

function AddPageByName(string mod, string pageName, int page) global
    JMap.setObj(GetPagesByName(mod), pageName, page)
endFunction
