	const_def 2 ; object constants
	const OLIVINECAFE_SAILOR1
	const OLIVINECAFE_FISHING_GURU
	const OLIVINECAFE_SAILOR2
    const OLIVINECAFE_FALKNER
    const OLIVINECAFE_BUGSY
    const OLIVINECAFE_WHITNEY
    const OLIVINECAFE_MORTY
    const OLIVINECAFE_CHUCK
    const OLIVINECAFE_JASMINE
    const OLIVINECAFE_PRYCE
    const OLIVINECAFE_CLAIR

OlivineCafe_MapScripts:
	db 0 ; scene scripts

	db 1 ; callbacks
    dbw MAPCALLBACK_SPRITES, .leader_sprites
    
.leader_sprites:
    disappear OLIVINECAFE_FALKNER
	disappear OLIVINECAFE_BUGSY
	disappear OLIVINECAFE_WHITNEY
	disappear OLIVINECAFE_MORTY
	disappear OLIVINECAFE_CHUCK
	disappear OLIVINECAFE_JASMINE
	disappear OLIVINECAFE_PRYCE
	disappear OLIVINECAFE_CLAIR
    checkevent EVENT_BEAT_RED
    iffalse .done
    callasm .find_shown_leader
    if_equal 0, .show_falkner
    if_equal 1, .show_bugsy
    if_equal 2, .show_whitney
    if_equal 3, .show_morty
    if_equal 4, .show_chuck
    if_equal 5, .show_jasmine
    if_equal 6, .show_pryce
    appear OLIVINECAFE_CLAIR
    
.done:
    end
    
.show_falkner:
    appear OLIVINECAFE_FALKNER
    end
.show_bugsy:
    appear OLIVINECAFE_BUGSY
    end
.show_whitney:
    appear OLIVINECAFE_WHITNEY
    end
.show_morty:
    appear OLIVINECAFE_MORTY
    end
.show_chuck:
    appear OLIVINECAFE_CHUCK
    end
.show_jasmine:
    appear OLIVINECAFE_JASMINE
    end
.show_pryce:
    appear OLIVINECAFE_PRYCE
    end
    
.find_shown_leader:
    ld a, [wRematchLeaders]
    and 7
    ld [wScriptVar], a
    ret

SailorScript_0x9c8c1:
	faceplayer
	opentext
	checkevent EVENT_GOT_HM04_STRENGTH
	iftrue UnknownScript_0x9c8d3
	writetext UnknownText_0x9c8df
	buttonsound
	verbosegiveitem HM_STRENGTH
	setevent EVENT_GOT_HM04_STRENGTH
UnknownScript_0x9c8d3:
	writetext UnknownText_0x9c965
	waitbutton
	closetext
	end

OlivineCafeFishingGuruScript:
	jumptextfaceplayer OlivineCafeFishingGuruText

OlivineCafeSailorScript:
	jumptextfaceplayer OlivineCafeSailorText

UnknownText_0x9c8df:
	text "Hah! Your #MON"
	line "sure look like"
	cont "lightweights!"

	para "They don't have"
	line "the power to move"
	cont "boulders aside."

	para "Here, use this"
	line "and teach them"
	cont "STRENGTH!"
	done

UnknownText_0x9c965:
	text "On the sea, the"
	line "only thing you can"

	para "count on is your"
	line "own good self!"

	para "I'm so proud of my"
	line "buff bod!"
	done

OlivineCafeFishingGuruText:
	text "OLIVINE CAFE's"
	line "menu is chock full"

	para "of hearty fare for"
	line "beefy SAILORS!"
	done

OlivineCafeSailorText:
	text "Whenever I roll"
	line "into this town, I"

	para "always visit the"
	line "OLIVINE CAFE."

	para "Everything on the"
	line "menu makes me feel"

	para "stronger. I can't"
	line "stop eating!"
	done
    
FalknerRematchScript:
    scall CheckBattleAlreadyO
    faceplayer
    opentext 
    writetext FalknerAskRematchText
    yesorno
    iffalse DidNotBattleO
    winlosstext FalknerRematchWinText, FalknerRematchLossText
    setlasttalked OLIVINECAFE_FALKNER
    loadtrainer FALKNER, FALKNER2
    jump StartBattleO
    
BugsyRematchScript:
    scall CheckBattleAlreadyO
    faceplayer
    opentext 
    writetext BugsyAskRematchText
    yesorno
    iffalse DidNotBattleO
    winlosstext BugsyRematchWinText, BugsyRematchLossText
    setlasttalked OLIVINECAFE_BUGSY
    loadtrainer BUGSY, BUGSY2
    jump StartBattleO
    
WhitneyRematchScript:
    scall CheckBattleAlreadyO
    faceplayer
    opentext 
    writetext WhitneyAskRematchText
    yesorno
    iffalse DidNotBattleO
    winlosstext WhitneyRematchWinText, WhitneyRematchLossText
    setlasttalked OLIVINECAFE_WHITNEY
    loadtrainer WHITNEY, WHITNEY2
    jump StartBattleO
    
MortyRematchScript:
    scall CheckBattleAlreadyO
    faceplayer
    opentext 
    writetext MortyAskRematchText
    yesorno
    iffalse DidNotBattleO
    winlosstext MortyRematchWinText, MortyRematchLossText
    setlasttalked OLIVINECAFE_MORTY
    loadtrainer MORTY, MORTY2
    jump StartBattleO
    
ChuckRematchScript:
    scall CheckBattleAlreadyO
    faceplayer
    opentext 
    writetext ChuckAskRematchText
    yesorno
    iffalse DidNotBattleO
    winlosstext ChuckRematchWinText, ChuckRematchLossText
    setlasttalked OLIVINECAFE_CHUCK
    loadtrainer CHUCK, CHUCK2
    jump StartBattleO
    
JasmineRematchScript:
    scall CheckBattleAlreadyO
    faceplayer
    opentext 
    writetext JasmineAskRematchText
    yesorno
    iffalse DidNotBattleO
    winlosstext JasmineRematchWinText, JasmineRematchLossText
    setlasttalked OLIVINECAFE_JASMINE
    loadtrainer JASMINE, JASMINE2
    jump StartBattleO
    
PryceRematchScript:
    scall CheckBattleAlreadyO
    faceplayer
    opentext 
    writetext PryceAskRematchText
    yesorno
    iffalse DidNotBattleO
    winlosstext PryceRematchWinText, PryceRematchLossText
    setlasttalked OLIVINECAFE_PRYCE
    loadtrainer PRYCE, PRYCE2
    jump StartBattleO
    
ClairRematchScript:
    scall CheckBattleAlreadyO
    faceplayer
    opentext 
    writetext ClairAskRematchText
    yesorno
    iffalse DidNotBattleO
    winlosstext ClairRematchWinText, ClairRematchLossText
    setlasttalked OLIVINECAFE_CLAIR
    loadtrainer CLAIR, CLAIR2
    jump StartBattleO
    
CheckBattleAlreadyO:
    checkevent EVENT_BEAT_KANTO_LEADER
    iffalse GoBackO
    faceplayer
    opentext 
    writetext BattledAlreadyTextO
    waitbutton
    closetext
    end_all
    
DidNotBattleO:
    writetext DidNotBattleTextO
    waitbutton
    closetext
GoBackO:
    end
    
StartBattleO:
	writecode VAR_BATTLETYPE, BATTLETYPE_CANLOSE
    startbattle
    reloadmap
    iffalse .LossToLeader
    opentext
    writetext BeatLeaderTextO
    jump .WonToLeader
.LossToLeader:
    opentext
    writetext LoseLeaderTextO
.WonToLeader:
    waitbutton
    closetext
	special HealParty
    setevent EVENT_BEAT_KANTO_LEADER
    end
    
FalknerAskRematchText:
BugsyAskRematchText:
WhitneyAskRematchText:
MortyAskRematchText:
ChuckAskRematchText:
JasmineAskRematchText:
PryceAskRematchText:
ClairAskRematchText:
    text "Battle?"
    done
	
FalknerRematchWinText:
BugsyRematchWinText:
WhitneyRematchWinText:
MortyRematchWinText:
ChuckRematchWinText:
JasmineRematchWinText:
PryceRematchWinText:
ClairRematchWinText:
    text "You win."
    done
	
FalknerRematchLossText:
BugsyRematchLossText:
WhitneyRematchLossText:
MortyRematchLossText:
ChuckRematchLossText:
JasmineRematchLossText:
PryceRematchLossText:
ClairRematchLossText:
    text "You lose."
    done
    
DidNotBattleTextO:
    text "Next time."
    done
    
BattledAlreadyTextO:
    text "Can't battle."
    done

BeatLeaderTextO:
    text "Good battle."
    done
    
LoseLeaderTextO:
    text "I'm good."
    done

OlivineCafe_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  2,  7, OLIVINE_CITY, 7
	warp_event  3,  7, OLIVINE_CITY, 7

	db 0 ; coord events

	db 0 ; bg events

	db 11 ; object events
	object_event  4,  3, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SailorScript_0x9c8c1, -1
	object_event  7,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeFishingGuruScript, -1
	object_event  6,  6, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeSailorScript, -1
	person_event SPRITE_FALKNER, 6, 2,  SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE,  PERSONTYPE_SCRIPT, 0, FalknerRematchScript, EVENT_CAFE_FALKNER
	person_event SPRITE_BUGSY,   1, 2,  SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, BugsyRematchScript,   EVENT_CAFE_BUGSY
	person_event SPRITE_WHITNEY, 4, 1,  SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED,   PERSONTYPE_SCRIPT, 0, WhitneyRematchScript, EVENT_CAFE_WHITNEY
	person_event SPRITE_MORTY,   5, 4,  SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, MortyRematchScript,   EVENT_CAFE_MORTY
	person_event SPRITE_CHUCK,   2, 8,  SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ChuckRematchScript,   EVENT_CAFE_CHUCK
	person_event SPRITE_JASMINE, 4, 6,  SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED,   PERSONTYPE_SCRIPT, 0, JasmineRematchScript, EVENT_CAFE_JASMINE
	person_event SPRITE_PRYCE,   2, 5,  SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, PryceRematchScript,   EVENT_CAFE_PRYCE
	person_event SPRITE_CLAIR,   6, 12, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE,  PERSONTYPE_SCRIPT, 0, ClairRematchScript,   EVENT_CAFE_CLAIR
