scriptName CommanderSpellEffect extends ActiveMagicEffect  
{Does something with the config!}

event OnEffectStart(Actor target, Actor caster)
    int color = McmConfig.GetInt("JurassicPark", "FaveColor")
    Debug.MessageBox("Favorite color: " + FormHelper.DecimalToHex(color))
endEvent

