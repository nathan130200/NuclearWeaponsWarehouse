#!include "config.opy"

globalvar scores
globalvar spawn
globalvar spawnTimeStr

subroutine CalcTimeStringFormat

#!define DEFAULT_HUD_POS HudPosition.LEFT
#!define getTeamScore(team) scores[0 if team == Team.1 else 1]
#!define getTeamHighScore(team) scores[2 if team == Team.1 else 3]
#!define createHud(players, text, slot, pos, col) hudSubtext(players, text, pos, slot, col, HudReeval.VISIBILITY_STRING_AND_COLOR, SpecVisibility.DEFAULT)
#!define teamColor(player) Color.TEAM_1 if player.getTeam() == Team.1 else Color.TEAM_2

rule "Initialize Global":
    @Event global
    scores = [0,0,0,0]

    registerConfig(bool, "Enabled", "Switch Spawns", ID_SWITCH_TIMER_ENABLED, true)
    registerConfig(float[0.25:1.5], "Hud update interval", "Switch Spawns", ID_SWITCH_TIMER_INTERVAL, 1)
    registerConfig(int[60:300], "Cooldown (In Seconds)", "Switch Spawns", ID_SWITCH_TIMER_VALUE, 1)

    spawn = [
        false,
        vect(49.469, -1.611, -13.959),
        vect(35.795, 4.230, -23.222),
        getConfig(ID_SWITCH_TIMER_VALUE)
    ]

    createHud(localPlayer, "\u200b\n\n\n\nNUCLEAR", 5, DEFAULT_HUD_POS, Color.SKY_BLUE)
    createHud(localPlayer, "WEAPONS", 6, DEFAULT_HUD_POS, Color.TURQUOISE)
    createHud(localPlayer, "WAREHOUSE\n\n", 7, DEFAULT_HUD_POS, Color.ROSE)

    createHud(localPlayer, "{} OUR SCORE: {}".format(
        iconString(Icon.HEART), getTeamScore(localPlayer.getTeam())
    ), 8, DEFAULT_HUD_POS, Color.LIME_GREEN)

    createHud(localPlayer, "{} ENEMY SCORE: {}".format(
        iconString(Icon.POISON), getTeamScore(getOppositeTeam(localPlayer.getTeam()))
    ), 9, DEFAULT_HUD_POS, teamColor(localPlayer))

    createHud(localPlayer, "{} SCORE DIFFERENCE: {}".format(
        iconString(Icon.WARNING), getTeamScore(localPlayer.getTeam())
    ), 10, DEFAULT_HUD_POS, Color.YELLOW)

    createHud(localPlayer, "{} HIGHEST TEAM SCORE: {}".format(
        iconString(Icon.SKULL), getTeamHighScore(localPlayer.getTeam())
    ), 11, DEFAULT_HUD_POS, Color.PURPLE)

    createHud(localPlayer, "{} SWITCH TEAMS SPAWN IN: {}".format(
        iconString(Icon.RECYCLE), spawn[4]
    ), 12, DEFAULT_HUD_POS, Color.GRAY)



#!include "spawn.opy"
