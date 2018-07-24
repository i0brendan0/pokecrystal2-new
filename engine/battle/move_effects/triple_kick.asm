BattleCommand_TripleKick: ; 346b2
; triplekick

	farcall TripleKickFar
	ret

; 346cd


BattleCommand_KickCounter: ; 346cd
; kickcounter

	ld hl, wKickCounter
	inc [hl]
	ret

; 346d2
