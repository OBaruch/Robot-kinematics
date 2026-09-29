# Specification

> Status: **As-built (reverse-engineered)**. Part A describes what the original 2019 code does, written as requirements that the existing implementation meets (or does not meet). Part B specifies the 2026 repository reorganization. Related documents: [intent.md](intent.md), [plan.md](plan.md), [docs/code-overview.md](../docs/code-overview.md).

Legend for **Status**: ✅ met by the original code · ⚠️ met with caveats · ❌ not met (expected failure, documented only) · ❔ not verified.

Verification method: values were re-computed independently from the same formulas and inputs (MATLAB was not available). Plots were not rendered, so visual requirements are ❔.

---

## Part A — Original project (as built)

### Global constraints

| ID | Constraint | Source |
|---|---|---|
| C-1 | Language: MATLAB; core functions only, no toolboxes. | Code |
| C-2 | All input data is hard-coded; there is no file or user input. | Code |
| C-3 | Output is printed to the Command Window and/or drawn in a figure. | Code |
| C-4 | Scripts are run with their own folder as the current folder. | Same-folder function calls |

### FR-1 Matrix product by loops — `src/plot-points/Act2PARTE1.m`

| ID | Requirement | Acceptance criterion | Status |
|---|---|---|---|
| FR-1.1 | Compute `c = a·b` with explicit nested loops. | `c = [29 37 45; 44 52 60; 14 13 12]` | ✅ |

### FR-2 2D transformations — `src/plot-points/Act2PARTE2.m`

| ID | Requirement | Acceptance criterion | Status |
|---|---|---|---|
| FR-2.1 | Scale points by (3, 2). | p1→(3,2), p2→(6,2), p3→(4.5,4) | ✅ |
| FR-2.2 | Rotate points by π about the origin. | p1→(−1,−1), p2→(−2,−1), p3→(−1.5,−2) | ✅ |
| FR-2.3 | Translate points by (4, 8). | p1→(5,9), p2→(6,9), p3→(5.5,10) | ✅ |
| FR-2.4 | Plot original / scaled / rotated / translated points in black / red / green / blue. | Figure shows 12 markers | ❔ (plotted on z = 1 with `plot3`) |

### FR-3 Axis–angle rotation — `src/rotation/`

| ID | Requirement | Acceptance criterion | Status |
|---|---|---|---|
| FR-3.1 | `rotacionRodirgues(th,w)` returns the Rodrigues rotation matrix. | For `th=π/4`, `w=[1 0 0]'`: `[1 0 0; 0 .7071 −.7071; 0 .7071 .7071]` | ✅ (unit `w` assumed) |
| FR-3.2 | `rotacionCuaternion(th,w)` returns the same matrix via a unit quaternion. | Same matrix as FR-3.1 | ✅ (unit `w` assumed) |
| FR-3.3 | `Actividad3.m` computes both matrices. | `R1` equals `R2` in the workspace | ✅ |

### FR-4 Quaternion composition — `src/quaternions/ActExtra1.m`

| ID | Requirement | Acceptance criterion | Status |
|---|---|---|---|
| FR-4.1 | Rotation matrices of q1 (π/2 about y) and q2 (π/4 about x). | Printed | ✅ |
| FR-4.2 | Quaternion product q1·q2 and its rotation matrix. | `[0 .7071 .7071; 0 .7071 −.7071; −1 0 0]` | ✅ |
| FR-4.3 | Show equality with `R(q1)·R(q2)`. | Same matrix; prints `SON IGUALES` | ✅ |

### FR-5 Reference frames and points — `src/reference-frames/`

| ID | Requirement | Acceptance criterion | Status |
|---|---|---|---|
| FR-5.1 | Draw a frame from a 4×4 transform (`Dibujar_Sistema_Referencia_3D`). | RGB axes, origin dot, label | ❔ |
| FR-5.2 | Draw a point (`Dibujar_Punto_3D`). | Blue `x` + red `o` | ❔ |
| FR-5.3 | Compute `T_cd = T_bc⁻¹·T_ab⁻¹·T_ad` (`Actividad4SistemasDeReferencia.m`). | `[−1 0 0 6; 0 0 1 2; 0 1 0 −2; 0 0 0 1]` | ✅ |
| FR-5.4 | Compute `T_ac = T_ab·T_bc`. | `[0 0 −1 4; −1 0 0 0; 0 1 0 1; 0 0 0 1]` | ✅ |
| FR-5.5 | Express `p_b = [0 −2 0]` in frames a, b, c, d. | a:(0,2,2) b:(0,−2,0) c:(−2,1,4) d:(8,6,−1) | ✅ |
| FR-5.6 | Build transforms from `Rx`,`Ry`,`Rz` and translations and draw frames a–d (`Actividad4SistemasDeReferenciaYPuntos.m`). | Four frames drawn | ❌ `Tinv` concatenation error expected before drawing |

### FR-6 DH forward kinematics — `src/transformation-matrix/MaatricesDeTransformacion.m`

| ID | Requirement | Acceptance criterion | Status |
|---|---|---|---|
| FR-6.1 | Build `T01…T34` from a standard DH table. | Four 4×4 matrices printed | ✅ |
| FR-6.2 | Compute `T04 = T01·T12·T23·T34`. | `[0 0 1 .8828; 0 −1 0 0; 1 0 0 .7828; 0 0 0 1]` | ✅ |

### Non-functional characteristics (observed)

- No input validation, no error handling, no tests **[Confirmed]**.
- Identifiers and comments in Spanish; CRLF line endings **[Confirmed]**.
- Known defects are listed in [docs/possible-improvements.md](../docs/possible-improvements.md).

---

## Part B — Repository modernization (2026)

### Requirements

| ID | Requirement |
|---|---|
| RR-1 | Every original `.m` file keeps its exact content (same git blob hash). |
| RR-2 | Every original `.m` file keeps its file name (MATLAB function/file name pairing). |
| RR-3 | Files that call each other stay in the same folder. |
| RR-4 | Source code is under `src/`, documentation under `docs/`, SDLC artifacts under `specs/`. |
| RR-5 | A `README.md` explains overview, context, structure, technologies, how it works, inputs/outputs, how to run, and includes a historical note. |
| RR-6 | Context statements are tagged Confirmed / Inferred / Unknown; nothing is invented. |
| RR-7 | The mapping from original to new paths is documented. |
| RR-8 | Defects and improvements are documented separately and explicitly marked as not applied. |
| RR-9 | No build, CI, container, test or package tooling is added. |
| RR-10 | `LICENSE` is preserved unchanged. |
| RR-11 | Git history of the moved files is preserved (moves done with `git mv`). |
| RR-12 | All documentation is written in English; all links between Markdown files are relative. |

### Acceptance checks

```bash
# RR-1, RR-2, RR-11: only 100% renames for .m files
git diff -M --summary origin/main -- '*.m'        # every line: "rename ... (100%)"

# RR-1: no content change
git diff -M --stat origin/main -- '*.m'           # 0 insertions, 0 deletions

# RR-10
git diff --quiet origin/main -- LICENSE && echo "LICENSE unchanged"
```
