INCLUDE "constants.asm"
INCLUDE "macros/wram.asm"


INCLUDE "vram.asm"


SECTION "Stack", WRAM0

wStackBottom::
	ds $100 - 1
wStack::
wStackTop::
	ds 1


SECTION "Audio RAM", WRAM0

wMusic::

; nonzero if playing
wMusicPlaying:: ds 1 ; c100

wChannels::
wChannel1:: channel_struct wChannel1 ; c101
wChannel2:: channel_struct wChannel2 ; c133
wChannel3:: channel_struct wChannel3 ; c165
wChannel4:: channel_struct wChannel4 ; c197

wSFXChannels::
wChannel5:: channel_struct wChannel5 ; c1c9
wChannel6:: channel_struct wChannel6 ; c1fb
wChannel7:: channel_struct wChannel7 ; c22d
wChannel8:: channel_struct wChannel8 ; c25f

	ds 1 ; c291

wCurTrackDuty:: ds 1
wCurTrackIntensity:: ds 1
wCurTrackFrequency:: ds 2
wc296:: ds 1 ; BCD value, dummied out
wCurNoteDuration:: ds 1 ; used in MusicE0 and LoadNote

wCurMusicByte:: ds 1 ; c298
wCurChannel:: ds 1 ; c299
wVolume:: ; c29a
; corresponds to $ff24
; Channel control / ON-OFF / Volume (R/W)
;   bit 7 - Vin->SO2 ON/OFF
;   bit 6-4 - SO2 output level (volume) (# 0-7)
;   bit 3 - Vin->SO1 ON/OFF
;   bit 2-0 - SO1 output level (volume) (# 0-7)
	ds 1
wSoundOutput:: ; c29b
; corresponds to $ff25
; bit 4-7: ch1-4 so2 on/off
; bit 0-3: ch1-4 so1 on/off
	ds 1
wSoundInput:: ; c29c
; corresponds to $ff26
; bit 7: global on/off
; bit 0: ch1 on/off
; bit 1: ch2 on/off
; bit 2: ch3 on/off
; bit 3: ch4 on/off
	ds 1

wMusicID:: ds 2 ; c29d
wMusicBank:: ds 1 ; c29f
wNoiseSampleAddress:: ds 2 ; c2a0
wNoiseSampleDelay:: ds 1 ; c2a2
	ds 1 ; c2a3
wMusicNoiseSampleSet:: ds 1 ; c2a4
wSFXNoiseSampleSet:: ds 1 ; c2a5

wLowHealthAlarm:: ; c2a6
; bit 7: on/off
; bit 4: pitch
; bit 0-3: counter
	ds 1

wMusicFade:: ; c2a7
; fades volume over x frames
; bit 7: fade in/out
; bit 0-5: number of frames for each volume level
; $00 = none (default)
	ds 1
wMusicFadeCount:: ds 1 ; c2a8
wMusicFadeID:: ds 2 ; c2a9

wCryPitch:: ds 2 ; c2b0
wCryLength:: ds 2 ; c2b2

wLastVolume:: ds 1 ; c2b4
wc2b5:: ds 1 ; c2b5

wSFXPriority:: ; c2b6
; if nonzero, turn off music when playing sfx
	ds 1

wChannel1JumpCondition:: ds 1
wChannel2JumpCondition:: ds 1
wChannel3JumpCondition:: ds 1
wChannel4JumpCondition:: ds 1

wStereoPanningMask:: ds 1 ; c2bc

wCryTracks:: ; c2bd
; plays only in left or right track depending on what side the monster is on
; both tracks active outside of battle
	ds 1

wSFXDuration:: ds 1
wCurSFX:: ; c2bf
; id of sfx currently playing
	ds 1
wChannelsEnd::

wMapMusic:: ds 1 ; c2c0

wDontPlayMapMusicOnReload:: ds 1
wMusicEnd::


SECTION "WRAM", WRAM0

wLZAddress:: ds 2 ; c2c2
wLZBank::    ds 1 ; c2c4

	ds 1

wBoxAlignment:: ds 1

wInputType::        ds 1 ; c2c7
wAutoInputAddress:: ds 2 ; c2c8
wAutoInputBank::    ds 1 ; c2ca
wAutoInputLength::  ds 1 ; c2cb

wMonStatusFlags:: ds 1
wGameLogicPaused:: ds 1 ; c2cd
wSpriteUpdatesEnabled:: ds 1

wc2cf:: ds 1 ; ????

wMapTimeOfDay:: ds 1

	ds 3

wPrinterConnectionOpen:: ds 1
wPrinterOpcode:: ds 1
wPrevDexEntry:: ds 1
wDisableTextAcceleration:: ds 1
wPreviousLandmark:: ds 1
wCurrentLandmark:: ds 1
wLandmarkSignTimer:: ds 2
wLinkMode:: ; c2dc
; 0 not in link battle
; 1 link battle
; 4 mobile battle
	ds 1

wScriptVar:: ds 1 ; c2dd

wPlayerNextMovement:: ds 1
wPlayerMovement:: ds 1
	ds 2
wc2e2::
wMovementObject::
	ds 1
wMovementDataPointer:: ds 3 ; dba
wc2e6:: ds 4
wMovementByteWasControlSwitch:: ds 1
wMovementPointer:: ds 2 ; c2eb

	ds 3

wTempObjectCopyMapObjectIndex:: ds 1 ; c2f0
wTempObjectCopySprite:: ds 1 ; c2f1
wTempObjectCopySpriteVTile:: ds 1 ; c2f2
wTempObjectCopyPalette:: ds 1 ; c2f3
wTempObjectCopyMovement:: ds 1 ; c2f4
wTempObjectCopyRange:: ds 1 ; c2f5
wTempObjectCopyX:: ds 1 ; c2f6
wTempObjectCopyY:: ds 1 ; c2f7
wTempObjectCopyRadius:: ds 1 ; c2f8

	ds 1

wTileDown::  ds 1 ; c2fa
wTileUp::    ds 1 ; c2fb
wTileLeft::  ds 1 ; c2fc
wTileRight:: ds 1 ; c2fd

wTilePermissions:: ; c2fe
; set if tile behavior prevents
; you from walking in that direction
; bit 3: down
; bit 2: up
; bit 1: left
; bit 0: right
	ds 1

    
SECTION "wSpriteAnims", WRAM0

UNION ; c300
; wSpriteAnimDict is a 10x2 dictionary
; keys: taken from third column of SpriteAnimSeqData
; values: vTiles
wSpriteAnimDict:: ds 10 * 2

wSpriteAnimationStructs::
; field  0:   index
; fields 1-3: loaded from SpriteAnimSeqData
wSpriteAnim1::  sprite_anim_struct wSpriteAnim1
wSpriteAnim2::  sprite_anim_struct wSpriteAnim2
wSpriteAnim3::  sprite_anim_struct wSpriteAnim3
wSpriteAnim4::  sprite_anim_struct wSpriteAnim4
wSpriteAnim5::  sprite_anim_struct wSpriteAnim5
wSpriteAnim6::  sprite_anim_struct wSpriteAnim6
wSpriteAnim7::  sprite_anim_struct wSpriteAnim7
wSpriteAnim8::  sprite_anim_struct wSpriteAnim8
wSpriteAnim9::  sprite_anim_struct wSpriteAnim9
wSpriteAnim10:: sprite_anim_struct wSpriteAnim10
wSpriteAnimationStructsEnd::

NEXTU ; c300
; mobile data
wc300:: ds 1
wc301:: ds 1
wc302:: ds 1
wc303:: ds 2
wc305:: ds 1
wc306:: ds 1
wc307:: ds 1
wc308:: ds 1
wc309:: ds 1
wc30a:: ds 1
wc30b:: ds 1
wc30c:: ds 1
wc30d:: ds 1
wc30e:: ds 1
wc30f:: ds 1
wc310:: ds 1
wc311:: ds 1
wc312:: ds 1
wc313:: ds 1
wc314:: ds 152
wc3ac:: ds 8
ENDU ; c3b4

wSpriteAnimCount:: ds 1
wCurrSpriteOAMAddr:: ds 1

wCurIcon:: ds 1 ; c3b6

wCurIconTile:: ds 1
wSpriteAnimAddrBackup::
wSpriteAnimIDBuffer::
wCurrSpriteAddSubFlags::
	ds 2
wCurrAnimVTile:: ds 1
wCurrAnimXCoord:: ds 1
wCurrAnimYCoord:: ds 1
wCurrAnimXOffset:: ds 1
wCurrAnimYOffset:: ds 1
wGlobalAnimYOffset:: ds 1
wGlobalAnimXOffset:: ds 1
wSpriteAnimsEnd::

	ds 11

; mobile data
wc3cc:: ds 1
wc3cd:: ds 31
wc3ec:: ds 1
wc3ed:: ds 1
wc3ee:: ds 1
wc3ef:: ds 1
wc3f0:: ds 1
wc3f1:: ds 1
wc3f2:: ds 1
wc3f3:: ds 1
wc3f4:: ds 1
wc3f5:: ds 1
wc3f6:: ds 1
wc3f7:: ds 1
wc3f8:: ds 1
wc3f9:: ds 1
wc3fa:: ds 1
wc3fb:: ds 1
wc3fc:: ds 1

wRematchLeaders:: ds 1
	ds 2


SECTION "Sprites", WRAM0

wVirtualOAM:: ; c400
wVirtualOAMSprite00:: sprite_oam_struct wVirtualOAMSprite00
wVirtualOAMSprite01:: sprite_oam_struct wVirtualOAMSprite01
wVirtualOAMSprite02:: sprite_oam_struct wVirtualOAMSprite02
wVirtualOAMSprite03:: sprite_oam_struct wVirtualOAMSprite03
wVirtualOAMSprite04:: sprite_oam_struct wVirtualOAMSprite04
wVirtualOAMSprite05:: sprite_oam_struct wVirtualOAMSprite05
wVirtualOAMSprite06:: sprite_oam_struct wVirtualOAMSprite06
wVirtualOAMSprite07:: sprite_oam_struct wVirtualOAMSprite07
wVirtualOAMSprite08:: sprite_oam_struct wVirtualOAMSprite08
wVirtualOAMSprite09:: sprite_oam_struct wVirtualOAMSprite09
wVirtualOAMSprite10:: sprite_oam_struct wVirtualOAMSprite10
wVirtualOAMSprite11:: sprite_oam_struct wVirtualOAMSprite11
wVirtualOAMSprite12:: sprite_oam_struct wVirtualOAMSprite12
wVirtualOAMSprite13:: sprite_oam_struct wVirtualOAMSprite13
wVirtualOAMSprite14:: sprite_oam_struct wVirtualOAMSprite14
wVirtualOAMSprite15:: sprite_oam_struct wVirtualOAMSprite15
wVirtualOAMSprite16:: sprite_oam_struct wVirtualOAMSprite16
wVirtualOAMSprite17:: sprite_oam_struct wVirtualOAMSprite17
wVirtualOAMSprite18:: sprite_oam_struct wVirtualOAMSprite18
wVirtualOAMSprite19:: sprite_oam_struct wVirtualOAMSprite19
wVirtualOAMSprite20:: sprite_oam_struct wVirtualOAMSprite20
wVirtualOAMSprite21:: sprite_oam_struct wVirtualOAMSprite21
wVirtualOAMSprite22:: sprite_oam_struct wVirtualOAMSprite22
wVirtualOAMSprite23:: sprite_oam_struct wVirtualOAMSprite23
wVirtualOAMSprite24:: sprite_oam_struct wVirtualOAMSprite24
wVirtualOAMSprite25:: sprite_oam_struct wVirtualOAMSprite25
wVirtualOAMSprite26:: sprite_oam_struct wVirtualOAMSprite26
wVirtualOAMSprite27:: sprite_oam_struct wVirtualOAMSprite27
wVirtualOAMSprite28:: sprite_oam_struct wVirtualOAMSprite28
wVirtualOAMSprite29:: sprite_oam_struct wVirtualOAMSprite29
wVirtualOAMSprite30:: sprite_oam_struct wVirtualOAMSprite30
wVirtualOAMSprite31:: sprite_oam_struct wVirtualOAMSprite31
wVirtualOAMSprite32:: sprite_oam_struct wVirtualOAMSprite32
wVirtualOAMSprite33:: sprite_oam_struct wVirtualOAMSprite33
wVirtualOAMSprite34:: sprite_oam_struct wVirtualOAMSprite34
wVirtualOAMSprite35:: sprite_oam_struct wVirtualOAMSprite35
wVirtualOAMSprite36:: sprite_oam_struct wVirtualOAMSprite36
wVirtualOAMSprite37:: sprite_oam_struct wVirtualOAMSprite37
wVirtualOAMSprite38:: sprite_oam_struct wVirtualOAMSprite38
wVirtualOAMSprite39:: sprite_oam_struct wVirtualOAMSprite39
wVirtualOAMEnd::


SECTION "Tilemap", WRAM0

wTileMap:: ; c4a0
; 20x18 grid of 8x8 tiles
	ds SCREEN_WIDTH * SCREEN_HEIGHT
wTileMapEnd::


SECTION "Battle", WRAM0

UNION ; c608
; unidentified uses
wc608:: ds 480

NEXTU ; c608
; miscellaneous
wMisc:: ds WMISC_WIDTH * WMISC_HEIGHT
wMiscEnd::

NEXTU ; c608
; odd egg
wOddEgg:: party_struct wOddEgg
wOddEggName:: ds MON_NAME_LENGTH
wOddEggOTName:: ds MON_NAME_LENGTH

NEXTU ; c608
; battle tower temp struct
wBT_OTTemp:: battle_tower_struct wBT_OTTemp

NEXTU ; c608
; hall of fame temp struct
wHallOfFameTemp:: hall_of_fame wHallOfFameTemp

NEXTU ; c608
; timeset temp storage
wTimeSetBuffer::
	ds 20
wInitHourBuffer:: ds 1 ; c61c
	ds 9
wInitMinuteBuffer:: ds 1 ; c626

NEXTU ; c608
; link engine data
	ds 10
wc612:: ds 10

NEXTU ; c608
; battle data
wBattle::
wEnemyMoveStruct::  move_struct wEnemyMoveStruct ; c608
wPlayerMoveStruct:: move_struct wPlayerMoveStruct ; c60f

wEnemyMonNick::  ds MON_NAME_LENGTH ; c616
wBattleMonNick:: ds MON_NAME_LENGTH ; c621

wBattleMon:: battle_struct wBattleMon ; c62c

	ds 1

wWildMon:: ds 1 ; c64e
	ds 1
wEnemyTrainerItem1:: ds 1 ; c650
wEnemyTrainerItem2:: ds 1 ; c651
wEnemyTrainerBaseReward:: ds 1 ; c652
wEnemyTrainerAIFlags:: ds 3 ; c653
wOTClassName:: ds TRAINER_CLASS_NAME_LENGTH ; c656

wCurOTMon:: ds 1 ; c663

wBattleParticipantsNotFainted::
; Bit array.  Bits 0 - 5 correspond to party members 1 - 6.
; Bit set if the mon appears in battle.
; Bit cleared if the mon faints.
; Backed up if the enemy switches.
; All bits cleared if the enemy faints.
	ds 1

wTypeModifier:: ; c665
; >10: super-effective
;  10: normal
; <10: not very effective
; bit 7: stab
	ds 1

wCriticalHit:: ; c666
; 0 if not critical
; 1 for a critical hit
; 2 for a OHKO
	ds 1

wAttackMissed:: ; c667
; nonzero for a miss
	ds 1

wPlayerSubStatus1:: ; c668
; bit
; 7 in love
; 6 rollout
; 5 endure
; 4 perish song
; 3 identified
; 2 protect
; 1 curse
; 0 nightmare
	ds 1
wPlayerSubStatus2:: ; c669
; bit
; 7
; 6
; 5
; 4
; 3
; 2
; 1
; 0 curled
	ds 1
wPlayerSubStatus3:: ; c66a
; bit
; 7 confused
; 6 flying
; 5 underground
; 4 charged
; 3 flinched
; 2 in loop
; 1 rampage
; 0 bide
	ds 1
wPlayerSubStatus4:: ; c66b
; bit
; 7 leech seed
; 6 rage
; 5 recharge
; 4 substitute
; 3
; 2 focus energy
; 1 mist
; 0 x accuracy
	ds 1
wPlayerSubStatus5:: ; c66c
; bit
; 7 can't run
; 6 destiny bond
; 5 lock-on
; 4 encored
; 3 transformed
; 2
; 1
; 0 toxic
	ds 1

wEnemySubStatus1:: ; c66d
; see wPlayerSubStatus1
	ds 1
wEnemySubStatus2:: ; c66e
; see wPlayerSubStatus2
	ds 1
wEnemySubStatus3:: ; c66f
; see wPlayerSubStatus3
	ds 1
wEnemySubStatus4:: ; c670
; see wPlayerSubStatus4
	ds 1
wEnemySubStatus5:: ; c671
; see wPlayerSubStatus5
	ds 1

wPlayerRolloutCount:: ds 1 ; c672
wPlayerConfuseCount:: ds 1 ; c673
wPlayerToxicCount:: ds 1 ; c674
wPlayerDisableCount:: ds 1 ; c675
wPlayerEncoreCount:: ds 1 ; c676
wPlayerPerishCount:: ds 1 ; c677
wPlayerFuryCutterCount:: ds 1 ; c678
wPlayerProtectCount:: ds 1 ; c679

wEnemyRolloutCount:: ds 1 ; c67a
wEnemyConfuseCount:: ds 1 ; c67b
wEnemyToxicCount:: ds 1 ; c67c
wEnemyDisableCount:: ds 1 ; c67d
wEnemyEncoreCount:: ds 1 ; c67e
wEnemyPerishCount:: ds 1 ; c67f
wEnemyFuryCutterCount:: ds 1 ; c680
wEnemyProtectCount:: ds 1 ; c681

wPlayerDamageTaken:: ds 2 ; c682
wEnemyDamageTaken:: ds 2 ; c684

wBattleReward:: ds 3 ; c686
wBattleAnimParam::
wKickCounter::
wPresentPower::
	ds 1 ; c689
wBattleScriptBuffer:: ds 40 ; c68a

wBattleScriptBufferAddress:: ds 2 ; c6b2

wTurnEnded:: ds 1 ; c6b4

	ds 1

wPlayerStats:: ; c6b6
wPlayerAttack:: ds 2
wPlayerDefense:: ds 2
wPlayerSpeed:: ds 2
wPlayerSpAtk:: ds 2
wPlayerSpDef:: ds 2
	ds 1

wEnemyStats:: ; c6c1
wEnemyAttack:: ds 2
wEnemyDefense:: ds 2
wEnemySpeed:: ds 2
wEnemySpAtk:: ds 2
wEnemySpDef:: ds 2
	ds 1

wPlayerStatLevels:: ; c6cc
; 07 neutral
wPlayerAtkLevel:: ds 1 ; c6cc
wPlayerDefLevel:: ds 1 ; c6cd
wPlayerSpdLevel:: ds 1 ; c6ce
wPlayerSAtkLevel:: ds 1 ; c6cf

UNION ; c6d0
; finish battle RAM
wPlayerSDefLevel:: ds 1 ; c6d0
wPlayerAccLevel:: ds 1 ; c6d1
wPlayerEvaLevel:: ds 1 ; c6d2
	ds 1 ; c6d3
wPlayerStatLevelsEnd::

wEnemyStatLevels:: ; c6d4
; 07 neutral
wEnemyAtkLevel:: ds 1 ; c6d4
wEnemyDefLevel:: ds 1 ; c6d5
wEnemySpdLevel:: ds 1 ; c6d6
wEnemySAtkLevel:: ds 1 ; c6d7
wEnemySDefLevel:: ds 1 ; c6d8
wEnemyAccLevel:: ds 1 ; c6d9
wEnemyEvaLevel:: ds 1 ; c6da
	ds 1

wEnemyTurnsTaken:: ds 1 ; c6dc
wPlayerTurnsTaken:: ds 1 ; c6dd
	ds 1

wPlayerSubstituteHP:: ds 1 ; c6df
wEnemySubstituteHP:: ds 1 ; c6e0

wUnusedPlayerLockedMove:: ds 1 ; c6e1
	ds 1

wCurPlayerMove:: ds 1 ; c6e3
wCurEnemyMove:: ds 1 ; c6e4

wLinkBattleRNCount:: ; c6e5
; how far through the prng stream
	ds 1

wEnemyItemState:: ds 1 ; c6e6
	ds 2
wCurEnemyMoveNum:: ds 1 ; c6e9

wEnemyHPAtTimeOfPlayerSwitch:: ds 2 ; c6ea
wPayDayMoney:: ds 3 ; c6ec

wSafariMonAngerCount:: ds 1
wSafariMonEating:: ds 1
	ds 1
wEnemyBackupDVs:: ds 2 ; used when enemy is transformed
wAlreadyDisobeyed:: ds 1 ; c6f4

wDisabledMove:: ds 1 ; c6f5
wEnemyDisabledMove:: ds 1 ; c6f6
wWhichMonFaintedFirst:: ds 1

; exists so you can't counter on switch
wLastPlayerCounterMove:: ds 1 ; c6f8
wLastEnemyCounterMove:: ds 1 ; c6f9

wEnemyMinimized:: ds 1 ; c6fa

wAlreadyFailed:: ds 1 ; c6fb

wBattleParticipantsIncludingFainted:: ds 1 ; c6fc
wBattleLowHealthAlarm:: ds 1 ; c6fd
wPlayerMinimized:: ds 1 ; c6fe
wPlayerScreens:: ; c6ff
; bit
; 7
; 6
; 5
; 4 reflect
; 3 light screen
; 2 safeguard
; 1
; 0 spikes
	ds 1

wEnemyScreens:: ; c700
; see wPlayerScreens
	ds 1

wPlayerSafeguardCount:: ds 1 ; c701
wPlayerLightScreenCount:: ds 1 ; c702
wPlayerReflectCount:: ds 1 ; c703
	ds 1

wEnemySafeguardCount:: ds 1 ; c705
wEnemyLightScreenCount:: ds 1 ; c706
wEnemyReflectCount:: ds 1 ; c707
	ds 1
	
wEnemyMonCaughtData:: ds 1

wBattleWeather:: ; c70a
; 00 normal
; 01 rain
; 02 sun
; 03 sandstorm
; 04 rain stopped
; 05 sunliight faded
; 06 sandstorm subsided
	ds 1

wWeatherCount:: ; c70b
; # turns remaining
	ds 1

wLoweredStat:: ds 1 ; c70c
wEffectFailed:: ds 1 ; c70d
wFailedMessage:: ds 1 ; c70e
wEnemyGoesFirst:: ds 1 ; c70f

wPlayerIsSwitching:: ds 1 ; c710
wEnemyIsSwitching::  ds 1 ; c711

wPlayerUsedMoves:: ; c712
; add a move that has been used once by the player
; added in order of use
	ds NUM_MOVES

wEnemyAISwitchScore:: ds 1 ; c716
wEnemySwitchMonParam:: ds 1 ; c717
wEnemySwitchMonIndex:: ds 1 ; c718
wTempLevel:: ds 1 ; c719
wLastPlayerMon:: ds 1 ; c71a
wLastPlayerMove:: ds 1 ; c71b
wLastEnemyMove:: ds 1 ; c71c

wPlayerFutureSightCount:: ds 1 ; c71d
wEnemyFutureSightCount:: ds 1 ; c71e

wGivingExperienceToExpShareHolders:: ds 1 ; c71f

wBackupEnemyMonBaseStats:: ds 5 ; c720
wBackupEnemyMonCatchRate:: ds 1 ; c725
wBackupEnemyMonBaseExp:: ds 1 ; c726

wPlayerFutureSightDamage:: ds 2 ; c727
wEnemyFutureSightDamage:: ds 2 ; c729
wPlayerRageCounter:: ds 1 ; c72b
wEnemyRageCounter:: ds 1 ; c72c

wBeatUpHitAtLeastOnce:: ds 1 ; c72d

wPlayerTrappingMove:: ds 1 ; c72e
wEnemyTrappingMove:: ds 1 ; c72f
wPlayerWrapCount:: ds 1 ; c730
wEnemyWrapCount:: ds 1 ; c731
wPlayerCharging:: ds 1 ; c732
wEnemyCharging:: ds 1 ; c733

wBattleEnded:: ds 1 ; c734

wWildMonMoves:: ds NUM_MOVES ; c735
wWildMonPP:: ds NUM_MOVES ; c739

wAmuletCoin:: ds 1 ; c73a

wSomeoneIsRampaging:: ds 1 ; c73b

wPlayerJustGotFrozen:: ds 1 ; c73c
wEnemyJustGotFrozen:: ds 1 ; c73d
wBattleEnd::
; Battle RAM
; c741

NEXTU ; c6d0
; trade
wTrademons::
wPlayerTrademon:: trademon wPlayerTrademon
wOTTrademon::     trademon wOTTrademon
wTrademonsEnd::
wTradeAnimAddress:: ds 2
wLinkPlayer1Name:: ds NAME_LENGTH
wLinkPlayer2Name:: ds NAME_LENGTH
wLinkTradeSendmonSpecies:: ds 1
wLinkTradeGetmonSpecies::  ds 1

NEXTU ; c6d0
; naming screen
wNamingScreenDestinationPointer:: ds 2 ; c6d0
wNamingScreenCurrNameLength:: ds 1 ; c6d2
wNamingScreenMaxNameLength:: ds 1 ; c6d3
wNamingScreenType:: ds 1 ; c6d4
wNamingScreenCursorObjectPointer:: ds 2 ; c6d5
wNamingScreenLastCharacter:: ds 1 ; c6d7
wNamingScreenStringEntryCoord:: ds 2 ; c6d8

NEXTU ; c6d0
; pokegear
wPokegearPhoneLoadNameBuffer:: ds 1 ; c6d0
wPokegearPhoneCursorPosition:: ds 1 ; c6d1
wPokegearPhoneScrollPosition:: ds 1 ; c6d2
wPokegearPhoneSelectedPerson:: ds 1 ; c6d3
wPokegearPhoneSubmenuCursor:: ds 1 ; c6d4
wPokegearMapCursorObjectPointer:: ds 2 ; c6d5
wPokegearMapCursorLandmark:: ds 1 ; c6d7
wPokegearMapPlayerIconLandmark:: ds 1 ; c6d8
wPokegearRadioChannelBank:: ds 1 ; c6d9
wPokegearRadioChannelAddr:: ds 2 ; c6da
wPokegearRadioMusicPlaying:: ds 1 ; c6dc

NEXTU ; c6d0
; slot machine
wSlots::
wReel1:: slot_reel wReel1
wReel2:: slot_reel wReel2
wReel3:: slot_reel wReel3
; c700
wReel1Stopped:: ds 3
wReel2Stopped:: ds 3
wReel3Stopped:: ds 3
wSlotBias:: ds 1
wSlotBet:: ds 1
wFirstTwoReelsMatching:: ds 1
wFirstTwoReelsMatchingSevens:: ds 1
wSlotMatched:: ds 1
wCurrReelStopped:: ds 3
wPayout:: ds 2
wCurrReelXCoord:: ds 1
wCurrReelYCoord:: ds 1
	ds 2
wSlotBuildingMatch:: ds 1
wSlotsDataEnd::
	ds 28
wSlotsEnd::

NEXTU ; c6d0
; card flip
wCardFlip::
wDeck:: ds 24
wDeckEnd::
; c6e8
wCardFlipNumCardsPlayed:: ds 1
wCardFlipFaceUpCard:: ds 1
wDiscardPile:: ds 24
wDiscardPileEnd::
wCardFlipEnd::

NEXTU ; c6d0
; dummy game
wDummyGame::
wDummyGameCards:: ds 9 * 5
wDummyGameCardsEnd::
wDummyGameLastCardPicked:: ds 1 ; c6fd
wDummyGameCard1:: ds 1 ; c6fe
wDummyGameCard2:: ds 1 ; c6ff
wDummyGameCard1Location:: ds 1 ; c700
wDummyGameCard2Location:: ds 1 ; c701
wDummyGameNumberTriesRemaining:: ds 1 ; c702
wDummyGameLastMatches:: ds 5 ; c703
wDummyGameCounter:: ds 1 ; c708
wDummyGameNumCardsMatched:: ds 1 ; c709
wDummyGameEnd::

NEXTU ; c6d0
; unown puzzle
wUnownPuzzle::
wPuzzlePieces:: ds 6 * 6
wUnownPuzzleEnd::

NEXTU ; c6d0
; pokedex
wPokedexDataStart::
wPokedexOrder:: ds $100 ; >= NUM_POKEMON
wPokedexOrderEnd::
wDexListingScrollOffset:: ds 1 ; offset of the first displayed entry from the start
wDexListingCursor:: ds 1 ; Dex cursor
wDexListingEnd:: ds 1 ; Last mon to display
wDexListingHeight:: ds 1 ; number of entries displayed at once in the dex listing
wCurrentDexMode:: ds 1 ; Pokedex Mode
wDexSearchMonType1:: ds 1 ; first type to search
wDexSearchMonType2:: ds 1 ; second type to search
wDexSearchResultCount:: ds 1
wDexArrowCursorPosIndex:: ds 1
wDexArrowCursorDelayCounter:: ds 1
wDexArrowCursorBlinkCounter:: ds 1
wDexSearchSlowpokeFrame:: ds 1
wUnlockedUnownMode:: ds 1
wDexCurrentUnownIndex:: ds 1
wDexUnownCount:: ds 1
wDexConvertedMonType:: ds 1 ; mon type converted from dex search mon type
wDexListingScrollOffsetBackup:: ds 1
wDexListingCursorBackup:: ds 1
wBackupDexListingCursor:: ds 1
wBackupDexListingPage:: ds 1
wDexCurrentLocation:: ds 1
wPokedexStatus:: ds 1
wPokedexDataEnd::
	ds 2

NEXTU ; c6d0
; mobile data
wc6d0:: ds 126
wc74e:: ds 107
wc7b9:: ds 1
wc7ba:: ds 1
wc7bb:: ds 2
wc7bd:: ds 19
wc7d0:: ds 1
wc7d1:: ds 1
wc7d2:: ds 1
wc7d3:: ds 1
wc7d4:: ds 1
ENDU ; c7e8
ENDU ; c7e8

wc7e8:: ds 24
wc7e8_End::


SECTION "Overworld Map", WRAM0

UNION ; c800
wOverworldMap:: ds 1300 ; c800
wOverworldMapEnd::

NEXTU ; c800
; GB Printer screen RAM
wGameboyPrinterRAM::
wGameboyPrinterScreen:: ds SCREEN_HEIGHT * SCREEN_WIDTH ; c800
wGameboyPrinterScreenEnd:: ; c968

NEXTU ; c800
; GB Printer data
wGameboyPrinter2bppSource:: ds 40 tiles
wGameboyPrinter2bppSourceEnd::
wca80:: ds 1
wPrinterRowIndex:: ds 1

; Printer data
wPrinterData:: ds 4
wPrinterChecksum:: ds 2 ; ca86
wPrinterHandshake:: ds 1
wPrinterStatusFlags::
; bit 7: set if error 1 (battery low)
; bit 6: set if error 4 (too hot or cold)
; bit 5: set if error 3 (paper jammed or empty)
; if this and the previous byte are both $ff: error 2 (connection error)
	ds 1

wHandshakeFrameDelay:: ds 1
wPrinterSerialFrameDelay:: ds 1
wPrinterSendByteOffset:: ds 2
wPrinterSendByteCounter:: ds 2

; tilemap backup?
wPrinterTileMapBuffer:: ds SCREEN_HEIGHT * SCREEN_WIDTH ; ca90
wPrinterTileMapBufferEnd::
wPrinterStatus:: ds 1 ; cbf8
	ds 1
wcbfa:: ds 1
wGBPrinterSettings:: ds 1
	ds 16
wGameboyPrinterRAMEnd::

NEXTU ; c800
; bill's pc data
wBillsPCPokemonList:: ; c800
; Pokemon, box number, list index
	ds 3 * 30

NEXTU ; c800
; raw link data
wLinkData:: ds $514
wLinkDataEnd::

NEXTU ; c800
; link data members
wLinkPlayerName:: ds NAME_LENGTH
wLinkPartyCount::   ds 1
wLinkPartySpecies:: ds PARTY_LENGTH
wLinkPartyEnd::     ds 1 ; older code doesn't check PartyCount

UNION ; c813
; time capsule party data
wTimeCapsulePlayerData::
wTimeCapsulePartyMon1:: red_party_struct wTimeCapsulePartyMon1
wTimeCapsulePartyMon2:: red_party_struct wTimeCapsulePartyMon2
wTimeCapsulePartyMon3:: red_party_struct wTimeCapsulePartyMon3
wTimeCapsulePartyMon4:: red_party_struct wTimeCapsulePartyMon4
wTimeCapsulePartyMon5:: red_party_struct wTimeCapsulePartyMon5
wTimeCapsulePartyMon6:: red_party_struct wTimeCapsulePartyMon6
wTimeCapsulePartyMonOTNames:: ds PARTY_LENGTH * NAME_LENGTH
wTimeCapsulePartyMonNicks:: ds PARTY_LENGTH * MON_NAME_LENGTH
wTimeCapsulePlayerDataEnd::

NEXTU ; c813
; link player data
wLinkPlayerData::
wLinkPlayerPartyMon1:: party_struct wLinkPlayerPartyMon1
wLinkPlayerPartyMon2:: party_struct wLinkPlayerPartyMon2
wLinkPlayerPartyMon3:: party_struct wLinkPlayerPartyMon3
wLinkPlayerPartyMon4:: party_struct wLinkPlayerPartyMon4
wLinkPlayerPartyMon5:: party_struct wLinkPlayerPartyMon5
wLinkPlayerPartyMon6:: party_struct wLinkPlayerPartyMon6
wLinkPlayerPartyMonOTNames:: ds PARTY_LENGTH * NAME_LENGTH
wLinkPlayerPartyMonNicks:: ds PARTY_LENGTH * MON_NAME_LENGTH
wLinkPlayerDataEnd::
ENDU ; c9b7

NEXTU ; c800
; mystery gift data
wMysteryGiftPartyTemp:: ; ds PARTY_LENGTH * (1 + 1 + NUM_MOVES)
wMysteryGiftStaging::
wc800:: ds 1
wc801:: ds 1
wc802:: ds 1
wc803:: ds 4
wc807:: ds 7
wc80e:: ds 1
wc80f:: ds 1
wc810:: ds 1
wc811:: ds 1
wc812:: ds 1
wc813:: ds 1
wc814:: ds 4
wc818:: ds 8
wc820:: ds 1
wc821:: ds 47

UNION ; c850
wMysteryGiftTrainerData:: ds (1 + 1 + NUM_MOVES) * PARTY_LENGTH + 2
wMysteryGiftTrainerDataEnd::

NEXTU ; c850
wc850:: ds 16
wc860:: ds 16
wc870:: ds 16
wc880:: ds 16
wc890:: ds 16
wc8a0:: ds 16
wc8b0:: ds 16
wc8c0:: ds 16
wc8d0:: ds 16
wc8e0:: ds 16
wc8f0:: ds 16
ENDU ; c900

wMysteryGiftPartnerData::
wc900:: ds 1
wMysteryGiftPartnerID:: ds 2
wMysteryGiftPartnerName:: ds NAME_LENGTH
wMysteryGiftPartnerDexCaught:: ds 1
wc90f::
wMysteryGiftPartnerSentDeco:: ds 1
wMysteryGiftPartnerWhichItem:: ds 1
wMysteryGiftPartnerWhichDeco:: ds 1
wMysteryGiftPartnerBackupItem:: ds 1
	ds 1
wMysteryGiftPartnerDataEnd::

	ds 60

wMysteryGiftPlayerData::
	ds 1
wMysteryGiftPlayerID:: ds 2
wMysteryGiftPlayerName:: ds NAME_LENGTH
wMysteryGiftPlayerDexCaught:: ds 1
wMysteryGiftPlayerSentDeco:: ds 1
wMysteryGiftPlayerWhichItem:: ds 1
wMysteryGiftPlayerWhichDeco:: ds 1
wMysteryGiftPlayerBackupItem:: ds 1
	ds 1
wMysteryGiftPlayerDataEnd::

	ds 144

wc9f4:: ds 5
wc9f9:: ds 7

UNION ; ca00
; blank credits tile buffer
wCreditsFaux2bpp:: ds 128

NEXTU ; ca00
; mystery gift data
wca00:: ds 1
wca01:: ds 1
wca02:: ds 1
	ds 160
ENDU ; caa3

wcaa3:: ds 2
wcaa5:: ds 16
wcab5:: ds 10
wcabf:: ds 10
wcac9:: ds 63
wcb08:: ds 6
wcb0e:: ds 5
wcb13:: ds 9
wcb1c:: ds 14

wBillsPC_ScrollPosition:: ds 1
wBillsPC_CursorPosition:: ds 1
wBillsPC_NumMonsInBox:: ds 1
wBillsPC_NumMonsOnScreen:: ds 1
wBillsPC_LoadedBox:: ds 1 ; 0 if party, 1 - 14 if box, 15 if active box
wBillsPC_BackupScrollPosition:: ds 1
wBillsPC_BackupCursorPosition:: ds 1
wBillsPC_BackupLoadedBox:: ds 1
wBillsPC_MonHasMail:: ds 1
	ds 18

wcb45:: ds 20
wcb59:: ds 20
wcb6d:: ds 1
wcb6e:: ds 22
wcb84:: ds 100
wcbe8:: ds 2
wLinkOTPartyMonTypes:: ds 2 * PARTY_LENGTH

wcc4a:: ds 22
wcc60:: ds 1
wcc61:: ds 1
wcc62:: ds 2
wcc64:: ds 1
wcc65:: ds 57
wcc9e:: ds 22
wccb4:: ds 1
wccb5:: ds 3
wccb8:: ds 1
wccb9:: ds 1
wccba:: ds 102
ENDU ; cd20


SECTION "Video", WRAM0

UNION ; cd20
; wBGMapBuffer
wBGMapBuffer::     ds 40 ; cd20
wBGMapPalBuffer::  ds 40 ; cd48
wBGMapBufferPtrs:: ds 40 ; cd70 ; 20 bg map addresses (16x8 tiles)
wBGMapBufferEnd::

NEXTU ; cd20
; credits
wCreditsPos:: ds 1
wCreditsUnusedCD21:: ds 1
wCreditsTimer:: ds 1

NEXTU ; cd20
; mobile data
wMobileMonSpeciesPointerBuffer:: ds 2
wMobileMonStructurePointerBuffer:: ds 2
wMobileMonOTNamePointerBuffer:: ds 2
wMobileMonNicknamePointerBuffer:: ds 2
wMobileMonMailPointerBuffer:: ds 2

NEXTU ; cd20
; more mobile data
wcd20:: ds 1
wcd21:: ds 1
wcd22:: ds 1
wcd23:: ds 1
wcd24:: ds 1
wMobileCommsJumptableIndex:: ds 1 ; cd25
wcd26:: ds 1
wcd27:: ds 1
wcd28:: ds 1
wcd29:: ds 1

wMobileMonSpeciesBuffer::
wcd2a:: ds 1

wTempOddEggNickname:: ; ds 11
wcd2b:: ds 1
wcd2c:: ds 1
wcd2d:: ds 1
wcd2e:: ds 1
wcd2f:: ds 1
wcd30:: ds 1
wcd31:: ds 1
wcd32:: ds 1
wcd33:: ds 1
wcd34:: ds 1
wcd35:: ds 1

; current time for link/mobile?
wcd36:: ds 1 ; hours
wcd37:: ds 1 ; mins
wcd38:: ds 1 ; secs

wcd39:: ds 1
wcd3a:: ds 1
wcd3b:: ds 1
wcd3c:: ds 1
wcd3d:: ds 1
wcd3e:: ds 1
wcd3f:: ds 1
wcd40:: ds 1
wcd41:: ds 1
wcd42:: ds 1
wcd43:: ds 1

; some sort of timer in link battles
wMobileInactivityTimerMinutes:: ds 1 ; mins
wMobileInactivityTimerSeconds:: ds 1 ; secs
wMobileInactivityTimerFrames:: ds 1 ; frames
wcd47:: ds 1

	ds 1

wBTTempOTSprite::
wcd49:: ds 1

wcd4a:: ds 1
wcd4b:: ds 1

wEZChatCursorXCoord::
wcd4c:: ds 1
wEZChatCursorYCoord::
wcd4d:: ds 1

wcd4e:: ds 1
wcd4f:: ds 1
wcd50:: ds 1
wcd51:: ds 1
wcd52:: ds 1

wMobileOpponentBattleMessage:: ; ds 12
wcd53:: ds 1
wcd54:: ds 1
wcd55:: ds 1
wcd56:: ds 1
wcd57:: ds 1
wcd58:: ds 1
wcd59:: ds 1
wcd5a:: ds 1
wcd5b:: ds 1
wcd5c:: ds 1
wcd5d:: ds 1
wcd5e:: ds 1
wcd5f:: ds 1
wcd60:: ds 2
wcd62:: ds 1
wcd63:: ds 1
wcd64:: ds 1
wcd65:: ds 1
wcd66:: ds 1
wcd67:: ds 1
wcd68:: ds 1
wcd69:: ds 1
wcd6a:: ds 1
wcd6b:: ds 1
wcd6c:: ds 1
wcd6d:: ds 1
wcd6e:: ds 1
wcd6f:: ds 2
wcd71:: ds 1
wcd72:: ds 1
wcd73:: ds 1
wcd74:: ds 1

wOTMonSelection:: ds 2 ; ds BATTLETOWER_PARTY_LENGTH
wcd77:: ds 1

wMobileCrashCheckPointer:: ds 2
wcd7a:: ds 2
wcd7c:: ds 3
wcd7f:: ds 1
wcd80:: ds 1
wcd81:: ds 1
wcd82:: ds 1
wcd83:: ds 1
wcd84:: ds 1
wcd85:: ds 4
wcd89:: ds 1
wcd8a:: ds 1
wcd8b:: ds 1
wcd8c:: ds 1
wcd8d:: ds 11
ENDU ; cd98

wSGBPredef:: ds 1 ; cd98

wPlayerHPPal:: ds 1 ; cd99
wEnemyHPPal:: ds 1 ; cd9a

wHPPals:: ds PARTY_LENGTH
wCurHPPal:: ds 1

	ds 7

wSGBPals:: ds 48 ; cda9

wAttrMap:: ; cdd9
; 20x18 grid of bg tile attributes for 8x8 tiles
; read horizontally from the top row
;		bit 7: priority
;		bit 6: y flip
;		bit 5: x flip
;		bit 4: pal # (non-cgb)
;		bit 3: vram bank (cgb only)
;		bit 2-0: pal # (cgb only)
	ds SCREEN_WIDTH * SCREEN_HEIGHT
wAttrMapEnd::

UNION ; cf41
; addresses dealing with serial comms
	ds 1
wcf42:: ds 1
	ds 1
wcf44:: ds 1
wcf45:: ds 1

NEXTU ; cf41
wTileAnimBuffer:: ds 1 tiles
ENDU ; cf51

; link data
wOtherPlayerLinkMode:: ds 1
wOtherPlayerLinkAction:: ds 1
	ds 3
wPlayerLinkAction:: ds 1
wcf57:: ds 1
	ds 3
wLinkTimeoutFrames:: ds 2 ; cf5b
wcf5d:: ds 2

wMonType:: ds 1 ; cf5f

wCurSpecies::
wCurMove::
	ds 1 ; cf60

wNamedObjectTypeBuffer:: ds 1

	ds 1

wJumptableIndex::
wBattleTowerBattleEnded::
	ds 1

UNION ; cf64
; unidentified
wcf64:: ds 1
wcf65:: ds 1
wcf66:: ds 1

NEXTU ; cf64
; intro and title data
wIntroSceneFrameCounter:: ds 1
UNION ; cf65
wIntroSceneTimer:: ds 1
NEXTU ; cf65
wTitleScreenTimer:: ds 2
ENDU

NEXTU ; cf64
; credits data
wCreditsBorderFrame:: ds 1
wCreditsBorderMon:: ds 1
wCreditsLYOverride:: ds 1

NEXTU ; cf64
; pokedex
wPrevDexEntryJumptableIndex:: ds 1
wPrevDexEntryBackup:: ds 1

NEXTU ; cf64
; pokegear
wPokegearCard:: ds 1
wPokegearMapRegion:: ds 1

NEXTU ; cf64
; pack
wPackJumptableIndex:: ds 1
wCurrPocket:: ds 1
wPackUsedItem:: ds 1

NEXTU ; cf64
; trainer card badges
wTrainerCardBadgeFrameCounter:: ds 1
wTrainerCardBadgeTileID:: ds 1
wTrainerCardBadgeAttributes:: ds 1

NEXTU ; cf64
; card flip data
wCardFlipCursorY:: ds 1
wCardFlipCursorX:: ds 1
wCardFlipWhichCard:: ds 1

NEXTU ; cf64
; magnet train
wMagnetTrainOffset:: ds 1
wMagnetTrainPosition:: ds 1
wMagnetTrainWaitCounter:: ds 1

NEXTU ; cf64
; unown puzzle data
wHoldingUnownPuzzlePiece:: ds 1
wUnownPuzzleCursorPosition:: ds 1
wUnownPuzzleHeldPiece:: ds 1

NEXTU ; cf64
; miscellaneous
wFrameCounter::
wNrOfBeatenBattleTowerTrainers::
wMomBankDigitCursorPosition::
wNamingScreenLetterCase::
wHallOfFameMonCounter::
wSlotsDelay::
	ds 1
wPrinterQueueLength::
	ds 1
ENDU ; cf67

wRequested2bpp::
wRequested2bppSize:: ds 1 ; cf67
wRequested2bppSource:: ds 2 ; cf68
wRequested2bppDest:: ds 2 ; cf6a

wRequested1bpp::
wRequested1bppSize:: ds 1 ; cf6c
wRequested1bppSource:: ds 2 ; cf6d
wRequested1bppDest:: ds 2 ; cf6f

wWindowStackPointer:: ds 2 ; cf71
wMenuJoypad:: ds 1 ; cf73
wMenuSelection:: ds 1 ; cf74
wMenuSelectionQuantity:: ds 1 ; cf75
wWhichIndexSet:: ds 1 ; cf76
wScrollingMenuCursorPosition:: ds 1 ; cf77
wWindowStackSize:: ds 1 ; cf78

	ds 8

; menu header
wMenuHeader:: ; cf81
wMenuFlags:: ds 1
wMenuBorderTopCoord:: ds 1
wMenuBorderLeftCoord:: ds 1
wMenuBorderBottomCoord:: ds 1
wMenuBorderRightCoord:: ds 1
wMenuDataPointer:: ds 2
wMenuCursorBuffer:: ds 2
wMenuDataBank:: ds 1
	ds 6
wMenuHeaderEnd::

wMenuData::
wMenuDataFlags:: ds 1 ; cf91

UNION ; cf92
; Vertical Menu/DoNthMenu/SetUpMenu
wMenuDataItems:: ds 1 ; cf92
wMenuDataIndicesPointer:: ds 2 ; cf94
wMenuDataDisplayFunctionPointer:: ds 2 ; cf96
wMenuDataPointerTableAddr:: ds 2 ; cf97

NEXTU ; cf92
; 2D Menu
wMenuData_2DMenuDimensions:: ds 1 ; cf92
wMenuData_2DMenuSpacing:: ds 1 ; cf93
wMenuData_2DMenuItemStringsBank:: ds 1 ; cf94
wMenuData_2DMenuItemStringsAddr:: ds 2 ; cf96
wMenuData_2DMenuFunctionBank:: ds 1 ; cf97
wMenuData_2DMenuFunctionAddr:: ds 2 ; cf98

NEXTU ; cf92
; Scrolling Menu
wMenuData_ScrollingMenuHeight:: ds 1 ; cf92
wMenuData_ScrollingMenuWidth:: ds 1 ; cf93
wMenuData_ScrollingMenuSpacing:: ds 1 ; cf94
wMenuData_ItemsPointerBank:: ds 1 ; cf95
wMenuData_ItemsPointerAddr:: ds 2 ; cf97
wMenuData_ScrollingMenuFunction1:: ds 3 ; cf98
wMenuData_ScrollingMenuFunction2:: ds 3 ; cf9b
wMenuData_ScrollingMenuFunction3:: ds 3 ; cf9e
ENDU ; cfa1
wMenuDataEnd::

w2DMenuData::
w2DMenuCursorInitY:: ds 1 ; cfa1
w2DMenuCursorInitX:: ds 1 ; cfa2
w2DMenuNumRows:: ds 1 ; cfa3
w2DMenuNumCols:: ds 1 ; cfa4
w2DMenuFlags1:: ; cfa5
; bit 7: Disable checking of wMenuJoypadFilter
; bit 6: Enable sprite animations
; bit 5: Wrap around vertically
; bit 4: Wrap around horizontally
; bit 3: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 5 is disabled and we tried to go too far down
; bit 2: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 5 is disabled and we tried to go too far up
; bit 1: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 4 is disabled and we tried to go too far left
; bit 0: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 4 is disabled and we tried to go too far right
	ds 1
w2DMenuFlags2:: ds 1 ; cfa6
w2DMenuCursorOffsets:: ds 1 ; cfa7
wMenuJoypadFilter:: ds 1 ; cfa8
w2DMenuDataEnd::

wMenuCursorY:: ds 1 ; cfa9
wMenuCursorX:: ds 1 ; cfaa
wCursorOffCharacter:: ds 1 ; cfab
wCursorCurrentTile:: ds 2 ; cfac

	ds 3

wOverworldDelay:: ds 1 ; cfb1
wTextDelayFrames:: ds 1 ; cfb2
wVBlankOccurred:: ds 1 ; cfb3

wPredefID:: ds 1 ; cfb4
wPredefTemp:: ds 2 ; cfb5
wPredefAddress:: ds 2 ; cfb7
wFarCallBCBuffer:: ds 2 ; cfb9

wcfbb:: ds 1

wGameTimerPause:: ; cfbc
; bit 0: game timer paused
; bit 7: something mobile
	ds 1

	ds 1

wcfbe:: ; SGB flags?
; bit 7
	ds 1

	ds 1

wInBattleTowerBattle:: ; cfc0
; 0 not in BattleTower-Battle
; 1 BattleTower-Battle
	ds 1

	ds 1

wFXAnimID:: ds 2 ; cfc2

wPlaceBallsX:: ds 1 ; cfc4
wPlaceBallsY:: ds 1 ; cfc5

wTileAnimationTimer:: ds 1 ; cfc6

; palette backups?
wBGP:: ds 1
wOBP0:: ds 1
wOBP1:: ds 1

wNumHits:: ds 1

	ds 1

wOptions:: ; cfcc
; bit 0-2: number of frames to delay when printing text
;   fast 1; mid 3; slow 5
; bit 3: ?
; bit 4: no text delay
; bit 5: stereo off/on
; bit 6: battle style shift/set
; bit 7: battle scene off/on
	ds 1
wSaveFileExists:: ds 1
wTextBoxFrame:: ; cfce
; bits 0-2: textbox frame 0-7
	ds 1
wTextBoxFlags::
; bit 0: 1-frame text delay
; bit 4: no text delay
	ds 1
wGBPrinter:: ; cfd0
; bit 0-6: brightness
;   lightest: $00
;   lighter:  $20
;   normal:   $40 (default)
;   darker:   $60
;   darkest:  $7F
	ds 1
wOptions2:: ; cfd1
; bit 1: menu account off/on
	ds 1
	ds 2
wOptionsEnd::

; Time buffer, for counting the amount of time since
; an event began.
wSecondsSince:: ds 1
wMinutesSince:: ds 1
wHoursSince:: ds 1
wDaysSince:: ds 1


SECTION "WRAM 1", WRAMX

wGBCOnlyDecompressBuffer:: ds 1 ; also uses the next $53f bytes for $540 total

wDefaultSpawnpoint:: ds 1

UNION ; d002
; mail temp storage
wTempMail:: mailmsg wTempMail

NEXTU ; d002
; poke seer
wSeerAction:: ds 1
wSeerNickname:: ds MON_NAME_LENGTH
wSeerCaughtLocation:: ds 17
wSeerTimeOfDay:: ds NAME_LENGTH
wSeerOTName:: ds NAME_LENGTH
wSeerOTNameGrammar:: ds 1
wSeerCaughtLevelString:: ds 4
wSeerCaughtLevel:: ds 1
wSeerCaughtData:: ds 1
wSeerCaughtGender:: ds 1

NEXTU ; d002
; mon buffer
wBufferMonNick:: ds MON_NAME_LENGTH ; d002
wBufferMonOT:: ds NAME_LENGTH ; d00d
wBufferMon:: party_struct wBufferMon ; d018
	ds 8
wMonOrItemNameBuffer::

NEXTU ; d002
; bug-catching contest
wBugContestResults::
	bugcontestwinner wBugContestFirstPlace
	bugcontestwinner wBugContestSecondPlace
	bugcontestwinner wBugContestThirdPlace
wBugContestWinnersEnd::
	bugcontestwinner wBugContestTemp
	ds 4
wBugContestWinnerName:: ds NAME_LENGTH

NEXTU ; d002
; mart items
wMartItem1BCD:: ds 3
wMartItem2BCD:: ds 3
wMartItem3BCD:: ds 3
wMartItem4BCD:: ds 3
wMartItem5BCD:: ds 3
wMartItem6BCD:: ds 3
wMartItem7BCD:: ds 3
wMartItem8BCD:: ds 3
wMartItem9BCD:: ds 3
wMartItem10BCD:: ds 3
wMartItemBCDEnd::

NEXTU ; d002
; town map data
wTownMapPlayerIconLandmark:: ds 1
UNION
wTownMapCursorLandmark:: ds 1
wTownMapCursorObjectPointer:: ds 2
NEXTU
wTownMapCursorCoordinates:: ds 2
ENDU

NEXTU ; d002
; phone call data
wPhoneScriptBank:: ds 1
wPhoneCaller:: ds 2

NEXTU ; d002
; radio data
wCurrentRadioLine:: ds 1
wNextRadioLine:: ds 1
wRadioTextDelay:: ds 1
wNumRadioLinesPrinted:: ds 1
wOaksPKMNTalkSegmentCounter:: ds 1
	ds 5
wRadioText:: ds 2 * SCREEN_WIDTH
wRadioTextEnd::

NEXTU ; d002
; lucky number show
wLuckyNumberDigit1Buffer:: ds 1
wLuckyNumberDigit2Buffer:: ds 1
wLuckyNumberDigit3Buffer:: ds 1
wLuckyNumberDigit4Buffer:: ds 1
wLuckyNumberDigit5Buffer:: ds 1

NEXTU ; d002
; movement buffer data
wMovementBufferCount:: ds 1
wMovementBufferObject:: ds 1
wUnusedMovementBufferBank:: ds 1
wUnusedMovementBufferPointer:: ds 2
wMovementBuffer:: ds 55

NEXTU ; d002
; box printing
wWhichBoxMonToPrint:: ds 1
wFinishedPrintingBox:: ds 1
wAddrOfBoxToPrint:: ds 2
wBankOfBoxToPrint:: ds 1
wWhichBoxToPrint:: ds 1

NEXTU ; d002
; trainer HUD data
	ds 1
wPlaceBallsDirection:: ds 1
wTrainerHUDTiles:: ds 1

NEXTU ; d002
; mobile participant nicknames
	ds 4
wMobileParticipant1Nickname:: ds NAME_LENGTH_JAPANESE
wMobileParticipant2Nickname:: ds NAME_LENGTH_JAPANESE
wMobileParticipant3Nickname:: ds NAME_LENGTH_JAPANESE

NEXTU ; d002
; earthquake data buffer
wEarthquakeMovementDataBuffer:: ds 5

NEXTU ; d002
; miscellaneous
wTempDayOfWeek::
wApricorns::
wKeepSevenBiasChance:: ; used in the slots to handle the favoring of 7 symbol streaks
	ds 1
	ds 2
wStartFlypoint:: ds 1
wEndFlypoint:: ds 1

NEXTU ; d002
; unidentified
wd002:: ds 1
wd003:: ds 1
wd004:: ds 1

; mobile?
	ds 3
wd008:: ds 2
	ds 2
wd00c:: ds 1
wd00d:: ds 1
	ds 1
wd00f:: ds 1
wd010:: ds 1
wd011:: ds 1
wd012:: ds 1
wd013:: ds 1
wd014:: ds 2
	ds 1
wd017:: ds 1
wd018:: ds 1
wd019:: ds 1
	ds 19
wd02d:: ds 1
wd02e:: ds 1
wd02f:: ds 1
wd030:: ds 1
wd031:: ds 1
wd032:: ds 1
wd033:: ds 1
wd034:: ds 2
wd036:: ds 2
	ds 6

UNION ; d03e
; engine buffers
wEngineBuffer1:: ds 1
wEngineBuffer2:: ds 1
wEngineBuffer3:: ds 1
wEngineBuffer4:: ds 1
wEngineBuffer5:: ds 1

NEXTU ; d03e
; menu items list
wMenuItemsList:: ds 16
wMenuItemsListEnd::

NEXTU ; d03e
; fruit tree data
wCurFruitTree:: ds 1
wCurFruit:: ds 1

NEXTU ; d03e
; elevator data
wElevatorPointerBank:: ds 1
wElevatorPointer:: ds 2
wElevatorOriginFloor:: ds 1

NEXTU ; d03e
; coord event data
wCurCoordEventSceneID:: ds 1
wCurCoordEventMapY:: ds 1
wCurCoordEventMapX:: ds 1
	ds 1
wCurCoordEventScriptAddr:: ds 2

NEXTU ; d03e
; BG event data
wCurBGEventYCoord:: ds 1
wCurBGEventXCoord:: ds 1
wCurBGEventType:: ds 1
wCurBGEventScriptAddr:: ds 2

NEXTU ; d03e
; mart data
	ds 1
wMartPointerBank:: ds 1
wMartPointer:: ds 2
	ds 1
wBargainShopFlags:: ds 1

NEXTU ; d03e
; trainer data
	ds 3
wTempTrainer::
wTempTrainerEventFlag:: ds 2
wTempTrainerClass:: ds 1
wTempTrainerID:: ds 1
wSeenTextPointer:: ds 2
wWinTextPointer:: ds 2
wLossTextPointer:: ds 2
wScriptAfterPointer:: ds 2
wRunningTrainerBattleScript:: ds 1
wTempTrainerEnd::

NEXTU ; d03e
; player movement data
wCurInput:: ds 1
wd03f:: ds 1
wd040:: ds 1
wd041:: ds 1
wMovementAnimation:: ds 1
wWalkingDirection:: ds 1
wFacingDirection:: ds 1
wWalkingX:: ds 1
wWalkingY:: ds 1
wWalkingTile:: ds 1
	ds 6
wPlayerTurningDirection:: ds 1

NEXTU ; d03e
; std script buffer
	ds 1
wJumpStdScriptBuffer:: ds 3

NEXTU ; d03e
; phone script pointer
	ds 10
wPhoneScriptPointer:: ds 2

NEXTU ; d03e
; backup menu data
	ds 7
wMenuCursorBufferBackup:: ds 1
wMenuScrollPositionBackup:: ds 1
	ds 31
ENDU ; d066
ENDU ; d066

wTMHMMoveNameBackup:: ds MOVE_NAME_LENGTH ; d066

wStringBuffer1:: ds 19 ; d073
wStringBuffer2:: ds 19 ; d086
wStringBuffer3:: ds 19 ; d099
wStringBuffer4:: ds 19 ; d0ac
wStringBuffer5:: ds 19 ; d0bf

wBattleMenuCursorBuffer:: ds 2 ; d0d2

wCurBattleMon:: ds 1 ; d0d4
wCurMoveNum:: ds 1 ; d0d5

wLastPocket:: ds 1

wPCItemsCursor::        ds 1
wPartyMenuCursor::      ds 1
wItemsPocketCursor::    ds 1
wKeyItemsPocketCursor:: ds 1
wBallsPocketCursor::    ds 1
wTMHMPocketCursor::     ds 1

wPCItemsScrollPosition::        ds 1
wPartyMenuScrollPosition::      ds 1 ; unused
wItemsPocketScrollPosition::    ds 1
wKeyItemsPocketScrollPosition:: ds 1
wBallsPocketScrollPosition::    ds 1
wTMHMPocketScrollPosition::     ds 1

wSwitchMon::
wSwitchItem::
wMoveSwapBuffer::
wd0e3::
	ds 1

wMenuScrollPosition:: ds 4

wQueuedScriptBank:: ds 1
wQueuedScriptAddr:: ds 2

wNumMoves:: ds 1

wFieldMoveSucceeded::
wItemEffectSucceeded::
wBattlePlayerAction::
; 0 - use move
; 1 - use item
; 2 - switch
wSolvedUnownPuzzle::
	ds 1 ; d0ec

wVramState:: ; d0ed
; bit 0: overworld sprite updating on/off
; bit 6: something to do with text
; bit 7: on when surf initiates
;        flickers when climbing waterfall
	ds 1

wBattleResult:: ds 1 ; d0ee
wUsingItemWithSelect:: ds 1 ; d0ef

UNION ; d0f0
; mart data
wCurMart:: ds 16
wCurMartEnd::

NEXTU ; d0f0
; elevator data
wCurElevator:: ds 1
wCurElevatorFloors:: ds 1

NEXTU ; d0f0
; mailbox data
wCurMessageScrollPosition:: ds 1
wCurMessageIndex:: ds 1
wMailboxCount:: ds 1
wMailboxItems:: ds MAILBOX_CAPACITY
wMailboxEnd:: ; d0fe
ENDU ; d100

wListPointer:: ds 2 ; d100
wUnusedD102:: ds 2 ; d102
wItemAttributesPtr:: ds 2 ; d104

wCurItem:: ds 1 ; d106
wCurItemQuantity:: ; d107
wMartItemID::
	ds 1

wCurPartySpecies:: ds 1 ; d108

wCurPartyMon:: ; d109
; contains which monster in a party
; is being dealt with at the moment
; 0-5
	ds 1

wWhichHPBar::
; 0: Enemy
; 1: Player
; 2: Party Menu
	ds 1
wPokemonWithdrawDepositParameter::
; 0: Take from PC
; 1: Put into PC
; 2: Take from Day-Care
; 3: Put into Day-Care
	ds 1

wItemQuantityChangeBuffer:: ds 1
wItemQuantityBuffer:: ds 1

wTempMon:: party_struct wTempMon ; d10e

wSpriteFlags:: ds 1 ; d13e

wHandlePlayerStep:: ds 2 ; d13f

wPartyMenuActionText:: ds 1 ; d141

wItemAttributeParamBuffer:: ds 1 ; d142

wCurPartyLevel:: ds 1 ; d143

wScrollingMenuListSize:: ds 2

; used when following a map warp
; d146
wNextWarp:: ds 1
wNextMapGroup:: ds 1
wNextMapNumber:: ds 1
wPrevWarp:: ds 1
wPrevMapGroup:: ds 1
wPrevMapNumber:: ds 1
; d14c

wPlayerBGMapOffsetX:: ds 1 ; used in FollowNotExact; unit is pixels
wPlayerBGMapOffsetY:: ds 1 ; used in FollowNotExact; unit is pixels

; Player movement
wPlayerStepVectorX:: ds 1 ; d14e
wPlayerStepVectorY:: ds 1 ; d14f
wPlayerStepFlags::   ds 1 ; d150
wPlayerStepDirection::  ; d151
; bit 7: Start step
; bit 6: Stop step
; bit 5: Doing step
; bit 4: In midair
; bits 0-3: unused
	ds 1

wBGMapAnchor:: ds 2 ; d152

UNION ; d154
wUsedSprites:: ds 64
wUsedSpritesEnd::

NEXTU ; d154
	ds 31
wd173:: ds 1 ; related to command queue type 3
ENDU ; d194

wOverworldMapAnchor:: ds 2 ; d194
wMetatileStandingY:: ds 1 ; d196
wMetatileStandingX:: ds 1 ; d197

wMapPartial::
wMapAttributesBank:: ds 1 ; d198
wMapTileset:: ds 1 ; d199
wEnvironment:: ds 1 ; d19a
wMapAttributesPointer:: ds 2 ; d19b
wMapPartialEnd::

wMapAttributes:: ; d19d
wMapBorderBlock:: ds 1 ; d19d
; width/height are in blocks (2x2 walkable tiles, 4x4 graphics tiles)
wMapHeight:: ds 1 ; d19e
wMapWidth:: ds 1 ; d19f
wMapBlocksBank:: ds 1; d1a0
wMapBlocksPointer:: ds 2 ; d1a1
wMapScriptsBank:: ds 1 ; d1a3
wMapScriptsPointer:: ds 2 ; d1a4
wMapEventsPointer:: ds 2 ; d1a6
; bit set
wMapConnections:: ds 1 ; d1a8
wMapAttributesEnd::

wNorthMapConnection:: map_connection_struct wNorth ; d1a9
wSouthMapConnection:: map_connection_struct wSouth ; d1b5
wWestMapConnection::  map_connection_struct wWest ; d1c1
wEastMapConnection::  map_connection_struct wEast ; d1cd

wTileset::
wTilesetBank:: ds 1 ; d1d9
wTilesetAddress:: ds 2 ; d1da
wTilesetBlocksBank:: ds 1 ; d1dc
wTilesetBlocksAddress:: ds 2 ; d1dd
wTilesetCollisionBank:: ds 1 ; d1df
wTilesetCollisionAddress:: ds 2 ; d1e0
wTilesetAnim:: ds 2 ; bank 3f ; d1e2
	ds 2 ; unused ; d1e4
wTilesetPalettes:: ds 2 ; bank 3f ; d1e6
wTilesetEnd::

wEvolvableFlags:: flag_array PARTY_LENGTH ; d1e8

wForceEvolution:: ds 1 ; d1e9

UNION ; d1ea
; general-purpose buffers
wBuffer1:: ds 1 ; d1ea
wBuffer2:: ds 1 ; d1eb
wBuffer3:: ds 1 ; d1ec
wBuffer4:: ds 1 ; d1ed
wBuffer5:: ds 1 ; d1ee
wBuffer6:: ds 1 ; d1ef

NEXTU ; d1ea
; HP bar animations
wCurHPAnimMaxHP::   ds 2 ; d1ea
wCurHPAnimOldHP::   ds 2 ; d1ec
wCurHPAnimNewHP::   ds 2 ; d1ee
wCurHPAnimPal::     ds 1 ; d1f0
wCurHPBarPixels::   ds 1 ; d1f1
wNewHPBarPixels::   ds 1 ; d1f2
wCurHPAnimDeltaHP:: ds 2 ; d1f3
wCurHPAnimLowHP::   ds 1 ; d1f5
wCurHPAnimHighHP::  ds 1 ; d1f6

NEXTU ; d1ea
; evolution data
wEvolutionOldSpecies:: ds 1 ; d1ea
wEvolutionNewSpecies:: ds 1 ; d1eb
wEvolutionPicOffset:: ds 1 ; d1ec
wEvolutionCanceled:: ds 1 ; d1ed

NEXTU ; d1ea
; mobile
	ds 2
wd1ec:: ds 1
wd1ed:: ds 1
wd1ee:: ds 1
wd1ef:: ds 1
wd1f0:: ds 1
wd1f1:: ds 1
wd1f2:: ds 1
wd1f3:: ds 4

NEXTU ; d1ea
; miscellaneous
wMagikarpLength:: ds 2
wSelectedDecoration:: ds 1
wOtherDecoration::    ds 1
	ds 3
wCurEnemyItem:: ds 1
ENDU ; d1f7

	ds 3

wLinkBattleRNs:: ds 10 ; d1fa

wTempEnemyMonSpecies::  ds 1 ; d204
wTempBattleMonSpecies:: ds 1 ; d205

wEnemyMon:: battle_struct wEnemyMon ; d206
wEnemyMonBaseStats:: ds 5 ; d226
wEnemyMonCatchRate:: ds 1 ; d22b
wEnemyMonBaseExp::   ds 1 ; d22c
wEnemyMonEnd::


wBattleMode:: ; d22d
; 0: overworld
; 1: wild battle
; 2: trainer battle
	ds 1

wTempWildMonSpecies:: ds 1

wOtherTrainerClass:: ; d22f
; class (Youngster, Bug Catcher, etc.) of opposing trainer
; 0 if opponent is a wild Pokémon, not a trainer
	ds 1

; BATTLETYPE_* values
wBattleType:: ds 1 ; d230

wOtherTrainerID:: ; d231
; which trainer of the class that you're fighting
; (Joey, Mikey, Albert, etc.)
	ds 1

wForcedSwitch:: ds 1

wTrainerClass:: ds 1 ; d233

wUnownLetter:: ds 1 ; d234

wMoveSelectionMenuType:: ds 1

; corresponds to the data/pokemon/base_stats/*.asm contents
wCurBaseData:: ; d236
wBaseDexNo:: ds 1 ; d236
wBaseStats:: ; d237
wBaseHP:: ds 1 ; d237
wBaseAttack:: ds 1 ; d238
wBaseDefense:: ds 1 ; d239
wBaseSpeed:: ds 1 ; d23a
wBaseSpecialAttack:: ds 1 ; d23b
wBaseSpecialDefense:: ds 1 ; d23c
wBaseType:: ; d23d
wBaseType1:: ds 1 ; d23d
wBaseType2:: ds 1 ; d23e
wBaseCatchRate:: ds 1 ; d23f
wBaseExp:: ds 1 ; d240
wBaseItems:: ; d241
wBaseItem1:: ds 1 ; d241
wBaseItem2:: ds 1 ; d242
wBaseGender:: ds 1 ; d243
wBaseUnknown1:: ds 1 ; d244
wBaseEggSteps:: ds 1 ; d245
wBaseUnknown2:: ds 1 ; d246
wBasePicSize:: ds 1 ; d247
wBasePadding:: ds 4 ; d248
wBaseGrowthRate:: ds 1 ; d24c
wBaseEggGroups:: ds 1 ; d24d
wBaseTMHM:: flag_array NUM_TM_HM_TUTOR ; d24e
wCurBaseDataEnd::

wCurDamage:: ds 2 ; d256

	ds 2

wMornEncounterRate::  ds 1 ; d25a
wDayEncounterRate::   ds 1 ; d25b
wNiteEncounterRate::  ds 1 ; d25c
wWaterEncounterRate:: ds 1 ; d25d
wListMoves_MoveIndicesBuffer:: ds NUM_MOVES
wPutativeTMHMMove:: ds 1
wInitListType:: ds 1
wBattleHasJustStarted:: ds 1

wNamedObjectIndexBuffer::
wCurTMHM::
wTypeMatchup::
wFoundMatchingIDInParty::
wd265::
	ds 1

wFailedToFlee:: ds 1
wNumFleeAttempts:: ds 1
wMonTriedToEvolve:: ds 1

wTimeOfDay:: ds 1 ; d269

	ds 1


SECTION "Enemy Party", WRAMX

UNION ; d26b
wd26b::
wPokedexShowPointerAddr:: ds 2
wPokedexShowPointerBank:: ds 1
	ds 3
wd271:: ds 5

NEXTU ; d26b
; enemy party
wOTPlayerName:: ds NAME_LENGTH ; d26b
ENDU ; d276

wOTPlayerID:: ds 2 ; d276
	ds 8
wOTPartyCount::   ds 1 ; d280
wOTPartySpecies:: ds PARTY_LENGTH ; d281
wOTPartyEnd::     ds 1 ; older code doesn't check PartyCount

UNION ; d288
; ot party mons
wOTPartyMons::
wOTPartyMon1:: party_struct wOTPartyMon1 ; d288
wOTPartyMon2:: party_struct wOTPartyMon2 ; d2b8
wOTPartyMon3:: party_struct wOTPartyMon3 ; d2e8
wOTPartyMon4:: party_struct wOTPartyMon4 ; d318
wOTPartyMon5:: party_struct wOTPartyMon5 ; d348
wOTPartyMon6:: party_struct wOTPartyMon6 ; d378
wOTPartyMonsEnd::

wOTPartyMonOT:: ds NAME_LENGTH * PARTY_LENGTH ; d3a8
wOTPartyMonNicknames:: ds MON_NAME_LENGTH * PARTY_LENGTH ; d3ea
wOTPartyDataEnd::
	ds 4

NEXTU ; d288
; catch tutorial dude pack
wDudeBag::
wDudeNumItems:: ds 1
wDudeItems:: ds 2 * 4
wDudeItemsEnd:: ds 1

wDudeNumKeyItems:: ds 1 ; d292
wDudeKeyItems:: ds 18
wDudeKeyItemsEnd:: ds 1

wDudeNumBalls:: ds 1 ; d2a6
wDudeBalls:: ds 2 * 4 ; d2a7
wDudeBallsEnd:: ds 1 ; d2af
wDudeBagEnd::
ENDU ; d430

wd430::
wBattleAction:: ds 1 ; d430

wd431:: ds 1
wMapStatus:: ds 1 ; d432
wMapEventStatus:: ; d433
; 0: do map events
; 1: do background events
	ds 1

wScriptFlags:: ; d434
; bit 3: priority jump
	ds 1
wScriptFlags2:: ; d435
	ds 1
wScriptFlags3:: ; d436
; bit 0: count steps
; bit 1: coord events
; bit 2: warps and connections
; bit 4: wild encounters
; bit 5: unknown
	ds 1

wScriptMode:: ds 1 ; d437
wScriptRunning:: ds 1 ; d438
wScriptBank:: ds 1 ; d439
wScriptPos:: ds 2 ; d43a

wScriptStackSize:: ds 1
wScriptStack:: ds 3 * 5
	ds 1
wScriptDelay:: ds 1 ; d44d

wPriorityScriptBank::
wScriptTextBank::
	ds 1 ; d44e
wPriorityScriptAddr::
wScriptTextAddr::
	ds 2 ; d44f
	ds 1
wWildEncounterCooldown:: ds 1 ; d452
wXYComparePointer:: ds 2 ; d453
	ds 4

wBattleScriptFlags:: ds 2 ; d459
wPlayerSpriteSetupFlags:: ; d45b
; bit 7: if set, cancel wPlayerAction
; bit 6: RefreshMapSprites doesn't reload player sprite
; bit 5: if set, set facing according to bits 0-1
; bit 2: female player has been transformed into male
; bits 0-1: direction facing
	ds 1
wMapReentryScriptQueueFlag:: ds 1 ; d45c MemScriptFlag
wMapReentryScriptBank:: ds 1 ; d45d MemScriptBank
wMapReentryScriptAddress:: ds 2 ; d45e MemScriptAddr
	ds 4
wTimeCyclesSinceLastCall:: ds 1 ; d464
wReceiveCallDelay_MinsRemaining:: ds 1 ; d465
wReceiveCallDelay_StartTime:: ds 3 ; d466
	ds 3
wBugContestMinsRemaining:: ds 1 ; d46c
wBugContestSecsRemaining:: ds 1 ; d46d
	ds 2
wMapStatusEnd:: ; d470

	ds 2

wCrystalData::
wPlayerGender:: ; d472
; bit 0:
;	0 male
;	1 female
	ds 1
wd473:: ds 1
wd474:: ds 1
wd475:: ds 1
wd476:: ds 1
wd477:: ds 1
wd478:: ds 1
wCrystalDataEnd::

wd479:: ds 2

wGameData::
wPlayerData::
wPlayerID:: ; d47b
	ds 2

wPlayerName:: ds NAME_LENGTH ; d47d
wMomsName::   ds NAME_LENGTH ; d488
wRivalName::  ds NAME_LENGTH ; d493
wRedsName::   ds NAME_LENGTH ; d49e
wGreensName:: ds NAME_LENGTH ; d4a9

wSavedAtLeastOnce:: ds 1
wSpawnAfterChampion:: ds 1

; init time set at newgame
wStartDay:: ds 1 ; d4b6
wStartHour:: ds 1 ; d4b7
wStartMinute:: ds 1 ; d4b8
wStartSecond:: ds 1 ; d4b9

wRTC:: ds 8 ; d4ba
wDST:: ; d4c2
; bit 7: dst
	ds 1

wGameTime::
wGameTimeCap::     ds 1 ; d4c3
wGameTimeHours::   ds 2 ; d4c4
wGameTimeMinutes:: ds 1 ; d4c6
wGameTimeSeconds:: ds 1 ; d4c7
wGameTimeFrames::  ds 1 ; d4c8

	ds 2

wCurDay:: ds 1 ; d4cb

	ds 1

wObjectFollow_Leader:: ds 1
wObjectFollow_Follower:: ds 1
wCenteredObject:: ds 1
wFollowerMovementQueueLength:: ds 1
wFollowMovementQueue:: ds 5

wObjectStructs:: ; d4d6
wPlayerStruct::   object_struct wPlayer
wObject1Struct::  object_struct wObject1
wObject2Struct::  object_struct wObject2
wObject3Struct::  object_struct wObject3
wObject4Struct::  object_struct wObject4
wObject5Struct::  object_struct wObject5
wObject6Struct::  object_struct wObject6
wObject7Struct::  object_struct wObject7
wObject8Struct::  object_struct wObject8
wObject9Struct::  object_struct wObject9
wObject10Struct:: object_struct wObject10
wObject11Struct:: object_struct wObject11
wObject12Struct:: object_struct wObject12
wObjectStructsEnd:: ; d6de

wCmdQueue:: ds CMDQUEUE_CAPACITY * CMDQUEUE_ENTRY_SIZE

	ds 40

wMapObjects:: ; d71e
wPlayerObject:: map_object wPlayer
wMap1Object::   map_object wMap1
wMap2Object::   map_object wMap2
wMap3Object::   map_object wMap3
wMap4Object::   map_object wMap4
wMap5Object::   map_object wMap5
wMap6Object::   map_object wMap6
wMap7Object::   map_object wMap7
wMap8Object::   map_object wMap8
wMap9Object::   map_object wMap9
wMap10Object::  map_object wMap10
wMap11Object::  map_object wMap11
wMap12Object::  map_object wMap12
wMap13Object::  map_object wMap13
wMap14Object::  map_object wMap14
wMap15Object::  map_object wMap15
wMapObjectsEnd::

wObjectMasks:: ds NUM_OBJECTS ; d81e

wVariableSprites:: ds 16; d82e

wEnteredMapFromContinue:: ds 1 ; d83e
	ds 2
wTimeOfDayPal:: ds 1 ; d841
	ds 4
wTimeOfDayPalFlags:: ds 1 ; d846
wTimeOfDayPalset:: ds 1
wCurTimeOfDay:: ds 1 ; d848

	ds 1

wSecretID:: ds 2
wStatusFlags:: ; d84c
; bit 0: pokedex
; bit 1: unown dex
; bit 2: flash
; bit 3: caught pokerus
; bit 4: rocket signal
; bit 5: wild encounters on/off
; bit 6: hall of fame
; bit 7: bug contest on
	ds 1

wStatusFlags2:: ; d84d
; bit 0: rockets
; bit 1: safari game (unused)
; bit 2: bug contest timer
; bit 3: unused
; bit 4: bike shop call
; bit 5: can use sweet scent
; bit 6: reached goldenrod
; bit 7: rockets in mahogany
	ds 1

wMoney:: ds 3 ; d84e
wMomsMoney:: ds 3 ; d851

wMomSavingMoney:: ; d854
; bit 0: saving some money
; bit 1: saving half money (unused)
; bit 2: saving all money (unused)
; bit 7: active
	ds 1

wCoins:: ds 2 ; d855

wBadges::
wJohtoBadges:: flag_array NUM_JOHTO_BADGES ; d857
wKantoBadges:: flag_array NUM_KANTO_BADGES ; d858


wTMsHMs:: ds NUM_TMS + NUM_HMS ; d859
wTMsHMsEnd::

wNumItems:: ds 1 ; d892
wItems:: ds MAX_ITEMS * 2 + 1 ; d893
wItemsEnd::

wNumKeyItems:: ds 1 ; d8bc
wKeyItems:: ds MAX_KEY_ITEMS + 1 ; d8bd
wKeyItemsEnd::

wNumBalls:: ds 1 ; d8d7
wBalls:: ds MAX_BALLS * 2 + 1 ; d8d8
wBallsEnd::

wPCItems:: ds MAX_PC_ITEMS * 2 + 1 ; d8f1
wPCItemsEnd::

	ds 1

wPokegearFlags::
; bit 0: map
; bit 1: radio
; bit 2: phone
; bit 3: expn
; bit 7: on/off
	ds 1
wRadioTuningKnob:: ds 1
wLastDexMode:: ds 1
	ds 1
wWhichRegisteredItem:: ds 1 ; d95b
wRegisteredItem:: ds 1 ; d95c

wPlayerState:: ds 1 ; d95d

wHallOfFameCount:: ds 2
wTradeFlags:: flag_array PARTY_LENGTH ; d960
	ds 1
wMooMooBerries:: ds 1 ; d962
wUndergroundSwitchPositions:: ds 1 ; d963
wFarfetchdPosition:: ds 1 ; d964

	ds 13

; map scene ids
wPokecenter2FSceneID::                            ds 1 ; d972
wTradeCenterSceneID::                             ds 1 ; d973
wColosseumSceneID::                               ds 1 ; d974
wTimeCapsuleSceneID::                             ds 1 ; d975
wPowerPlantSceneID::                              ds 1 ; d976
wCeruleanGymSceneID::                             ds 1 ; d977
wRoute25SceneID::                                 ds 1 ; d978
wTrainerHouseB1FSceneID::                         ds 1 ; d979
wVictoryRoadGateSceneID::                         ds 1 ; d97a
wSaffronMagnetTrainStationSceneID::               ds 1 ; d97b
wRoute16GateSceneID::                             ds 1 ; d97c
wRoute17Route18GateSceneID::                      ds 1 ; d97d
wIndigoPlateauPokecenter1FSceneID::               ds 1 ; d97e
wWillsRoomSceneID::                               ds 1 ; d97f
wKogasRoomSceneID::                               ds 1 ; d980
wBrunosRoomSceneID::                              ds 1 ; d981
wKarensRoomSceneID::                              ds 1 ; d982
wLancesRoomSceneID::                              ds 1 ; d983
wHallOfFameSceneID::                              ds 1 ; d984
wRoute27SceneID::                                 ds 1 ; d985
wNewBarkTownSceneID::                             ds 1 ; d986
wElmsLabSceneID::                                 ds 1 ; d987
wPlayersHouse1FSceneID::                          ds 1 ; d988
wRoute29SceneID::                                 ds 1 ; d989
wCherrygroveCitySceneID::                         ds 1 ; d98a
wMrPokemonsHouseSceneID::                         ds 1 ; d98b
wRoute32SceneID::                                 ds 1 ; d98c
wRoute35NationalParkGateSceneID::                 ds 1 ; d98d
wRoute36SceneID::                                 ds 1 ; d98e
wRoute36NationalParkGateSceneID::                 ds 1 ; d98f
wAzaleaTownSceneID::                              ds 1 ; d990
wGoldenrodGymSceneID::                            ds 1 ; d991
wGoldenrodMagnetTrainStationSceneID::             ds 1 ; d992
wGoldenrodPokecenter1FSceneID::                   ds 1 ; d993
wOlivineCitySceneID::                             ds 1 ; d994
wRoute34SceneID::                                 ds 1 ; d995
wRoute34IlexForestGateSceneID::                   ds 1 ; d996
wEcruteakTinTowerEntranceSceneID::                ds 1 ; d997
wWiseTriosRoomSceneID::                           ds 1 ; d998
wEcruteakPokecenter1FSceneID::                    ds 1 ; d999
wEcruteakGymSceneID::                             ds 1 ; d99a
wMahoganyTownSceneID::                            ds 1 ; d99b
wRoute42SceneID::                                 ds 1 ; d99c
wCianwoodCitySceneID::                            ds 1 ; d99d
wBattleTower1FSceneID::                           ds 1 ; d99e
wBattleTowerBattleRoomSceneID::                   ds 1 ; d99f
wBattleTowerElevatorSceneID::                     ds 1 ; d9a0
wBattleTowerHallwaySceneID::                      ds 1 ; d9a1
wBattleTowerOutsideSceneID::                      ds 1 ; d9a2
wRoute43GateSceneID::                             ds 1 ; d9a3
wMountMoonSceneID::                               ds 1 ; d9a4
wSproutTower3FSceneID::                           ds 1 ; d9a5
wTinTower1FSceneID::                              ds 1 ; d9a6
wBurnedTower1FSceneID::                           ds 1 ; d9a7
wBurnedTowerB1FSceneID::                          ds 1 ; d9a8
wRadioTower5FSceneID::                            ds 1 ; d9a9
wRuinsOfAlphOutsideSceneID::                      ds 1 ; d9aa
wRuinsOfAlphResearchCenterSceneID::               ds 1 ; d9ab
wRuinsOfAlphHoOhChamberSceneID::                  ds 1 ; d9ac
wRuinsOfAlphKabutoChamberSceneID::                ds 1 ; d9ad
wRuinsOfAlphOmanyteChamberSceneID::               ds 1 ; d9ae
wRuinsOfAlphAerodactylChamberSceneID::            ds 1 ; d9af
wRuinsOfAlphInnerChamberSceneID::                 ds 1 ; d9b0
wMahoganyMart1FSceneID::                          ds 1 ; d9b1
wTeamRocketBaseB1FSceneID::                       ds 1 ; d9b2
wTeamRocketBaseB2FSceneID::                       ds 1 ; d9b3
wTeamRocketBaseB3FSceneID::                       ds 1 ; d9b4
wGoldenrodUndergroundSwitchRoomEntrancesSceneID:: ds 1 ; d9b5
wSilverCaveRoom3SceneID::                         ds 1 ; d9b6
wVictoryRoadSceneID::                             ds 1 ; d9b7
wDragonsDenB1FSceneID::                           ds 1 ; d9b8
wDragonShrineSceneID::                            ds 1 ; d9b9
wOlivinePortSceneID::                             ds 1 ; d9ba
wVermilionPortSceneID::                           ds 1 ; d9bb
wFastShip1FSceneID::                              ds 1 ; d9bc
wFastShipB1FSceneID::                             ds 1 ; d9bd
wMountMoonSquareSceneID::                         ds 1 ; d9be
wMobileTradeRoomSceneID::                         ds 1 ; d9bf
wMobileBattleRoomSceneID::                        ds 1 ; d9c0

; fight counts
wJackFightCount::    ds 1 ; d9f2
wBeverlyFightCount:: ds 1 ; unused
wHueyFightCount::    ds 1
wGavenFightCount::   ds 1
wBethFightCount::    ds 1
wJoseFightCount::    ds 1
wReenaFightCount::   ds 1
wJoeyFightCount::    ds 1
wWadeFightCount::    ds 1
wRalphFightCount::   ds 1
wLizFightCount::     ds 1
wAnthonyFightCount:: ds 1
wToddFightCount::    ds 1
wGinaFightCount::    ds 1
wIrwinFightCount::   ds 1 ; unused
wArnieFightCount::   ds 1
wAlanFightCount::    ds 1
wDanaFightCount::    ds 1
wChadFightCount::    ds 1
wDerekFightCount::   ds 1 ; unused
wTullyFightCount::   ds 1
wBrentFightCount::   ds 1
wTiffanyFightCount:: ds 1
wVanceFightCount::   ds 1
wWiltonFightCount::  ds 1
wKenjiFightCount::   ds 1 ; unused
wParryFightCount::   ds 1
wErinFightCount::    ds 1
; da0e


wEventFlags:: ; da72
	assert NUM_EVENTS <= $800, "Too many event flags. Over 2048"
	ds $100

wCurBox:: ds 1 ; db72

	ds 2

; 8 chars + $50
wBoxNames:: ds BOX_NAME_LENGTH * NUM_BOXES ; db75

wCelebiEvent:: ; dbf3
; bit 2: forest is restless
	ds 1

	ds 1

wBikeFlags:: ; dbf5
; bit 0: using strength
; bit 1: always on bike
; bit 2: downhill
	ds 1
	ds 1 ; cleared along with wBikeFlags by ResetBikeFlags

wCurrMapSceneScriptPointer:: ds 2 ; dbf7

wCurrentCaller:: ds 2 ; dbf9
wCurrMapWarpCount:: ds 1 ; dbfb
wCurrMapWarpsPointer:: ds 2 ; dbfc
wCurrMapCoordEventCount:: ds 1 ; dbfe
wCurrMapCoordEventsPointer:: ds 2 ; dbff
wCurrMapBGEventCount:: ds 1 ; dc01
wCurrMapBGEventsPointer:: ds 2 ; dc02
wCurrMapObjectEventCount:: ds 1 ; dc04
wCurrMapObjectEventsPointer:: ds 2 ; dc05
wCurrMapSceneScriptCount:: ds 1 ; dc07
wCurrMapSceneScriptsPointer:: ds 2 ; dc08
wCurrMapCallbackCount:: ds 1 ; dc0a
wCurrMapCallbacksPointer:: ds 2 ; dc0b

	ds 2

; Sprite id of each decoration
wDecoBed::           ds 1 ; dc0f
wDecoCarpet::        ds 1 ; dc10
wDecoPlant::         ds 1 ; dc11
wDecoPoster::        ds 1 ; dc12
wDecoConsole::       ds 1 ; dc13
wDecoLeftOrnament::  ds 1 ; dc14
wDecoRightOrnament:: ds 1 ; dc15
wDecoBigDoll::       ds 1 ; dc16

; Items bought from Mom
wWhichMomItem:: ds 1 ; dc17
wWhichMomItemSet:: ds 1 ; dc18
wMomItemTriggerBalance:: ds 3 ; dc19

wDailyResetTimer:: ds 2 ; dc1c
wDailyFlags:: ds 1
wWeeklyFlags:: ds 1
wSwarmFlags:: ds 1
	ds 2
wTimerEventStartDay:: ds 1
	ds 3

wFruitTreeFlags:: flag_array NUM_FRUIT_TREES ; dc27

	ds 2

wLuckyNumberDayBuffer:: ds 2 ; dc2d
	ds 2
wSpecialPhoneCallID:: ds 1 ; dc31
	ds 3
wBugContestStartTime:: ds 4 ; day, hour, min, sec ; dc35
wUnusedTwoDayTimerOn:: ds 1 ; dc39
wUnusedTwoDayTimer:: ds 1
wUnusedTwoDayTimerStartDate:: ds 1
	ds 4
wMobileOrCable_LastSelection:: ds 1
wdc41:: ds 1
wdc42:: ds 8
wBuenasPassword:: ds 1
wBlueCardBalance:: ds 1
wDailyRematchFlags:: ds 4
wDailyPhoneItemFlags:: ds 4
wDailyPhoneTimeOfDayFlags:: ds 4
wKenjiBreakTimer:: ds 2 ; Kenji
wYanmaMapGroup:: ds 1 ; dc5a
wYanmaMapNumber:: ds 1
wPlayerMonSelection:: ds 3
wdc5f:: ds 1
wdc60:: ds 19

wStepCount:: ds 1 ; dc73
wPoisonStepCount:: ds 1 ; dc74
	ds 2
wHappinessStepCount:: ds 1
	ds 1

wParkBallsRemaining::
wSafariBallsRemaining:: ds 1 ; dc79
wSafariTimeRemaining:: ds 2 ; dc7a

wPhoneList:: ds CONTACT_LIST_SIZE ; dc7c
; dc86
	ds 23

wLuckyNumberShowFlag:: ds 1 ; dc9d
	ds 1
wLuckyIDNumber:: ds 2 ; dc9f

wRepelEffect:: ds 1 ; If a Repel is in use, it contains the nr of steps it's still active
wBikeStep:: ds 2
wKurtApricornQuantity:: ds 1

wPlayerDataEnd::


wCurrMapData::

wVisitedSpawns:: flag_array NUM_SPAWNS ; dca5

wDigWarpNumber:: ds 1 ; dcaa
wDigMapGroup::   ds 1 ; dcab
wDigMapNumber::  ds 1 ; dcac

; used on maps like second floor pokécenter, which are reused, so we know which
; map to return to
wBackupWarpNumber:: ds 1 ; dcad
wBackupMapGroup::   ds 1 ; dcae
wBackupMapNumber::  ds 1 ; dcaf

	ds 3

wLastSpawnMapGroup:: ds 1
wLastSpawnMapNumber:: ds 1

wWarpNumber:: ds 1 ; dcb4
wMapGroup:: ds 1 ; dcb5 ; map group of current map
wMapNumber:: ds 1 ; dcb6 ; map number of current map
wYCoord:: ds 1 ; dcb7 ; current y coordinate relative to top-left corner of current map
wXCoord:: ds 1 ; dcb8 ; current x coordinate relative to top-left corner of current map
wScreenSave:: ds 6 * 5

wCurrMapDataEnd::


SECTION "Party", WRAMX

wPokemonData::

wPartyCount::   ds 1 ; DC88 ; number of Pokémon in party
wPartySpecies:: ds PARTY_LENGTH ; DC89 ; species of each Pokémon in party
wPartyEnd::     ds 1 ; DC8F ; older code doesn't check wPartyCount

wPartyMons::
wPartyMon1:: party_struct wPartyMon1 ; DC90
wPartyMon2:: party_struct wPartyMon2 ; DCC0
wPartyMon3:: party_struct wPartyMon3 ; DCF0
wPartyMon4:: party_struct wPartyMon4 ; DD20
wPartyMon5:: party_struct wPartyMon5 ; DD50
wPartyMon6:: party_struct wPartyMon6 ; DD80

wPartyMonOT:: ds NAME_LENGTH * PARTY_LENGTH ; ddff

wPartyMonNicknames:: ds MON_NAME_LENGTH * PARTY_LENGTH ; de41
wPartyMonNicknamesEnd::

	ds 16

wPokedexCaught:: flag_array NUM_POKEMON ; de99
wEndPokedexCaught::

wPokedexSeen:: flag_array NUM_POKEMON ; deb9
wEndPokedexSeen::

wUnownDex:: ds NUM_UNOWN ; ded9
wUnlockedUnowns:: ds 1 ; def3
wFirstUnownSeen:: ds 1

wDayCareMan:: ; def5
; bit 7: active
; bit 6: egg ready
; bit 5: monsters are compatible
; bit 0: monster 1 in day-care
	ds 1

wBreedMon1::
wBreedMon1Nick::  ds MON_NAME_LENGTH ; def6
wBreedMon1OT::    ds NAME_LENGTH ; df01
wBreedMon1Stats:: box_struct wBreedMon1 ; df0c

wDayCareLady:: ; df2c
; bit 7: active
; bit 0: monster 2 in day-care
	ds 1

wStepsToEgg:: ; df2d
	ds 1
wBreedMotherOrNonDitto:: ; df2e
;  z: yes
; nz: no
	ds 1

wBreedMon2::
wBreedMon2Nick::  ds MON_NAME_LENGTH ; df2f
wBreedMon2OT::    ds NAME_LENGTH ; df3a
wBreedMon2Stats:: box_struct wBreedMon2 ; df45

wEggNick:: ds MON_NAME_LENGTH ; df65
wEggOT::   ds NAME_LENGTH ; df70
wEggMon::  box_struct wEggMon ; df7b

wBugContestSecondPartySpecies:: ds 1
wContestMon:: party_struct wContestMon ; df9c

wDunsparceMapGroup:: ds 1
wDunsparceMapNumber:: ds 1
wFishingSwarmFlag:: ds 1

wRoamMon1:: roam_struct wRoamMon1 ; dfcf
wRoamMon2:: roam_struct wRoamMon2 ; dfd6
wRoamMon3:: roam_struct wRoamMon3 ; dfdd

wRoamMons_CurrentMapNumber:: ds 1
wRoamMons_CurrentMapGroup:: ds 1
wRoamMons_LastMapNumber:: ds 1
wRoamMons_LastMapGroup:: ds 1

wBestMagikarpLengthFeet:: ds 1
wBestMagikarpLengthInches:: ds 1
wMagikarpRecordHoldersName:: ds NAME_LENGTH

wPokemonDataEnd::
wGameDataEnd::
; dff5


SECTION "Pic Animations", WRAMX

wTempTileMap::
; 20x18 grid of 8x8 tiles
	ds SCREEN_WIDTH * SCREEN_HEIGHT ; $168 = 360

; PokeAnim data
wPokeAnimSceneIndex:: ds 1
wPokeAnimPointer:: ds 2
wPokeAnimSpecies:: ds 1
wPokeAnimUnownLetter:: ds 1
wPokeAnimSpeciesOrUnown:: ds 1
wPokeAnimGraphicStartTile:: ds 1
wPokeAnimCoord:: ds 2
wPokeAnimFrontpicHeight:: ds 1
; PokeAnim Data
wPokeAnimIdleFlag:: ds 1
wPokeAnimSpeed:: ds 1
wPokeAnimPointerBank:: ds 1
wPokeAnimPointerAddr:: ds 2
wPokeAnimFramesBank:: ds 1
wPokeAnimFramesAddr:: ds 2
wPokeAnimBitmaskBank:: ds 1
wPokeAnimBitmaskAddr:: ds 2
wPokeAnimFrame:: ds 1
wPokeAnimJumptableIndex:: ds 1
wPokeAnimRepeatTimer:: ds 1
wPokeAnimCurBitmask:: ds 1
wPokeAnimWaitCounter:: ds 1
wPokeAnimCommand:: ds 1
wPokeAnimParameter:: ds 1
	ds 1
wPokeAnimBitmaskCurCol:: ds 1
wPokeAnimBitmaskCurRow:: ds 1
wPokeAnimBitmaskCurBit:: ds 1
wPokeAnimBitmaskBuffer:: ds 7
	ds 2
wPokeAnimStructEnd::


SECTION "Battle Tower RAM", WRAMX

w3_d000:: ds 1 ; d000
w3_d001:: ds 1
w3_d002:: ds $7e
w3_d080:: ds 1
w3_d081:: ds $f
w3_d090:: ds $70

w3_d100::
wBT_OTTrainer:: battle_tower_struct wBT_OT
	ds $20
wBT_TrainerTextIndex:: ds 1 ; d200
	ds 1
w3_d202:: battle_tower_struct w3_d202
w3_d2e2:: battle_tower_struct w3_d2e2
w3_d3c2:: battle_tower_struct w3_d3c2
w3_d4a2:: battle_tower_struct w3_d4a2
w3_d582:: battle_tower_struct w3_d582
w3_d662:: battle_tower_struct w3_d662

UNION ; d742
w3_d742:: battle_tower_struct w3_d742
; d822

NEXTU ; d742
	ds $be
w3_d800:: ds BG_MAP_WIDTH * SCREEN_HEIGHT

NEXTU ; d742
	ds $be
wBTChoiceOfLvlGroup:: ds 1
	ds $68
w3_d869:: ds $17
w3_d880:: ds 1
w3_d881:: ds 9
w3_d88a:: ds 5
w3_d88f:: ds 5
w3_d894:: ds 1
w3_d895:: ds 11
w3_d8a0:: ds 1
w3_d8a1:: ds 1
w3_d8a2:: ds 1
w3_d8a3:: ds 1
ENDU ; d8a4

	ds $1c0

w3_dc00:: ds SCREEN_WIDTH * SCREEN_HEIGHT
w3_dd68:: ds SCREEN_WIDTH * SCREEN_HEIGHT

	ds $11c

w3_dfec:: ds $10
w3_dffc:: ds 4


SECTION "GBC Video", WRAMX

; eight 4-color palettes each
wGBCPalettes::
wBGPals1:: ds 8 palettes ; d000
wOBPals1:: ds 8 palettes ; d040
wBGPals2:: ds 8 palettes ; d080
wOBPals2:: ds 8 palettes ; d0c0

wLYOverrides:: ds SCREEN_HEIGHT_PX ; d100
wLYOverridesEnd:: ; d190

	ds 1

wMagnetTrain::
wMagnetTrainDirection:: ds 1
wMagnetTrainInitPosition:: ds 1
wMagnetTrainHoldPosition:: ds 1
wMagnetTrainFinalPosition:: ds 1
wMagnetTrainPlayerSpriteInitX:: ds 1

	ds 106

wLYOverridesBackup:: ds SCREEN_HEIGHT_PX ; d200
wLYOverridesBackupEnd::


SECTION "Battle Animations", WRAMX

wBattleAnimTileDict:: ds 10

wActiveAnimObjects:: ; d30a
wAnimObject01:: battle_anim_struct wAnimObject01
wAnimObject02:: battle_anim_struct wAnimObject02
wAnimObject03:: battle_anim_struct wAnimObject03
wAnimObject04:: battle_anim_struct wAnimObject04
wAnimObject05:: battle_anim_struct wAnimObject05
wAnimObject06:: battle_anim_struct wAnimObject06
wAnimObject07:: battle_anim_struct wAnimObject07
wAnimObject08:: battle_anim_struct wAnimObject08
wAnimObject09:: battle_anim_struct wAnimObject09
wAnimObject10:: battle_anim_struct wAnimObject10
wActiveAnimObjectsEnd:: ; d3aa

wActiveBGEffects:: ; d3fa
wBGEffect1:: battle_bg_effect wBGEffect1
wBGEffect2:: battle_bg_effect wBGEffect2
wBGEffect3:: battle_bg_effect wBGEffect3
wBGEffect4:: battle_bg_effect wBGEffect4
wBGEffect5:: battle_bg_effect wBGEffect5
wActiveBGEffectsEnd::

wNumActiveBattleAnims:: ds 1 ; d40e

wBattleAnimFlags:: ds 1 ; d40f
wBattleAnimAddress:: ds 2 ; d410
wBattleAnimDuration:: ds 1 ; d412
wBattleAnimParent:: ds 2 ; d413
wBattleAnimLoops:: ds 1 ; d415
wBattleAnimVar:: ds 1 ; d416
wBattleAnimByte:: ds 1 ; d417
wBattleAnimOAMPointerLo:: ds 1 ; d418

UNION ; d419
; unidentified
wBattleAnimTemp0:: ds 1
wBattleAnimTemp1:: ds 1
wBattleAnimTemp2:: ds 1
wBattleAnimTemp3:: ds 1

NEXTU ; d419
wBattleAnimTempOAMFlags:: ds 1
wBattleAnimTempField02:: ds 1
wBattleAnimTempTileID:: ds 1
wBattleAnimTempXCoord:: ds 1
wBattleAnimTempYCoord:: ds 1
wBattleAnimTempXOffset:: ds 1
wBattleAnimTempYOffset:: ds 1
wBattleAnimTempAddSubFlags:: ds 1
wBattleAnimTempPalette:: ds 1
ENDU ; d422

UNION ; d422
	ds $32
wBattleAnimEnd::

NEXTU ; d422
wSurfWaveBGEffect:: ds $40
wSurfWaveBGEffectEnd::
ENDU ; d462


SECTION "Mobile RAM", WRAMX

w5_d800:: ds $200
w5_da00:: ds $200
w5_dc00:: ds $d
w5_dc0d:: ds 4
w5_dc11:: ds 9
w5_MobileOpponentBattleMessages:: ds $c ; dc1a
w5_MobileOpponentBattleStartMessage:: ds $c ; dc26
w5_MobileOpponentBattleWinMessage:: ds $c ; dc32
w5_MobileOpponentBattleLossMessage:: ds $c ; dc3e


SECTION "Scratch RAM", WRAMX

UNION ; d000
wScratchTileMap:: ds BG_MAP_WIDTH * BG_MAP_HEIGHT
wScratchAttrMap:: ds BG_MAP_WIDTH * BG_MAP_HEIGHT

NEXTU ; d000
wDecompressScratch:: ds $80 tiles
wDecompressEnemyFrontpic:: ds $80 tiles
ENDU ; e000


SECTION "Stack RAM", WRAMX

wWindowStack:: ds $1000 - 1
wWindowStackBottom:: ds 1


INCLUDE "sram.asm"
