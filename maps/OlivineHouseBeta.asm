	const_def 2 ; object constants
	const OLIVINEHOUSEBETA_TEACHER

OlivineHouseBeta_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

OlivineHouseBetaTeacherScript:
    faceplayer
    opentext
    checkevent EVENT_MET_MOVE_RELEARNER
    iftrue .met_relearner
    writetext .intro_text
    setevent EVENT_MET_MOVE_RELEARNER
.met_relearner:
    special MoveRelearner
    end    
    
.intro_text:
	text "Hello! I'm the"
	line "Move Relearner!"

	para "I can help your"
	line "#mon remember"
	para "moves that they"
	line "have forgotten."

	para "I can do this for"
	line "you, in exchange"
	cont "for a Heart Scale."

	para "I collect them,"
	line "you see."
	prompt

OlivineHouseBetaBookshelf1:
	jumpstd picturebookshelf

OlivineHouseBetaBookshelf2:
	jumpstd magazinebookshelf

OlivineHouseBetaTeacherText:
	text "When my #MON"
	line "got sick, the"

	para "PHARMACIST in"
	line "ECRUTEAK made some"
	cont "medicine for me."
	done

OlivineHouseBeta_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  2,  7, OLIVINE_CITY, 4
	warp_event  3,  7, OLIVINE_CITY, 4

	db 0 ; coord events

	db 2 ; bg events
	bg_event  0,  1, BGEVENT_READ, OlivineHouseBetaBookshelf1
	bg_event  1,  1, BGEVENT_READ, OlivineHouseBetaBookshelf2

	db 2 ; object events
	object_event  2,  3, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineHouseBetaTeacherScript, -1
