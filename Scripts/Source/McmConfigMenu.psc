scriptName McmConfigMenu extends SKI_ConfigBase hidden
{Extend this to create a McmConfig Mod Configuration Menu}

; TODO option for logo page

; TODO - Make sure folks can actually ENABLE and DISABLE widgets on the page dynamically
;        e.g. EnableOption("NAME") and DisableOption("NAME")
;        as well as HideOption("NAME") and ShowOption("NAME")

; TODO: for all options, support "enabled": true/false

; TODO: allow 'true' 'false' boolean support

; TODO make function invocation work after player load games

string property McmFolder auto

; TODO - Dynamically Loaded Page Names

event OnConfigInit()
    ModName = GetModNameFromScriptName()
    McmFolder = "Data\\Interface\\" + ModName + "\\MCM"
    LoadPages()
endEvent

event OnPageReset(string pageName)
    string pageFileName = McmConfig.GetPageFileName(ModName, pageName)
    int page = JValue.readFromFile(McmFolder + "\\" + pageFileName)

    ; Left Column
    SetCursorFillMode(TOP_TO_BOTTOM)
    RenderWidgets(JMap.getObj(page, "left"))

    ; Right Column
    SetCursorPosition(1)
    RenderWidgets(JMap.getObj(page, "right"))
endEvent

function RenderWidgets(int widgets)
    if ! widgets
        return
    endIf

    int widgetCount = JArray.count(widgets)
    int i = 0
    while i < widgetCount
        RenderWidget(JArray.getObj(widgets, i))
        i += 1
    endWhile
endFunction

; (A) Squish this RenderWidget function BACK into the RenderWidgets function
;     and put that into the OnPageReset
; (B) Put all of the RenderWidget functions into OnPageReset
function RenderWidget(int widget)
    string type = JMap.getStr(widget, "type")
    if type == "header"
        AddHeaderOption(JMap.getStr(widget, "text"))
    elseIf type == "text"
        RenderTextWidget(widget)
    elseIf type == "input"
        RenderInputWidget(widget)
    elseIf type == "toggle"
        RenderToggleWidget(widget)
    elseIf type == "slider"
        RenderSliderWidget(widget)
    ; elseIf type == "menu"
    ;     RenderMenuWidget(widget)
    endIf
endFunction

function RenderTextWidget(int widget)
    RegisterOption(widget, AddTextOption( \
        JMap.getStr(widget, "description"), \
        JMap.getStr(widget, "text") \
        ))
endFunction

function RenderInputWidget(int widget)
    RegisterOption(widget, \
        AddInputOption( \
            JMap.getStr(widget, "text"), \
            JMap.getStr(widget, "prompt") \
        ))
endFunction

function RenderToggleWidget(int widget)
    string name = JMap.getStr(widget, "name")
    bool default = JMap.getStr(widget, "default") == "true"
    if McmConfig.IsConfigVariableExists(ModName, name)
        default = McmConfig.GetBool(ModName, name)
    endIf
    McmConfig.SetBool(ModName, name, default)
    RegisterOption(widget, \
        AddToggleOption( \
            JMap.getStr(widget, "text"), \
            default \
        ))
endFunction

; Add decimal precision
function RenderSliderWidget(int widget)
    string name = JMap.getStr(widget, "name")
    float value = JMap.getFlt(widget, "value")
    if McmConfig.IsConfigVariableExists(ModName, name)
        value = McmConfig.GetFloat(ModName, name)
    endIf
    RegisterOption(widget, \
        AddSliderOption( \
            JMap.getStr(widget, "text"), \
            value \
        ))
endFunction

function RegisterOption(int widget, int optionId)
    int optionMap = McmConfig.GetModOptionMap(ModName)
    JIntMap.setObj(optionMap, optionId, widget)
endFunction

int function GetOptionWidget(int optionId)
    int optionMap = McmConfig.GetModOptionMap(ModName)
    return JIntMap.getObj(optionMap, optionId)
endFunction

function LoadPages()
    int pageFiles = JValue.readFromDirectory(McmFolder)
    StartListeningToAllFunctionCallsInAllPages(pageFiles)
    string[] pageFileNames = JMap.allKeysPArray(pageFiles)
    Pages = JMap.allKeysPArray(pageFiles)
    int i = 0
    while i < Pages.Length
        ; Remove the .json
        Pages[i] = StringUtil.Substring(Pages[i], 0, StringUtil.Find(Pages[i], ".json"))

        ; Remove the number prefix
        Pages[i] = StringUtil.Substring(Pages[i], StringUtil.Find(Pages[i], "-") + 1)

        ; Add the page with the filename
        McmConfig.AddPageFileName(ModName, Pages[i], pageFileNames[i])

        i += 1
    endWhile
endFunction

string function GetModNameFromScriptName()
    string script = self
    int mcmIndex = StringUtil.Find(script, "MCM ")
    return StringUtil.Substring(script, 1, mcmIndex - 1)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Events
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

event OnOptionInputOpen(int optionId)
    SetInputDialogStartText("Whoo hoo... you can add start text")
endEvent

event OnOptionInputAccept(int optionId, string text)
    int widget = GetOptionWidget(optionId)
    string widgetName = JMap.getStr(widget, "name")
    McmConfig.SetString(ModName, widgetName, text)
endEvent

event OnOptionSelect(int optionId)
    int widget = GetOptionWidget(optionId)
    string functionName = JMap.getStr(widget, "function")
    if functionName
        InvokeFunction(functionName)
    endIf
    string type = JMap.getStr(widget, "type")
    if type == "toggle"
        string name = JMap.getStr(widget, "name")
        bool currentValue = McmConfig.GetBool(ModName, name)
        SetToggleOptionValue(optionId, ! currentValue)
        McmConfig.SetBool(ModName, name, ! currentValue)
    endIf
endEvent

event OnOptionSliderOpen(int optionId)
    int widget = GetOptionWidget(optionId)
    int range = JMap.getObj(widget, "range")
    float start = JArray.getFlt(range, 0)
    float end = JArray.getFlt(range, 1)
    float value = JMap.getFlt(widget, "value")
    float default = JMap.getFlt(widget, "default")
    if ! JMap.hasKey(widget, "default")
        default = value
    endIf
    float interval = JMap.getFlt(widget, "interval")
    if ! interval
        interval = 1
    endIf
    SetSliderDialogRange(start, end)
    SetSliderDialogInterval(interval)
    SetSliderDialogStartValue(value)
    SetSliderDialogDefaultValue(default)
endEvent

event OnOptionSliderAccept(int optionId, float value)
    int widget = GetOptionWidget(optionId)
    string name = JMap.getStr(widget, "name")
    McmConfig.SetFloat(ModName, name, value)
    SetSliderOptionValue(optionId, value)
endEvent

function InvokeFunction(string functionName)
    int theEvent = ModEvent.Create(ModName + " MCM Function " + functionName)
    ModEvent.Send(theEvent)
endFunction

function StartListeningToAllFunctionCallsInAllPages(int pageMap)
    string[] pageNames = JMap.allKeysPArray(pageMap)
    int pageIndex = 0
    while pageIndex < pageNames.Length
        int page = JMap.getObj(pageMap, pageNames[pageIndex])
        int leftColumn = JMap.getObj(page, "left")
        int rightColumn = JMap.getObj(page, "right")

        ; Go through right column and activate functions
        int widgetCount = JArray.count(leftColumn)
        int widgetIndex = 0
        while widgetIndex < widgetCount
            int widget = JArray.getObj(leftColumn, widgetIndex)
            string functionName = JMap.getStr(widget, "function")
            if functionName
                RegisterForModEvent(ModName + " MCM Function " + functionName, functionName)
            endIf
            widgetIndex += 1
        endWhile

        ; Go through left column and activate functions
        widgetCount = JArray.count(rightColumn)
        widgetIndex = 0
        while widgetIndex < widgetCount
            int widget = JArray.getObj(rightColumn, widgetIndex)
            string functionName = JMap.getStr(widget, "function")
            if functionName
                RegisterForModEvent(ModName + " MCM Function " + functionName, functionName)
            endIf
            widgetIndex += 1
        endWhile

        pageIndex += 1
    endWhile
endFunction
