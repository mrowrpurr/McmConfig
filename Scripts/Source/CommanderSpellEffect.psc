scriptName CommanderSpellEffect extends ActiveMagicEffect  
{Does something with the config!}

event OnEffectStart(Actor target, Actor caster)
    Debug.MessageBox("Favorite dinosaur: " + McmConfig.GetString("JurassicPark", "FaveDino"))
endEvent

