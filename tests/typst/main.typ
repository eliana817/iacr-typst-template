#import "@iacr/typst:0.1.0": iacr-template

///////////////////
// Document info //
///////////////////

/*
journal: The IACR journal this paper is submitted to.
  Accepted values:
    - "cic"
    - "tosc"
    - "tches"
*/
#let journal = sys.inputs.at("journal", default: "tosc")

/*
version: The version of the document.
  Accepted values:
      - "preprint"   : Default. Shows license + date in footer.
      - "submission" : Anonymizes authors and affiliations for blind review.
      - "final"      : Shows full journal header, DOI, and publication dates.
*/
#let version = sys.inputs.at("version", default: "preprint")

// title: The full title of the paper.
#let title = "How to Use the IACR Journal Document Template"

/*
running_title: Short title for the page header (even pages).
  Set to none to auto-derive from title.
*/
#let running_title = "The iacrj document template"

// subtitle: An optional subtitle. Set to none if not needed.
#let subtitle = "iacrj Typst Template Documentation (v0.1.0)"

/////////////
// Authors //
/////////////

/*
authors: A list of authors. Each author is a dictionary with the following fields:
  - name  (required) : Full name of the author.
  - inst  (required) : Tuple of affiliation IDs (must match ids in affiliations).
    --> Use (1,) for a single affiliation (trailing comma required).
  - email (optional) : Email address. Will appear as a mailto link under the corresponding affiliation on the front page.
TODO: add orcid, surname, onclick
*/
#let authors = (
  (name: "Eliana Grasser", inst: (1,), email: "eliana.grasser@st.com"),
  (name: "Gilles Van Assche", inst: (2, 3), email: "gilles.vanassche@st.com"),
)

//////////////////
// Affiliations //
//////////////////

/*
affiliations: A list of affiliations. Each affiliation is a dictionary with:
  - id      (required) : Numeric identifier. Must match the inst values used in the authors list above.
  - name    (required) : Full name of the institution.
  - city    (required) : City of the institution.
  - country (required) : Country of the institution.
TODO: add ror, street, postcode
*/
#let affiliations = (
  (id: 1, name: "STMicroelectronics", city: "Rousset", country: "France"),
  (id: 2, name: "STMicroelectronics", city: "Diegem", country: "Belgium"),
  (id: 3, name: "Université Libre de Bruxelles", city: "Brussels", country: "Belgium"),
)

/*
running_authors: Short author list for the page header (odd pages).
  Set to none to auto-derive from authors list.
*/
#let running_authors = "Grasser and Van Assche"

///////////////////////////
// Abstract and keywords //
///////////////////////////

/*
keywords: A list of keywords describing the paper.
  Displayed after the abstract separated by " · ".
*/
#let keywords = ("Template", "Typst", "IACR")

/*
abstract: The abstract of the paper.
  Typst content enclosed in [], so you can use formatting, math, etc.
  Do not use citations inside the abstract.
*/
#let abstract = [
This is documentation for the `iacrj` document template that can be used for the three IACR journals ToSC, TCHES, and  CiC.
The `iacrj` document template is intended to be the Typst equivalent for the LaTeX `iacrj` document class.
]

// TODO: add textabstract

////////////////////////////
// Final version metadata //
////////////////////////////

/*
The following fields are only displayed when version = "final".
Set to none if not yet assigned by the journal.
*/

// vol: Volume number of the journal issue.
#let vol = "volume number"

// no: Issue number of the journal volume.
#let no = "issue number"

/*
  doi: Digital Object Identifier assigned by the journal.
  Do not include the "https://doi.org/" prefix, just the identifier.
  e.g. "10.46586/tosc.v2024.i1.1-23"
*/
#let doi = none

/*
  crossmark_url: URL to the CrossMark page for the paper.
  Set to none if not yet assigned by the journal.
*/
#let crossmark_url = none

// received: Date the paper was received by the journal.
#let received = "received date"

// revised: Date the paper was revised.
#let revised = "revised date"

// accepted: Date the paper was accepted.
#let accepted = "accepted date"

// published: Date the final version was published.
#let published = "published date"

///////////////////////
// Document contents //
///////////////////////

#show: iacr-template.with(

  journal: journal,
  version: version,
  title: title,
  subtitle: subtitle,

  authors: authors,

  affiliations: affiliations,

  abstract: abstract,
  keywords: keywords,

  running_title: running_title,
  running_authors: running_authors,

  vol: vol,
  no: no,
  doi: doi,
  crossmark_url: crossmark_url,
  received: received, 
  revised: revised,
  accepted: accepted,
  published: published,

)

// TODO: remove the numbering for the introduction
= Introduction

This document is a guide to using the `iacrj` document template for three IACR journals:
- IACR Transactions on Symmetric Cryptology (ToSC),
- IACR Transactions on Cryptographic Hardware and Embedded Systems (TCHES),
- IACR Communications in Cryptology (CiC)

The `iacrj` template is intended to be the Typst equivalent for the `iacrj` document class in LaTeX.

The class is still in development and feedback and comments are welcome.
The latest version can be found at https://github.com/eliana817/iacr-typst-template/ .
There is also a #link("https://github.com/IACR/latex")[github repository] where you can open issues or to submit pull requests.

*NOTES* \
- The production system to which you submit your final version does not yet support Typst.
- The default fonts are provided by the template.
  Please do not change this.
- Avoid using too many packages.
- Don't try to change the bibliography style, the page style, or the page numbering.

///////////////////
// Bibliography  //
///////////////////

/*
bib-file: Path to the .bib file containing references.
  Path is relative to main.typ.
*/
#let bib-file = "references.bib"

#bibliography(bib-file,
  title: "References",
)

