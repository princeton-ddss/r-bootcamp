#let to-string(content) = {
  if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  }
}

#let solution(body) = figure(
  block(
    width: 100%,
    inset: (top: 0.75em, bottom: 0.75em),
  )[
    #set align(left)
    #show emph: it => strong(it.body)
    #body
  ],
  kind: "solution",
  supplement: [Solution],
)

#let article(
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
  headerleft: none,
  headerright: none,
  cols: 1,
  margin: (x: 1in, y: 1in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  mathfont: "New Computer Modern Math",
  codefont: "DejaVu Sans Mono",
  title-size: 24pt,
  subtitle-size: 18pt,
  heading-family: none,
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  sectionnumbering: none,
  pagenumbering: "1",
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  linestretch: 1,
  linkcolor: "#800000",
  frontmatter-logo: none,
  frontmatter-logo-height: auto,
  doc,
) = {
  let headerleft = if headerleft == none { [] } else { headerleft }
  let headerright = if headerright == none { [] } else { headerright }

  set page(
    paper: paper,
    margin: margin,
    numbering: pagenumbering,
    header: [
      #headerleft
      #h(1fr)
      #headerright
      #v(-8pt)
      #line(length: 100%)
    ],
    header-ascent: 30%,
  )

  set par(
    justify: true,
    leading: 1.15 * 0.65em,
  )
  set text(
    lang: lang,
    region: region,
    font: font,
    size: fontsize,
  )
  show math.equation: set text(font: mathfont)
  show raw: set text(font: codefont)

  show figure.caption: it => [
    #v(-1em)
    #align(left)[
      #block(inset: 1em)[
        #text(weight: "bold")[
          #it.supplement
          #context it.counter.display(it.numbering)
        ]
        #it.separator
        #it.body
      ]
    ]
  ]

  set heading(numbering: sectionnumbering)

  set document(
    title: title,
    date: auto,
  )

  if authors != none {
    set document(
      author: authors.map(author => to-string(author.name)).join(", ", last: ", and "),
    )
  }

  show link: this => {
    if type(this.dest) != label {
      text(this, fill: rgb(linkcolor.replace("\\#", "#")))
    } else {
      text(this, fill: rgb("#0000CC"))
    }
  }

  show ref: this => {
    text(this, fill: rgb("#640872"))
  }

  if title != none {
    align(center)[
      #if frontmatter-logo != none {
        image(to-string(frontmatter-logo), height: frontmatter-logo-height)
      }
      #block(inset: 1em)[
        #set par(
          justify: false,
          leading: heading-line-height,
        )
        #if (
          heading-family != none
          or heading-weight != "bold"
          or heading-style != "normal"
          or heading-color != black
        ) {
          set text(
            font: heading-family,
            weight: heading-weight,
            style: heading-style,
            fill: heading-color,
          )
          text(size: title-size)[#title]
          if subtitle != none {
            linebreak()
            text(size: subtitle-size)[#subtitle]
          }
        } else {
          text(weight: "bold", size: title-size)[#title]
          if subtitle != none {
            linebreak()
            text(weight: "semibold", size: subtitle-size)[#subtitle]
          }
        }
      ]
    ]
  }

  if authors != none {
    for i in range(calc.ceil(authors.len() / 3)) {
      let end = calc.min((i + 1) * 3, authors.len())
      let slice = authors.slice(i * 3, end)
      grid(
        columns: slice.len() * (1fr,),
        gutter: 12pt,
        ..slice.map(author => align(center, {
          if "url" in author {
            link(author.url)[#text(weight: "bold")[#author.name]]
          } else {
            text(weight: "bold")[#author.name]
          }
          set text(size: 0.8em)
          if "department" in author and author.department != none {
            linebreak()
            author.department
          }
          if "university" in author and author.university != none {
            linebreak()
            author.university
          }
          if "location" in author and author.location != [] {
            linebreak()
            author.location
          }
          if "email" in author {
            linebreak()
            link("mailto:" + to-string(author.email))[#to-string(author.email)]
          }
        }))
      )
      v(20pt, weak: true)
    }
  }

  if date != none {
    align(center)[
      #block(inset: 1em)[#date]
    ]
  }

  if abstract != none {
    block(inset: 2em)[
      #text(weight: "semibold")[#abstract-title]
      #h(1em)
      #abstract
    ]
  }

  if title != none or authors != none or date != none {
    align(center)[
      #line(length: 80%)
    ]
  }

  if toc {
    let title = if toc_title == none { auto } else { toc_title }
    block(above: 0em, below: 2em)[
      #outline(
        title: title,
        depth: toc_depth,
        indent: toc_indent,
      )
    ]
  }

  set par(
    justify: true,
    first-line-indent: 1em,
    leading: linestretch * 0.65em,
  )

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none,
)
