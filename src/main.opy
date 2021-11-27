#!include "config.opy"

globalvar scores
globalvar spawn

#!define DEFAULT_HUD_POS HudPosition.LEFT

#!define getTeamScore(team) scores[0 if team == Team.1 else 1]
#!define getTeamHighScore(team) scores[2 if team == Team.1 else 3]
#!define createHud(players, text, slot, pos, col, spec) hudSubtext(players, text, pos, slot, col, HudReeval.VISIBILITY_STRING_AND_COLOR, spec)
#!define clientOnly() [x for x in [localPlayer] if x.hasSpawned()]

rule "Initialize Global":
    @Event global
    scores = [0,0,0,0]

    registerConfig(bool, "Enabled", "Switch Spawns", CONFIG_SWITCH_TIMER_ENABLED, true, 0)
    registerConfig(int[60:900], "Cooldown (In Seconds)", "Switch Spawns", CONFIG_SWITCH_TIMER_VALUE, 450, 1)
    registerConfig(float[0.5:5], "Hud update interval", "Switch Spawns", CONFIG_SWITCH_TIMER_INTERVAL, 1.25, 2)

    spawn = [
        false,
        vect(49.469, -1.611, -13.959),
        vect(35.795, 4.230, -23.222),
        getConfig(CONFIG_SWITCH_TIMER_VALUE)
    ]

    createHud(clientOnly(), "\u200b\n\n\n\nNUCLEAR", 5, DEFAULT_HUD_POS, Color.BLUE, SpecVisibility.ALWAYS)
    createHud(clientOnly(), "WEAPONS", 6, DEFAULT_HUD_POS, Color.SKY_BLUE, SpecVisibility.ALWAYS)
    createHud(clientOnly(), "WAREHOUSE\n\n", 7, DEFAULT_HUD_POS, Color.AQUA, SpecVisibility.ALWAYS)

    createHud(clientOnly(), "{} OUR SCORE: {}".format(
        iconString(Icon.HEART), getTeamScore(localPlayer.getTeam())
    ), 8, DEFAULT_HUD_POS, Color.LIME_GREEN, SpecVisibility.NEVER)

    createHud(clientOnly(), "{} ENEMY SCORE: {}".format(
        iconString(Icon.POISON), getTeamScore(getOppositeTeam(localPlayer.getTeam()))
    ), 9, DEFAULT_HUD_POS, Color.RED, SpecVisibility.NEVER)

    createHud(clientOnly(), "{} SCORE DIFFERENCE: {}".format(
        iconString(Icon.WARNING), getTeamScore(localPlayer.getTeam())
    ), 10, DEFAULT_HUD_POS, Color.YELLOW, SpecVisibility.NEVER)

    createHud(clientOnly(), "{} HIGHEST TEAM SCORE: {}".format(
        iconString(Icon.SKULL), getTeamHighScore(localPlayer.getTeam())
    ), 11, DEFAULT_HUD_POS, Color.PURPLE, SpecVisibility.NEVER)

    createHud(clientOnly(), "{} SWITCH TEAMS SPAWN IN: {}".format(
        iconString(Icon.RECYCLE), spawn[4]
    ), 12, DEFAULT_HUD_POS, Color.GRAY, SpecVisibility.ALWAYS)



#!include "modules/spawn.opy"
