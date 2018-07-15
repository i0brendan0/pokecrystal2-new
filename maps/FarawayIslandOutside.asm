	const_def 2 ; object constants
	const FARAWAY_ISLAND_SAILOR

FarawayIslandOutside_MapScriptHeader::
	db 0 ; scene scripts

	db 0 ; callbacks

Check_Home:
	spriteface PLAYER, LEFT
	spriteface FARAWAY_ISLAND_SAILOR, RIGHT
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	jump DoHomeScript

MapSailorFWI:
	faceplayer
DoHomeScript:
	opentext
	checkevent EVENT_FOUGHT_MEW
	iffalse .FightMew
	writetext AskGoHomeText
	yesorno
	iffalse .DidNotLeave
	writetext GoHomeText
	special FadeOutPalettes
	pause 15
	warpfacing UP, OLIVINE_PORT, 15, 15
	end

.FightMew:
	writetext FightMewText
	waitbutton
	closetext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .GoBack
	end

.DidNotLeave:
	writetext NoLeaveText
	waitbutton
	closetext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .GoBack
	end
	
.GoBack:
	applymovement PLAYER, GoBackMovement
	spriteface FARAWAY_ISLAND_SAILOR, UP
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	end
	
GoBackMovement:
	step UP
	step_end
	
FightMewText:
	text "Looks like you"
	line "haven't looked inside"
	cont "the cave there."
	
	para "Go inside and see if"
	line "you find anything."
	done

AskGoHomeText:
	text "Are you done looking"
	line "around and you want"
	cont "to go home?"
	done
	
GoHomeText:
	text "Ok. Let's head on"
	line "out shall we?"
	done

NoLeaveText:
	text "Ok then. I'll be"
	line "waiting then."
	done

FarawayIslandOutside_MapEvents:
	db 0, 0 ; filler

	db 1 ; warp events
	warp_def 17, 14, 1, FARAWAY_ISLAND_CAVE

	db 1 ; coord events
	xy_trigger 0, 23, 14, 0, Check_Home, 0, 0

	db 0 ; bg events

	db 1 ; object events
	person_event SPRITE_SAILOR, 23, 13, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, MapSailorFWI, EVENT_FARAWAY_ISLAND_MAP_SAILOR
