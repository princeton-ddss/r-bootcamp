#let projector-theme(api, doc) = {
  set page(
    foreground: context place(
      bottom + right,
      dx: -1.8em,
      dy: -0.85em,
      block(
        width: 4em,
        height: 1em,
        fill: white,
        align(right + horizon)[
          #text(size: 0.6em, fill: gray)[#(api.slide-number)()]
        ],
      ),
    ),
  )
  doc
}

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

#let toc-slide(api, toc_title) = {
  (api.slide)[
    #let title = if toc_title == none { "Outline" } else { toc_title }
    #heading(outlined: false, title)
    #set text(size: 1.5em)
    #align(horizon)[
      #(api.toolbox.all-sections)((sections, current) => {
        sections
          .map(s => if s == current { emph(s) } else { s })
          .join([ #linebreak() ])
      })
    ]
  ]
}
