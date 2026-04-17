// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find
// documentation on creating typst templates and some examples here:
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#let article(
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  margin: (left: 2cm, right: 2cm, top: 1.5cm, bottom: 2cm),
  paper: "a4",
  lang: "en",
  region: "AU",
  font: "libertinus serif",
  fontsize: 11pt,
  linestretch: 1.3,
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: "Fira Sans",
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  heading-size: 0.85em,
  branding: false,
  sectionnumbering: none,
  pagenumbering: "1",
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  // Define authornames string from authors list
  let authornames = if authors != none {
    authors.map(author => author.name.replace("~", sym.space.nobreak)).join(", ")
  } else {
    ""
  }

  // Set PDF metadata
  set document(
    title: title,
    author: authornames,
    date: if date != none { auto } else { none },
  )
  set page(
    paper: paper,
    margin: margin,
    numbering: pagenumbering,
    header: context{
      if counter(page).get().first() > 1 and title != none {
        grid(
          columns: (1fr, auto),
          align: (left, right),
          [#text(font: heading-family, size: 10pt)[#title]],
          [#text(font: heading-family, size: 10pt)[#counter(page).display()]],
        )
        v(-6pt)
        line(length: 100%, stroke: 0.5pt)
        v(6pt) // Add some space below the line
      }
    },
    footer: context{
      if counter(page).get().first() == 1 {
        align(center)[#counter(page).display()]
      }
    },
  )
  set par(justify: true, leading: linestretch * 0.7em)
  set text(lang: lang, region: region, font: font, size: fontsize)
  set heading(numbering: sectionnumbering)
  show heading: set text(
    font: heading-family,
    size: heading-size,
    weight: heading-weight,
    style: heading-style,
    fill: heading-color,
  )
  show heading.where(level: 1): set block(above: 20pt, below: 12pt)
  show outline: set text(font: heading-family, size: 0.85em)

  // Indented lists
  show list: set block(above: 1.2em, below: 1.2em)
  show enum: set block(above: 1.2em, below: 1.2em)
  show list: set list(indent: 1em)
  show enum: set enum(indent: 1em)

  // Make all links blue
  show link: set text(fill: rgb(0, 0, 255))
  // Math font
  show math.equation: set text(font: "Libertinus math")
  // Figure and table captions in italics
  show figure.caption: set text(style: "italic")
  // Optional branding logo at top
  if branding {
    // Bottom right logos on first page only
    v(-1cm)
  } else {
    v(-1cm)
  }

  if title != none {
    context {
      let inner = {
        align(left)[
          #text(
            font: heading-family,
            size: title-size,
            weight: heading-weight,
            fill: if branding { white } else { black },
          )[#title]
          #if subtitle != none {
            v(4pt)
            text(
              font: heading-family,
              size: subtitle-size,
              weight: "normal",
              fill: if branding { white } else { black },
            )[#subtitle]
          }
        ]

        grid(columns: (0.6fr, 0.4fr), rows: auto, align: (left, right), [
          #if authornames != "" {
            set par(justify: false)
            text(
              font: heading-family,
              size: 12pt,
              fill: if branding { white } else { black },
            )[#authornames]
          }
        ], [
          #if date != none {
            text(
              font: heading-family,
              size: 10pt,
              fill: if branding { white } else { black },
            )[#date]
          }
        ])
      }
      if branding {
        let content = block(width: 100%, inset: 6pt, fill: rgb(0, 28, 61, 60%))[ #inner ]

        let m = measure(content, width: page.width)

        block(width: 100%, height: m.height, clip: true)[
          #place(top + left)[
            #image("bg-wide.jpg", width: 100%, height: auto, fit: "cover")
          ]

          #place(top + left)[ #content ]
        ]
      } else {
        rect(
          fill: gray.lighten(50%),
          //stroke: gray,
          width: 100%,
          inset: 6pt,
          radius: 2pt,
        )[#inner]
      }
    }
    v(10pt)
  }
  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
      #outline(title: toc_title, depth: toc_depth, indent: toc_indent);
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
