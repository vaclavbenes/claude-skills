---
name: weasyprint
description: Use when user wants to convert a PDF to editable HTML, convert HTML to PDF using weasyprint, or achieve pixel-perfect layout matching between PDF and HTML. Use when user mentions weasyprint, print CSS, @page rules, PDF generation, or needs a PDF cloned as an editable HTML document.
---

# WeasyPrint — HTML ↔ PDF Conversion

## Overview

Two independent workflows: **PDF → editable HTML** (Claude reads PDF, generates print-optimized HTML) and **HTML → PDF** (run weasyprint CLI). Iterate on HTML with user text feedback until pixel-perfect.

## Workflow A — PDF → HTML

1. **Read the PDF** — use the Read tool on the PDF file path
2. **Extract** — note exact page size, margins, fonts, font sizes, colors, spacing, layout
3. **Generate print-optimized HTML** — apply Print CSS Defaults below, overriding with extracted values
4. **Save** — same directory as input, same basename: `report.pdf` → `report.html`
5. **Offer to run Workflow B** — convert HTML back to PDF immediately to verify fidelity

## Workflow B — HTML → PDF

```bash
weasyprint input.html output.pdf --optimize-images
```

Output: same directory, same basename: `report.html` → `report.pdf`

**Show all stdout** — warnings reveal layout problems (missing fonts, broken images, unsupported CSS).

**Iterate:** user gives text feedback → edit HTML → re-run weasyprint → repeat until pixel-perfect.

## Print CSS Defaults (always include)

```css
@page {
  size: A4;       /* override: extract actual size from PDF */
  margin: 2cm;    /* override: extract actual margins from PDF */
}

* {
  box-sizing: border-box;
}

body {
  font-family: sans-serif; /* override: extract actual font from PDF */
  font-size: 11pt;          /* override: extract actual size */
  line-height: 1.4;
}

p {
  widows: 3;
  orphans: 3;
}

h1, h2, h3, h4 {
  page-break-after: avoid;
}

table, figure, pre {
  page-break-inside: avoid;
}
```

**Use cm/mm units** (not px) for margins, padding, fixed dimensions — px is screen-centric, cm/mm maps directly to print dimensions.

## Extracting From a PDF

When reading a PDF, capture:

| Property | What to look for |
|----------|-----------------|
| Page size | A4, Letter, or custom dimensions (width × height) |
| Margins | top / bottom / left / right in cm/mm |
| Fonts | name, size, weight — for headings and body separately |
| Colors | hex values for text, backgrounds, borders, links |
| Layout | single/multi-column, header/footer content, logo position |
| Tables | column widths, borders, cell padding, alignment |

## Common Mistakes

| Problem | Cause | Fix |
|---------|-------|-----|
| Images missing in PDF | Relative paths unresolved | Use absolute paths or add `--base-url <dir>` |
| Wrong fonts rendered | Font not installed on system | Use web-safe fonts or embed via `@font-face` |
| Page breaks mid-sentence | Missing widows/orphans | `p { widows: 3; orphans: 3; }` |
| Content clipped at page edge | px-based margins | Switch `@page` margin to cm units |
| Background colors missing | Print mode strips backgrounds | Add `-webkit-print-color-adjust: exact; print-color-adjust: exact;` |
| Debugging font/image issues | Default output is quiet | Add `-v` flag temporarily: `weasyprint -v input.html out.pdf` |
