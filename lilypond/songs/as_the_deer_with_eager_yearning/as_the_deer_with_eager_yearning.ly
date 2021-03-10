\version "2.20.0"
#(ly:set-option 'relative-includes #t)
\include "../../lib/hymn_common.ly"

%% TUNE INFO
%% If you have a shared tune file, use this form:
\include "../../shared_tunes/geneva_42.ly"

%% SONG INFO
title = \titleText "As the deer with eager yearning"
poet = \smallText "Text: Based on Psalm 42, Christine T. Curtis, 1939, alt."
copyright = \public_domain_notice "Kenan Schaefkofer"
%prescore_text = \prescoreText "Uncomment to add text up and left of the score"
%postscore_text = \postscoreText "Uncomment to add text down and left of the score"
tags = "theist 4part acapella 2verse musicbyother textbyother"
dateAdded = "2021-03-09"
\include "../../lib/header.ly"

%% LYRICS
verseA = \lyricmode {
  As the deer with ea -- ger yearn -- ing
  seeks the cool -- ing wa -- ter -- course,
  so my soul with ar -- dor burn -- ing
  longs for God, its heav'n -- ly source.
  When shall I be -- hold God's face?
  When shall I re -- ceive God's grace?
  Whal shall I, God's prais -- es voic -- ing,
  come be -- fore our God re -- joic -- ing?
}
verseB = \lyricmode {
  Day and night in grief and an -- guish
  bit -- ter tears have been my meat,
  while my long -- ing soul may lan -- guish
  to par -- take of man -- na sweet.
  O my soul, be not dis -- mayed.
  Trust in God, who is our aid.
  Hope and joy God's love pro -- vides you,
  'tis God's hand a -- lone that guides you.
}

all_verses = <<
  \new NullVoice = "soprano" \soprano
  % Add what you need. If more than 4, fill in the second argument as shown in 5 and 6
  \new Lyrics  \lyricsto soprano  { \globalLyrics "1" "" \verseA }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "2" "" \verseB }
>>

%% Traditional notation
\book { \bookOutputSuffix "trad" \score { \fillTradScore \soprano \alto \tenor \bass \songChords } \postscore_text }

%% Traditional with shaped noteheads (broken on non-combined chords)
\book { \bookOutputSuffix "shapenote" \score { \fillTradScore {\aikenHeads \soprano} {\aikenHeads \alto} {\aikenHeads \tenor} {\aikenHeads \bass} \songChords } \postscore_text }

%% Clairnotes Notation
\book { \bookOutputSuffix "clairnote" \score { \fillClairScore \soprano \alto \tenor \bass } \postscore_text }

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
    \tempo  4 = 170
  }
}