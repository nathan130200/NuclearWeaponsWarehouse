#!define registerConfig(type, name, category, id, defaultValue, slot) \
    configs[id] = createWorkshopSetting(type, category, name, defaultValue, slot)

#!define getConfig(id) configs[id]


#!define CONFIG_SWITCH_TIMER_ENABLED 0
#!define CONFIG_SWITCH_TIMER_VALUE 1
#!define CONFIG_ENABLE_SERVER_STATS 2
#!define CONFIG_UPDATE_SHARED_STATS_INTERVAL 3
