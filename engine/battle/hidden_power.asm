HiddenPowerDamage: ; fbced
; Override Hidden Power's type and power based on the user's DVs.

	ld hl, wBattleMonDVs
	ld a, [hBattleTurn]
	and a
	jr z, .got_dvs
	ld hl, wEnemyMonDVs
.got_dvs


; Power:

; Take the top bit from each stat

	; Attack
	ld a, [hl]
	swap a
	and %1000

	; Defense
	ld b, a
	ld a, [hli]
	and %1000
	srl a
	or b

	; Speed
	ld b, a
	ld a, [hl]
	swap a
	and %1000
	srl a
	srl a
	or b

	; Special
	ld b, a
	ld a, [hl]
	and %1000
	srl a
	srl a
	srl a
	or b

; Multiply by 5
	ld b, a
	add a
	add a
	add b

; Add Special & 3
	ld b, a
	ld a, [hld]
	and %0011
	add b

; Divide by 2 and add 30 + 1
	srl a
	add 30
	inc a

	ld d, a


; Type:

	; Attack/Defense/Speed/Defense DVs % 21
	ld a, [hli]
	ld [hDividend], a
	ld a, [hl]
	ld [hDividend+1], a
	ld a, NUM_TYPES+1
	ld [hDivisor], a
	ld b, 2
	call Divide
	ld a, [hRemainder]
	cp UNUSED_TYPES
	jr c, .done

; Skip Unused types
	add SPECIAL - UNUSED_TYPES

; Overwrite the current move type.
.done
	push af
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVarAddr
	pop af
	ld [hl], a

; Get the rest of the damage formula variables
; based on the new type, but keep base power.
	ld a, d
	push af
	farcall BattleCommand_DamageStats ; damagestats
	pop af
	ld d, a
	ret
; fbd54
