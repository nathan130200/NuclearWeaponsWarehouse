rule "[TEAM 1] Process score":
    @Event playerDied
    @Condition entityExists(attacker)
    @Condition attacker != victim
    @Condition attacker.getTeam() == Team.1
    scores[TEAM1_SCORE] += 1

rule "[TEAM 2] Process score":
    @Event playerDied
    @Condition entityExists(attacker)
    @Condition attacker != victim
    @Condition attacker.getTeam() == Team.2
    scores[TEAM2_SCORE] += 1

rule "[TEAM 1] Update high score":
    @Event global
    @Condition scores[TEAM1_SCORE] > scores[TEAM1_HISCORE]
    scores[TEAM1_HISCORE] = scores[TEAM1_SCORE]

rule "[TEAM 2] Update high score":
    @Event global
    @Condition scores[TEAM2_SCORE] > scores[TEAM2_HISCORE]
    scores[TEAM2_HISCORE] = scores[TEAM2_SCORE]
