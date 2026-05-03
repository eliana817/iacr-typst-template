/////////////////////////////////////////////////////
//           IACR template (v.0.1.0)               //
///////////////////////////////////////////////////// 

#import "Define/define.typ": *
#import "@iacr/typst:0.1.0": iacr-template

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
  received: received, 
  revised: revised,
  accepted: accepted,
  published: published,

)

#include "Sections/references.typ"