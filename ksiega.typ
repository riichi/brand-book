// Build: typst compile --font-path fonts ksiega.typ

#let green = rgb("#214214")
#let red = rgb("#c40000")
#let gray = luma(45%)

// Red ball diameter as a fraction of the sign's width: the clear space unit X.
#let ball-ratio = 0.134
// Sign width relative to the full logo with text (viewBox units).
#let sign-ratio = 217.16243 / 651.91724

#let logo(name, dir: "assets", replace: (:), ..args) = {
  let s = read(dir + "/" + name + ".svg")
  for (from, to) in replace { s = s.replace(from, to) }
  image(bytes(s), format: "svg", ..args)
}

#let logo-mono(color: black, en: false, ..args) = logo(
  if en { "logo_text_mono_en" } else { "logo_text_mono" },
  replace: ("#000000": color.to-hex()),
  ..args,
)

#set document(title: "Księga znaku — Krakowski Klub Chombo")
#set text(font: "Roboto", size: 10.5pt, lang: "pl", fill: luma(15%))
#set par(justify: false, leading: 0.7em)
#set page(
  paper: "a4",
  margin: (x: 2cm, top: 2.2cm, bottom: 2.4cm),
  footer: context {
    set text(size: 8pt, fill: gray)
    [Krakowski Klub Chombo · Księga znaku]
    h(1fr)
    counter(page).display()
  },
)
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  set text(size: 26pt, weight: "bold", fill: green)
  block(below: 1.2em, it.body)
}
#show heading.where(level: 2): set text(size: 13pt, weight: "bold", fill: green)
#show heading.where(level: 2): set block(above: 1.6em, below: 0.8em)

#let caption(body) = text(size: 8.5pt, fill: gray, body)
#let tile(bg: white, border: true, height: 4.5cm, body) = block(
  width: 100%,
  height: height,
  breakable: false,
  fill: bg,
  stroke: if border { 0.5pt + luma(85%) } else { none },
  radius: 2pt,
  align(center + horizon, body),
)

#page(footer: none, margin: 0pt)[
  #let today = datetime.today()
  #let months = ("stycznia", "lutego", "marca", "kwietnia", "maja", "czerwca", "lipca", "sierpnia", "września", "października", "listopada", "grudnia")
  #place(top + left, dx: 2cm, dy: 2cm, text(size: 9pt, fill: gray)[#today.day() #months.at(today.month() - 1) #today.year()])
  #align(center + horizon, logo("logo_text_path", width: 70%))
  #place(bottom, block(width: 100%, height: 5.5cm, fill: green, inset: 2cm)[
    #set text(fill: white)
    #text(size: 34pt, weight: "bold")[Księga znaku]
    #v(-0.6em)
    #text(size: 13pt)[Zasady stosowania logo Krakowskiego Klubu Chombo]
  ])
]

= Znak

Logo łączy dwa motywy: znak zielonego smoka z kamieni do mahjonga oraz męską
czapkę krakuskę (rogatywkę) z pawim piórem, część tradycyjnego krakowskiego stroju ludowego.

Logo nie podlega żadnym modyfikacjom. Zawsze używaj oryginalnych plików.
Nie przerysowuj logo, nie składaj go od nowa ani nie
zmieniaj proporcji.

== Wersje

#grid(
  columns: (1fr, 2.4fr),
  column-gutter: 8pt,
  row-gutter: 6pt,
  tile(logo("logo", height: 70%)),
  tile(logo("logo_text_path", width: 80%)),
  caption[*Sygnet.* Gdy miejsca jest mało lub nazwa klubu pada obok (avatar, naszywka, przypinka).],
  caption[*Logo z napisem.* Wersja podstawowa, stosowana wszędzie tam, gdzie to możliwe.],
)
#v(8pt)
#grid(
  columns: (1fr, 2.4fr),
  column-gutter: 8pt,
  row-gutter: 6pt,
  [],
  tile(logo("logo_text_path_en", width: 80%)),
  [],
  caption[*Wersja angielska.* W materiałach anglojęzycznych.],
)

= Pole ochronne i rozmiar

== Pole ochronne

Wokół logo zostaw wolną przestrzeń, w którą nie wchodzą tekst, grafiki ani
krawędź nośnika. Jej minimalna szerokość to *X*, czyli średnica czerwonej kuli
w znaku.

#let clear-space(body, x) = box(
  stroke: (paint: red, thickness: 0.6pt, dash: "dashed"),
  inset: x,
  box(stroke: 0.4pt + luma(80%), body),
)
#let x-marker(x) = box(height: x, width: x, circle(width: x, fill: red))

#let sign-width = 3.2cm
#let full-width = 9cm
#grid(
  columns: (auto, 1fr),
  column-gutter: 1cm,
  align: horizon,
  clear-space(logo("logo", width: sign-width), sign-width * ball-ratio),
  clear-space(logo("logo_text_path", width: full-width), full-width * sign-ratio * ball-ratio),
)
#v(6pt)
#grid(
  columns: (auto, 1fr),
  column-gutter: 6pt,
  align: horizon,
  x-marker(sign-width * ball-ratio), caption[X = średnica czerwonej kuli. Linia przerywana to granica pola ochronnego.],
)

== Minimalny rozmiar

Poniżej tych wymiarów detale znaku (oko pióra, prześwity między elementami) przestają być czytelne.

#table(
  columns: (1fr, 1fr, 1fr),
  stroke: none,
  inset: (x: 0pt, y: 6pt),
  table.hline(stroke: 0.5pt + luma(80%)),
  [*Wersja*], [*Druk (wysokość)*], [*Ekran (wysokość)*],
  table.hline(stroke: 0.5pt + luma(80%)),
  [Sygnet], [15 mm], [48 px],
  [Logo z napisem], [12 mm], [40 px],
  table.hline(stroke: 0.5pt + luma(80%)),
)

= Kolorystyka

Wartości HEX i RGB są wzorcowe. Wartości CMYK są orientacyjne: przed drukiem
uzgodnij je z drukarnią i sprawdź na próbnym wydruku.

#let palette = (
  ("Ciemna zieleń", rgb("#214214"), "znak smoka, napis"),
  ("Czerwień", rgb("#c40000"), "czapka krakuska"),
  ("Zieleń pióra", rgb("#648b15"), "pawie pióro"),
  ("Złoto", rgb("#c3ac02"), "oko pióra"),
  ("Indygo", rgb("#2a1487"), "oko pióra"),
)
#let percents(c) = c.components(alpha: false).map(v => str(int(calc.round(v / 1%)))).join(" ")
#let rgb-255(c) = c.components(alpha: false).map(v => str(int(calc.round(v / 100% * 255)))).join(" ")

#let swatch(name, c, usage, large: false) = block(width: 100%)[
  #block(width: 100%, height: if large { 4cm } else { 2.4cm }, fill: c, radius: 2pt)
  #text(weight: "bold", name) \
  #set text(size: 8.5pt)
  #grid(
    columns: (auto, 1fr),
    column-gutter: 6pt,
    row-gutter: 3pt,
    text(fill: gray)[HEX], upper(c.to-hex()),
    text(fill: gray)[RGB], rgb-255(c),
    text(fill: gray)[CMYK], percents(c.cmyk()),
    text(fill: gray)[W znaku], usage,
  )
]

== Kolory podstawowe

#grid(
  columns: (1fr, 1fr),
  column-gutter: 12pt,
  ..palette.slice(0, 2).map(k => swatch(..k, large: true)),
)

== Kolory uzupełniające

Występują tylko w znaku. Nie używaj ich samodzielnie jako kolorów klubowych.

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 12pt,
  ..palette.slice(2).map(k => swatch(..k)),
)

= Wersje kolorystyczne

== Pełny kolor

Wersja podstawowa. Stosuj ją tylko na białym lub bardzo jasnym, jednolitym tle.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  tile(height: 3.1cm, logo("logo_text_path", width: 62%)),
  tile(height: 3.1cm, bg: rgb("#f4f1ea"), border: false, logo("logo_text_path", width: 62%)),
)

== Wersja jednobarwna

Gdy tło jest ciemne, kolorowe lub gdy technika druku ogranicza liczbę kolorów
(haft, sitodruk, grawer, pieczątka), używaj wersji jednobarwnej. Może mieć
dowolny kolor, pod warunkiem że jest *jednolity* i wyraźnie kontrastuje z tłem.
Na ciemnym tle używaj wersji białej. Na tle wzorzystym lub zdjęciu jest
dozwolona, jeśli w skali szarości każdy fragment logo wyraźnie odcina się od
tła. W przeciwnym razie użyj białej plakietki.

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 8pt,
  row-gutter: 8pt,
  tile(height: 2.4cm, logo-mono(width: 80%)),
  tile(height: 2.4cm, logo-mono(color: green, width: 80%)),
  tile(height: 2.4cm, bg: rgb("#f4f1ea"), border: false, logo-mono(color: red, width: 80%)),
  tile(height: 2.4cm, bg: green, border: false, logo-mono(color: white, width: 80%)),
  tile(height: 2.4cm, bg: red, border: false, logo-mono(color: white, width: 80%)),
  tile(height: 2.4cm, bg: tiling(size: (8pt, 8pt), rect(width: 8pt, height: 8pt, fill: luma(10%), place(rect(width: 4pt, height: 8pt, fill: luma(17%))))), border: false, logo-mono(color: white, width: 80%)),
)

== Pełny kolor na białej plakietce

Gdy logo musi wystąpić w pełnym kolorze na ciemnym lub wzorzystym tle (np. obok
logo partnerów i sponsorów), umieść je na białej plakietce. Najpierw sprawdź,
czy nie wystarczy wersja biała.

- Plakietka jest prostokątem w czystej bieli, bez cieni, obrysów, przezroczystości i gradientów.
- Margines między logo a krawędzią plakietki wynosi co najmniej 2X.
- Rogi są proste albo zaokrąglone promieniem X/2.
- Pole ochronne liczy się od krawędzi plakietki.
- Plakietkę stosuje się tylko z wersją w pełnym kolorze.

#let plate(w) = {
  let x = w * sign-ratio * ball-ratio
  box(fill: white, inset: 2 * x, radius: x / 2, logo("logo_text_path", width: w))
}
#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  tile(height: 2.9cm, bg: green, border: false, plate(3.8cm)),
  tile(height: 2.9cm, bg: gradient.linear(..color.map.rainbow, angle: 30deg), border: false, plate(3.8cm)),
)

= Niedozwolone użycia

#let dont(body, label, bg: white) = block(width: 100%)[
  #block(
    width: 100%,
    height: 3.4cm,
    fill: bg,
    stroke: 0.5pt + luma(85%),
    radius: 2pt,
    clip: true,
    align(center + horizon, body),
  )
  #text(fill: red, weight: "bold")[×] #h(2pt) #caption(label)
]

// A silhouette copy filled and stroked in the outline color sits under the original.
// The viewBox is widened so the stroke isn't clipped; the minus sign is written
// explicitly because str() of a negative number yields U+2212, which breaks SVG.
#let outlined(color, thickness: 20, w) = {
  let hex = color.to-hex()
  let m = thickness
  let frame = (
    "viewBox=\"0 0 651.91724 308.73657\"": "viewBox=\"-" + str(m) + " -" + str(m) + " " + str(651.91724 + 2 * m) + " " + str(308.73657 + 2 * m) + "\"",
    "width=\"651.91724\"": "width=\"" + str(651.91724 + 2 * m) + "\"",
    "height=\"308.73657\"": "height=\"" + str(308.73657 + 2 * m) + "\"",
  )
  let stroke = ";stroke-linejoin:round;stroke:" + hex + ";stroke-width:"
  let under = frame + (
    // The sign sits in a group scaled by 4/3, the text does not.
    "stroke:none": stroke.slice(1) + str(thickness * 3 / 4),
    "style=\"fill:#214214\"": "style=\"fill:#214214" + stroke + str(thickness) + "\"",
  )
  for c in ("#214214", "#648b15", "#c3ac02", "#2a1487", "#c40000") { under.insert(c, hex) }
  box(width: w)[
    #logo("logo_text_path", replace: under, width: w)
    #place(top + left, logo("logo_text_path", replace: frame, width: w))
  ]
}
// logo.svg path ids: 14, 18 dragon; 24, 32 tassel and ball; 26, 28, 30 hat; 16, 20, 22 feather.
#let sign-without(ids) = image(
  bytes(read("assets/logo.svg").replace(
    regex("(id=\"path(?:" + ids + ")\"\\s+style=\"fill:)#[0-9a-f]{6}"),
    m => m.captures.at(0) + "none",
  )),
  format: "svg",
  height: 2.6cm,
)
#let w = 4cm
#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 10pt,
  row-gutter: 14pt,
  dont(scale(x: 135%, y: 85%, reflow: true, logo("logo_text_path", width: w * 0.7)))[Nie rozciągaj i nie ściskaj],
  dont(rotate(-12deg, reflow: true, logo("logo_text_path", width: w)))[Nie obracaj],
  dont(logo(
    "logo_text_path",
    width: w,
    replace: ("#c40000": "#1f6fd0", "#214214": "#7a2a8a"),
  ))[Nie zmieniaj kolorów],
  dont(
    bg: gradient.linear(..color.map.rainbow, angle: 30deg),
    logo("logo_text_path", width: w),
  )[Nie umieszczaj na wzorzystym tle],
  dont(stack(
    dir: ltr,
    spacing: 6pt,
    logo("logo", height: 1.9cm),
    align(horizon, text(font: "Libertinus Serif", style: "italic", size: 15pt, fill: green)[
      Krakowski \ Klub \ Chombo
    ]),
  ))[Nie zmieniaj fontu ani układu napisu],
  dont(bg: green, logo("logo_text_path", width: w))[Nie stawiaj pełnego koloru na ciemnym tle],
  dont(bg: green, outlined(white, w))[Nie dodawaj obrysu],
  dont(move(dx: -0.9cm, dy: 0.7cm, logo("logo_text_path", width: w * 1.3)))[Nie przycinaj logo],
  dont(
    bg: gradient.linear(..color.map.rainbow, angle: 30deg),
    logo-mono(color: white, width: w),
  )[Nie stawiaj na tle o zmiennej jasności],
  dont(image("examples/logo_low_quality.jpg", width: w))[Nie używaj plików niskiej jakości],
  dont(box(width: 100%, height: 100%)[
    #place(center + horizon, sign-without("16|20|22|26|28|30"))
    #place(center + horizon, dx: -0.6cm, dy: 0.2cm, rotate(-35deg, sign-without("14|18|24|32")))
  ])[Nie modyfikuj elementów logo],
  dont(logo("logo_text", dir: "examples", replace: (">Krakowski<": ">Krakoski<", ">Klub<": ">Club<", ">Chombo<": ">Combo<"), width: w))[Nie zmieniaj nazwy],
)

= Typografia

Napis w logo jest złożony krojem *Roboto Bold*. Napis jest częścią znaku, więc
zawsze używaj gotowych plików, a nie składaj go od nowa.

#block(inset: (y: 8pt))[
  #text(size: 40pt, weight: "bold", fill: green)[Roboto Bold] \
  #text(size: 16pt, weight: "bold")[
    AĄBCĆDEĘFGHIJKLŁMNŃOÓPRSŚTUWYZŹŻ \
    aąbcćdeęfghijklłmnńoóprsśtuwyzźż \
    0123456789
  ]
]

Roboto jest darmowy (licencja SIL Open Font License) i dostępny w Google Fonts.

= Przykłady zastosowań

#let u = 1cm / 33
#let tshirt(fill, print) = box(width: 200 * u, height: 210 * u)[
  #polygon(
    fill: fill,
    stroke: 0.5pt + luma(70%),
    (70 * u, 0pt), (85 * u, 12 * u), (100 * u, 15 * u), (115 * u, 12 * u),
    (130 * u, 0pt), (175 * u, 15 * u), (200 * u, 65 * u),
    (168 * u, 80 * u), (165 * u, 210 * u), (35 * u, 210 * u), (32 * u, 80 * u),
    (0pt, 65 * u), (25 * u, 15 * u),
  )
  #place(top + center, dy: 45 * u, print)
]

== Koszulki

#grid(
  columns: (1fr, 1fr),
  align: center,
  tshirt(white, logo("logo_text_path", width: 3cm)),
  tshirt(green, logo-mono(color: white, width: 3cm)),
  v(4pt), v(4pt),
  caption[Jasna koszulka: pełny kolor], caption[Ciemna koszulka: wersja biała],
)

== Avatary i ikony

Na kwadratowe i okrągłe pola (media społecznościowe, Discord, ikony aplikacji)
umieść sygnet w pełnym kolorze na białym tle. Wysokość sygnetu to 70% boku pola.
Sygnet jest przesunięty o X/2 w górę względem środka pola (korekta optyczna:
dolna część znaku jest wizualnie cięższa). Nie dodawaj obrysu
wokół znaku.

#let avatar(shape) = {
  let size = 2.6cm
  let h = size * 0.7
  let x = h * (217.16243 / 308.73657) * ball-ratio
  shape(
    width: size,
    height: size,
    fill: white,
    inset: 0pt,
    align(center + horizon, move(dy: -x / 2, logo("logo", height: h))),
  )
}
#grid(
  columns: (1fr, 1fr),
  column-gutter: 8pt,
  tile(height: 4cm, bg: rgb("#313338"), border: false, stack(
    dir: ltr,
    spacing: 1cm,
    avatar(circle.with()),
    avatar(rect.with(radius: 22%)),
  )),
  tile(height: 4cm, bg: rgb("#f0f2f5"), border: false, stack(
    dir: ltr,
    spacing: 1cm,
    avatar(circle.with(stroke: 0.5pt + luma(85%))),
    avatar(rect.with(radius: 22%, stroke: 0.5pt + luma(85%))),
  )),
)

== Identyfikator turniejowy

#align(center, block(
  width: 9cm,
  height: 5.5cm,
  breakable: false,
  radius: 3mm,
  stroke: 0.5pt + luma(75%),
  clip: true,
)[
  #place(top + left, dx: 5mm, dy: 5mm, logo("logo_text_path", height: 1.4cm))
  #place(horizon + left, dx: 5mm, dy: 4mm, text(size: 16pt, weight: "bold")[Imię Nazwisko])
  #place(bottom, block(width: 100%, height: 1.1cm, fill: green, inset: (x: 5mm), align(horizon, text(fill: white, size: 9pt, weight: "bold")[Nazwa turnieju · Kraków 2026])))
])

= Pliki

Wszystkie pliki znajdują się w katalogu `assets/`. Do druku i dalszej obróbki
używaj plików SVG, PNG tylko tam, gdzie wektor nie jest obsługiwany.

#table(
  columns: (auto, 1fr),
  stroke: none,
  inset: (x: 0pt, y: 5pt),
  column-gutter: 14pt,
  table.hline(stroke: 0.5pt + luma(80%)),
  [*Plik*], [*Wersja*],
  table.hline(stroke: 0.5pt + luma(80%)),
  `logo.svg`, [sygnet, pełny kolor (także `logo.png`)],
  `logo_mono.svg`, [sygnet, czarny],
  `logo_mono_white.svg`, [sygnet, biały],
  `logo_text_path.svg`, [logo z napisem, pełny kolor (także `logo_text_path.png`)],
  `logo_text_mono.svg`, [logo z napisem, czarne],
  `logo_text_mono_white.svg`, [logo z napisem, białe],
  `logo_text_path_en.svg`, [logo z napisem (EN), pełny kolor],
  `logo_text_mono_en.svg`, [logo z napisem (EN), czarne],
  `logo_text_mono_en_white.svg`, [logo z napisem (EN), białe],
  table.hline(stroke: 0.5pt + luma(80%)),
)
