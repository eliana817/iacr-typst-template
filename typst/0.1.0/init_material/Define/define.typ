// Define all document metadata here.

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
#let journal = "tosc"

/* 
version: The version of the document.
  Accepted values:
      - "preprint"   : Default. Shows license + date in footer.
      - "submission" : Anonymizes authors and affiliations for blind review.
      - "final"      : Shows full journal header, DOI, and publication dates.
*/
#let version = "preprint"

// title: The full title of the paper.
#let title = "Title"

// subtitle: An optional subtitle. Set to none if not needed.
#let subtitle = "Subtitle"

/////////////
// Authors //
/////////////

/* 
authors: A list of authors. Each author is a dictionary with the following fields:
  - name  (required) : Full name of the author.
  - inst  (required) : Tuple of affiliation IDs (must match ids in affiliations).
    --> Use (1,) for a single affiliation (trailing comma required).
  - email (optional) : Email address. Will appear as a mailto link under the corresponding affiliation on the front page.
*/
#let authors = (
  (name: "Author A", inst: (1,), email: "author_a@example.com"),
  (name: "Author B", inst: (1, 2), email: "author_b@example.com"),
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
*/
#let affiliations = (
  (id: 1, name: "Affiliation A", city: "City A", country: "Country A"),
  (id: 2, name: "Affiliation B", city: "City B", country: "Country B"),
)

///////////////////////////
// Abstract and keywords //
///////////////////////////

/* 
keywords: A list of keywords describing the paper.
  Displayed after the abstract separated by " · ".
*/
#let keywords = ("keyword one", "keyword two", "keyword three")

/* 
abstract: The abstract of the paper. 
  Typst content enclosed in [], so you can use formatting, math, etc.
  Do not use citations inside the abstract.
*/
#let abstract = [
  Abstract content goes here.
]

/////////////////////
// Running headers //
/////////////////////

/*
running_title: Short title for the page header (even pages).
  Set to none to auto-derive from title.
*/
#let running_title = "Running Title"

/*
running_authors: Short author list for the page header (odd pages).
  Set to none to auto-derive from authors list.
*/
#let running_authors = "Running Authors"

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

///////////////////
// Bibliography  //
///////////////////

/*
bib-file: Path to the .bib file containing references.
  Path is relative to main.typ.
*/
#let bib-file = "../References/references.bib"