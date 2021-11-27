globalvar configs

#!define registerConfig(type, name, category, _ID, defaultValue) \
    configs[_ID] = createWorkshopSetting(type, category, name, defaultValue, _ID)

#!define getConfig(_ID) configs[_ID]


#!define ID_SWITCH_TIMER_ENABLED 0
#!define ID_SWITCH_TIMER_INTERVAL 1
#!define ID_SWITCH_TIMER_VALUE 2
