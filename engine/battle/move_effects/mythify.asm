BattleCommand_Mythify:
	call BattleRandom
	rra
	jr c, .confuse_opponent	
	call BattleCommand_SwitchTurn
	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_CONFUSE
	ret z
	ld a, [wEffectFailed]
	and a
	ret nz
	call SafeCheckSafeguard
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVarAddr
	bit SUBSTATUS_CONFUSED, [hl]
	ret nz
	call BattleCommand_FinishConfusingTarget
	jp BattleCommand_SwitchTurn

.confuse_opponent
	jp BattleCommand_ConfuseTarget