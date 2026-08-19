#let title-slide(api, title, subtitle, authors, date) = {
  (api.slide)[
    #place(
      bottom + left,
      float: true,
      image("DDSS-stacked_PU_shield_black.png", width: 1.45in),
    )

    #align(center)[
      #if title != none {
        text(weight: "bold", size: 3em, title)
      }

      #if subtitle != none {
        v(0.8em)
        text(size: 2em, weight: "semibold", subtitle)
      }

      #if authors != none and authors != [] {
        v(2.2em)
        set text(size: 1.25em)

        let count = authors.len()
        let ncols = calc.min(count, 3)
        grid(
          columns: (1fr,) * ncols,
          row-gutter: 1.5em,
          ..authors.map(author => align(center)[
            #author.name
            #linebreak()
            #author.affiliation
          ]),
        )
      }

      #if date != none {
        v(1.2em)
        text(size: 1.25em, date)
      }
    ]
  ]
}
