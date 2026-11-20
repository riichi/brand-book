# Build the PDF document
build:
    typst compile --font-path fonts ksiega.typ

# Watch and auto-rebuild on changes
watch:
    typst watch --font-path fonts ksiega.typ

# Remove generated PDF
clean:
    rm -f ksiega.pdf

# Run pre-commit checks
lint:
    prek run --all-files

# Install pre-commit hooks
install-hooks:
    prek install
