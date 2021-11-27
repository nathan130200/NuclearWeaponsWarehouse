#!define isSpawnSwitched() spawn[0]
#!define switchSpawns() spawn[0] = not spawn[0]
#!define getTeamSpawn(team) spawn[1] if team == Team.1 else spawn[2]
#!define switchTeamsTimer spawn[3]
#!define switchTeamsTimeStr spawn[4]

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
    if switchTeamsTimer <= 0:
        switchTeamsTimer = getConfig(ID_SWITCH_TIMER_VALUE)
        switchSpawns()

    switchTeamsTimer = switchTeamsTimer - 1
    wait(1)

    goto RULE_START

rule "[TEAMS] Tick switch teams timer hud":
    @Event global
    
    if ceil(switchTeamsTimer / 60) > 0.1:
        spawnTimeStr = round(switchTeamsTimer / 60)
    else:
        spawnTimeStr = "0"

    spawnTimeStr = "{}:".format(spawnTimeStr)

    if round(switchTeamsTimer % 60) <= 9:
        spawnTimeStr = "{}0{}".format(spawnTimeStr, switchTeamsTimer % 60)
    else:
        spawnTimeStr = "{}{}".format(spawnTimeStr, switchTeamsTimer % 60)

    spawn[4] = spawnTimeStr

    wait(getConfig(ID_SWITCH_TIMER_INTERVAL))
    goto RULE_START
