	const_def 2 ; object constants
	const CELADONCAFE_SUPER_NERD
	const CELADONCAFE_FISHER1
	const CELADONCAFE_FISHER2
	const CELADONCAFE_FISHER3
	const CELADONCAFE_TEACHER
	const CELADONCAFE_BROCK
	const CELADONCAFE_MISTY
	const CELADONCAFE_LTSURGE
	const CELADONCAFE_ERIKA
	const CELADONCAFE_JANINE
	const CELADONCAFE_SABRINA
	const CELADONCAFE_BLAINE
	const CELADONCAFE_BLUE

CeladonCafe_MapScripts:
	db 0 ; scene scripts

	db 1 ; callbacks
    dbw MAPCALLBACK_SPRITES, .leader_sprites
    
.leader_sprites:
    disappear CELADONCAFE_BROCK
	disappear CELADONCAFE_MISTY
	disappear CELADONCAFE_LTSURGE
	disappear CELADONCAFE_ERIKA
	disappear CELADONCAFE_JANINE
	disappear CELADONCAFE_SABRINA
	disappear CELADONCAFE_BLAINE
	disappear CELADONCAFE_BLUE
    checkevent EVENT_BEAT_RED
    iffalse .done
    callasm .find_shown_leader
    if_equal 0, .show_brock
    if_equal 1, .show_misty
    if_equal 2, .show_lt_surge
    if_equal 3, .show_erika
    if_equal 4, .show_janine
    if_equal 5, .show_sabrina
    if_equal 6, .show_blaine
    appear CELADONCAFE_BLUE
    
.done:
    end
    
.show_brock:
    appear CELADONCAFE_BROCK
    end
.show_misty:
    appear CELADONCAFE_MISTY
    end
.show_lt_surge:
    appear CELADONCAFE_LTSURGE
    end
.show_erika:
    appear CELADONCAFE_ERIKA
    end
.show_janine:
    appear CELADONCAFE_JANINE
    end
.show_sabrina:
    appear CELADONCAFE_SABRINA
    end
.show_blaine:
    appear CELADONCAFE_BLAINE
    end
    
.find_shown_leader:
    ld a, [wRematchLeaders]
    swap a
    and 7
    ld [wScriptVar], a
    ret
    

CeladonCafeChef:
	faceplayer
	opentext
	writetext ChefText_Eatathon
	waitbutton
	closetext
	end

CeladonCafeFisher1:
	opentext
	writetext Fisher1Text_Snarfle
	waitbutton
	closetext
	faceplayer
	opentext
	writetext Fisher1Text_Concentration
	waitbutton
	closetext
	turnobject CELADONCAFE_FISHER1, LEFT
	end

CeladonCafeFisher2:
	opentext
	writetext Fisher2Text_GulpChew
	waitbutton
	closetext
	faceplayer
	opentext
	writetext Fisher2Text_Quantity
	waitbutton
	closetext
	turnobject CELADONCAFE_FISHER2, RIGHT
	end

CeladonCafeFisher3:
	opentext
	writetext Fisher3Text_MunchMunch
	waitbutton
	closetext
	faceplayer
	opentext
	writetext Fisher3Text_GoldenrodIsBest
	waitbutton
	closetext
	turnobject CELADONCAFE_FISHER3, RIGHT
	end

CeladonCafeTeacher:
	checkitem COIN_CASE
	iftrue .HasCoinCase
	opentext
	writetext TeacherText_CrunchCrunch
	waitbutton
	closetext
	faceplayer
	opentext
	writetext TeacherText_NoCoinCase
	waitbutton
	closetext
	turnobject CELADONCAFE_TEACHER, LEFT
	end

.HasCoinCase:
	opentext
	writetext TeacherText_KeepEating
	waitbutton
	closetext
	turnobject CELADONCAFE_TEACHER, RIGHT
	opentext
	writetext TeacherText_MoreChef
	waitbutton
	closetext
	turnobject CELADONCAFE_TEACHER, LEFT
	end

EatathonContestPoster:
	jumptext EatathonContestPosterText

CeladonCafeTrashcan:
	checkevent EVENT_FOUND_LEFTOVERS_IN_CELADON_CAFE
	iftrue .TrashEmpty
	giveitem LEFTOVERS
	iffalse .PackFull
	opentext
	itemtotext LEFTOVERS, MEM_BUFFER_0
	writetext FoundLeftoversText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	setevent EVENT_FOUND_LEFTOVERS_IN_CELADON_CAFE
	end

.PackFull:
	opentext
	itemtotext LEFTOVERS, MEM_BUFFER_0
	writetext FoundLeftoversText
	buttonsound
	writetext NoRoomForLeftoversText
	waitbutton
	closetext
	end

.TrashEmpty:
	jumpstd trashcan

ChefText_Eatathon:
	text "Hi!"

	para "We're holding an"
	line "eatathon contest."

	para "We can't serve you"
	line "right now. Sorry."
	done

Fisher1Text_Snarfle:
	text "…Snarfle, chew…"
	done

Fisher1Text_Concentration:
	text "Don't talk to me!"

	para "You'll break my"
	line "concentration!"
	done

Fisher2Text_GulpChew:
	text "…Gulp… Chew…"
	done

Fisher2Text_Quantity:
	text "I take quantity"
	line "over quality!"

	para "I'm happy when I'm"
	line "full!"
	done

Fisher3Text_MunchMunch:
	text "Munch, munch…"
	done

Fisher3Text_GoldenrodIsBest:
	text "The food is good"
	line "here, but GOLDEN-"
	cont "ROD has the best"
	cont "food anywhere."
	done

TeacherText_CrunchCrunch:
	text "Crunch… Crunch…"
	done

TeacherText_NoCoinCase:
	text "Nobody here will"
	line "give you a COIN"

	para "CASE. You should"
	line "look in JOHTO."
	done

TeacherText_KeepEating:
	text "Crunch… Crunch…"

	para "I can keep eating!"
	done

TeacherText_MoreChef:
	text "More, CHEF!"
	done

EatathonContestPosterText:
	text "Eatathon Contest!"
	line "No time limit!"

	para "A battle without"
	line "end! The biggest"

	para "muncher gets it"
	line "all for free!"
	done

FoundLeftoversText:
	text "<PLAYER> found"
	line "@"
	text_from_ram wStringBuffer3
	text "!"
	done

NoRoomForLeftoversText:
	text "But <PLAYER> can't"
	line "hold another item…"
	done
    
BrockRematchScript:
    scall CheckBattleAlready
    faceplayer
    opentext 
    writetext BrockAskRematchText
    yesorno
    iffalse DidNotBattle
    winlosstext BrockRematchWinText, BrockRematchLossText
    setlasttalked CELADONCAFE_BROCK
    loadtrainer BROCK, BROCK2
    jump StartBattle
    
MistyRematchScript:
    scall CheckBattleAlready
    faceplayer
    opentext 
    writetext MistyAskRematchText
    yesorno
    iffalse DidNotBattle
    winlosstext MistyRematchWinText, MistyRematchLossText
    setlasttalked CELADONCAFE_MISTY
    loadtrainer MISTY, MISTY2
    jump StartBattle
    
LtSurgeRematchScript:
    scall CheckBattleAlready
    faceplayer
    opentext 
    writetext LtSurgeAskRematchText
    yesorno
    iffalse DidNotBattle
    winlosstext LtSurgeRematchWinText, LtSurgeRematchLossText
    setlasttalked CELADONCAFE_LTSURGE
    loadtrainer LT_SURGE, LT_SURGE2
    jump StartBattle
    
ErikaRematchScript:
    scall CheckBattleAlready
    faceplayer
    opentext 
    writetext ErikaAskRematchText
    yesorno
    iffalse DidNotBattle
    winlosstext ErikaRematchWinText, ErikaRematchLossText
    setlasttalked CELADONCAFE_ERIKA
    loadtrainer ERIKA, ERIKA2
    jump StartBattle
    
JanineRematchScript:
    scall CheckBattleAlready
    faceplayer
    opentext 
    writetext JanineAskRematchText
    yesorno
    iffalse DidNotBattle
    winlosstext JanineRematchWinText, JanineRematchLossText
    setlasttalked CELADONCAFE_JANINE
    loadtrainer JANINE, JANINE2
    jump StartBattle
    
SabrinaRematchScript:
    scall CheckBattleAlready
    faceplayer
    opentext 
    writetext SabrinaAskRematchText
    yesorno
    iffalse DidNotBattle
    winlosstext SabrinaRematchWinText, SabrinaRematchLossText
    setlasttalked CELADONCAFE_SABRINA
    loadtrainer SABRINA, SABRINA2
    jump StartBattle
    
BlaineRematchScript:
    scall CheckBattleAlready
    faceplayer
    opentext 
    writetext BlaineAskRematchText
    yesorno
    iffalse DidNotBattle
    winlosstext BlaineRematchWinText, BlaineRematchLossText
    setlasttalked CELADONCAFE_BLAINE
    loadtrainer BLAINE, BLAINE2
    jump StartBattle
    
BlueRematchScript:
    scall CheckBattleAlready
    faceplayer
    opentext 
    writetext BlueAskRematchText
    yesorno
    iffalse DidNotBattle
    winlosstext BlueRematchWinText, BlueRematchLossText
    setlasttalked CELADONCAFE_BLUE
    loadtrainer BLUE, BLUE2
    jump StartBattle
    
CheckBattleAlready:
    checkevent EVENT_BEAT_KANTO_LEADER
    iffalse GoBack
    faceplayer
    opentext 
    writetext BattledAlreadyText
    waitbutton
    closetext
    end_all
    
DidNotBattle:
    writetext DidNotBattleText
    waitbutton
    closetext
GoBack:
    end
    
StartBattle:
	writecode VAR_BATTLETYPE, BATTLETYPE_CANLOSE
    startbattle
    reloadmap
    iffalse .LossToLeader
    opentext
    writetext BeatLeaderText
    jump .WonToLeader
.LossToLeader:
    opentext
    writetext LoseLeaderText
.WonToLeader:
    waitbutton
    closetext
	special HealParty
    setevent EVENT_BEAT_KANTO_LEADER
    end
    
BrockAskRematchText:
MistyAskRematchText:
LtSurgeAskRematchText:
ErikaAskRematchText:
JanineAskRematchText:
SabrinaAskRematchText:
BlaineAskRematchText:
BlueAskRematchText:
    text "Battle?"
    done

BrockRematchWinText:
MistyRematchWinText:
LtSurgeRematchWinText:
ErikaRematchWinText:
JanineRematchWinText:
SabrinaRematchWinText:
BlaineRematchWinText:
BlueRematchWinText:
    text "You win."
    done

BrockRematchLossText:
MistyRematchLossText:
LtSurgeRematchLossText:
ErikaRematchLossText:
JanineRematchLossText:
SabrinaRematchLossText:
BlaineRematchLossText:
BlueRematchLossText:
    text "You lose."
    done
    
DidNotBattleText:
    text "Next time."
    done
    
BattledAlreadyText:
    text "Can't battle."
    done

BeatLeaderText:
    text "Good battle."
    done
    
LoseLeaderText:
    text "I'm good."
    done

CeladonCafe_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  6,  7, CELADON_CITY, 9
	warp_event  7,  7, CELADON_CITY, 9

	db 0 ; coord events

	db 2 ; bg events
	bg_event  5,  0, BGEVENT_READ, EatathonContestPoster
	bg_event  7,  1, BGEVENT_READ, CeladonCafeTrashcan

	db 13 ; object events
	object_event  9,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CeladonCafeChef, -1
	object_event  4,  6, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCafeFisher1, -1
	object_event  1,  7, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonCafeFisher2, -1
	object_event  1,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCafeFisher3, -1
	object_event  4,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCafeTeacher, -1
	person_event SPRITE_BROCK,   6, 2,  SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BrockRematchScript,   EVENT_CAFE_BROCK
	person_event SPRITE_MISTY,   4, 1,  SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED,   PERSONTYPE_SCRIPT, 0, MistyRematchScript,   EVENT_CAFE_MISTY
	person_event SPRITE_SURGE,   1, 3,  SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, LtSurgeRematchScript,   EVENT_CAFE_LTSURGE
	person_event SPRITE_ERIKA,   5, 4,  SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ErikaRematchScript,   EVENT_CAFE_ERIKA
	person_event SPRITE_JANINE,  5, 11, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE,  PERSONTYPE_SCRIPT, 0, JanineRematchScript,  EVENT_CAFE_JANINE
	person_event SPRITE_SABRINA, 2, 11, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED,   PERSONTYPE_SCRIPT, 0, SabrinaRematchScript, EVENT_CAFE_SABRINA
	person_event SPRITE_BLAINE,  6, 12, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, BlaineRematchScript,  EVENT_CAFE_BLAINE
	person_event SPRITE_BLUE,    6, 15, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED,   PERSONTYPE_SCRIPT, 0, BlueRematchScript,    EVENT_CAFE_BLUE
