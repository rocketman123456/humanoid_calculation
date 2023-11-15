syms dL L1 L2 L3 real;

w1 = [1, 0, 0]';
p1 = [0, -dL, 0]';
S1 = build_screw(w1, p1)

w2 = [0, 0, 1]';
p2 = [0, -dL, 0]';
S2 = build_screw(w2, p2)

w3 = [0, 1, 0]';
p3 = [0, -dL, 0]';
S3 = build_screw(w3, p3)

w4 = [0, 1, 0]';
p4 = [0, -dL, -L1]';
S4 = build_screw(w4, p4)

w5 = [0, 1, 0]';
p5 = [0, -dL, -L1-L2]';
S5 = build_screw(w5, p5)

w6 = [1, 0, 0]';
p6 = [0, -dL, -L1-L2]';
S6 = build_screw(w6, p6)

function S = build_screw(w, p)
    v = - cross(w, p);
    S = [w', v']';
end
