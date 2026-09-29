# Robot Kinematics — MATLAB Coursework Exercises

A collection of short MATLAB scripts and functions covering the mathematical foundations of robot kinematics: matrix operations, 2D homogeneous transformations, 3D rotation matrices (Rodrigues' formula and unit quaternions), composition of reference frames with homogeneous transformation matrices, and forward kinematics using Denavit–Hartenberg (DH) parameters.

> **Original implementation.** This repository preserves the original implementation of the project. The source code has intentionally not been refactored or modernized in order to retain the historical context and original development approach. The source code represents the original implementation developed during my university studies.

---

## Project Context

| Item | Value | Evidence level |
|---|---|---|
| Project origin | **Coursework / Assignment** (university robotics course) | Inferred, strong evidence |
| Author | Omar Baruch Morón López (Baruch Lopez) | Confirmed (`src/quaternions/ActExtra1.m` header, `LICENSE`) |
| Date of work | Around January 2019 | Confirmed for one file (`ActExtra1.m` is dated *29/enero/2019*) |
| Uploaded to GitHub | 20 February 2021 | Confirmed (git history) |
| University / course name | Not stated | Unknown |
| Assignment statements | Not included in the repository | Unknown |
| Language of code and comments | Spanish | Confirmed |

Why *coursework*: the files are named after numbered activities (`Act2PARTE1`, `Act2PARTE2`, `Actividad3`, `Actividad4…`, `ActExtra1` = "extra activity 1"), one header contains the author's name, a student ID number and a date, and the topics follow the typical order of an introductory robotics course. No assignment PDF, report or course name is present, so the exact course and institution cannot be determined. See [docs/project-context.md](docs/project-context.md).

## Problem Statement

Each script solves one exercise on the mathematics used to describe the position and orientation of robot links:

- How to multiply matrices by hand (triple loop) and apply scaling, rotation and translation to points.
- How to build a rotation matrix from an axis and an angle, using two equivalent formulations.
- How to compose rotations with quaternions and show that it matches composing rotation matrices.
- How to chain and invert homogeneous transformations between several reference frames and express a point in each of them.
- How to compute the forward kinematics of a serial manipulator from a DH parameter table.

## Objective

Inferred: to practice and demonstrate, numerically and graphically, the core transformations of robot kinematics as part of a course. No written objective is included in the repository.

## Repository Structure

```
Robot-kinematics/
├── README.md                 Project overview (this file)
├── LICENSE                   MIT License (original, 2021)
├── AGENTS.md                 Contribution rules for humans and automated agents
├── .gitignore                MATLAB/Octave temporary files
├── src/                      ORIGINAL MATLAB code (unchanged)
│   ├── plot-points/          Activity 2 — matrix product and 2D transformations
│   ├── rotation/             Activity 3 — Rodrigues and quaternion rotation functions
│   ├── quaternions/          Extra activity 1 — quaternion composition
│   ├── reference-frames/     Activity 4 — reference frames, points and plotting helpers
│   └── transformation-matrix/ DH-based forward kinematics
├── docs/                     Documentation written during the reorganization
│   ├── project-context.md
│   ├── code-overview.md
│   ├── theory.md
│   └── possible-improvements.md
└── specs/                    Intent, specification and plan for this repository
    ├── intent.md
    ├── spec.md
    └── plan.md
```

The folders under `src/` were renamed from the original ones (`Plot Points`, `Rotation`, `Quaternions`, `Reference Points`, `Tranformation Matrix`). File names and file contents were **not** changed. The full mapping is in [docs/project-context.md](docs/project-context.md#original-layout-and-mapping).

## Original Implementation

All `.m` files under `src/` are byte-for-byte identical to the files uploaded in 2021 (same git blobs, original CRLF line endings, Spanish identifiers and comments, original typos such as `rotacionRodirgues` and `MaatricesDeTransformacion`). Known defects are documented, **not fixed**, in [docs/possible-improvements.md](docs/possible-improvements.md).

## Technologies

- **MATLAB** (`.m` scripts, local functions in separate files, anonymous functions, `plot3`, `line`, `text`, `inv`, `cross`) — confirmed.
- The MATLAB version used originally is unknown.
- GNU Octave compatibility is plausible for most scripts because only core functions are used, but it has not been verified.

No toolboxes, external libraries or data files are used.

## How It Works

| Module | Entry point | What it does |
|---|---|---|
| `plot-points` | `Act2PARTE1.m` | Multiplies two 3×3 matrices using three nested loops. |
| `plot-points` | `Act2PARTE2.m` | Applies scaling, rotation (π) and translation matrices in 2D homogeneous coordinates to three points and plots the results in different colors. |
| `rotation` | `Actividad3.m` | Calls `rotacionRodirgues(th,w)` and `rotacionCuaternion(th,w)` to build the same rotation (π/4 about x) in two ways. |
| `quaternions` | `ActExtra1.m` | Builds two quaternions, multiplies them and shows that the resulting rotation matrix equals the product of the individual rotation matrices. |
| `reference-frames` | `Actividad4SistemasDeReferencia.m` | Given `T_ab`, `T_bc`, `T_ad`, computes `T_cd` and `T_ac`, draws frames a–d and a point, and prints the point's coordinates in every frame. |
| `reference-frames` | `Actividad4SistemasDeReferenciaYPuntos.m` | Builds transforms from elementary rotations `Rx`, `Ry`, `Rz` plus translations, then draws the frames. |
| `transformation-matrix` | `MaatricesDeTransformacion.m` | Builds the four link transforms from a DH table and multiplies them to obtain `T04` (forward kinematics). |

A per-file description, the expected numeric results and the dependencies between files are in [docs/code-overview.md](docs/code-overview.md). The underlying math is summarized in [docs/theory.md](docs/theory.md).

## Inputs and Outputs

- **Inputs:** all values are hard-coded inside each script. There are no input files, prompts or parameters.
- **Outputs:** matrices printed to the MATLAB Command Window, and 3D figures (frames, axes and points) for the plotting scripts. No output files are written, and no historical outputs or screenshots are stored in the repository.

## Running the Project

Requirements: a MATLAB installation (version unknown).

Every script must be run **from its own folder**, because the scripts call helper functions that live in the same folder:

```matlab
cd src/rotation
Actividad3              % uses rotacionRodirgues.m and rotacionCuaternion.m

cd ../reference-frames
Actividad4SistemasDeReferencia   % uses Dibujar_Sistema_Referencia_3D.m and Dibujar_Punto_3D.m
```

The other scripts are self-contained. Several scripts begin with `clear` / `clear all` / `close all`, which clear the workspace and close figures.

Known caveat (from static reading of the code, not from execution): `Actividad4SistemasDeReferenciaYPuntos.m` is expected to stop with a matrix-dimension error at the line that computes `T_cd`, because of its `Tinv` helper. See [docs/possible-improvements.md](docs/possible-improvements.md).

## Documentation

- [Project context](docs/project-context.md) — origin, evidence, timeline, original layout.
- [Code overview](docs/code-overview.md) — what each file does, dependencies, expected results.
- [Theory](docs/theory.md) — rotations, quaternions, homogeneous transforms, DH convention.
- [Possible improvements](docs/possible-improvements.md) — defects and ideas, deliberately **not** applied.
- [Intent](specs/intent.md), [Specification](specs/spec.md), [Plan](specs/plan.md) — reverse-engineered SDLC artifacts for the project and this reorganization.

## Historical Note

This repository was later reorganized and documented to improve readability and preserve the historical context of the original project. The original source code remains unchanged.

## License

[MIT](LICENSE) © 2021 Baruch Lopez
