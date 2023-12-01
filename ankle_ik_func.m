function [tML, tMR] = ankle_ik_func(L1, d, h1, h2, tx, ty)
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
        %tML_2 = 0;
    else
        tML_1 = asind(CL / LenL) - asind(AL / LenL);
        %tML__ = asind(CL / LenL) + acosd(BL / LenL);
        %tML_2 = -asind(CL / LenL) + asind(AL / LenL);
        %tML_3 = acosd(CL / LenL) - acosd(AL / LenL);
        %tML_4 = -acosd(CL / LenL) + acosd(AL / LenL);
    end
    % assert(tML_1 - tML_2 < 1e-6)
    
    if(LenR < abs(CR))
        tMR_1 = 0;
        %tMR_2 = 0;
    else
        tMR_1 = asind(CR / LenR) - asind(AR / LenR);
        %tMR__ = asind(CR / LenR) + acosd(BR / LenR);
        %tMR_2 = -asind(CR / LenR) + asind(AR / LenR);
        %tMR_3 = acosd(CR / LenR) - acosd(AR / LenR);
        %tMR_4 = -acosd(CR / LenR) + acosd(AR / LenR);
    end
    % assert(tMR_1 - tMR_2 < 1e-6)
    
    tML = tML_1;
    tMR = tMR_1;
end