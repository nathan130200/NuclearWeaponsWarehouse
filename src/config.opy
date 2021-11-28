#!define registerConfig(type, name, category, id, defaultValue, slot) \
    configs[id] = createWorkshopSetting(type, category, name, defaultValue, slot)

#!define getConfig(id) configs[id]

# Switch teams settings
#!define opt_SwitchTeams_Enabled 0
#!define opt_SwitchTeams_Time 1

# Advanced settings
#!define opt_EnableServerStats 2
#!define opt_UpdateServerStatsInterval 3

# Team balance settings
#!define opt_TeamBalance_Enabled 4
#!define opt_TeamBalance_MovePlayers 5
#!define opt_TeamBalance_SpawnBot 6
#!define opt_TeamBalance_SpawnBotCount 7
