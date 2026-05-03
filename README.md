# IACR Typst Template

A Typst template for IACR journals (CiC, ToSC, TCHES), based on the official LaTeX class [iacrj.cls](https://github.com/IACR/latex/blob/main/iacrj/iacrj.cls), taken from the official [IACR LaTeX Template Repository](https://github.com/IACR/latex/tree/main).

---

## Installation

Clone the repository into your Typst local packages directory:

**Windows:**
```bash
git clone [git_url] "%APPDATA%\Roaming\typst\packages\iacr"
```

**macOS/Linux:**
```bash
git clone [git_url] ~/.local/share/typst/packages/iacr
```

---

## Usage

### Start a new paper

Initialize a new paper using the template. In bash run:

```bash
typst init @iacr/typst:0.1.0 my-paper
```

This will create the following structure in a new `my-paper` folder:

```
my-paper/
├── Define/
│   └── define.typ        ← Fill out your metadata here
├── Media/                ← Images and figures
├── References/
│   └── references.bib    ← BibTeX bibliography
├── Sections/             ← Optional: split content into section files
└── main.typ              ← Paper content
```

### Quick Start

**1. Fill out `Define/define.typ`** with your paper metadata (title, authors, affiliations, etc.). 

> [!NOTE] 
> See the comments in that file for accepted values and usage.

**3. Fill out your paper in `main.typ`:**

```typst
#import "Define/define.typ": *
#import "@local/iacr:0.1.0": iacr-template

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

= Introduction

Your content here. Cite with @yourkey.

// Optional: include section files from the Sections/ folder
#include "Sections/my-section.typ"

```

**4. Compile to PDF:**

Via the command line (in your project's directory):
```bash
typst compile main.typ
```
Or directly in your IDE using the Typst extension (e.g. in VS Code, click the compile button or use the live preview).

---

## Versions

The version can be set in `Define/define.typ` using the `version` variable:

| Value | Description |
|---|---|
| `"preprint"` | Default. Shows license and date in footer. |
| `"submission"` | Hides authors/affiliations for blind review. |
| `"final"` | Shows full journal header, DOI, and publication dates. |