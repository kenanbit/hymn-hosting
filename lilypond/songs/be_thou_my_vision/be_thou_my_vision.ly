\version "2.20.0"
#(ly:set-option 'relative-includes #t)
\language "english"
\include "../../lib/clairnote.ly"
\include "../../lib/hymn_common.ly"
%\include "color_by_pitch.ly"

%% See docs/all_tags.txt for the full list available
tags = "theist 4part acapella 5verse musicbyother textbyother"
\header {
  title = \titleText "Be thou my vision"
  %subtitle = \smallText "Optional"
  composer = \smallText "Music: Irish melody, 1909"
  arranger = \smallText "Arranged by Martin Shaw, 1931"
  poet = \smallText "Text: Ancient Irish, tr. Mary Elizabeth Byrne, 1905"
  meter = \smallText "SLANE 10.10.9.10"
  copyright = \public_domain_notice "Kenan Schaefkofer"
  tagline = \tagline
}

%% SETTINGS
hymnKey = \key ef \major
hymnTime = \time 3/4
%% Adjust these to fix beaming
%hymnBaseMoment = \set Timing.baseMoment = #(ly:make-moment 1/4)
%hymnBeatStructure = \set Timing.beatStructure = 1,1,1,1
%hymnBeatExceptions = \set Timing.beamExceptions = #'()
globalParts = {
  \hymnKey
  \hymnTime
  \hymnBaseMoment
  \hymnBeatStructure
  \hymnBeamExceptions
}

%% NOTES
soprano = {
  \globalParts
  \relative g' { ef4 ef f8( ef) | c4 bf bf8( c) | ef4 ef f | g2. | } \break
  \relative g' { f4 4 4 | f g bf | c bf g | bf2. | } \break
  \relative g' { c4 8( d) ef( d) | c4( bf) g | bf4 ef, d | c2( bf4) | } \break
  \relative g' { ef4 g bf | c8( bf) g4 ef8( g) | f4 ef ef | ef2. | }\break
  \bar "|."
}
alto = {
  \globalParts
  \relative e' { bf4 4 c | c bf bf8 c8 | g4 c d | ef2. | }
  \relative e' { d4 d c | d ef f | ef f g | f2. |}
  \relative e' { af4 4 4 | af4( g) ef | bf g g | af2( bf4) | }
  \relative e' { bf4 ef f | g ef ef | c c af | bf2. | }
}
tenor = {
  \globalParts
  \relative a { g4 g af | g g f | g g bf | bf2. | }
  \relative a { bf4 bf af | bf bf bf | g bf4. c8 | d2. | }
  \relative a { ef'4 8 d c d | ef2 bf4 | ef,4 4 4 | 2( bf'4) | }
  \relative a { g4 c d | ef4 bf g8 ef | af4 4 4 | g2. | }
}
bass = {
  \globalParts
  \relative d { ef4 4 af, | ef'4 4 d | c4 c bf | ef2. |}
  \relative d { bf4 4 f' | bf, ef d | c d ef | bf2. |}
  \relative d { af'4 4 4 | ef2 4 | g,4 c bf | af2( bf4) | }
  \relative d { ef4 c bf | g g c | af af c | ef2. }
}
songChords = \chords {
  \set chordChanges = ##t
}

%% LYRICS
verseA = \lyricmode {
  Be thou my vi -- sion, O Lord of my heart;
  naught be all else to me save that thou art.
  Thou my best thought, by day or by night,
  wak -- ing or sleep -- ing thy pres -- ence my light.
}
verseB = \lyricmode {
  Be thou my wis -- dom, be thou my true word;
  I ev -- er with thee, and thou with me, Lord.
  Thou my great Ma-ker, thy child may I be,
  thou in me dwell -- ing, and I one with thee.
}
verseC = \lyricmode {
  Be thou my buck -- ler, my sword for the fight.
  Be thou my dig -- ni -- ty, thou my de -- light,
  thou my soul's shel -- ter, thou my high tower.
  Raise thou me heav'n -- ward, O Pow'r of my pow'r.
}
verseD = \lyricmode {
  Rich -- es I heed not, nor vain, emp -- ty praise;
  thou mine in -- her -- i -- tance, now and al -- ways.
  Thou and thou on -- ly, first in my heart,
  high King of heav -- en, my trea -- sure thou art.
}
verseE = \lyricmode {
  High King of heav -- en, when vic -- t'ry is won
  may I reach heav -- en's joys, O bright heav'n's Sun!
  Heart of my heart, what -- ev -- er be -- fall,
  still be my vi -- sion, O Rul -- er of all.
}

all_verses = <<
  \new NullVoice = "soprano" \soprano
  % Add what you need. If more than 4, fill in the second argument as shown in 5 and 6
  \new Lyrics  \lyricsto soprano  { \globalLyrics "1" "1" \verseA }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "2" "2" \verseB }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "3" "3" \verseC }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "4" "4" \verseD }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "5" "5" \verseE }
>>

%% If fillScore needs to be modified (usually for non-SATB standard songs), copy it here from hymn_common
%% The default fillscore combines the first two arguments into an upper staff and the last two arguments into 
%% a lower staff.

%% Traditional notation
\book { \bookOutputSuffix "trad" \score { \fillTradScore \soprano \alto \tenor \bass \songChords } }

%% Traditional with shaped noteheads (broken on non-combined chords)
\book { \bookOutputSuffix "shapenote" \score { \fillTradScore {\aikenHeads \soprano} {\aikenHeads \alto} {\aikenHeads \tenor} {\aikenHeads \bass} \songChords } }

%% Clairnotes Notation
\book { \bookOutputSuffix "clairnote" \score { 
  \layout {
    #(layout-set-staff-size 18)
  } \fillClairScore \soprano \alto \tenor \bass
}}

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