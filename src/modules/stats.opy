# Javascript scripted macros for rule generation.
#!define getServerStat(type) __script__("interop/stat_type.js")

# Generate all possible stats for rules.
#!define sharedStatsRuleGenerator(keys) __script__("interop/sharedStatsGenerator.js")

# Shortcut macro for creating server stat hud subtext.
#!define serverStatHud(text, type, slot) createHud(clientOnly(), "{}: {}%".format(\
    text, getServerStat(type)\
), slot, HudPosition.LEFT, Color.WHITE, SpecVisibility.ALWAYS)\

rule "Initialize server stats.":
    @Event global
    @Condition getConfig(CONFIG_ENABLE_SERVER_STATS)

    serverStatHud("\u200b\n{} SERVER LOAD".format(iconString(Icon.BOLT)), 0, 31)
    serverStatHud("{} SERVER LOAD PEAK".format(iconString(Icon.STOP)), 1, 32)
    serverStatHud("{} SERVER LOAD AVG".format(iconString(Icon.DIZZY)), 2, 33)

rule "Initialize shared stats hud.":
    @Event global
    stats = [0,0]
    statText = []
    statTemp = 0

rule "[SHARED STATS] Process 'DAMAGE' stat":
    @Event playerTookDamage
    @Condition entityExists(attacker)
    @Condition attacker != victim
    @Condition eventDamage >= 0.1
    stats[STAT_DAMAGE] += eventDamage

rule "[SHARED STATS] Process 'HEAL' stat":
    @Event playerReceivedHealing
    @Condition eventHealing >= 0.1
    stats[STAT_HEAL] += eventHealing

# Generate rules for valid stat types.
sharedStatsRuleGenerator(["DAMAGE", "HEAL"])
