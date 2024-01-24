points = [
    -2, -1.5, -1, 1, 1.5, 2,  1.5,  1, -1, -1.5;
     0,  0.8,  1, 1, 0.8, 0, -0.8, -1, -1, -0.8;
     0,    0,  0, 0,   0, 0,    0,  0,  0,    0;
];

n = [0; 0; 1];
len = 10;

p = [0; 0; 0];
for i = 1 : 1 : len
    p1 = points(:, i);
    p = p + p1;
end
center = p / len;

target = [3; 3; 0];

inside = true;
related = [0, 0, 0, 0, 0, 0, 0, 0];
index = 0;
for i = 1 : 1  : len
    if i == len
        i1 = i;i2 = 1;
        p1 = points(:, i);
        p2 = points(:, i+1);
    else
        i1 = i;i2 = i+1;
        p1 = points(:, i);
        p2 = points(:, i+1);
    end

    p21 = p2 - p1;
    pt1 = target - p1;
    sig = dot(cross(pt1, p21), n);
    if sig < 0
        inside = false;

        % check intersect
        A = p1;
        B = p2;
        C = target;
        D = center;

        AC = C - A;
        AD = D - A;
        BC = C - B;
        BD = D - B;
        CA = -AC;
        CB = -BC;
        DA = -AD;
        DB = -BD;

        if dot(corss(AC, AD), cross(BC, BD)) <= 0 && dot(cross(CA, CB), cross(DA, DB)) <=0
            t1 = cross((center - p1), (target - center));
            t2 = cross((p2 - p1), (target, center));
            t = sqrt((t1' * t1) / (t2' * t2));

            intersect = p1 + (p2 - p1) * t

            related(index + 1) = i1;
            related(index + 2) = i2;
            index += 2;
        end
    end
end