scriptName MyCoolTest extends SkyUnitTest

function Tests()
    Test("This should fail").Fn(ThisShouldFail_Test())
endFunction

function ThisShouldFail_Test()
    ExpectQuest(None).Stage(10).Not().To(BeCurrentStage())
    
    ; MAGIC

    ExpectQuest(None).Stage(10).To(BeCurrentStage())
endFunction
