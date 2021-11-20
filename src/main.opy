#!disableOptimizations

globalvar spawns
globalvar scores

rule "[DISCLAIMER] Notice message":
    @Event global
    printLog("Its remastered version of 500% - Nuclear Weapons WareHouse")
    printLog("This remaster is focused to clear readability and fix lot problems in original script code.")
    printLog("And fixes lot of unbalanced teams, when you get more kills you become more stronger, like in original code.")
    printLog("This script is not intended to be used for any other purpose than playing 500% - Nuclear Weapons WareHouse")
    printLog("Source code used to remaster this gamemode you can find at: https://github.com/nathan130200/crazy-ow")
    printLog("Created using OverPy extension. Check it out in: https://github.com/Zezombye/overpy/")
    printLog("Have fun!")

rule "Initialzie Global":
    disableAnnouncer()
    disableGamemodeCompletion()
    disableMusic()
    disableScoring()
    scores = [0, 0]

rule "[TEAM 1]: Spawn Point":
    @Team 1
    @Event eachPlayer
    @Condition eventPlayer.isInSpawnRoom()
    eventPlayer.teleport(spawns[0])

rule "[TEAM 2]: Spawn Point":
    @Team 2
    @Event eachPlayer
    @Condition eventPlayer.isInSpawnRoom()
    eventPlayer.teleport(spawns[1])

rule "Map: Watchpoint Gibraltar":
    @Condition getCurrentMap() == Map.WATCHPOINT_GIBRALTAR
    spawns = [
        vect(49.469, -1.611, -13.959),
        vect(27.215, 0.548, -32.123)
    ]

rule "Map: Setup Example":
    @Disabled

    # Check if the map is the map we want to setup
    @Condition getCurrentMap() == Map.PRACTICE_RANGE

    # Set positions of the spawn points each team will spawn at.
    spawns = [
        vect(0, 0, 0),
        vect(0, 0, 0)
    ]

    # Other more stuff if needed.
    disableScoring()
