# Krakow Chombo Club Brand Book

[![Build Status](https://github.com/riichi/brand-book/workflows/Build%20PDF/badge.svg)](https://github.com/riichi/brand-book/actions/workflows/build.yml)

Brand book (in Polish) of Krakowski Klub Chombo. The logo files are in `assets/`.

## How to build the document locally

1. Install [typst](https://typst.app/),
2. Run `typst compile --font-path fonts ksiega.typ` - the output file will be named `ksiega.pdf`.

Typical tasks are also available as [just](https://just.systems/) recipes:
- `just build` - compile the document
- `just watch` - watch and auto-rebuild on changes
- `just clean` - remove generated PDF
- `just lint` - run [prek](https://prek.j178.dev/) checks
- `just install-hooks` - install prek hooks

## Publishing a release

Push a tag named `release-*`. The release will contain `ksiega.pdf` and `ksiega-znaku.zip` (the PDF, `assets/` and `LICENSE`).

## License

The logo is not openly licensed; the rest of the repository is CC0. See [LICENSE](LICENSE).
