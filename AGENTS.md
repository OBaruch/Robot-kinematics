# AGENTS.md

Working rules for anyone who changes this repository, whether a person or an automated coding agent. Read [specs/intent.md](specs/intent.md) first.

## Non-negotiable rules

1. **Do not edit anything under `src/`.** The `.m` files are the original 2019 coursework and are kept byte-for-byte, including CRLF line endings, Spanish identifiers, typos and known bugs.
   - Do not reformat, rename, fix, optimize or "modernize" them.
   - Do not add `.gitattributes` rules or tooling that would re-normalize their line endings.
   - Moving a whole folder is allowed only with `git mv`, and only if every function file stays in the same folder as the scripts that call it.
2. **Do not invent context.** Mark every statement about the project's origin as *Confirmed*, *Inferred* or *Unknown* (see [docs/project-context.md](docs/project-context.md)).
3. **Record defects, do not fix them.** New findings go into [docs/possible-improvements.md](docs/possible-improvements.md).
4. **No unnecessary infrastructure.** No CI, containers, package managers, linters or build tools unless a spec in `specs/` asks for them.
5. Any modernized code, if it is ever added, lives in a new, clearly labelled folder (for example `modern/`), never in `src/`.

## Workflow

Changes follow the order *intent → spec → plan → implement → verify*:

1. Check that the change fits [specs/intent.md](specs/intent.md).
2. Update [specs/spec.md](specs/spec.md) if the change affects requirements or acceptance criteria.
3. Add the tasks to [specs/plan.md](specs/plan.md).
4. Implement them on a feature branch and open a pull request.
5. Verify before merging:

```bash
# Every line must be empty or start with R100 (pure rename).
# Any M, A, D or R<100 line means an original file was changed.
git diff -M --name-status origin/main -- '*.m'

# Must report 0 insertions and 0 deletions.
git diff -M --stat origin/main -- '*.m' | tail -1
```

## Repository map

| Path | Purpose | May be edited? |
|---|---|---|
| `src/` | Original MATLAB code | **No** |
| `docs/` | Documentation written during the reorganization | Yes |
| `specs/` | Intent, specification and plan | Yes |
| `README.md`, `AGENTS.md`, `.gitignore` | Repository metadata | Yes |
| `LICENSE` | Original MIT license (2021) | No |
