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
	call ConfuseTarget_AfterSubstitute
	jp BattleCommand_SwitchTurn

.confuse_opponent
	jp BattleCommand_ConfuseTarget