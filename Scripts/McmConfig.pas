.info
  .source "McmConfig.psc"
  .modifyTime 1633196585
  .compileTime 1633196634
  .user "mrowr"
  .computer "MROWR-PURR"
.endInfo
.userFlagsRef
  .flag conditional 1
  .flag hidden 0
.endUserFlagsRef
.objectTable
  .object McmConfig 
    .userFlags 1
    .docString "Interface for getting and setting configuration variables for McmConfig."
    .autoState 
    .variableTable
    .endVariableTable
    .propertyTable
    .endPropertyTable
    .stateTable
      .state
        .function GetState
          .userFlags 0
          .docString "Function that returns the current state"
          .return String
          .paramTable
          .endParamTable
          .localTable
          .endLocalTable
          .code
            RETURN ::state
          .endCode
        .endFunction
        .function GotoState
          .userFlags 0
          .docString "Function that switches this object to the specified state"
          .return None
          .paramTable
            .param newState String
          .endParamTable
          .localTable
            .local ::NoneVar None
          .endLocalTable
          .code
            CALLMETHOD onEndState self ::NoneVar
            ASSIGN ::state newState
            CALLMETHOD onBeginState self ::NoneVar
          .endCode
        .endFunction
        .function GetString static
          .userFlags 0
          .docString ""
          .return string
          .paramTable
            .param mod string
            .param name string
          .endParamTable
          .localTable
            .local ::temp0 int
            .local ::temp1 string
          .endLocalTable
          .code
            CALLSTATIC mcmconfig GetModValueMap ::temp0 mod ;@line 5
            CALLSTATIC jmap getStr ::temp1 ::temp0 name "" ;@line 5
            RETURN ::temp1 ;@line 5
          .endCode
        .endFunction
        .function SetString static
          .userFlags 0
          .docString ""
          .return NONE
          .paramTable
            .param mod string
            .param name string
            .param value string
          .endParamTable
          .localTable
            .local ::temp2 int
            .local ::nonevar none
          .endLocalTable
          .code
            CALLSTATIC mcmconfig GetModValueMap ::temp2 mod ;@line 9
            CALLSTATIC jmap setStr ::nonevar ::temp2 name value ;@line 9
          .endCode
        .endFunction
        .function GetInt static
          .userFlags 0
          .docString ""
          .return int
          .paramTable
            .param mod string
            .param name string
          .endParamTable
          .localTable
            .local ::temp3 int
          .endLocalTable
          .code
            CALLSTATIC mcmconfig GetModValueMap ::temp3 mod ;@line 13
            CALLSTATIC jmap getInt ::temp3 ::temp3 name 0 ;@line 13
            RETURN ::temp3 ;@line 13
          .endCode
        .endFunction
        .function SetInt static
          .userFlags 0
          .docString ""
          .return NONE
          .paramTable
            .param mod string
            .param name string
            .param value int
          .endParamTable
          .localTable
            .local ::temp4 int
            .local ::nonevar none
          .endLocalTable
          .code
            CALLSTATIC mcmconfig GetModValueMap ::temp4 mod ;@line 17
            CALLSTATIC jmap setInt ::nonevar ::temp4 name value ;@line 17
          .endCode
        .endFunction
        .function GetFloat static
          .userFlags 0
          .docString ""
          .return float
          .paramTable
            .param mod string
            .param name string
          .endParamTable
          .localTable
            .local ::temp5 int
            .local ::temp6 float
          .endLocalTable
          .code
            CALLSTATIC mcmconfig GetModValueMap ::temp5 mod ;@line 21
            CALLSTATIC jmap getFlt ::temp6 ::temp5 name 0.0 ;@line 21
            RETURN ::temp6 ;@line 21
          .endCode
        .endFunction
        .function SetFloat static
          .userFlags 0
          .docString ""
          .return NONE
          .paramTable
            .param mod string
            .param name string
            .param value float
          .endParamTable
          .localTable
            .local ::temp7 int
            .local ::nonevar none
          .endLocalTable
          .code
            CALLSTATIC mcmconfig GetModValueMap ::temp7 mod ;@line 25
            CALLSTATIC jmap setFlt ::nonevar ::temp7 name value ;@line 25
          .endCode
        .endFunction
        .function GetBool static
          .userFlags 0
          .docString ""
          .return bool
          .paramTable
            .param mod string
            .param name string
          .endParamTable
          .localTable
            .local ::temp8 int
            .local ::temp9 bool
          .endLocalTable
          .code
            CALLSTATIC mcmconfig GetModValueMap ::temp8 mod ;@line 29
            CALLSTATIC jmap getInt ::temp8 ::temp8 name 0 ;@line 29
            COMPAREEQ ::temp9 ::temp8 1 ;@line 29
            RETURN ::temp9 ;@line 29
          .endCode
        .endFunction
        .function SetBool static
          .userFlags 0
          .docString ""
          .return NONE
          .paramTable
            .param mod string
            .param name string
            .param value bool
          .endParamTable
          .localTable
            .local ::temp10 int
            .local ::nonevar none
          .endLocalTable
          .code
            JUMPF value label1 ;@line 33
            CALLSTATIC mcmconfig GetModValueMap ::temp10 mod ;@line 34
            CALLSTATIC jmap setInt ::nonevar ::temp10 name 1 ;@line 34
            JUMP label0
            label1:
            CALLSTATIC mcmconfig GetModValueMap ::temp10 mod ;@line 36
            CALLSTATIC jmap setInt ::nonevar ::temp10 name 0 ;@line 36
            label0:
          .endCode
        .endFunction
        .function ConfigVariableExists static
          .userFlags 0
          .docString ""
          .return bool
          .paramTable
            .param mod string
            .param name string
          .endParamTable
          .localTable
            .local ::temp11 int
            .local ::temp12 bool
          .endLocalTable
          .code
            CALLSTATIC mcmconfig GetModValueMap ::temp11 mod ;@line 45
            CALLSTATIC jmap hasKey ::temp12 ::temp11 name ;@line 45
            RETURN ::temp12 ;@line 45
          .endCode
        .endFunction
        .function GetModDataStructure static
          .userFlags 0
          .docString ""
          .return int
          .paramTable
            .param mod string
          .endParamTable
          .localTable
            .local ::temp13 string
            .local ::temp14 int
            .local ::temp15 bool
            .local modPath string
            .local modData int
            .local ::temp16 bool
            .local ::nonevar none
          .endLocalTable
          .code
            STRCAT ::temp13 ".mcmConfig." mod ;@line 49
            ASSIGN modPath ::temp13 ;@line 49
            CALLSTATIC jdb solveObj ::temp14 modPath 0 ;@line 50
            ASSIGN modData ::temp14 ;@line 50
            NOT ::temp15 modData ;@line 51
            JUMPF ::temp15 label3 ;@line 51
            CALLSTATIC jmap object ::temp14  ;@line 52
            ASSIGN modData ::temp14 ;@line 52
            CALLSTATIC jdb solveObjSetter ::temp16 modPath modData true ;@line 53
            CALLSTATIC jmap object ::temp14  ;@line 54
            CALLSTATIC jmap setObj ::nonevar modData "pageFileNames" ::temp14 ;@line 54
            CALLSTATIC jmap object ::temp14  ;@line 55
            CALLSTATIC jmap setObj ::nonevar modData "values" ::temp14 ;@line 55
            CALLSTATIC jintmap object ::temp14  ;@line 56
            CALLSTATIC jmap setObj ::nonevar modData "options" ::temp14 ;@line 56
            JUMP label2
            label3:
            label2:
            RETURN modData ;@line 58
          .endCode
        .endFunction
        .function GetModValueMap static
          .userFlags 0
          .docString ""
          .return int
          .paramTable
            .param mod string
          .endParamTable
          .localTable
            .local ::temp17 int
          .endLocalTable
          .code
            CALLSTATIC mcmconfig GetModDataStructure ::temp17 mod ;@line 62
            CALLSTATIC jmap getObj ::temp17 ::temp17 "values" 0 ;@line 62
            RETURN ::temp17 ;@line 62
          .endCode
        .endFunction
        .function GetModOptionMap static
          .userFlags 0
          .docString ""
          .return int
          .paramTable
            .param mod string
          .endParamTable
          .localTable
            .local ::temp18 int
          .endLocalTable
          .code
            CALLSTATIC mcmconfig GetModDataStructure ::temp18 mod ;@line 66
            CALLSTATIC jmap getObj ::temp18 ::temp18 "options" 0 ;@line 66
            RETURN ::temp18 ;@line 66
          .endCode
        .endFunction
        .function AddPageFileName static
          .userFlags 0
          .docString ""
          .return NONE
          .paramTable
            .param mod string
            .param pageName string
            .param filePath string
          .endParamTable
          .localTable
            .local ::temp19 int
            .local ::nonevar none
            .local pageFilenames int
          .endLocalTable
          .code
            CALLSTATIC mcmconfig GetModDataStructure ::temp19 mod ;@line 70
            CALLSTATIC jmap getObj ::temp19 ::temp19 "pageFileNames" 0 ;@line 70
            ASSIGN pageFilenames ::temp19 ;@line 70
            CALLSTATIC jmap setStr ::nonevar pageFileNames pageName filePath ;@line 71
          .endCode
        .endFunction
        .function GetPageFileName static
          .userFlags 0
          .docString ""
          .return string
          .paramTable
            .param mod string
            .param pageName string
          .endParamTable
          .localTable
            .local ::temp20 int
            .local ::nonevar none
            .local ::temp21 string
            .local pageFilenames int
          .endLocalTable
          .code
            CALLSTATIC mcmconfig GetModDataStructure ::temp20 mod ;@line 75
            CALLSTATIC jmap getObj ::temp20 ::temp20 "pageFileNames" 0 ;@line 75
            ASSIGN pageFilenames ::temp20 ;@line 75
            CALLSTATIC mcmconfig GetModDataStructure ::temp20 mod ;@line 76
            CALLSTATIC jvalue writeToFile ::nonevar ::temp20 "WhyIsntItWorking.json" ;@line 76
            CALLSTATIC jmap getStr ::temp21 pageFileNames pageName "" ;@line 77
            RETURN ::temp21 ;@line 77
          .endCode
        .endFunction
        .function onBeginState
          .userFlags 0
          .docString "Event received when this state is switched to"
          .return None
          .paramTable
          .endParamTable
          .localTable
          .endLocalTable
          .code
          .endCode
        .endFunction
        .function onEndState
          .userFlags 0
          .docString "Event received when this state is switched away from"
          .return None
          .paramTable
          .endParamTable
          .localTable
          .endLocalTable
          .code
          .endCode
        .endFunction
      .endState
    .endStateTable
  .endObject
.endObjectTable