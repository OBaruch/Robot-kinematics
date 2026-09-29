# Possible Improvements

> **None of the items below have been applied.** The code under `src/` is kept exactly as it was originally written, to preserve the historical implementation. This list only documents what a modern revision *could* change. Any such change should go into a separate, clearly labelled location (for example a new `modern/` folder), never into `src/`.

Items are grouped by severity. "Static analysis" means the conclusion comes from reading the code; the scripts were not run in MATLAB for this documentation.

## Defects

| # | File | Issue | Effect (static analysis) |
|---|---|---|---|
| 1 | `src/reference-frames/Actividad4SistemasDeReferenciaYPuntos.m`, `src/reference-frames/Actividad4SistemasDeReferencia.m` | `Tinv=@(T)([T(1:3,1:3)'-T(1:3,1:3)'*T(1:3,4);0 0 0 1])` — the minus sign turns `R'` and `-R'*p` into one subtraction instead of two blocks. Intended: `[T(1:3,1:3)' -T(1:3,1:3)'*T(1:3,4); 0 0 0 1]`. | `…YPuntos.m` is expected to stop with a concatenation error. In `…SistemasDeReferencia.m` the helper is defined but never called, so no effect. |
| 2 | `src/reference-frames/Actividad4SistemasDeReferencia.m` | Printed messages do not match the code (`T_cd` label for the `T_ac` computation; `Tinv` mentioned while `inv` is used). | Misleading console output only. |
| 3 | `src/reference-frames/Actividad4SistemasDeReferenciaYPuntos.m` | `% Dibujar_Punto_3D(pa)` refers to `pa`, which is never defined. | None while commented out. |
| 4 | `src/plot-points/Act2PARTE2.m` | 2D homogeneous points are plotted with `plot3`, using the homogeneous `1` as z; `axis` gets only four limits. | Points are drawn on the plane z = 1 in a 3D view; works, but is confusing. |

## Robustness

- `rotacionRodirgues` and `rotacionCuaternion` assume `w` is a unit vector; normalizing it (`w = w/norm(w)`) would make them safe for any axis.
- `Act2PARTE1.m` does not check that the inner dimensions match (`m == p`) before multiplying.
- `inv(T)` could be replaced by the closed-form inverse of a homogeneous transform, which is exact and cheaper.

## Readability and style

- Add semicolons to the accumulation line in `Act2PARTE1.m` so the matrix is printed once instead of 27 times.
- Replace the `if i==1 … if i==4` chain in `MaatricesDeTransformacion.m` with an accumulated product in the loop (`T = T*TRevoluta(...)`); the unused variable `y` from `size` could be removed.
- Remove the unused `q1` and `q2` in `ActExtra1.m`, or use them in the product.
- Reuse `rotacionCuaternion` in `ActExtra1.m` instead of repeating the formula.
- The skew-symmetric helper `J` is defined in three places; it could be a shared function.
- Fix file-name typos (`rotacionRodirgues`, `MaatricesDeTransformacion`) — note that renaming a function file also requires renaming the function and every call.
- Avoid `clear all` (it also clears breakpoints and loaded functions).
- Use English or consistent Spanish identifiers and add header help comments (`help` text) to every function.

## Possible extensions (outside the original scope)

- Unit tests (MATLAB `matlab.unittest` or Octave `test`) that check the expected values listed in [code-overview.md](code-overview.md), e.g. that both rotation functions agree and that `R(q1·q2) = R(q1)·R(q2)`.
- A small shared `+kinematics` package with `rotx`, `roty`, `rotz`, `tinv`, `dh`.
- Plot of the manipulator links for the DH example.
- Verification of Octave compatibility.
