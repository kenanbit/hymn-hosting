\version "2.20.0"
#(ly:set-option 'relative-includes #t)
\include "../../lib/hymn_common.ly"


%% See docs/all_tags.txt for the full list available
tags = "christian 4part acapella 4verse musicbyother textbyother evening"
\header {
  title = \titleText "The day you gave us, Lord"
  %subtitle = \smallText "Optional"
  composer = \smallText "Music: Clement C. Scholefield, 1874"
  %arranger = \smallText "Arranged by (optional), year"
  poet = \smallText "Text: John Ellerton, 1870"
  meter = \smallText "ST. CLEMENT 98.98"
  copyright = \public_domain_notice "Kenan Schaefkofer"
  tagline = \tagline
}

%% SETTINGS
hymnKey = \key g \major
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
  \numericTimeSignature
}

%% NOTES
soprano = {
  \globalParts
  \relative g' { \partial 4 d4 | b'( c) b | d4( b) a | g( a) e | g fs \bar "" } \break
  \relative g' { \partial 4 e4 | d2 4 | g( a) b | a2 g4 | fs2 \bar "" } \break
  \relative g' { \partial 4 d4 | b'( c) b | d4( b) a | g( a) e | g fs \bar "" } \break
  \relative g' { \partial 4 e4 | d( e) fs | g( b) a | e( g) fs | g2 \bar "|." }
}
alto = {
  \globalParts
  \relative e' { d4 | 2 g4 | fs2 4 | g( e) e | c c }
  \relative e' { c | c( b) d | e2 d4 | cs2 4 | d2 }
  \relative e' { d4 | 2 g4 | fs2 4 | g( e) e | c c }
  \relative e' { a,4 | d2 c4 | b4( d) e | e2 d4 | d2 }
}
tenor = {
  \globalParts
  \relative a { d,4 | g2 g4 | a( d) c | b( c) a | a a }
  \relative a { g4 | a( g) a | b2 g4 | e2 a4 | a2 }
  \relative a { a4 | g2 g4 | a( d) c | b( c) a | a a }
  \relative a { a4 | g2 a4 | g2 c4 | c2 4 | b2 }
}
bass = {
  \globalParts
  \relative d { d4 | g,2 g'4 | d2 4 | e4( a,) c | d d }
  \relative d { e4 | fs4( g) fs | e2 4 | a,2 4 | d2 }
  \relative d { fs4 | g2 g4 | d2 4 | e4( a,) c | d d }
  \relative d { c4 | b2 d4 | e( b) c | a2 d4 | g,2 }
}
songChords = \chords {
  \set chordChanges = ##t
}

%% LYRICS
verseA = \lyricmode {
  The day you gave us, Lord, is end -- ed;
  the dark -- ness falls at your re -- quest.
  To you our morn -- ing hymns as -- cend -- ed;
  your praise shall sanc -- ti -- fy our rest.
}
verseB = \lyricmode {
  We thank you that your church, un -- sleep -- ing
  while earth rolls on -- ward in -- to light,
  through all the world its watch is keep -- ing,
  and nev -- er rests by day or night.
}
verseC = \lyricmode {
  As o -- ver con -- ti -- nent and is -- land
  each dawn leads on an -- oth -- er day,
  the voice of prayer is nev -- er si -- lent,
  nor do the prais -- es die a -- way.
}
verseD = \lyricmode {
  So be it, Lord, your throne shall nev -- er,
  like earth's proud king -- doms pass a -- way.
  Your kind -- dom stands and grows for -- ev -- er,
  un -- til there dawns your glo -- rious day.
}
verseE = \lyricmode { }
verseF = \lyricmode { }

all_verses = <<
  \new NullVoice = "soprano" \soprano
  % Add what you need. If more than 4, fill in the second argument as shown in 5 and 6
  \new Lyrics  \lyricsto soprano  { \globalLyrics "1" "" \verseA }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "2" "" \verseB }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "3" "" \verseC }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "4" "" \verseD }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "5" "5" \verseE }
  \new Lyrics  \lyricsto soprano  { \globalLyrics "6" "6" \verseF }
>>

%% If fillScore needs to be modified (usually for non-SATB standard songs), copy it here from hymn_common
%% The default fillscore combines the first two arguments into an upper staff and the last two arguments into
%% a lower staff.

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
    \tempo  4 = 110
  }
}
