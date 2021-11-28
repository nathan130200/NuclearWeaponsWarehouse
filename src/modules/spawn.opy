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

    do:
        if not isSpawnSwitched():
            eventPlayer.teleport(spawn[2])
        else:
            eventPlayer.teleport(spawn[1])

        wait(0.25)
    while RULE_CONDITION

rule "[TEAM2] Respawn":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.isInSpawnRoom()

    do:
        if not isSpawnSwitched():
            eventPlayer.teleport(spawn[1])
        else:
            eventPlayer.teleport(spawn[2])
    
        wait(0.25)
    while RULE_CONDITION

rule "[SPAWN] Tick switch teams timer":
    @Event global
    @Condition getConfig(CONFIG_SWITCH_TIMER_ENABLED)
    do:
        if switchTeamsTimer <= 0:
            bigMessage(getAllPlayers(), "Teams spawn points switched")
            switchTeamsTimer = getConfig(CONFIG_SWITCH_TIMER_VALUE)
            switchSpawns()
    
        switchTeamsTimer = switchTeamsTimer - 1
        wait(1)
    while RULE_CONDITION

rule "[SPAWN] Spawn protection":
    @Event eachPlayer
    @Condition eventPlayer.isInSpawnRoom()
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    eventPlayer.setInvisibility(Invis.ALL)
    wait(2)
    waitUntil(eventPlayer.isMoving(), 9999)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)
    eventPlayer.setInvisibility(Invis.NONE)

    # Just funny moments
    eventPlayer.communicate(Comms.VOICE_LINE_UP)
