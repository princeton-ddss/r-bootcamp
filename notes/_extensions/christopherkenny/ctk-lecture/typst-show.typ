$if(hide-solutions)$
#show figure.where(kind: "solution"): hide
$endif$

#show: doc => article(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(by-author)$
  authors: (
$for(by-author)$
$if(it.name.literal)$
    (
      name: [$it.name.literal$],
      last: [$it.name.family$],
$for(it.affiliations/first)$
      department: $if(it.department)$[$it.department$]$else$none$endif$,
      university: $if(it.name)$[$it.name$]$else$none$endif$,
      location: [$if(it.city)$$it.city$$if(it.country)$, $endif$$endif$$if(it.country)$$it.country$$endif$],
$endfor$
$if(it.email)$
      email: [$it.email$],
$endif$
$if(it.url)$
      url: "$it.url$",
$endif$
    ),
$endif$
$endfor$
  ),
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(header-left)$
  headerleft: [$header-left$],
$endif$
$if(header-right)$
  headerright: [$header-right$],
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(abstract)$
  abstract: [$abstract$],
  abstract-title: "$labels.abstract$",
$endif$
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(papersize)$
  paper: "$papersize$",
$endif$
$if(mainfont)$
  font: ($for(mainfont)$"$mainfont$",$endfor$),
$elseif(brand.typography.base.family)$
  font: $brand.typography.base.family$,
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$elseif(brand.typography.base.size)$
  fontsize: $brand.typography.base.size$,
$endif$
$if(mathfont)$
  mathfont: ($for(mathfont)$"$mathfont$",$endfor$),
$endif$
$if(codefont)$
  codefont: ($for(codefont)$"$codefont$",$endfor$),
$endif$
$if(title)$
$if(brand.typography.headings.family)$
  heading-family: $brand.typography.headings.family$,
$endif$
$if(brand.typography.headings.weight)$
  heading-weight: $brand.typography.headings.weight$,
$endif$
$if(brand.typography.headings.style)$
  heading-style: "$brand.typography.headings.style$",
$endif$
$if(brand.typography.headings.color)$
  heading-color: $brand.typography.headings.color$,
$endif$
$if(brand.typography.headings.line-height)$
  heading-line-height: $brand.typography.headings.line-height$,
$endif$
$endif$
$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$
  pagenumbering: $if(page-numbering)$"$page-numbering$"$else$none$endif$,
$if(toc)$
  toc: $toc$,
$endif$
$if(toc-title)$
  toc_title: [$toc-title$],
$endif$
$if(toc-indent)$
  toc_indent: $toc-indent$,
$endif$
  toc_depth: $toc-depth$,
  cols: $if(columns)$$columns$$else$1$endif$,
$if(linestretch)$
  linestretch: $linestretch$,
$endif$
$if(linkcolor)$
  linkcolor: "$linkcolor$",
$endif$
$if(frontmatter-logo)$
  frontmatter-logo: [$frontmatter-logo$],
$endif$
$if(frontmatter-logo-height)$
  frontmatter-logo-height: $frontmatter-logo-height$,
$endif$
  doc,
)
