# Code Overview

This document explains every source file under `src/` **without modifying it**. Identifiers are quoted exactly as they appear in the code (in Spanish, including original spelling).

## About the expected results

The numbers under **Expected result** were not taken from a MATLAB run. MATLAB was not available when this documentation was written, and the repository contains no saved outputs. They were obtained by re-implementing the same formulas with the same hard-coded values in a separate numerical tool (NumPy) during the documentation work. They are what the scripts are *expected* to print, rounded to 4 decimals. Values such as `6.1232e-17` that MATLAB prints instead of exact zeros are shown as `0`.

## Dependency map

```
src/rotation/
  Actividad3.m ──calls──► rotacionRodirgues.m
               └─calls──► rotacionCuaternion.m

src/reference-frames/
  Actividad4SistemasDeReferencia.m ─────┬─calls─► Dibujar_Sistema_Referencia_3D.m
                                        └─calls─► Dibujar_Punto_3D.m
  Actividad4SistemasDeReferenciaYPuntos.m ─calls─► Dibujar_Sistema_Referencia_3D.m
                                                   (Dibujar_Punto_3D call is commented out)

src/plot-points/Act2PARTE1.m              standalone
src/plot-points/Act2PARTE2.m              standalone
src/quaternions/ActExtra1.m               standalone (repeats the quaternion formula inline)
src/transformation-matrix/MaatricesDeTransformacion.m   standalone
```

No file calls anything outside its own folder. Scripts must be run with their own folder as the current folder (or with that folder on the MATLAB path).

---

## `src/plot-points/` — Activity 2

### `Act2PARTE1.m` (script) — matrix product by loops

- Defines `a` (3×3) and `b = [1 2 3; 4 5 6; 7 8 9]`.
- Gets their sizes with `size`, creates `c = zeros(l,q)` and fills it with three nested `for` loops (`i`, `j`, `k`): `c(i,j) = c(i,j) + a(i,k)*b(k,j)`.
- The accumulation line has no semicolon, so the whole matrix `c` is printed at each of the 27 inner iterations.
- Goal (inferred): implement matrix multiplication manually instead of using `a*b`.

Expected final value:

```
c = [ 29  37  45
      44  52  60
      14  13  12 ]
```

### `Act2PARTE2.m` (script) — 2D scaling, rotation and translation

- Three points in **2D homogeneous coordinates** `[x; y; 1]`: `p1 = [1;1;1]`, `p2 = [2;1;1]`, `p3 = [1.5;2;1]`.
- Builds three 3×3 matrices:
  - `e` — scaling with `sx = 3`, `sy = 2`;
  - `r` — rotation about the origin by `th = pi`;
  - `t` — translation by `tx = 4`, `ty = 8`.
- Applies each matrix separately to each original point (the transforms are not chained) and plots with `plot3`: original points in black (`k.`), scaled in red, rotated in green, translated in blue.
- The homogeneous `1` is plotted as the z coordinate, so all points lie on the plane z = 1. `axis([-20 20 -20 20])` only sets x and y limits.

Expected transformed points (x, y, w):

| Point | Scaled (red) | Rotated π (green) | Translated (blue) |
|---|---|---|---|
| p1 | (3, 2, 1) | (−1, −1, 1) | (5, 9, 1) |
| p2 | (6, 2, 1) | (−2, −1, 1) | (6, 9, 1) |
| p3 | (4.5, 4, 1) | (−1.5, −2, 1) | (5.5, 10, 1) |

---

## `src/rotation/` — Activity 3

### `rotacionRodirgues.m` (function) — `R = rotacionRodirgues(th, w)`

- Rotation of angle `th` about axis `w` using **Rodrigues' formula**:
  `R = I + sin(th)·J(w) + (1 − cos(th))·J(w)²`.
- `J` is an anonymous function that builds the skew-symmetric matrix of a 3-vector (*matriz asimétrica*).
- The header comment explains that `w` is the rotation axis, e.g. `x = [1 0 0]`.
- `w` is assumed to be a unit vector; the function does not normalize it.
- The file name keeps the original spelling (`Rodirgues`), which must match the function name.

### `rotacionCuaternion.m` (function) — `R = rotacionCuaternion(th, w)`

- Same inputs, but builds the unit quaternion `(u0, u) = (cos(th/2), sin(th/2)·w)` and converts it to a rotation matrix:
  `R = (u0² − uᵀu)·I + 2·u0·J(u) + 2·u·uᵀ`.

### `Actividad3.m` (script)

- `w = [1 0 0]'`, `th = pi/4`.
- `R1 = rotacionRodirgues(th,w)` and `R2 = rotacionCuaternion(th,w)`. Both lines end with `;`, so nothing is printed; the results are left in the workspace.
- Goal (inferred): show that both methods give the same matrix.

Expected result (`R1` and `R2` are equal):

```
[ 1   0        0
  0   0.7071  -0.7071
  0   0.7071   0.7071 ]
```

---

## `src/quaternions/` — Extra activity 1

### `ActExtra1.m` (script)

- Header: author name, a student ID number and the date `29/enero/2019`.
- Quaternion 1: rotation of `pi/2` about `y`. Quaternion 2: rotation of `pi/4` about `x`. For each it prints the rotation matrix (`MatrizDeRotacionDelCuaternion1`, `MatrizDeRotacionDelCuaternion2`) with the same formula as `rotacionCuaternion.m`, written inline.
- Computes the **quaternion product** `q1·q2`:
  scalar part `a = u01·u02 − u1ᵀu2`, vector part `b = u01·u2 + u02·u1 + u1 × u2`.
- Prints the rotation matrix of the product (`MatrizDeRotacionDeLaMultiplicacionDeCuartenions`) and the product of the two matrices (`MatrizDeRotacionDeLaMultiplicacionDeLasMatrizesDeRotacion`), then prints `SON IGUALES` ("they are equal").
- The variables `q1` and `q2` are built but not used afterwards.

Expected result (both final matrices):

```
[  0   0.7071   0.7071
   0   0.7071  -0.7071
  -1   0        0      ]
```

The statement printed at the end is correct: the rotation of `q1·q2` equals `R(q1)·R(q2)`.

---

## `src/reference-frames/` — Activity 4

### `Dibujar_Sistema_Referencia_3D.m` (function) — `Dibujar_Sistema_Referencia_3D(aTb, s)`

- Draws the frame described by the 4×4 homogeneous transform `aTb`: the x, y and z axes (length 2) as red, green and blue lines, a black dot at the origin and the label `s` below it.
- Sets `hold on`, `grid on`, axis limits `[-10 10]` in x, y, z, axis labels and `view([-45,30])`.

### `Dibujar_Punto_3D.m` (function) — `Dibujar_Punto_3D(at)`

- Draws a point at `at(1:3)` as a blue `x` over a red `o`.
- Sets axis limits `[-10 10 -10 10 0 10]` (z from 0), which differ from the frame helper.

### `Actividad4SistemasDeReferencia.m` (script)

- Clears workspace, Command Window and axes (`clear`, `clc`, `cla`).
- Defines an anonymous `Tinv` (not used in this script — `inv` is used instead).
- Given data: `T_ab`, `T_bc`, `T_ad` and a point `p_b = [0; -2; 0; 1]` expressed in frame **b**.
- Computes and prints:
  - `T_cd = inv(T_bc)*inv(T_ab)*T_ad`
  - `T_ac = T_ab*T_bc`
- Draws frames a (identity, label `Origen a`), b, c and d (d recomputed as `T_ab*T_bc*T_cd`) and the point `T_ab*p_b`.
- Prints the point in each frame: `p_a = T_ab*p_b`, `P_b = p_b`, `p_c = inv(T_bc)*p_b`, `p_d = inv(T_cd)*p_c`.

Expected results:

```
T_cd = [ -1  0  0   6        T_ac = [  0  0 -1  4
          0  0  1   2                 -1  0  0  0
          0  1  0  -2                  0  1  0  1
          0  0  0   1 ]                0  0  0  1 ]

p_a = [0; 2; 2; 1]
P_b = [0; -2; 0; 1]
p_c = [-2; 1; 4; 1]
p_d = [8; 6; -1; 1]     (consistent with inv(T_ad)*p_a)
```

### `Actividad4SistemasDeReferenciaYPuntos.m` (script)

- Defines elementary rotations `Rx`, `Ry`, `Rz` as anonymous functions and the same `Tinv` helper.
- Builds `T_ab` and `T_bc` as a rotation of `pi/4` about z plus a translation `[2 2 0]`, and `T_ad` as a pure translation `[2 2 0]`.
- Computes `T_cd = Tinv(T_bc)*Tinv(T_ab)*T_ad`, then draws frames a, b, c, d. The call that would draw a point is commented out (`% Dibujar_Punto_3D(pa)`), and `pa` is never defined.

**Expected behavior (static analysis, not executed):** the script is expected to stop with a *"Dimensions of arrays being concatenated are not consistent"* error when `Tinv` is called. Inside `Tinv`, `T(1:3,1:3)'-T(1:3,1:3)'*T(1:3,4)` subtracts a 3×1 vector from a 3×3 matrix. In recent MATLAB versions this gives a 3×3 result, which cannot be stacked on top of the 1×4 row `[0 0 0 1]`. In older versions the subtraction itself fails. The intended expression was probably `[R' -R'*p; 0 0 0 1]`. This is documented only; the code was not changed. No frame is drawn because the error happens before the plotting lines.

---

## `src/transformation-matrix/` — Forward kinematics

### `MaatricesDeTransformacion.m` (script)

- Clears everything (`clear all`, `close all`, `clc`).
- DH table with columns `a`, `alpha`, `d`, `theta (q)`:

  | Link | a | α | d | θ |
  |---|---|---|---|---|
  | 1 | 0 | π/2 | 0.5 | 0 |
  | 2 | 0.4 | 0 | 0 | π/4 |
  | 3 | 0 | π/2 | 0 | π/4 |
  | 4 | 0 | 0 | 0.6 | 0 |

- `TRevoluta(a, alpha, d, theta)` is the **standard DH** homogeneous transform:
  `Rot_z(θ)·Trans_z(d)·Trans_x(a)·Rot_x(α)`.
- A loop over the rows uses `if i==1 … if i==4` to assign and print `T01`, `T12`, `T23` and `T34`.
- Prints `Cinematica Directa` ("forward kinematics") and `T04 = T01*T12*T23*T34`.

Expected result:

```
T04 = [ 0   0   1   0.8828
        0  -1   0   0
        1   0   0   0.7828
        0   0   0   1      ]
```

The end effector is at about (0.883, 0, 0.783) in the base frame.
