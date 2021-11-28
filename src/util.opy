#
# Time formatting utilities
#

#!define formatZeros(val) ("0{}").format(val) if val <= 9 else val
#!define getMinutes(time) formatZeros(floor(time / 60))
#!define getSeconds(time) formatZeros(floor(time % 60))
#!define getTimeFormat(time) "{}:{}".format(getMinutes(time), getSeconds(time))

#
# Team score function utilities
#

#!define getTeamSpawn(team) spawns

#!define getTeamScore(team) scores[0 if team == Team.1 else 1]
#!define getTeamHighScore(team) scores[2 if team == Team.1 else 3]
#!define getTeamScoreByIndex(index) scores[index]
#!define getTeamHighScoreByIndex(index) scores[2 + index]

#!define getMilion(val) ((val / 1000) / 1000)
#!define getThousand(val) (val / 1000)

# Shortcut macro for creating hud subtext
#!define createHud(players, text, slot, pos, col, spec) hudSubtext(players, text, pos, slot, col, HudReeval.VISIBILITY_STRING_AND_COLOR, spec)

# Only local client playwe will be selected, if has spawned once in game.
#!define clientOnly() [x for x in [localPlayer] if x.hasSpawned()]

# Shortcut macro for creating inworld text
#!define inWorldText(player, text, position, color) createInWorldText(player, text, position, 1.55,\
    Clip.SURFACES, WorldTextReeval.VISIBILITY_STRING_AND_COLOR, color, SpecVisibility.ALWAYS)
