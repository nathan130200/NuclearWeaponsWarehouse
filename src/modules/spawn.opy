#!define isTeamsSwitched() spawn[0]
#!define switchTeams() spawn[0] = not spawn[0]
#!define POS1 spawn[1]
#!define POS2 spawn[2]

#!define getSpawnPoint(team) \
    (getBaseSpawn(getOppositeTeam(team))) if isTeamsSwitched() else getBaseSpawn(team)

#!define getBaseSpawn(team) POS1 if team == Team.1 else POS2

rule "[SPAWN POINT] Team 1":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.isInSpawnRoom()
    do:
        if isTeamsSwitched():
            eventPlayer.teleport(POS2)
        else:
            eventPlayer.teleport(POS1)


        wait(0.5)
    while RULE_CONDITION

rule "[SPAWN POINT] Team 2":
    @Event eachPlayer
    @Team 2
    @Condition eventPlayer.isAlive()
    @Condition eventPlayer.isInSpawnRoom()
    do:
        if isTeamsSwitched():
            eventPlayer.teleport(POS1)
        else:
            eventPlayer.teleport(POS2)


        wait(0.5)
    while RULE_CONDITION

#!define switchTeamsTimer spawn[3]
#!define switchTeamsTimeStr spawn[4]
#!define switchTeamsTimeTemp spawn[5]

rule "[SPAWN] Tick switch teams timer":
    @Event global
    @Condition getConfig(opt_SwitchTeams_Enabled)
    do:
        if switchTeamsTimer <= 0:
            switchTeams()
            switchTeamsTimer = getConfig(opt_SwitchTeams_Time)
    
        switchTeamsTimer = switchTeamsTimer - 1
        wait(1)
    while RULE_CONDITION

rule "[SPAWN] Spawn protection":
    @Event eachPlayer
    @Condition eventPlayer.isInSpawnRoom()
    eventPlayer.setInvisibility(Invis.ALL)
    eventPlayer.setStatusEffect(null, Status.PHASED_OUT, 9999)
    wait(1)
    waitUntil(eventPlayer.isMoving(), 9999)
    eventPlayer.setInvisibility(Invis.NONE)
    eventPlayer.clearStatusEffect(Status.PHASED_OUT)

    eventPlayer.tempVarVoiceLine = random.randint(0, 4)

    if eventPlayer.tempVarVoiceLine == 0:
        eventPlayer.communicate(Comms.VOICE_LINE_UP)
    elif eventPlayer.tempVarVoiceLine == 1:
        eventPlayer.communicate(Comms.VOICE_LINE_RIGHT)
    elif eventPlayer.tempVarVoiceLine == 2:
        eventPlayer.communicate(Comms.VOICE_LINE_LEFT)
    elif eventPlayer.tempVarVoiceLine == 3:
        eventPlayer.communicate(Comms.VOICE_LINE_DOWN)
