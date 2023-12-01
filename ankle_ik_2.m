clear;
clc;

L1 = 25;
d = 64.3 / 2.0;
h1 = 112;
h2 = 65;

[tMLx, tMRx] = ankle_ik_func(L1, d, h1, h2, tx+dt, ty);
[tMLy, tMRy] = ankle_ik_func(L1, d, h1, h2, tx, ty+dt);

JF = [tMLx / dt, tMLy / dt; tMRx / dt, tMRy / dt];
J = pinv(JF);

start_x = -20;
step_x = 0.2;
end_x = 20;

start_y = -60;
step_y = 0.2;
end_y = 60;

[tx_mat, ty_mat] = meshgrid(start_x:step_x:end_x, start_y:step_y:end_y);
t1_mat = [];
t2_mat = [];
i = 1;
hold on
for tx = start_x:step_x:end_x
    t1_list = [];
    t2_list = [];
    for ty = start_y:step_y:end_y
        [t1, t2] = ankle_ik_func(L1, d, h1, h2, tx, ty);
        t1_list = [t1_list, t1];
        t2_list = [t2_list, t2];
    end
    t1_mat(:,i) = t1_list;
    t2_mat(:,i) = t2_list;
    i = i + 1;
end

mesh(tx_mat, ty_mat, t1_mat);
% mesh(tx_mat, ty_mat, t2_mat);


