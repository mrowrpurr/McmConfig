scriptName CommanderSpellEffect extends ActiveMagicEffect  
{Does something with the config!}

event OnEffectStart(Actor target, Actor caster)
    Debug.MessageBox("The coolest input evar is: " + \
        McmConfig.GetString("Commander", "MyCoolInput"))
endEvent

