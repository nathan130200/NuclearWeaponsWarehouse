globalvar configs

#!define registerConfig(type, name, category, id, defaultValue, slot) \
    configs[id] = createWorkshopSetting(type, category, name, defaultValue, slot)

#!define getConfig(id) configs[id]


#!define CONFIG_SWITCH_TIMER_ENABLED 0
#!define CONFIG_SWITCH_TIMER_INTERVAL 1
#!define CONFIG_SWITCH_TIMER_VALUE 2
