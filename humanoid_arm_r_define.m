syms h dA LA0 LA1 LA2 real;

w1 = [0, 1, 0]';
p1 = [-dA, -LA0, h]';
S1 = build_screw(w1, p1)

w2 = [1, 0, 0]';
p2 = [-dA, -LA0, h]';
S2 = build_screw(w2, p2)

w3 = [0, 1, 0]';
p3 = [-dA, -LA0, h - LA1]';
S3 = build_screw(w3, p3)

function S = build_screw(w, p)
    v = - cross(w, p);
    S = [w', v']';
end
