\version "2.20.0"

\include "articulate.ly"

\header {
  title = "Pretender"
  author = "Official髭男dism"
  subtitle = \markup {
    \override #'(font-name . "IPAexGothic")
    \fromproperty #'header:author
  }
  pdfcomposer = "藤原聡"
  pdfpoet = \markup \fromproperty #'header:pdfcomposer
  composer = \markup {
    \override #'(font-name . "IPAexGothic")
    \concat { "作曲・作詞　" \fromproperty #'header:pdfcomposer }
  }
  subject = \markup \concat {
    "Bass partition for “"
    \fromproperty #'header:title
    "” by "
    \fromproperty #'header:pdfcomposer
    "."
  }
  keywords = #(string-join '(
    "music"
    "partition"
    "bass"
  ) ", ")
  tagline = ##f
}

\paper {
  indent = 0\mm
  markup-system-spacing.padding = 3
  system-system-spacing.padding = 3
  #(define fonts
    (set-global-fonts
     #:music "gonville"
     #:brace "gonville"
   ))
}

section = #(define-music-function (text) (string?) #{
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT
  \once \override Score.RehearsalMark.padding = #2
  \mark \markup \override #'(thickness . 2) \rounded-box \bold #text
#})

gl = \glissando

% From https://lilypond.1069038.n5.nabble.com/Hammer-on-and-pull-off-td208307.html
after =
#(define-music-function (t e m) (ly:duration? ly:music? ly:music?)
   #{
     \context Bottom <<
       #m
       { \skip $t <> -\tweak extra-spacing-width #empty-interval $e }
     >>
   #})

sectionBSubB = {
  r4 r16 aes-2 des8-3 c-1 r e, f |
}

sectionBSubA = {
  r4. \once \stemDown f8\gl ees'\3 r aes, des |
  \sectionBSubB |
}

sectionB = {
  des,8[ r r des] c[ r e, f] |
  \sectionBSubA |
  r8 f'\3 e\3 ees\3 r d4\3 des8 |
  \sectionBSubB |
  \sectionBSubA |
  r8 f8 f\gl d'\3~ 2 |
  \repeat unfold 7 bes8 bes\gl |
  \repeat unfold 8 ees\3 |
}

sectionCSubA = {
  \repeat unfold 8 aes,8 |
  g8 g g f e e e e |
  \repeat unfold 7 f f\gl |
  \repeat unfold 4 ees'\3 \repeat unfold 4 aes, |
}

sectionCSubB = {
  \repeat unfold 8 des8 |
  \repeat unfold 8 c |
  \repeat unfold 7 bes bes\gl |
  \repeat unfold 8 ees\3 |
}

sectionC = {
  \repeat unfold 2 {
    \sectionCSubA
    \sectionCSubB
    \break
  }
  aes,1~ |
  aes |
}

hammer = \markup{ \sans "H" }

sectionD = {
  aes8-. aes-. r16 aes r aes r2 |
  g8-. g-. r16 f8\gl c'16 r2 |
  f,8-. f-. r16 f r f r2 |
  bes8-. bes-. r8. bes16 r bes r8 bes f\gl |
  \break
  bes-.\4 bes-.\4 r16 bes r bes\4 r4. f'8\3 |
  ees-.\3 ees-.\3 r16 ees\3 r ees\3 r4 \override TextScript.extra-offset = #'(0 . -1.4) \after 32 ^\hammer ees16\3( f\3) aes\2 f\3 |
  aes8-.\2 aes-.\2 r16 aes\2 r aes\2 r4 \after 32 ^\hammer ees16\3( f\3) aes\2 f\3 |
  aes8-.\2 aes-.\2 r8. aes16\2 r aes\2 r8 r4 |
}

sectionE = {
  \repeat unfold 16 des8 |
  \repeat unfold 7 c c\gl |
  \break
  \repeat unfold 7 f\3 f\3\gl |
  \repeat unfold 15 bes, bes\gl |
  \break
  \repeat unfold 14 ees\3 r4 |
  \repeat unfold 8 des8 |
  \break

  \repeat unfold 8 c |
  \repeat unfold 4 bes c c c c\gl |
  \repeat unfold 4 f\3 \repeat unfold 4 ees\3 |
}

sectionF = {
  \repeat unfold 8 des8 |
  \repeat unfold 8 c |
  \repeat unfold 7 bes bes\gl |
  ees1\3~ |
  ees\3 |
}

song = \relative c, {
  \numericTimeSignature
  \override MultiMeasureRest.expand-limit = 3

  % Intro 1
  \tag #'(score video) \compressMMRests R1*4 |

  \section "Intro 2"
  \repeat volta 2 {
    \repeat unfold 8 aes8 |
    \repeat unfold 4 g \repeat unfold 4 c |
    \repeat unfold 8 f, |
    \repeat unfold 5 bes8 bes\gl ees\3 ees\3 |
  }
  \break
  \section "A"
  aes,1 |
  \tag #'(score midi) \compressMMRests R1*5 |
  \tag #'video R1*5 |
  \break
  \section "Aʹ"
  aes1 |
  g2 c4. e8 |
  f2.~ 8 8\gl bes1\2 |
  \break
  bes,2.\4~ bes8\3 f'\3 |
  ees1\3 |
  aes,2.\4 \override TextScript.extra-offset = #'(0 . -1.35) \after 32 ^\hammer ees'16\3( f\3)  aes\2 f\3 |
  aes1\2 |
  \break
  % Segno 1
  \section "B"
  \sectionB
  \break
  % Segno 2
  \section "C"
  \sectionC
  \break
  \section "D"
  \sectionD
  \break

  % 1st D.S.
  % To B
  \section "B (Repeat)"
  \sectionB
  \break

  % Repeat the first 8 measures for section C
  \section "C (Repeat)"
  \sectionCSubA
  \sectionCSubB
  \break

  \section "E"
  \sectionE
  \break

  % 2nd D.S.
  % Repeat section C except for the last note
  \section "C (Repeat 2)"
  \repeat unfold 2 {
    \sectionCSubA
    \sectionCSubB
    \break
  }

  \section "F"
  \sectionF
  \section "End"
  \compressMMRests R1*9 \bar "|."
}

staff = \new Staff \with {
  midiInstrument = #"electric bass (finger)"
  \omit StringNumber
  % Don't show markup in this staff
  \omit TextScript
} {
  \clef "bass_8"
  \once \override Score.MetronomeMark.extra-offset = #'(-3 . 0)
  \tempo 4 = 92
  \key aes \major
  \time 4/4
  \song
}
staves = \new StaffGroup \with {
  \override Glissando.breakable = ##t
  \override Glissando.after-line-breaking = ##t
} <<
  \staff
  \new TabStaff \with {
    stringTunings = #bass-tuning
    % To display the hammer-on and pull-of markup
    \revert TextScript.stencil
    \override TextScript.font-size = #-3
    \slurUp
  } {
    \clef moderntab
    \song
  }
>>
