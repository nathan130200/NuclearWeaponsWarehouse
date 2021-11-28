#!define team1_count autoBalanceData[0] 
#!define team2_count autoBalanceData[1] 
#!define team1_diff autoBalanceData[2]
#!define team2_diff autoBalanceData[3]
#!define _e autoBalanceData[4]
#!define _t autoBalanceData[5]
#!define haveFreeSlots(team) len([x for x in getPlayers(team)]) < getNumberOfSlots(team)

rule "[AUTO BALANCE] Auto balanced based on players slots":
    @Event global
    @Condition getConfig(opt_TeamBalance_Enabled)
    @Condition getConfig(opt_TeamBalance_MovePlayers)

    do:
        if team1_diff > 1 or team2_diff > 1:
            if team1_count > team2_count:
                if haveFreeSlots(Team.2):
                    _e = random.choice(getPlayers(Team.1))
                    _t = Team.2
            elif team2_count > team1_count:
                if haveFreeSlots(Team.2):
                    _e = random.choice(getPlayers(Team.2)) 
                    _t = Team.1

        if entityExists(_e) and _t != null:
            printLog("[AUTO BALANCE] Moved player '{}' to team '{}'".format(_e, _t))
            
            if not _e.isDummy():
                moveToTeam(_e, _t, -1)
            else:
                createDummy(_e.getCurrentHero(), _t, -1, _e.getPosition(), Vector.FORWARD)
                wait()
                destroyDummy(_e.getSlot())

            _e = null
            _t = null
            wait(0.25)
    
        wait(1)
    while RULE_CONDITION

rule "[AUTO BALANCE] Calculate players count difference":
    @Event global
    autoBalanceData[0] = len(getPlayers(Team.1))
    autoBalanceData[1] = len(getPlayers(Team.2))
    autoBalanceData[2] = autoBalanceData[0] - autoBalanceData[1]
    autoBalanceData[3] = autoBalanceData[1] - autoBalanceData[0]
    wait(1)
    goto RULE_START

