function k = tri_kernel(u)
    if u < sqrt(6) && u > -sqrt(6)
        k = (1-(abs(u)/sqrt(6)))/sqrt(6);
    else
        k = 0;
    end
    return;
end




