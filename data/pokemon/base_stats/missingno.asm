	db MISSINGNO ; 252

	db  106, 155,  17,  44,  44, 114
	;   hp   atk  def  spd  sat  sdf

	db CURSE_T, CURSE_T
	db 45 ; catch rate
	db 100 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDERLESS ; gender
	db 100 ; unknown
	db 120 ; step cycles to hatch
	db 5 ; unknown
	INCBIN "gfx/pokemon/missingno/front.dimensions"
	db 0, 0, 0, 0 ; padding
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tmhm
	tmhm
	; end
