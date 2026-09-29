# Plan

> Implementation plan for the repository modernization specified in [spec.md](spec.md) Part B, based on [intent.md](intent.md). The original 2019 project had no written plan; its reconstructed build order is in section 1 for reference.

## 1. Reconstructed build order of the original project (2019)

Inferred from the activity numbers in the file names. Only `ActExtra1.m` has a date.

| Step | Activity | Files | Evidence |
|---|---|---|---|
| 1 | Activity 2 — matrix product, 2D transforms | `src/plot-points/` | File names `Act2PARTE1/2` |
| 2 | Activity 3 — axis–angle rotation functions | `src/rotation/` | File name `Actividad3` |
| ? | Extra activity 1 — quaternion composition | `src/quaternions/` | Dated 29 Jan 2019; position relative to others unknown |
| 3 | Activity 4 — reference frames and points | `src/reference-frames/` | File names `Actividad4…` |
| ? | DH forward kinematics | `src/transformation-matrix/` | No number; the topic usually comes last in a course |

## 2. Modernization plan (2026)

### Approach

Documentation-only change on a feature branch, delivered through a pull request. The work is done in small commits, each one reviewable on its own:

1. **Restructure** — move files, no content change.
2. **Document** — README, `docs/`, `.gitignore`, `AGENTS.md`.
3. **Specify** — `specs/intent.md`, `specs/spec.md`, `specs/plan.md`.

### Tasks

| # | Task | Output | Spec | Status |
|---|---|---|---|---|
| T-1 | Inventory every file; read all code and git history; look for PDFs, Word, images, data or outputs (none found). | Findings in `docs/project-context.md` | RR-6 | ✅ Done |
| T-2 | Classify the project origin with evidence levels. | Coursework / Assignment (Inferred) | RR-6 | ✅ Done |
| T-3 | Record the blob hashes of all `.m` files before moving them. | Baseline | RR-1 | ✅ Done |
| T-4 | `git mv` the five original folders into `src/` with kebab-case names; keep file names. | `src/plot-points`, `src/rotation`, `src/quaternions`, `src/reference-frames`, `src/transformation-matrix` | RR-2, RR-3, RR-4, RR-11 | ✅ Done |
| T-5 | Compare blob hashes after the move. | Identical set | RR-1 | ✅ Done |
| T-6 | Re-compute the expected numeric results independently, to document them. | Values in `docs/code-overview.md` and `spec.md` | — | ✅ Done |
| T-7 | Write `README.md`. | README | RR-5 | ✅ Done |
| T-8 | Write `docs/project-context.md` (evidence, timeline, path mapping, contradictions). | Doc | RR-6, RR-7 | ✅ Done |
| T-9 | Write `docs/code-overview.md` (per-file behavior, dependency map, expected results). | Doc | RR-5 | ✅ Done |
| T-10 | Write `docs/theory.md` (math used by the scripts). | Doc | RR-5 | ✅ Done |
| T-11 | Write `docs/possible-improvements.md`, marked as not applied. | Doc | RR-8 | ✅ Done |
| T-12 | Add a MATLAB/Octave `.gitignore`. | `.gitignore` | RR-9 (no tooling, ignore rules only) | ✅ Done |
| T-13 | Add `AGENTS.md` with the preservation rules and verification commands. | `AGENTS.md` | RR-1 | ✅ Done |
| T-14 | Write `specs/intent.md`, `specs/spec.md`, `specs/plan.md`. | Specs | — | ✅ Done |
| T-15 | Run the acceptance checks from `spec.md` Part B and check all relative links. | Clean result | RR-1, RR-10, RR-12 | ✅ Done |
| T-16 | Push the branch and open a pull request. | PR | — | ✅ Done |

### Decisions

| Decision | Reason |
|---|---|
| Keep the original `.m` file names, including typos. | MATLAB requires a function file to be named like its function; renaming would require editing code. |
| Rename only folders. | Removes spaces and the `Tranformation` typo without touching any file. |
| Keep each exercise group in its own folder under `src/`. | Scripts call helper functions from their own folder. |
| No `data/`, `assets/`, `examples/`, `notebooks/` or `docs/original/` folders. | The repository has no data, images, examples, notebooks or original documents. |
| No `assignment.md` or `architecture.md`. | No assignment statement exists; the code is too small to have an architecture beyond the dependency map in `code-overview.md`. |
| No `.gitattributes`. | Could re-normalize the original CRLF line endings. |
| Expected results computed outside MATLAB and labelled as such. | MATLAB was not available; the results must not look like captured output. |

### Risks

| Risk | Mitigation |
|---|---|
| Accidental change to an original file (editor, line-ending normalization). | Blob-hash comparison and `git diff -M --summary` check (T-5, T-15); rule 1 in `AGENTS.md`. |
| Presenting inferences as facts. | Evidence levels on every context statement. |
| Moving a helper away from its caller. | Folders moved as whole units (T-4). |

## 3. Future work (not planned)

Anything in [docs/possible-improvements.md](../docs/possible-improvements.md). If it is ever done, it needs its own intent/spec/plan update and must not modify `src/`.
