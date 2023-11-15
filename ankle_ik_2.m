clear;
clc;

L1 = 25;
d = 64.3;
h1 = 112;
h2 = 65;

tx = 5;
ty = -30;

[tML, tMR] = ankle_ik_(L1, d, h1, h2, tx, ty)

dt = 1e-6;

[tMLx, tMRx] = ankle_ik_(L1, d, h1, h2, tx+dt, ty);
[tMLy, tMRy] = ankle_ik_(L1, d, h1, h2, tx, ty+dt);

JF = [tMLx / dt, tMLy / dt; tMRx / dt, tMRy / dt];
J = pinv(JF);

function [tML, tMR] = ankle_ik_(L1, d, h1, h2, tx, ty)

cx = cosd(tx);
cy = cosd(ty);
sx = sind(tx);
sy = sind(ty);

AL = - L1 * L1 * cy + L1 * d * sx * sy;
BL = -L1 * L1 * sy + L1 * h1 - L1 * d * sx * cy;
CL = -(L1 * L1 + d * d - d * d *cx - L1 * h1 * sy - d * h1 * sx * cy);

LenL = sqrt(AL * AL + BL * BL);

AR = - L1 * L1 * cy - L1 * d * sx * sy;
BR = -L1 * L1 * sy + L1 * h2 + L1 * d * sx * cy;
CR = -(L1 * L1 + d * d - d * d *cx - L1 * h2 * sy + d * h2 * sx * cy);

LenR = sqrt(AR * AR + BR * BR);

tML_1 = asind(CL / LenL) - asind(AL / LenL);
tML_2 = asind(CL / LenL) + acosd(BL / LenL);
assert(tML_1 - tML_2 < 1e-6)

tMR_1 = asind(CR / LenR) - asind(AR / LenR);
tMR_2 = asind(CR / LenR) + acosd(BR / LenR);
assert(tMR_1 - tMR_2 < 1e-6)

tML = tML_1;
tMR = tMR_1;

end