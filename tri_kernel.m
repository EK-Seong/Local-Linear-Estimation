%This function is the triangular kernel function described in Hansen's Econometrics chapter 19.
%k_i=tr_kernel((X_i-x)/h)

function k = tri_kernel(u)
    if u < sqrt(6) && u > -sqrt(6)
        k = (1-(abs(u)/sqrt(6)))/sqrt(6);
    else
        k = 0;
    end
    return;
end




