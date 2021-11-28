#!define flashIcon iconData[0]
#!define flashEnabled iconData[1]
#!define flashState iconData[2]
#!define flashRate iconData[4]

#!define flashFilter ((not flashEnabled or (flashEnabled and flashState)) \
    and not isInLoS(localPlayer.tempIconPos[0], localPlayer.tempIconPos[1], BarrierLos.PASS_THROUGH_BARRIERS))

rule "[SPAWN ICON] Initialize params.":
    @Event global
    iconData = [null,false,false,0.75]

    createIcon([p for p in [localPlayer] if flashFilter],
        localPlayer.tempIconPos[1] + vect(0, 1.5, 0), Icon.SKULL, IconReeval.VISIBILITY_AND_POSITION,
            Color.RED, true)

rule "[SPAWN ICON] Update icon position":
    @Event eachPlayer
    @Condition entityExists(eventPlayer)
    do:
        eventPlayer.tempIconPos[0] = eventPlayer.getPosition()
        eventPlayer.tempIconPos[1] = getSpawnPoint(getOppositeTeam(eventPlayer.getTeam()))
        wait(1)
    while RULE_CONDITION

rule "[SPAWN ICON] Start flashing":
    @Event global
    @Condition switchTeamsTimer <= 30
    @Condition not flashEnabled
    flashEnabled = true

    while switchTeamsTimer > 0:

        if switchTeamsTimer == 10:
            flashRate = 0.25
        elif switchTeamsTimer <= 5:
            flashRate = 0.16
        else:
            flashRate = 0.5
            
        flashState = not flashState
        
        if flashState:
            playEffect(getPlayers(localPlayer.getTeam()), DynamicEffect.DEBUFF_IMPACT_SOUND, null, localPlayer.tempIconPos[1], 35)
            playEffect(getPlayers(localPlayer.getTeam()), DynamicEffect.DEBUFF_IMPACT_SOUND, null, localPlayer.tempIconPos[1], 2)

        wait(flashRate)

    wait(1.5)
    flashEnabled = false

    playEffect(getPlayers(localPlayer.getTeam()), DynamicEffect.RING_EXPLOSION_SOUND, Color.RED,
        localPlayer.tempIconPos[1], 70)

    wait(1)
