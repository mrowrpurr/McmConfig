scriptName CommanderSpellEffect extends ActiveMagicEffect  
{Does something with the config!}

event OnEffectStart(Actor target, Actor caster)

    float answer = 42.42
    
    string theValue = McmConfig.GetString("Commander", "MyCoolInput")

    Debug.MessageBox("The coolest input evar is: " + theValue)

    ; Debug.MessageBox("The coolest input evar is: " + \
    ;     McmConfig.GetString("Commander", "MyCoolInput"))
endEvent

