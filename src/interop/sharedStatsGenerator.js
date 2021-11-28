// subroutine Hud_UpdateDamageStats

function template(name, key) {
    return `
def ${name}():
    @Name "[SHARED STATS] Update shared stat '${key}'"
    statTemp = [
        (stats[STAT_${key}] / 1000),
        ((stats[STAT_${key}] / 1000) / 1000)
    ]

    if statTemp[1] >= 0.5:
        statText[STAT_${key}] = "{} M".format(statTemp[1])
    elif statTemp[0] >= 0.5:
        statText[STAT_${key}] = "{} K".format(statTemp[0])
    else:
        statText[STAT_${key}] = stats[STAT_${key}]
        
    wait(1)
`;
}

var subroutines = [];

for (var key of keys) {
    var subroutineName = `hud_update_${key.toLowerCase()}_stat`;

    subroutines.push({
        name: subroutineName,
        signature: `subroutine ${subroutineName}`,
        body: template(subroutineName, key)
    })
}

var root = subroutines.map(x => x.signature).join('\n');
root += '\n' + subroutines.map(x => x.body).join('\n\n');

root + `
rule "[SHARED STATS] Update display task.":
    @Event global
${subroutines.map(x => `\t${x.name}()`).join('\n')}
    wait(getConfig(CONFIG_UPDATE_SHARED_STATS_INTERVAL))
    goto RULE_START`;
