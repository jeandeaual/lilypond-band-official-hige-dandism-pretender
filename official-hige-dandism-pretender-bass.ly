\version "2.20.0"

\include "official-hige-dandism-pretender-bass.ily"

\score {
  \keepWithTag #'score \staves
}

\score {
  \unfoldRepeats \articulate \keepWithTag #'midi \staff
  \midi {}
}
