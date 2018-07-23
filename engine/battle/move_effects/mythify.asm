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
	call GetItemHeldEffect
	ld a, b
	cp HELD_PREVENT_CONFUSE
	ret z
	ld a, [wEffectFailed]
	and a
	ret nz
	push hl
	ld hl, wPlayerScreens
	ld a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wEnemyScreens
.got_turn
	bit SCREENS_SAFEGUARD, [hl]
	pop hl
	ret nz
	push hl
	ld hl, wPlayerScreens
	ld a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wEnemyScreens

.got_turn
	bit SCREENS_SAFEGUARD, [hl]
	pop hl

.confuse_opponent
	jp BattleCommand_ConfuseTarget