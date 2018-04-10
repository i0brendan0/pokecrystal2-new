	const_def 2 ; object constants
	const ROUTE34ILEXFORESTGATE_TEACHER1
	const ROUTE34ILEXFORESTGATE_BUTTERFREE
	const ROUTE34ILEXFORESTGATE_LASS
	const ROUTE34ILEXFORESTGATE_TEACHER2

Route34IlexForestGate_MapScripts:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_OBJECTS, .IsForestRestless

.IsForestRestless:
	checkevent EVENT_FOREST_IS_RESTLESS
	iffalse .Normal
	disappear ROUTE34ILEXFORESTGATE_TEACHER1
	appear ROUTE34ILEXFORESTGATE_TEACHER2
	return

.Normal:
	disappear ROUTE34ILEXFORESTGATE_TEACHER2
	appear ROUTE34ILEXFORESTGATE_TEACHER1
	return

Route34IlexForestGateCelebiEvent:
	checkevent EVENT_FOREST_IS_RESTLESS
	iffalse .skip
	showemote EMOTE_SHOCK, ROUTE34ILEXFORESTGATE_TEACHER2, 20
	turnobject ROUTE34ILEXFORESTGATE_TEACHER2, LEFT
	turnobject PLAYER, RIGHT
	follow PLAYER, ROUTE34ILEXFORESTGATE_TEACHER2
	applymovement PLAYER, MovementData_0x62d97
	stopfollow
	turnobject PLAYER, DOWN
	opentext
	writetext UnknownText_0x62e41
	waitbutton
	closetext
	applymovement ROUTE34ILEXFORESTGATE_TEACHER2, MovementData_0x62d9a
.skip:
	end

TeacherScript_0x62d63:
	faceplayer
	opentext
	checkevent EVENT_FOREST_IS_RESTLESS
	iftrue .ForestIsRestless
    checkevent EVENT_BEAT_RED
    iftrue GetSweetHoney
	checkevent EVENT_GOT_TM12_SWEET_SCENT
	iftrue .GotSweetScent
	writetext UnknownText_0x62d9d
	buttonsound
	verbosegiveitem TM_SWEET_SCENT, 10
	iffalse .NoRoom
	setevent EVENT_GOT_TM12_SWEET_SCENT
.GotSweetScent:
	writetext UnknownText_0x62df6
	waitbutton
.NoRoom:
	closetext
	end

.ForestIsRestless:
	writetext UnknownText_0x62e41
	buttonsound
	closetext
	end
    
GetSweetHoney:
	checkevent EVENT_GOT_HONEY
	iftrue UnknownScript_0x62d7e
	writetext SweetHoneyText
	buttonsound
	verbosegiveitem SWEET_HONEY
	iffalse CantGiveSweetHoney
	setevent EVENT_GOT_HONEY
	writetext SweetHoneyGiveText
	waitbutton
	closetext
	end

CantGiveSweetHoney:
	writetext SweetHoneyBagFullText
	waitbutton
	closetext
	end

IlexGateButterfree:
	opentext
	writetext UnknownText_0x62e83
	cry BUTTERFREE
	waitbutton
	closetext
	end

Route34IlexForestGateLassScript:
	jumptextfaceplayer Route34IlexForestGateLassText

MovementData_0x62d97:
	step UP
	step UP
	step_end

MovementData_0x62d9a:
	step DOWN
	step RIGHT
	step_end
    
SweetHoneyText:
	text "My #MON is an"
	line "expert at collect-"
	cont "ing SWEET HONEY."

	para "I'll share some"
	line "with you."
	done
	
SweetHoneyBagFullText: ; 0x557d6
	text "I want to give you"
	line "some SWEET HONEY,"

	para "but you have no"
	line "room for it."
	done
	
SweetHoneyGiveText: ; 0x55819
	text "Here you go! Have"
	line "some SWEET HONEY!"
	
	para "Have a #MON"
	line "hold it to make a"
	cont "wild #MON"
	cont "easier to catch."
	done



UnknownText_0x62d9d:
	text "Oh, honey. You're"
	line "making a #DEX?"

	para "It must be hard if"
	line "#MON won't"

	para "appear. Try using"
	line "this TM."
	done

UnknownText_0x62df6:
	text "It's SWEET SCENT."

	para "Use it wherever"
	line "#MON appear."

	para "#MON will be"
	line "enticed by it."
	done

UnknownText_0x62e41:
	text "Something's wrong"
	line "in ILEX FOREST…"

	para "You should stay"
	line "away right now."
	done

UnknownText_0x62e83:
	text "BUTTERFREE: Freeh!"
	done

Route34IlexForestGateLassText:
	text "Did you see the"
	line "shrine honoring"
	cont "the protector?"

	para "It watches over"
	line "the FOREST from"
	cont "across time."

	para "I think that it"
	line "must be a grass-"
	cont "type #MON."
	done

Route34IlexForestGate_MapEvents:
	db 0, 0 ; filler

	db 4 ; warp events
	warp_event  4,  0, ROUTE_34, 1
	warp_event  5,  0, ROUTE_34, 2
	warp_event  4,  7, ILEX_FOREST, 1
	warp_event  5,  7, ILEX_FOREST, 1

	db 1 ; coord events
	coord_event  4,  7, SCENE_DEFAULT, Route34IlexForestGateCelebiEvent

	db 0 ; bg events

	db 4 ; object events
	object_event  9,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TeacherScript_0x62d63, EVENT_ROUTE_34_ILEX_FOREST_GATE_TEACHER_BEHIND_COUNTER
	object_event  9,  4, SPRITE_BUTTERFREE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, IlexGateButterfree, -1
	object_event  3,  4, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route34IlexForestGateLassScript, EVENT_ROUTE_34_ILEX_FOREST_GATE_LASS
	object_event  5,  7, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TeacherScript_0x62d63, EVENT_ROUTE_34_ILEX_FOREST_GATE_TEACHER_IN_WALKWAY
