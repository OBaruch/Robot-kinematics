# Theory

A short summary of the math behind the scripts, so the code can be read without a textbook. Each section points to the file that uses it. The notation follows the code.

## 1. Homogeneous coordinates in 2D

*Used in `src/plot-points/Act2PARTE2.m`.*

A 2D point `(x, y)` is written as `[x; y; 1]`. This lets scaling, rotation and translation all be 3×3 matrix products:

```
Scaling          Rotation (θ)                 Translation
[sx 0  0]        [cos θ  -sin θ  0]           [1 0 tx]
[0  sy 0]        [sin θ   cos θ  0]           [0 1 ty]
[0  0  1]        [0       0      1]           [0 0 1 ]
```

## 2. Skew-symmetric matrix

*Used in `rotacionRodirgues.m`, `rotacionCuaternion.m`, `ActExtra1.m` (anonymous function `J`).*

For `w = [w1 w2 w3]ᵀ`:

```
J(w) = [  0   -w3   w2
          w3   0   -w1
         -w2   w1   0  ]
```

`J(w)·v = w × v` (cross product).

## 3. Rodrigues' rotation formula

*Used in `src/rotation/rotacionRodirgues.m`.*

Rotation by angle `θ` about a **unit** axis `w`:

```
R = I + sin θ · J(w) + (1 − cos θ) · J(w)²
```

## 4. Unit quaternions

*Used in `src/rotation/rotacionCuaternion.m` and `src/quaternions/ActExtra1.m`.*

A rotation by `θ` about unit axis `w` is the quaternion `q = (u0, u)` with `u0 = cos(θ/2)`, `u = sin(θ/2)·w`. Its rotation matrix is:

```
R(q) = (u0² − uᵀu)·I + 2·u0·J(u) + 2·u·uᵀ
```

Product of two quaternions `q1 = (u01, u1)` and `q2 = (u02, u2)`:

```
q1·q2 = ( u01·u02 − u1ᵀu2 ,  u01·u2 + u02·u1 + u1 × u2 )
```

And `R(q1·q2) = R(q1)·R(q2)`, which is what `ActExtra1.m` shows numerically.

## 5. Homogeneous transformations in 3D

*Used in `src/reference-frames/`.*

The pose of frame **b** relative to frame **a** is the 4×4 matrix

```
T_ab = [ R_ab  t_ab
         0 0 0  1   ]
```

where `R_ab` is a 3×3 rotation and `t_ab` the position of b's origin in a.

- **Change of frame of a point:** `p_a = T_ab · p_b` (points written as `[x; y; z; 1]`).
- **Composition:** `T_ac = T_ab · T_bc`.
- **Inverse:** `T_ab⁻¹ = [ R_abᵀ  −R_abᵀ·t_ab ; 0 0 0 1 ]`. This is the formula the `Tinv` helper tries to express (see [code-overview.md](code-overview.md)).
- **Solving for an unknown transform:** from `T_ad = T_ab·T_bc·T_cd` it follows that `T_cd = T_bc⁻¹·T_ab⁻¹·T_ad`.

Elementary rotations (as in `Actividad4SistemasDeReferenciaYPuntos.m`):

```
Rx(θ) = [1 0 0; 0 cos θ −sin θ; 0 sin θ cos θ]
Ry(θ) = [cos θ 0 sin θ; 0 1 0; −sin θ 0 cos θ]
Rz(θ) = [cos θ −sin θ 0; sin θ cos θ 0; 0 0 1]
```

## 6. Denavit–Hartenberg forward kinematics

*Used in `src/transformation-matrix/MaatricesDeTransformacion.m`.*

In the standard DH convention each link `i` is described by four parameters `(a, α, d, θ)` and the transform from frame `i−1` to frame `i` is:

```
T = Rot_z(θ) · Trans_z(d) · Trans_x(a) · Rot_x(α)

  = [ cos θ   −sin θ·cos α    sin θ·sin α    a·cos θ
      sin θ    cos θ·cos α   −cos θ·sin α    a·sin θ
      0        sin α          cos α          d
      0        0              0              1       ]
```

The pose of the end effector relative to the base is the product of all link transforms: `T04 = T01·T12·T23·T34`.
