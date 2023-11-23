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

start_x = -10;
step_x = 0.2;
end_x = 10;

start_y = -20;
step_y = 0.2;
end_y = 20;

[tx_mat, ty_mat] = meshgrid(start_x:step_x:end_x, start_y:step_y:end_y);
t1_mat = [];
t2_mat = [];
i = 1;
hold on
for tx = start_x:step_x:end_x
    t1_list = [];
    t2_list = [];
    for ty = start_y:step_y:end_y
        [t1, t2] = ankle_ik_(L1, d, h1, h2, tx, ty);
        t1_list = [t1_list, t1];
        t2_list = [t2_list, t2];
    end
    t1_mat(:,i) = t1_list;
    t2_mat(:,i) = t2_list;
    i = i + 1;
end

% mesh(tx_mat, ty_mat, t1_mat);
mesh(tx_mat, ty_mat, t2_mat);

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
    
    if(LenL < abs(CL))
        tML_1 = 0;
        tML_2 = 0;
    else
        tML_1 = asind(CL / LenL) - asind(AL / LenL);
        tML_2 = asind(CL / LenL) + acosd(BL / LenL);
    end
    assert(tML_1 - tML_2 < 1e-6)
    
    if(LenR < abs(CR))
        tMR_1 = 0;
        tMR_2 = 0;
    else
        tMR_1 = asind(CR / LenR) - asind(AR / LenR);
        tMR_2 = asind(CR / LenR) + acosd(BR / LenR);
    end
    assert(tMR_1 - tMR_2 < 1e-6)
    
    tML = tML_1;
    tMR = tMR_1;
end