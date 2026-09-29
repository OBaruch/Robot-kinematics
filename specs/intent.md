# Intent

> Status: **Reconstructed**. The project was built in 2019 without written intent/spec/plan documents. This file was written afterwards from the evidence in the repository (see [docs/project-context.md](../docs/project-context.md)). Statements are tagged **[Confirmed]**, **[Inferred]** or **[Unknown]**.

## 1. Original intent of the project (2019)

### Why it existed

To complete the practical exercises of a university robotics course on the mathematics of robot kinematics **[Inferred]**. The files are numbered activities (`Act2`, `Actividad3`, `Actividad4`, `ActExtra1`) **[Confirmed]**, one file is signed with a student name, ID number and the date 29 January 2019 **[Confirmed]**. The institution and course name are **[Unknown]**.

### Who it was for

- The course instructor, who received and graded the activities **[Inferred]**.
- The author, as practice for the course topics **[Inferred]**.

### Desired outcome

For each activity, a MATLAB script that computes the requested result with hard-coded data and, where useful, shows it graphically **[Inferred from the code]**:

1. Multiply matrices manually and apply 2D scaling / rotation / translation to points.
2. Build a rotation matrix from an axis and an angle in two equivalent ways (Rodrigues, quaternion).
3. Show that composing quaternions is equivalent to composing rotation matrices.
4. Chain and invert homogeneous transforms between frames and express a point in each frame, with a 3D drawing.
5. Compute the forward kinematics of a manipulator from a Denavit–Hartenberg table.

### Out of scope (original)

User input, reusable library design, tests, error handling, performance, documentation for third parties **[Inferred — none of these exist in the code]**.

## 2. Intent of the 2026 repository modernization

### Why

The repository was uploaded in 2021 as five loose folders of MATLAB files, without a README, with typos in folder names and with no explanation of what each exercise did. It is now kept as part of a technical portfolio, so a reader must understand it quickly.

### Desired outcome

- A clear, navigable repository that explains the context, the math and every file.
- The original code preserved **exactly**, so the repository stays an honest record of the 2019 work.
- A clear separation between the original implementation (`src/`) and the documentation added later (`docs/`, `specs/`, `README.md`).

### Guiding principle

**Modernize the repository, not the project.** Organization, documentation and presentation may follow current practice. The technical implementation must not change.

### Non-goals

- Fixing, refactoring, reformatting or translating the MATLAB code.
- Adding tests, CI, packaging, containers or other infrastructure.
- Filling gaps in the history with invented facts (course name, grades, requirements).
