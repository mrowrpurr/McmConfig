scriptName JurassicParkMCM extends McmConfigMenu

string GUAR_PLUGIN = "mihailguar.esp"
int[] GUAR_FORM_IDS

int GUAR_ONE = 0x5904
int GUAR_TWO = 0x23fa4
int GUAR_THREE = 0x1ee12
int GUAR_FOUR = 0x1ee15
int GUAR_FIVE = 0x1ee16

event OnMenuInit()
    SetupGuars()
    int keyCode = McmConfig.GetInt(ModName, "DinoHotkey")
    RegisterForKey(keyCode)
endEvent

; TODO - On Player Load Game

function SetupGuars()
    GUAR_FORM_IDS = new int[5]
    GUAR_FORM_IDS[0] = GUAR_ONE
    GUAR_FORM_IDS[1] = GUAR_TWO
    GUAR_FORM_IDS[2] = GUAR_THREE
    GUAR_FORM_IDS[3] = GUAR_FOUR
    GUAR_FORM_IDS[4] = GUAR_FIVE
endFunction

function OnDinoHotkeyChange(int keyCode)
    UnregisterForAllKeys()
    RegisterForKey(keyCode)
endFunction

event OnKeyDown(int keyCode)
    int randomGuarIndex = Utility.RandomInt(0, GUAR_FORM_IDS.Length - 1)
    int randomGuarFormID = GUAR_FORM_IDS[randomGuarIndex]
    Form randomGuar = Game.GetFormFromFile(randomGuarFormID, GUAR_PLUGIN)
    Game.GetPlayer().PlaceAtMe(randomGuar)
endEvent

function RebootJurassicPark()
    Debug.MessageBox("Holy omg jeepers it worked.")
endFunction

function YouClickedTheThing()
    Debug.MessageBox("You clicked the thing")
endFunction
