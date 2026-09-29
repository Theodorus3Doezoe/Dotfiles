// =============================================================================
// GLOBAL TYPST SCHOOL / ACADEMIC TEMPLATE
// Author: Sven Dinkla
// Language: English (default)
// =============================================================================

// Internal states for versioning and review mode
#let __template_version = state("__template_version", "1.0")
#let __template_review = state("__template_review", false)
#let __template_highlight_versions = state("__template_highlight_versions", ("1.0",))

// Helper for formatted date display
#let format-date(d) = {
  let months = (
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  )
  if type(d) == datetime {
    let day = str(d.day())
    let month = months.at(d.month() - 1)
    let year = str(d.year())
    [#month #day, #year]
  } else if d == auto {
    let today = datetime.today()
    let day = str(today.day())
    let month = months.at(today.month() - 1)
    let year = str(today.year())
    [#month #day, #year]
  } else if d == none {
    none
  } else {
    d
  }
}

// Helper to normalize authors
#let normalize-authors(authors, student-number: none) = {
  if type(authors) == str {
    ((name: authors, student-number: student-number, email: none),)
  } else if type(authors) == dictionary {
    ((
      name: authors.at("name", default: "Sven Dinkla"),
      student-number: authors.at("student-number", default: authors.at("student-id", default: authors.at("studentnummer", default: student-number))),
      email: authors.at("email", default: none),
    ),)
  } else if type(authors) == array {
    authors.map(a => {
      if type(a) == str {
        (name: a, student-number: student-number, email: none)
      } else if type(a) == dictionary {
        (
          name: a.at("name", default: "Sven Dinkla"),
          student-number: a.at("student-number", default: a.at("student-id", default: a.at("studentnummer", default: none))),
          email: a.at("email", default: none),
        )
      } else {
        (name: str(a), student-number: student-number, email: none)
      }
    })
  } else {
    ((name: "Sven Dinkla", student-number: student-number, email: none),)
  }
}

// =============================================================================
// VERSIONING & CHANGE TRACKING HELPERS
// =============================================================================

#let parse-change-args(args, default-block: false) = {
  let named = args.named()
  let pos = args.pos()
  let is-block = named.at("block", default: default-block)

  if pos.len() == 1 {
    (version: auto, body: pos.at(0), block: is-block)
  } else if pos.len() >= 2 {
    (version: str(pos.at(0)), body: pos.at(1), block: is-block)
  } else {
    (version: auto, body: [], block: is-block)
  }
}

// Added content (#add[text] or #add("1.1")[text])
#let add(..args) = context {
  let parsed = parse-change-args(args)
  let is-review = __template_review.get()
  let current-doc-ver = __template_version.get()
  let active-versions = __template_highlight_versions.get()

  let target-ver = if parsed.version == auto { current-doc-ver } else { parsed.version }
  let is-active = is-review and active-versions.contains(target-ver)

  if not is-active {
    parsed.body
  } else {
    if parsed.block {
      block(
        width: 100%,
        stroke: (left: 3.5pt + rgb("#16a34a")),
        fill: rgb("#f0fdf4"),
        radius: (right: 4pt),
        inset: (x: 10pt, y: 8pt),
        spacing: 1.2em,
        [
          #text(size: 8pt, weight: "bold", fill: rgb("#15803d"))[+ v#target-ver]
          #v(2pt)
          #parsed.body
        ]
      )
    } else {
      highlight(fill: rgb("#dcfce7"), radius: 2.5pt)[#parsed.body]
    }
  }
}

// Changed content (#chg[text] or #chg("1.1")[text])
#let chg(..args) = context {
  let parsed = parse-change-args(args)
  let is-review = __template_review.get()
  let current-doc-ver = __template_version.get()
  let active-versions = __template_highlight_versions.get()

  let target-ver = if parsed.version == auto { current-doc-ver } else { parsed.version }
  let is-active = is-review and active-versions.contains(target-ver)

  if not is-active {
    parsed.body
  } else {
    if parsed.block {
      block(
        width: 100%,
        stroke: (left: 3.5pt + rgb("#d97706")),
        fill: rgb("#fffbeb"),
        radius: (right: 4pt),
        inset: (x: 10pt, y: 8pt),
        spacing: 1.2em,
        [
          #text(size: 8pt, weight: "bold", fill: rgb("#b45309"))[Δ v#target-ver]
          #v(2pt)
          #parsed.body
        ]
      )
    } else {
      highlight(fill: rgb("#fef3c7"), radius: 2.5pt)[#parsed.body]
    }
  }
}

// Deleted content (#del[text] or #del("1.1")[text])
#let del(..args) = context {
  let parsed = parse-change-args(args)
  let is-review = __template_review.get()
  let current-doc-ver = __template_version.get()
  let active-versions = __template_highlight_versions.get()

  let target-ver = if parsed.version == auto { current-doc-ver } else { parsed.version }
  let is-active = is-review and active-versions.contains(target-ver)

  if not is-active {
    none
  } else {
    if parsed.block {
      block(
        width: 100%,
        stroke: (left: 3.5pt + rgb("#dc2626")),
        fill: rgb("#fef2f2"),
        radius: (right: 4pt),
        inset: (x: 10pt, y: 8pt),
        spacing: 1.2em,
        [
          #text(size: 8pt, weight: "bold", fill: rgb("#b91c1c"))[- v#target-ver]
          #v(2pt)
          #strike[#parsed.body]
        ]
      )
    } else {
      highlight(fill: rgb("#fee2e2"), radius: 2.5pt)[#strike[#parsed.body]]
    }
  }
}

// Block shortcuts
#let add-block(..args) = add(..args, block: true)
#let chg-block(..args) = chg(..args, block: true)
#let del-block(..args) = del(..args, block: true)

// Semantic aliases
#let added = add
#let changed = chg
#let deleted = del

// =============================================================================
// CALLOUT BOXES
// =============================================================================
#let callout(title: none, type: "info", body) = {
  let colors = (
    info: (border: rgb("#2563eb"), bg: rgb("#eff6ff"), text: rgb("#1e40af")),
    tip: (border: rgb("#059669"), bg: rgb("#f0fdf4"), text: rgb("#065f46")),
    warning: (border: rgb("#d97706"), bg: rgb("#fffbeb"), text: rgb("#92400e")),
    danger: (border: rgb("#dc2626"), bg: rgb("#fef2f2"), text: rgb("#991b1b")),
    note: (border: rgb("#64748b"), bg: rgb("#f8fafc"), text: rgb("#334155")),
  )
  let c = colors.at(type, default: colors.info)

  block(
    width: 100%,
    stroke: (left: 3.5pt + c.border),
    fill: c.bg,
    radius: (right: 4pt),
    inset: (x: 12pt, y: 10pt),
    spacing: 1.2em,
    [
      #if title != none [
        #text(weight: "bold", fill: c.text, size: 10pt)[#title]
        #v(3pt)
      ]
      #text(fill: rgb("#1f2937"), size: 10pt)[#body]
    ]
  )
}

#let info(body, title: [Information]) = callout(title: title, type: "info", body)
#let tip(body, title: [Tip]) = callout(title: title, type: "tip", body)
#let warning(body, title: [Warning]) = callout(title: title, type: "warning", body)
#let note(body, title: [Note]) = callout(title: title, type: "note", body)
#let waarschuwing = warning
#let opmerking = note

// =============================================================================
// MAIN TEMPLATE FUNCTION
// =============================================================================
#let template(
  // Titles
  title: [Document Title],
  subtitle: none,

  // Practicum / Assignment (Hilderink guideline)
  practicum: none,
  assignment: auto,

  // Author(s) - Defaults to Sven Dinkla
  authors: "Sven Dinkla",
  author: auto,
  student-number: none,
  student-id: auto,
  studentnummer: auto,

  // Teacher / Docent (Hilderink guideline)
  teacher: none,
  docent: auto,

  // Date (defaults to today in English)
  date: auto,

  // Course / Subject
  course: none,
  vak: auto,

  // Abstract (Hilderink guideline: unnumbered, excluded from TOC)
  abstract: none,
  abstract-title: [Abstract],

  // Versioning & Review Mode
  version: "1.0",
  versie: auto,
  review: false,                // true = show highlights; false = clean final document
  highlight-version: auto,      // auto = current version, or "1.1", or ("1.1", "1.2")
  changelog: none,              // Revision table array
  changelog-title: [Document Revision History],
  changelog-pagebreak: false,

  // Styling & layout
  logo: none,
  accent-color: rgb("#1d4ed8"), // Royal Blue
  paper: "a4",
  font: ("Adwaita Sans", "Nimbus Sans", "FreeSans"),
  font-mono: ("JetBrainsMono NF", "DejaVu Sans Mono", "Nimbus Mono PS"),
  font-size: 11pt,              // Standard 11pt as recommended in guideline Table 5
  lang: "en",

  // Table of contents
  toc: true,
  toc-title: [Table of Contents],
  toc-depth: 3,

  // Page numbering style: "1" (default) or "1 / 1"
  page-numbering: "1",

  // Page break per H1 (each challenge / chapter starts on a new page)
  h1-pagebreak: false,
  chapter-pagebreak: auto,
  h1-nieuwe-pagina: auto,

  // Math equation numbering (e.g. "(1.1)" as in guideline page 9)
  equation-numbering: "(1.1)",

  // Body content
  body
) = {
  // Handle aliases
  let authors-input = if author != auto { author } else { authors }
  let s-num = if student-id != auto { student-id } else if studentnummer != auto { studentnummer } else { student-number }
  let crs = if vak != auto { vak } else { course }
  let ver = if versie != auto { str(versie) } else { str(version) }
  let tchr = if docent != auto { docent } else { teacher }
  let prac = if assignment != auto { assignment } else { practicum }
  let break-on-h1 = if h1-nieuwe-pagina != auto {
    h1-nieuwe-pagina
  } else if chapter-pagebreak != auto {
    chapter-pagebreak
  } else {
    h1-pagebreak
  }

  let author-list = normalize-authors(authors-input, student-number: s-num)
  let date-text = format-date(date)

  // Configure states for #add, #chg, #del
  __template_version.update(ver)
  __template_review.update(review)
  __template_highlight_versions.update(
    if highlight-version == auto {
      (ver,)
    } else if type(highlight-version) == array {
      highlight-version.map(v => str(v))
    } else {
      (str(highlight-version),)
    }
  )

  // Document metadata
  set document(
    title: title,
    author: author-list.map(a => a.name),
  )

  // Text defaults
  set text(
    font: font,
    lang: lang,
    size: font-size,
    fill: rgb("#1f2937"),
  )

  // Link styling
  show link: set text(fill: accent-color)

  // ===========================================================================
  // 1. COVER PAGE
  // ===========================================================================
  page(
    paper: paper,
    margin: (x: 2.8cm, top: 3.2cm, bottom: 2.8cm),
    header: none,
    footer: none,
  )[
    // Accent bar on left edge
    #place(top + left, dx: -2.8cm, dy: -3.2cm)[
      #rect(
        width: 8mm,
        height: 100% + 6cm,
        fill: accent-color,
      )
    ]

    #v(0.8cm)

    // Optional logo top-right
    #if logo != none [
      #align(right)[
        #if type(logo) == str {
          image(logo, width: 4cm)
        } else {
          logo
        }
      ]
      #v(1.2cm)
    ]

    // Top subject/course & practicum tag
    #if crs != none or prac != none [
      #let tag = if crs != none and prac != none [
        #crs #if prac != none [ --- #prac ]
      ] else if crs != none [
        #crs
      ] else [
        #prac
      ]
      #text(size: 11pt, weight: "bold", fill: accent-color, tracking: 1.5pt)[
        #upper(tag)
      ]
      #v(0.8em)
    ]

    // Main document title
    #text(size: 26pt, weight: "bold", fill: rgb("#0f172a"), hyphenate: false)[
      #title
    ]

    // Subtitle
    #if subtitle != none [
      #v(0.6em)
      #text(size: 13pt, fill: rgb("#475569"), weight: "regular")[
        #subtitle
      ]
    ]

    #v(1.2em)
    #line(length: 100%, stroke: 2pt + accent-color)

    #v(1fr)

    // Minimal metadata card
    #rect(
      fill: rgb("#f8fafc"),
      stroke: 1pt + rgb("#e2e8f0"),
      radius: 6pt,
      inset: (x: 18pt, y: 16pt),
      width: 100%,
    )[
      #grid(
        columns: (auto, 1fr),
        row-gutter: 11pt,
        column-gutter: 18pt,

        text(weight: "bold", fill: rgb("#475569"))[
          #if author-list.len() > 1 [Authors:] else [Author:]
        ],
        [
          #for (i, author) in author-list.enumerate() {
            if i > 0 [ \ ]
            text(weight: "semibold", fill: rgb("#0f172a"))[#author.name]
            if author.student-number != none [
              #text(fill: rgb("#64748b"))[ (#author.student-number)]
            ]
          }
        ],

        ..if date-text != none {(
          text(weight: "bold", fill: rgb("#475569"))[Date:],
          text(fill: rgb("#0f172a"))[#date-text]
        )} else {()},

        ..if crs != none {(
          text(weight: "bold", fill: rgb("#475569"))[Course:],
          text(fill: rgb("#0f172a"))[#crs]
        )} else {()},

        ..if prac != none {(
          text(weight: "bold", fill: rgb("#475569"))[Practicum:],
          text(fill: rgb("#0f172a"))[#prac]
        )} else {()},

        ..if tchr != none {(
          text(weight: "bold", fill: rgb("#475569"))[Teacher:],
          text(fill: rgb("#0f172a"))[#tchr]
        )} else {()},

        text(weight: "bold", fill: rgb("#475569"))[Version:],
        [
          #text(fill: rgb("#0f172a"), weight: "medium")[#ver]
          #if review [
            #h(6pt)
            #box(
              fill: rgb("#fef3c7"),
              radius: 3pt,
              inset: (x: 5pt, y: 2pt),
              outset: 0pt,
              text(size: 8pt, weight: "bold", fill: rgb("#b45309"))[REVIEW MODE]
            )
          ]
        ],
      )
    ]
    #v(0.5cm)
  ]

  // ===========================================================================
  // 1.5 ABSTRACT (Hilderink guideline: unnumbered, excluded from TOC)
  // ===========================================================================
  if abstract != none {
    page(
      paper: paper,
      margin: (x: 2.6cm, top: 3.2cm, bottom: 2.8cm),
      header: none,
      footer: none,
    )[
      #v(0.8cm)
      #text(size: 20pt, weight: "bold", fill: accent-color)[
        #abstract-title
      ]
      #v(0.5em)
      #line(length: 100%, stroke: 1.5pt + rgb("#e2e8f0"))
      #v(1.2em)
      #set par(justify: true, leading: 0.8em)
      #abstract
    ]
  }

  // ===========================================================================
  // 2. TABLE OF CONTENTS & REVISION HISTORY (CHANGELOG)
  // ===========================================================================
  let has-changelog = changelog != none and changelog.len() > 0

  if toc or has-changelog {
    page(
      paper: paper,
      margin: (x: 2.6cm, top: 3cm, bottom: 2.8cm),
      header: none,
      footer: none,
    )[
      #if toc [
        #v(0.6cm)
        #text(size: 20pt, weight: "bold", fill: accent-color)[
          #toc-title
        ]
        #v(0.5em)
        #line(length: 100%, stroke: 1.5pt + rgb("#e2e8f0"))
        #v(1.2em)
        #outline(
          title: none,
          indent: 1.5em,
          depth: toc-depth,
        )
      ]

      #if has-changelog [
        #if toc and changelog-pagebreak [
          #pagebreak()
        ] else if toc [
          #v(2.5em)
        ]

        #text(size: 14pt, weight: "bold", fill: rgb("#0f172a"))[
          #changelog-title
        ]
        #v(0.4em)
        #line(length: 100%, stroke: 1pt + rgb("#e2e8f0"))
        #v(0.8em)

        #table(
          columns: (auto, auto, auto, 1fr),
          stroke: 0.5pt + rgb("#e2e8f0"),
          fill: (col, row) => if row == 0 { rgb("#f8fafc") } else { none },
          table.header([*Version*], [*Date*], [*Author*], [*Summary of Changes*]),
          ..for item in changelog {
            (
              text(weight: "bold")[#item.at("version", default: "-")],
              item.at("date", default: "-"),
              item.at("author", default: author-list.first().name),
              item.at("description", default: item.at("changes", default: "-")),
            )
          }
        )
      ]
    ]
  }

  // ===========================================================================
  // 3. BODY & MINIMALIST PAGE NUMBERING
  // ===========================================================================
  set page(
    paper: paper,
    margin: (x: 2.6cm, top: 2.8cm, bottom: 2.8cm),
    header: context {
      // Dynamic chapter heading detection
      let cur-page = here().page()
      let headings-on-page = query(heading.where(level: 1)).filter(h => h.location().page() == cur-page)
      let section-title = if headings-on-page.len() > 0 {
        headings-on-page.first().body
      } else {
        let prev-headings = query(heading.where(level: 1)).filter(h => h.location().page() < cur-page)
        if prev-headings.len() > 0 {
          prev-headings.last().body
        } else {
          none
        }
      }

      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        text(size: 8.5pt, fill: rgb("#94a3b8"))[#title],
        if section-title != none {
          text(size: 8.5pt, fill: rgb("#94a3b8"))[#section-title]
        } else if crs != none {
          text(size: 8.5pt, fill: rgb("#94a3b8"))[#crs]
        } else {
          none
        }
      )
      v(4pt)
      line(length: 100%, stroke: 0.4pt + rgb("#e2e8f0"))
    },
    footer: context {
      line(length: 100%, stroke: 0.4pt + rgb("#e2e8f0"))
      v(4pt)
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        text(size: 8.5pt, fill: rgb("#94a3b8"))[
          #author-list.map(a => a.name).join(", ")
        ],
        text(size: 8.5pt)[
          #if page-numbering == "1 / 1" or page-numbering == "both" [
            #text(fill: rgb("#64748b"), weight: "medium")[#counter(page).display()]
            #text(fill: rgb("#cbd5e1"))[\/ ]
            #text(fill: rgb("#94a3b8"))[#counter(page).final().first()]
          ] else [
            #text(fill: rgb("#64748b"), weight: "medium")[#counter(page).display()]
          ]
        ]
      )
    }
  )

  // Reset page counter so content starts on Page 1
  counter(page).update(1)

  // Heading numbering (1, 1.1, 1.1.1)
  set heading(numbering: "1.1")
  show heading: it => {
    let size = if it.level == 1 { 16pt } else if it.level == 2 { 13pt } else { 11pt }
    let top-space = if it.level == 1 { 1.8em } else if it.level == 2 { 1.4em } else { 1.2em }
    let col = if it.level == 1 { accent-color } else { rgb("#0f172a") }

    if it.level == 1 and break-on-h1 {
      pagebreak(weak: true)
    }

    v(top-space)
    text(size: size, weight: "bold", fill: col)[
      #it
    ]
    v(0.7em)
  }

  // Paragraph spacing and justified text
  set par(justify: true, leading: 0.75em)

  // Captions: Table captions on top, image/figure captions below (Hilderink guideline)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: image): set figure.caption(position: bottom)

  // Equation numbering (e.g. "(1.1)" as in guideline page 9)
  if equation-numbering != none {
    set math.equation(numbering: equation-numbering)
  }

  // Code blocks
  show raw.where(block: true): it => {
    rect(
      fill: rgb("#f8fafc"),
      stroke: 1pt + rgb("#e2e8f0"),
      radius: 4pt,
      width: 100%,
      inset: 10pt,
    )[
      #set text(font: font-mono, size: 9pt)
      #it
    ]
  }

  // Inline code
  show raw.where(block: false): it => {
    box(
      fill: rgb("#f1f5f9"),
      radius: 3pt,
      outset: (x: 2pt, y: 2pt),
      baseline: 0%,
    )[
      #set text(font: font-mono, size: 9pt, fill: rgb("#0f172a"))
      #it
    ]
  }

  body
}

// Optional helper function for standardized Practicum Challenge structure
#let challenge(
  number,
  title,
  intro: none,
  procedure: none,
  results: none,
  conclusions: none,
) = {
  heading(level: 1)[Challenge #number: #title]
  if intro != none [
    == Introduction
    #intro
  ]
  if procedure != none [
    == Procedure & Architecture
    #procedure
  ]
  if results != none [
    == Results & Verification
    #results
  ]
  if conclusions != none [
    == Conclusions & Trade-offs
    #conclusions
  ]
}

// Aliases
#let school-template = template
#let school-document = template
#let school-report = template
#let technical-report = template
#let practicum-report = template
#let project = template
