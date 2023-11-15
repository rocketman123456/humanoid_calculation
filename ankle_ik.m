clear;
clc;

syms L1 d h1 h2 tx ty tML tMR real

R = roty(ty) * rotx(tx);

RL = roty(tML);
RR = roty(tMR);

pFL = [-L1, d, 0]';
pFR = [-L1, -d, 0]';

pML = [-L1, d, h1]';
pMR = [-L1, -d, h2]';

pFL_ = R * pFL;
pFR_ = R * pFR;

pML_ = RL * [-L1, d, 0]' + [0, 0, h1]';
pMR_ = RR * [-L1, -d, 0]' + [0, 0, h2]';

dL1 = pML_ - pFL_;
dL2 = pMR_ - pFR_;

dL1_ = simplify(expand(dL1' * dL1 - h1 * h1))
dL2_ = simplify(expand(dL2' * dL2 - h2 * h2))

function R = rotx(x)
    R = [1, 0, 0; 0, cos(x), -sin(x); 0, sin(x), cos(x)];
end

function R = roty(x)
    R = [cos(x), 0, sin(x); 0, 1, 0; -sin(x), 0, cos(x)];
end

function R = rotz(x)
    R = [cos(x), -sin(x), 0; sin(x), cos(x), 0; 0, 0, 1];
end
