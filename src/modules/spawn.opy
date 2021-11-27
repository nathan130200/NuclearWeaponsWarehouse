#!define isSpawnSwitched() spawn[0]
#!define switchSpawns() spawn[0] = not spawn[0]
#!define getTeamSpawn(team) spawn[1] if team == Team.1 else spawn[2]
#!define switchTeamsTimer spawn[3]
#!define switchTeamsTimeStr spawn[4]
#!define switchTeamsTimeTemp spawn[5]

rule "[TEAM1] Respawn":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.isInSpawnRoom()

    if not isSpawnSwitched():
        eventPlayer.teleport(spawn[2])
    else:
        eventPlayer.teleport(spawn[1])

rule "[TEAM2] Respawn":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.isInSpawnRoom()

    if not isSpawnSwitched():
        eventPlayer.teleport(spawn[1])
    else:
        eventPlayer.teleport(spawn[2])

rule "[TEAMS] Tick switch teams timer":
    @Event global
    @Condition getConfig(CONFIG_SWITCH_TIMER_ENABLED)
    do:
        if switchTeamsTimer <= 0:
            switchTeamsTimer = getConfig(CONFIG_SWITCH_TIMER_VALUE)
            switchSpawns()
    
        switchTeamsTimer = switchTeamsTimer - 1
        wait(1)
    while RULE_CONDITION

rule "[TEAMS] Tick switch teams timer hud":
    @Event global
    @Condition getConfig(CONFIG_SWITCH_TIMER_ENABLED)
    
    do:
        if ceil(switchTeamsTimer / 60) >= 1.0:
            switchTeamsTimeTemp = round(switchTeamsTimer / 60)
        else:
            switchTeamsTimeTemp = "0"

        switchTeamsTimeTemp = "{}:".format(switchTeamsTimeTemp)

        if round(switchTeamsTimer % 60) <= 9:
            switchTeamsTimeTemp = "{}0{}".format(switchTeamsTimeTemp, switchTeamsTimer % 60)
        else:
            switchTeamsTimeTemp = "{}{}".format(switchTeamsTimeTemp, switchTeamsTimer % 60)

        switchTeamsTimeStr = switchTeamsTimeTemp

        wait(getConfig(CONFIG_SWITCH_TIMER_INTERVAL))
    while RULE_CONDITION
