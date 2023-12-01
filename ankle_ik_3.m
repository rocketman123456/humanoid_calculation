clear;
clc;

L1 = 25;
d = 64.3 / 2.0;
h1 = 112;
h2 = 65;

tx = 0;
ty = 30;

dt = 1e-6;

[tML, tMR] = ankle_ik_func(L1, d, h1, h2, tx, ty)
[tML_x, tMR_x] = ankle_ik_func(L1, d, h1, h2, tx+dt, ty);
[tML_y, tMR_y] = ankle_ik_func(L1, d, h1, h2, tx, ty+dt);

Jf = [(tML_x - tML) / dt, (tML_y - tML) / dt; (tMR_x - tMR) / dt, (tMR_y - tMR) / dt]
J  = pinv(Jf)
J_ = J'