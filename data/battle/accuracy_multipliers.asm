; Multiplier ratios for accuracy from modifier -6 to +6
; (for other stats, see data/battle/stat_multipliers.asm).

AccuracyLevelMultipliers:
	db 1, 3 ; -6 =  33.33%
	db 3, 8 ; -5 =  37.5%
	db 3, 7 ; -4 =  42.86%
	db 1, 2 ; -3 =  50%
	db 3, 5 ; -2 =  60%
	db 3, 4 ; -1 =  75%
	db 1, 1 ;  0 = 100%
	db 4, 3 ; +1 = 133.33%
	db 5, 3 ; +2 = 166.66%
	db 2, 1 ; +3 = 200%
	db 7, 3 ; +4 = 233.33%
	db 8, 3 ; +5 = 266.66%
	db 3, 1 ; +6 = 300%
