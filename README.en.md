# Sky Xcode Dark Theme

`Sky Xcode Dark Theme` is a VS Code port of the IntelliJ **Xcode-Dark** theme, optimized for consistent Java/Spring and modern frontend token coloring.

## Baseline Sources

- UI and syntax palette baseline: `images/xcode-dark-palette.svg`
- VS Code theme file: `themes/sky-xcode-dark-color-theme.json`

Dark themes reuse the SVG role colors whenever possible. Adapted colors stay in the same hue family when additional contrast or VS Code-specific states are required.

## Current Color Strategy (Java/Spring)

- Keywords/annotations: bold Xcode pink (`#FF78B2`)
- Strings: coral (`#FF806C`)
- Numbers/characters: soft yellow (`#DACA77`)
- Methods/functions: teal (`#75C3B3`)
- Local variables and parameters: white (`#FCFCFC`)
- Global/member variables and properties: purple (`#B37EEE`)
- Classes/interfaces/enums/type references/type parameters: cyan-blue (`#49B0CE`)

## Current Color Strategy (Vue/React/Frontend)

- Vue/React components, inherited classes, and type references use the type cyan-blue.
- JS/TS variables and `const` bindings keep the same variable color; italics distinguish readonly bindings.
- Object property declarations, destructuring keys, and member access use the member purple.
- Enum members use the constant orange with italics.
- Module names and CSS/SCSS namespace prefixes use the namespace gold.
- HTML/Vue/JSX tags, attributes, and string values retain tag pink, attribute brown, and string coral.
- CSS custom-property declarations and `var()` references keep the same variable color.

## Completed Optimizations Summary

- Added Java/Spring-focused token rules (annotations, packages/imports, local/member variable behavior).
- Fixed inconsistent variable coloring by narrowing overly broad scopes and adding Java local-variable fallback rules.
- Removed risky broad method-call coloring (`meta.function-call`, `meta.method-call`) to avoid color bleed.
- Unified class-related coloring (class/interface/enum/declaration/reference/defaultLibrary) into one color family.
- Unified generic type parameters (`typeParameter`) with class/type color for cleaner `Map<String, Object>` readability.
- Updated semantic token mappings to reduce declaration/use mismatch.
- Added the Vue `component` semantic token and matching Vue/React TextMate fallbacks.
- Unified JS/TS object properties, `const` bindings, enum members, inherited classes, and module names.
- Used exclusion-based object-key selectors to avoid coloring methods, string keys, numeric keys, or separators.

## Key Development Rules

- Prefer semantic tokens first; use TextMate rules as fallback.
- Avoid broad meta scopes that can color entire expressions (for example `meta.method-call`).
- Keep declaration and usage consistent for the same symbol category.
- Validate at least these regression cases:
  1. Java method signatures, generic types, arrays, fields, annotations, and constructors
  2. Vue/React component declarations, imports, and template/JSX usage
  3. JS/TS `const` declarations and repeated references
  4. Object-literal, destructuring, and member-access property names
  5. TypeScript enum declarations and references
  6. HTML/Vue/JSX tags, attributes, and embedded expressions
  7. CSS/SCSS custom-property declarations and `var()` references

## Recommended Debug Workflow

1. In VS Code, run `Developer: Inspect Editor Tokens and Scopes`.
2. Capture token type/modifier/language and TextMate scope for the problematic symbol.
3. Adjust `semanticTokenColors` first, then minimal `tokenColors` fallback.
4. Rebuild VSIX and re-test in the same code snippet.

## Build and Package

Run from repository root:

```powershell
powershell -ExecutionPolicy Bypass -File build-vsix.ps1
```

Output:

- `vscode-xcode-dark-theme.vsix`

## Installation

1. In VS Code, run `Extensions: Install from VSIX...`
2. Select `sky-xcode-dark-theme.vsix`
3. Activate `Sky Xcode Dark Theme`

## Credits

- Ported and optimized for VS Code usage

## License

MIT
