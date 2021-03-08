\version "2.20.0"
#(ly:set-option 'relative-includes #t)
\include "../../lib/hymn_common.ly"

%% TUNE INFO
composer = \smallText "Music: François H. Barthélémon,  1833"
meter = \smallText "BALERMA CM"
hymnKey = \key af \major
hymnTime = \time 6/4
\include "../../lib/global_parts.ly"

%% SONG INFO
title = \titleText "Help us to help each other, Lord"
poet = \smallText "Text: Charles Wesley, 1742"
copyright = \public_domain_notice "Kenan Schaefkofer"
tags = "christian 4part acapella 4verse musicbyother textbyother"
\include "../../lib/header.ly"

%% NOTES
soprano = {
  \globalParts
  \relative g' { \partial 4 af4 | c2 bf4 af2 f4 | ef2  f4 af2 bf4 | c2 bf4 c( ef) c | bf2.~ \partial 2 bf2 \bar " " |} \break
  \relative g' { \partial 4 bf4 | c2 bf4 af2 f4 | ef2 c4 ef2 bf'4 | c( ef) c bf4.( af8) bf4 | af2.~ \partial 2 2 |} \break
  \bar "|."
}
alto = {
  \globalParts
  \relative e' { ef4 | 2 df4 c2 df4 | c2 df4 c2 ef4 | 2 4 2 4 | 2.~ 2 |}
  \relative e' { ef4 | 2 df4 c2 df4 | c2 af4 bf2 ef4 | 2 4 df4.( c8) df4 | c2.~ 2 |}
}
tenor = {
  \globalParts
  \relative a { c4 | af2 g4 af2 4 | 2 4 2 g4 | af2 g4 af( c) af | g2.~ 2 |}
  \relative a { g4 af2 g4 af2 4 | 2 4 g2 4 | af( c) af g4.( af8) g4 | af2.~ 2 |}
}
bass = {
  \globalParts
  \relative d { af4 | 2 ef'4 f2 df4 | af2 4 2 ef'4 | af2 ef4 af2 af,8. c16 | ef2.~ 2 |}
  \relative d { ef4 | af2 ef4 f2 df4 | af2 f'4 ef2 4 | af2 af,8. c16 ef2 4 | af2.~ 2 |}
}

%% LYRICS
verseA = \lyricmode {
  Help us to help each oth -- er, Lord,
  each oth -- er's cross to bear,
  let each his friend -- ly aid af -- ford,
  and feel a -- noth -- er's care.
}
verseB = \lyricmode {
  Up in -- to thee, our liv -- ing head,
  let us in all things grow,
  and by thy sac -- ri -- fice be led
  the fruits of love to show.
}
verseC = \lyricmode {
    Touched by the lode -- stone of thy love
    let all our hearts a -- gree;
    and ev -- er toward each oth -- er move,
    and ev -- er move toward thee.
}
verseD = \lyricmode {
  This is the bond of per -- fect -- ness,
  thy spot -- less char -- i -- ty.
  O let us still, we pray, pos -- sess
  the mind that was in thee.
}

all_verses = <<
  \new NullVoice = "soprano" \soprano
  % Add what you need. If more than 4, fill in the second argument as shown in 5 and 6
  \new Lyrics  \lyricsto soprano  { \globalLyrics "1" "" \verseA }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "2" "" \verseB }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "3" "" \verseC }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "4" "" \verseD }
>>

%% Traditional notation
\book { \bookOutputSuffix "trad" \score { \fillTradScore \soprano \alto \tenor \bass \songChords } }

%% Traditional with shaped noteheads (broken on non-combined chords)
\book { \bookOutputSuffix "shapenote" \score { \fillTradScore {\aikenHeads \soprano} {\aikenHeads \alto} {\aikenHeads \tenor} {\aikenHeads \bass} \songChords } }

%% Clairnotes Notation
\book { \bookOutputSuffix "clairnote" \score { \fillClairScore \soprano \alto \tenor \bass } }

%% MIDI output
\score {
  <<
    \new Staff \with { midiMaximumVolume = #0.9 } \soprano
    \new Staff \with { midiMaximumVolume = #0.7  } \alto
    \new Staff \with { midiMaximumVolume = #0.8  } \tenor
    \new Staff \with { midiMaximumVolume = #0.9 } \bass
  >>
  \midi {
    \context { \Staff \remove "Staff_performer" }
    \context { \Voice \consists "Staff_performer" }
    \tempo  4 = 120
  }
}
