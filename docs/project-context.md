# Project Context

This document records what can be established about the origin of this repository, and how sure each statement is.

Evidence levels used throughout the documentation:

- **Confirmed** — stated directly in a file or in the git history.
- **Inferred** — a reasonable conclusion drawn from the available files, but not stated anywhere.
- **Unknown** — the repository does not contain enough information to decide.

## Classification

**Project origin: Coursework / Assignment** (Inferred, strong evidence).

| Evidence | Source | Level |
|---|---|---|
| File names refer to numbered activities: `Act2PARTE1`, `Act2PARTE2` (activity 2, parts 1 and 2), `Actividad3`, `Actividad4SistemasDeReferencia`, `Actividad4SistemasDeReferenciaYPuntos`, `ActExtra1` (extra activity 1). | File names | Confirmed |
| Header `%OMAR BARUCH MORON LOPEZ 213605572 29/enero/2019` — an author name, a 9-digit number that looks like a student ID, and a date. This is the usual way students label submitted work. | `src/quaternions/ActExtra1.m` | Confirmed (content); Inferred (meaning of the number) |
| Topics follow the usual order of an introductory robotics course: matrix operations → 2D transforms → 3D rotations → quaternions → reference frames → Denavit–Hartenberg forward kinematics. | Code | Inferred |
| The repository is named *Robot-kinematics*. | GitHub repository name | Confirmed |
| The last line of `ActExtra1.m` prints `SON IGUALES` ("they are equal"), i.e. the script is written to prove a statement for an exercise. | Code | Confirmed (content); Inferred (purpose) |

## What is known

| Topic | Value | Level |
|---|---|---|
| Author | Omar Baruch Morón López, published as Baruch Lopez | Confirmed |
| Date the code was written | At least one file on 29 January 2019; the others are undated | Confirmed / Unknown |
| Date published | 20 February 2021 (two commits: "Initial commit" with `LICENSE`, then "Add files via upload" with all `.m` files) | Confirmed |
| License | MIT, © 2021 Baruch Lopez | Confirmed |
| Language | MATLAB | Confirmed |
| Natural language of identifiers and comments | Spanish | Confirmed |
| Institution, course name, professor, semester | Not present | Unknown |
| Assignment statements, rubric, report or delivered PDFs | Not present | Unknown |
| MATLAB version used | Not present | Unknown |
| Order in which the activities were done | Activity numbers suggest 2 → 3 → 4; the position of "extra 1" and of the DH script is not stated | Inferred / Unknown |

Because no assignment document exists, no `assignment.md` has been created: the original requirements cannot be reconstructed with confidence. The per-exercise goals given in [code-overview.md](code-overview.md) are inferred from the code itself.

## Scope of the original work

- Short standalone scripts, each solving one exercise with hard-coded values.
- A few reusable functions: two rotation-matrix builders and two 3D plotting helpers.
- No data files, no tests, no build system, no GUI, no toolboxes.
- No outputs (figures, logs, screenshots) were committed.

## Original layout and mapping

The files were uploaded in 2021 in five top-level folders. During the reorganization they were moved under `src/` with `git mv`. **Only the folder names changed; the file names and file contents did not.** File names were kept because in MATLAB a function file must have the same name as the function it defines (for example `rotacionRodirgues.m` defines `rotacionRodirgues`), and scripts call these functions by name.

| Original path | Current path |
|---|---|
| `Plot Points/Act2PARTE1.m` | `src/plot-points/Act2PARTE1.m` |
| `Plot Points/Act2PARTE2.m` | `src/plot-points/Act2PARTE2.m` |
| `Rotation/Actividad3.m` | `src/rotation/Actividad3.m` |
| `Rotation/rotacionRodirgues.m` | `src/rotation/rotacionRodirgues.m` |
| `Rotation/rotacionCuaternion.m` | `src/rotation/rotacionCuaternion.m` |
| `Quaternions/ActExtra1.m` | `src/quaternions/ActExtra1.m` |
| `Reference Points/Actividad4SistemasDeReferencia.m` | `src/reference-frames/Actividad4SistemasDeReferencia.m` |
| `Reference Points/Actividad4SistemasDeReferenciaYPuntos.m` | `src/reference-frames/Actividad4SistemasDeReferenciaYPuntos.m` |
| `Reference Points/Dibujar_Punto_3D.m` | `src/reference-frames/Dibujar_Punto_3D.m` |
| `Reference Points/Dibujar_Sistema_Referencia_3D.m` | `src/reference-frames/Dibujar_Sistema_Referencia_3D.m` |
| `Tranformation Matrix/MaatricesDeTransformacion.m` | `src/transformation-matrix/MaatricesDeTransformacion.m` |

Notes on the folder names:

- `Plot Points` contains a matrix-multiplication exercise and a 2D transformation exercise that plots points. The new name `plot-points` keeps the original meaning.
- `Reference Points` became `reference-frames` because its scripts are about *sistemas de referencia* (reference frames); the points are secondary.
- `Tranformation Matrix` (original typo) became `transformation-matrix`.

## Contradictions and oddities

These are recorded as they are, without deciding which version is right:

- `Act2PARTE2.m` starts with the comment `%%%%%%%%%%%%%Parte1` even though the file is part 2.
- In `Actividad4SistemasDeReferencia.m`, the message printed before computing `T_ac` says `Se encuentra T_cd ... T_ab*T_bc` (mentions `T_cd` but computes `T_ac`). The first message says `Tinv(...)` while the code uses `inv(...)`.
- In `Actividad4SistemasDeReferenciaYPuntos.m`, the message says `Rinv(...)` but the code calls `Tinv(...)`.
- The anonymous function in `MaatricesDeTransformacion.m` is called `TRevoluta` (revolute joint), but the DH table also has non-zero `d` values in rows 1 and 4. Which joints were meant to be revolute or prismatic cannot be determined.
- The two `Actividad4…` scripts use different transforms `T_ab`, `T_bc`, `T_ad`. They appear to be two separate exercises (or two versions of one) rather than one program.
