scriptName McmConfigMenu extends SKI_ConfigBase hidden
{Extend this to create a McmConfig Mod Configuration Menu}

string property McmFolder auto

event OnConfigInit()
    ModName = GetModNameFromScriptName()
    McmFolder = "Data\\Interface\\" + ModName + "\\MCM"
    LoadPages()
endEvent

event OnPageReset(string pageName)
    int page = JValue.readFromFile(McmFolder + "\\" + pageName + ".json")

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

function RenderWidget(int widget)
    string type = JMap.getStr(widget, "type")
    if type == "header"
        AddHeaderOption(JMap.getStr(widget, "text"))
    elseIf type == "text"
        RenderTextWidget(widget)
    elseIf type == "input"
        RenderInputWidget(widget)
    endIf
endFunction

function RenderTextWidget(int widget)
    AddTextOption( \
        JMap.getStr(widget, "description"), \
        JMap.getStr(widget, "text") \
    )
endFunction

; name": "MyCoolInput",
; "type": "input",
; "text": "Set the Cool Input",
; "tooltip": "This sets the coolest inp
; value: ""

function RenderInputWidget(int widget)
    string name = JMap.getStr(widget, "name")
    RegisterOption(widget, \
        AddInputOption( \
            JMap.getStr(widget, "text"), \
            JMap.getStr(widget, "prompt") \
        ))
endFunction

function RegisterOption(int widget, int optionId)
    int optionMap = McmConfig.GetModOptionMap(ModName)
    JIntMap.setObj(optionId, optionId, widget)
endFunction

int function GetOptionWidget(int optionId)
    int optionMap = McmConfig.GetModOptionMap(ModName)
    return JIntMap.getObj(optionMap, optionId)
endFunction

function LoadPages()
    int pageFiles = JValue.readFromDirectory(McmFolder)
    Pages = JMap.allKeysPArray(pageFiles)
    int i = 0
    while i < Pages.Length
        Pages[i] = StringUtil.Substring(Pages[i], 0, StringUtil.Find(Pages[i], ".json"))
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
