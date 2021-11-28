#!define team1_count autoBalanceData[0] 
#!define team2_count autoBalanceData[1] 
#!define team_count_diff autoBalanceData[2]
#!define oldEntity autoBalanceData[3]
#!define newTeam autoBalanceData[4]
#!define haveFreeSlots(team) len([x for x in getPlayers(team)]) < getNumberOfSlots(team)

rule "[AUTO BALANCE] Auto balanced based on players slots":
    @Event global
    @Condition getConfig(opt_TeamBalance_Enabled)
    @Condition getConfig(opt_TeamBalance_MovePlayers)

    do:
        wait(1)

        if team_count_diff > 1:
            if team1_count > team2_count - 1:
                if haveFreeSlots(Team.2):
                    oldEntity = random.choice(getPlayers(Team.1))
                    newTeam = Team.2
                    goto _swap

            if team2_count > team1_count - 1:
                if haveFreeSlots(Team.2):
                    oldEntity = random.choice(getPlayers(Team.2)) 
                    newTeam = Team.1
                    goto _swap

        _swap:
        if entityExists(oldEntity) and newTeam != null:
            printLog("[AUTO BALANCE] Moved player '{}' to team '{}'".format(oldEntity, newTeam))
            
            if not oldEntity.isDummy():
                moveToTeam(oldEntity, newTeam, -1)
            else:
                createDummy(oldEntity.getCurrentHero(), newTeam, -1, oldEntity.getPosition(), Vector.FORWARD)
                wait()
                destroyDummy(oldEntity.getTeam(), oldEntity.getSlot())

            oldEntity = null
            newTeam = null
            wait(0.25)
    while RULE_CONDITION

rule "[AUTO BALANCE] Calculate players count difference":
    @Event global
    autoBalanceData[0] = len(getPlayers(Team.1))
    autoBalanceData[1] = len(getPlayers(Team.2))
    autoBalanceData[2] = abs(autoBalanceData[0] - autoBalanceData[1])
    wait(1)
    goto RULE_START

