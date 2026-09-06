// Based on the latex existing template (iacrj.cls): 
// https://github.com/IACR/latex/blob/main/iacrj/iacrj.cls
// 
// The CC license badge was taken from here:
// https://github.com/creativecommons/cc-assets/blob/main/license_badges/small/by.svg
// 
// The crossmark image for CiC documents is from: 
// https://crossmark.crossref.org/widget/v2.0/readme.html

#let iacr-front-page(
  title: "",
  subtitle: none,
  authors: (),
  affiliations: (),
  abstract: [],
  keywords: (),
  anonymous: false,
  anonymous_placeholder: "",
  cite-color: blue,
) = {
  align(center)[
    #v(1em)
    #text(size: 17.28pt, weight: "bold")[#title]
    #if subtitle != none {
      v(0.3em)
      text(size: 12pt, style: "italic")[#subtitle]
    }
    #v(1em)

    // Hide authors and affiliations if submission version (anonymous)
    
    #if not anonymous {
      let show-inst = authors.len() > 1 and affiliations.len() > 1
      text(size: 10pt)[
        #authors.map(a =>
          if show-inst and "inst" in a and a.inst.len() > 0 {
            [#a.name#super(a.inst.map(str).join(","))]
          } else {
            [#a.name]
          }
        ).join(", ")
      ]
      v(0.5em)
      text(size: 9pt)[
        
        #affiliations.map(a => {
          // Create list of emails that correspond to each affiliation
          let affil-authors = authors.filter(au => 
            "inst" in au and a.id in au.inst and "email" in au
          )
          
          let affil-emails = affil-authors.map(au => au.email)

          stack(
            spacing: 5pt,
            // Affiliation line
            if show-inst {
              [#super(str(a.id))#a.name, #a.city, #a.country]
            } else {
              [#a.name, #a.city, #a.country]
            },
            // Add mailto links when applicable
            if affil-emails.len() > 0 {
              if affil-emails.len() == 1 {
                // If only one email, show it as is
                link("mailto:" + affil-emails.first())[
                  #text(fill: cite-color, size: 9pt)[#affil-emails.first()]
                ]
              } else {
                // If multiple emails: group as {a, b, c}@domain.com if same domain
                let domain = affil-emails.first().split("@").last()
                let same-domain = affil-emails.all(e => e.ends-with("@" + domain))
                
                if same-domain {
                  let usernames = affil-emails.map(e => e.split("@").first())
                  link("mailto:" + affil-emails.join(","))[
                    #text(fill: cite-color, size: 9pt)[
                      \{#usernames.join(", ")\}\@#domain
                    ]
                  ]
                } else {
                  // Different domains: show individually
                  stack(
                    spacing: 1pt,
                    ..affil-emails.map(e =>
                      link("mailto:" + e)[
                        #text(fill: cite-color, size: 9pt)[#e]
                      ]
                    )
                  )
                }
              }
            }
          )
        }).join([])

      ]
    } else {
      // If version is submission: show anonymous placeholder
      text(size: 10pt, style: "italic")[#anonymous_placeholder]
    }
  ]

  v(2em)

  // Abstract + keywords
  align(center)[
    #block(width: 85%, inset: (x: 0pt))[

      #set text(size: 9pt)
      #set align(left)

      // Abstract
      #text(weight: "bold")[Abstract.] 
      #abstract

      #v(.5em)

      // Keywords
      #block[
        #if keywords.len() > 0 {
          text(weight: "bold")[Keywords: ] 
          keywords.join(" · ")
        }
      ]
    ]
  ]
}

#let iacr-template(

  journal: "tosc", // cic, tosc, tches
  version: "preprint", // preprint, submission or final
  title: "",
  subtitle: none,

  authors: (),
  // e.g.: (
  //   (name: "Author A", inst: (1,), email: "author_a@example.com"),
  //   (name: "Author B",   inst: (1,2), email: "author_b@example.com"),
  // )
  
  affiliations: (),
  // e.g.: (
  //   (id: 1, name: "Affiliation A", city: "City A", country: "Country A"),
  //   (id: 2, name: "Affiliation B", city: "City B", country: "Country B"),
  // )
  
  abstract: [],
  keywords: (),

  running_title: none,
  running_authors: none,

  vol: none,
  no: none,
  doi: none,
  crossmark_url: none,
  received: none, 
  revised: none,
  accepted: none,
  published: none,

  body
) = {
  
  let license_value = link("http://creativecommons.org/licenses/by/4.0/")[Creative Commons License CC-BY 4.0]

  // Set variables based on journal 
  
  let (pub_name, eissn) = if journal == "cic" {
      ("IACR Communications in Cryptology", "3006-5496")
    } else if journal == "tosc" {
      ("IACR Transactions on Symmetric Cryptology", "2519-173X")
    } else if journal == "tches" {
      ("IACR Transactions on Cryptographic Hardware and Embedded Systems", "2569-2925")
    } else {
      ("", "")
    }

  // Set variables based on version 
  
  let anonymous = version == "submission"
  let anonymous_placeholder = "Anonymous Submission to " + pub_name
  let is_final  = version == "final"
  let actual_running_authors = if anonymous {
    ""
  } else if running_authors != none {
    running_authors
  } else {
    authors.map(a => a.name).join(", ")
  }
  let actual_running_title = if running_title != none { 
    running_title 
  } else { 
    title 
  }

  // General formatting

  set page(
    paper: "a4",
    margin: (
      top: 12.5%,
      right: 17.5%,
      bottom: 12.5%,
      left: 17.5%
    )
  )

  set text(font: "New Computer Modern", fill: black, size: 10pt)
  set par(
    justify: true,
    first-line-indent: (amount: 1em, all: false),
    spacing: .65em
  )

  // Bibliography 
  
  set bibliography(
    style: "Resources/bib_style/din-1505-2-alphanumeric.csl"
  )

  // Heading style
  
  set heading(
    numbering: "1.1",
  )

  show heading: it => {
    if it.level >= 3 {
      set text(size: 10pt)
    }
    it
    v(.5em)
  }

  show heading.where(level: 1): set text(size: 14.4pt, weight: "bold")
  show heading.where(level: 2): set text(size: 12pt, weight: "bold")
  show heading.where(level: 3): set text(weight: "bold")

  // Links

  // --- Should we overwrite the default colors of typst to match the latex colors?? Cause they are slightly different.
  let xcolor-green = rgb("#00FF00")  // citecolor=black!70!green
  let latex-red = rgb("#ED1B23")
  let latex-black = rgb("#221E1F")
  let latex-blue = rgb("#2D2F92")

  let cite-color = color.mix((latex-black, 70%), (xcolor-green, 30%), space: rgb) // latex xcolor RGB blend
  let link-color = color.mix((latex-black, 70%), (latex-red,  30%), space: rgb) // linkcolor=black!70!red

  let hyperref-default-magenta = rgb("#FF00FF")
  let url-color = if journal == "cic" { rgb("#0000FF") } else { hyperref-default-magenta }

  show ref: set text(fill: link-color)
  show cite: set text(fill: cite-color)
  show link: it => {
    if type(it.dest) == str {
      text(fill: url-color, it)
    } else {
      text(fill: link-color, it)
    }
  }

  // Figures

  show figure: set block(breakable: true)
  show figure.caption: it => [
    #set align(left)
    #text(weight: "bold")[#it.supplement  #context it.counter.display(it.numbering): ] #it.body
  ]
  // For tables, caption is at the top
  show figure.where(kind: table): it => {
    it.caption
    it.body
  }

  // Header and footer (all main pages)
  set page(

    header: context {
      set text(size: 9pt)
      if here().page() == 1 {
        if is_final { // Header on first page for final version only
          let lp = counter(page).final().first()
          if journal == "cic" {
            // CiC: name + EISSN + vol/no/pages on left, DOI on right
            grid(
              columns: (1fr, auto),
              align: (top + left, bottom + right),
              stack(
                spacing: 5pt,
                [#pub_name],
                [ISSN #eissn, Vol. ]
                + if vol != none { [#vol] }
                + if no  != none { [, No. #no] }
                + [, #lp pages.]
              ),
              if doi != none {
                stack(
                  spacing: 2pt,
                  link("https://doi.org/" + doi)[https://doi.org\/#doi],
                  if crossmark_url != none {
                    v(2pt)
                    link(crossmark_url)[
                      #image("Resources/crossmark.svg", height: 25%)
                    ]
                  }
                )
              }
            )
          } else {
            // ToSC and TCHES: name + EISSN + vol/no/pages + DOI all on left
            stack(
              spacing: 5pt,
              [#pub_name],
              [ISSN #eissn]
              + if vol != none { [, Vol. #vol] }
              + if no  != none { [, No. #no]  }
              + [, pp. 1\--#lp.]
              + [ #h(1fr) ]
              + if doi != none {
                  link("https://doi.org/" + doi, [DOI: #doi])
                },
            )
          }
        }
        // No header on first page for preprint/submission versions
      } else {
        // Running authors appear on odd pages, left-aligned
        if calc.odd(here().page()) {
          grid(
            columns: (1fr, auto),
            // Anonymous submission instead of running authors if submission version
            if anonymous { [#anonymous_placeholder] }
            else { [#actual_running_authors] },
            counter(page).display(),
          )
        } else {
          // Running title appears on even pages, right-aligned
          grid(
            columns: (auto, 1fr),
            counter(page).display(),
            align(right)[#actual_running_title],
          )
        }
        v(-.2em)
        line(length: 100%, stroke: .5pt)
      }
    },

    footer: context {
      // For the first page only: license + date
      if here().page() == 1 {
        set text(size: 8pt)
        if is_final {
        // Footer for final version
        grid(
          columns: (1fr, auto),
          [Licensed under #license_value],
          link("https://creativecommons.org/licenses/by/4.0/deed.en")[
            #image("Resources/by.svg", width: 4em)
          ], 
        )

        // Dates row — only shown if value is not none
        grid(
          columns: (1fr, 1fr, 1fr, 1fr),
          if received  != none [ Received: #received ],
          if revised   != none [ Revised: #revised ],
          if accepted  != none [ Accepted: #accepted ],
          if published != none [ Published: #published ],
        )
      } else {
        // Footer for preprint version
        grid(
          columns: (1fr, auto),
          [Licensed under #license_value],
          [Date of this document: #datetime.today().display()],
        )
      }
      }
    }
  )

  // PDF metadata
  set document(
    title: actual_running_title,
    // Authors are hidden if for submission
    author: if anonymous { "hidden for submission" } else { actual_running_authors },
    description: pub_name + if doi != none { ", DOI: " + doi } else { "" },
  )

  // Front page content formatting. 

  iacr-front-page(
    title: title,
    subtitle: subtitle,
    authors: authors,
    affiliations: affiliations,
    abstract: abstract,
    keywords: keywords,
    anonymous: anonymous,
    anonymous_placeholder: anonymous_placeholder,
    cite-color: cite-color,
  )

  v(2em)

  body

}