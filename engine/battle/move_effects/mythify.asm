BattleCommand_Mythify:
	call BattleRandom
	rra
	jr c, .confuse_opponent
	ld hl, wBattleMonItem
	ld a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wEnemyMonItem
.go
	ld b, [hl]
	jp GetItemHeldEffect
.confuse_opponent
	jp BattleCommand_ConfuseTarget