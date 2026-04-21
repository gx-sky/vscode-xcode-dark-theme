# Sky Xcode Dark Theme

`Sky Xcode Dark Theme` is a VS Code port of the IntelliJ **Xcode-Dark** theme, with an emphasis on Java/Spring readability and consistent token coloring.

## Baseline Sources

- UI baseline: `resources/Xcode-Dark.theme.json`
- Editor/token baseline: `resources/Xcode-Dark.xml`
- VS Code theme file: `themes/sky-xcode-dark-color-theme.json`

## Current Color Strategy (Java/Spring)

- Keywords: pink + bold (`#F97BB0`)
- Strings: coral (`#FF806C`)
- Methods/functions: teal (`#75C2B3`)
- Local variables: white (`#FCFCFC`)
- Global/member variables: cyan-blue (`#49B0CE`)
- Classes/interfaces/enums/type references/type parameters: unified cyan-blue (`#49B0CE`)
- Annotations/decorators: pink family (`#FF78B2`, with layered Java annotation tuning)

## Completed Optimizations Summary

- Added Java/Spring-focused token rules (annotations, packages/imports, local/member variable behavior).
- Fixed inconsistent variable coloring by narrowing overly broad scopes and adding Java local-variable fallback rules.
- Removed risky broad method-call coloring (`meta.function-call`, `meta.method-call`) to avoid color bleed.
- Unified class-related coloring (class/interface/enum/declaration/reference/defaultLibrary) into one color family.
- Unified generic type parameters (`typeParameter`) with class/type color for cleaner `Map<String, Object>` readability.
- Updated semantic token mappings to reduce declaration/use mismatch.

## Key Development Rules

- Prefer semantic tokens first; use TextMate rules as fallback.
- Avoid broad meta scopes that can color entire expressions (for example `meta.method-call`).
- Keep declaration and usage consistent for the same symbol category.
- For Java tuning, validate at least these cases:
  1. Method signature + generic return type
  2. Local variable declaration + repeated usage
  3. Member/global field declaration + usage
  4. Annotation-heavy Spring service class

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
