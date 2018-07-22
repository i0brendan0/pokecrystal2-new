GetFirstPokemonHappiness: ; 718d
	ld hl, wPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	ld de, wPartySpecies
.loop
	ld a, [de]
	cp EGG
	jr nz, .done
	inc de
	add hl, bc
	jr .loop

.done
	ld [wd265], a
	ld a, [hl]
	ld [wScriptVar], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

CheckFirstMonIsEgg: ; 71ac
	ld a, [wPartySpecies]
	ld [wd265], a
	cp EGG
	ld a, 1
	jr z, .egg
	xor a

.egg
	ld [wScriptVar], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

ChangeHappiness: ; 71c2
; Perform happiness action c on wCurPartyMon

	ld a, [wCurPartyMon]
	inc a
	ld e, a
	ld d, 0
	ld hl, wPartySpecies - 1
	add hl, de
	ld a, [hl]
	cp EGG
	ret z

	push bc
	ld hl, wPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	pop bc

	ld d, h
	ld e, l

	push de
	ld a, [de]
	cp HAPPINESS_THRESHOLD_1
	ld e, 0
	jr c, .ok
	inc e
	cp HAPPINESS_THRESHOLD_2
	jr c, .ok
	inc e

.ok
	dec c
	ld b, 0
	ld hl, HappinessChanges
	add hl, bc
	add hl, bc
	add hl, bc
	ld d, 0
	add hl, de
	ld a, [hl]
	cp $64 ; why not $80?
	pop de

	ld a, [de]
	jr nc, .negative
	add [hl]
	
	push af
	push hl
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld b, [hl]
	call GetItemHeldEffect
	pop hl
	ld a, b
	cp HELD_FRIENDSHIP_INCREASE
	jr z, .increase
	pop af
	jr .done
	
.increase
	pop af
	ld b, [hl]
	srl b
	adc b
	
	jr nc, .done
	ld a, -1
	jr .done

.negative
	add [hl]
	jr c, .done
	xor a

.done
	ld [de], a
	ld a, [wBattleMode]
	and a
	ret z
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wPartyMenuCursor]
	cp b
	ret nz
	ld a, [de]
	ld [wBattleMonHappiness], a
	ret


INCLUDE "data/events/happiness_changes.asm"


StepHappiness:: ; 725a
; Raise the party's happiness by 1 point every other step cycle.

	ld hl, wHappinessStepCount
	ld a, [hl]
	inc a
	and 1
	ld [hl], a
	jr nz, .soothe_bell

	ld de, wPartyCount
	ld a, [de]
	and a
	ret z

	ld c, a
	ld hl, wPartyMon1Happiness
.loop
	inc de
	ld a, [de]
	cp EGG
	jr z, .next
	inc [hl]
	jr nz, .next
	ld [hl], $ff

.next
	push de
	ld de, PARTYMON_STRUCT_LENGTH
	add hl, de
	pop de
	dec c
	jr nz, .loop
	ret
	
.soothe_bell
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld hl, wPartyMon1Item
	ld de, wPartyMon1Happiness
.bell_loop
	push bc
	ld b, [hl]
	call GetItemHeldEffect
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	cp HELD_FRIENDSHIP_BOOST
	ld a, [de]
	jr nz, .no_change
	inc a
	jr nz, .no_change
	dec a
.no_change
	ld [de], a
	ld a, e
	add PARTYMON_STRUCT_LENGTH
	ld e, a
	jr nc, .no_carry
	inc d
.no_carry
	dec c
	jr nz, .bell_loop
	ret

DayCareStep:: ; 7282
; Raise the experience of Day-Care Pokémon every step cycle.

	ld a, [wDayCareMan]
	bit DAYCAREMAN_HAS_MON_F, a
	jr z, .day_care_lady

	ld a, [wBreedMon1Level] ; level
	cp MAX_LEVEL
	jr nc, .day_care_lady
	ld hl, wBreedMon1Exp + 2 ; exp
	inc [hl]
	jr nz, .day_care_lady
	dec hl
	inc [hl]
	jr nz, .day_care_lady
	dec hl
	inc [hl]
	ld a, [hl]
	cp HIGH(MAX_DAY_CARE_EXP >> 8)
	jr c, .day_care_lady
	ld a, HIGH(MAX_DAY_CARE_EXP >> 8)
	ld [hl], a

.day_care_lady
	ld a, [wDayCareLady]
	bit DAYCARELADY_HAS_MON_F, a
	jr z, .check_egg

	ld a, [wBreedMon2Level] ; level
	cp MAX_LEVEL
	jr nc, .check_egg
	ld hl, wBreedMon2Exp + 2 ; exp
	inc [hl]
	jr nz, .check_egg
	dec hl
	inc [hl]
	jr nz, .check_egg
	dec hl
	inc [hl]
	ld a, [hl]
	cp HIGH(MAX_DAY_CARE_EXP >> 8)
	jr c, .check_egg
	ld a, HIGH(MAX_DAY_CARE_EXP >> 8)
	ld [hl], a

.check_egg
	ld hl, wDayCareMan
	bit DAYCAREMAN_MONS_COMPATIBLE_F, [hl]
	ret z
	ld hl, wStepsToEgg
	dec [hl]
	ret nz

	call Random
	ld [hl], a
	callfar CheckBreedmonCompatibility
	ld a, [wd265]
	cp 230
	ld b, 32 percent - 1
	jr nc, .okay
	ld a, [wd265]
	cp 170
	ld b, 16 percent
	jr nc, .okay
	ld a, [wd265]
	cp 110
	ld b, 12 percent
	jr nc, .okay
	ld b, 4 percent

.okay
	call Random
	cp b
	ret nc
	ld hl, wDayCareMan
	res DAYCAREMAN_MONS_COMPATIBLE_F, [hl]
	set DAYCAREMAN_HAS_EGG_F, [hl]
	ret
