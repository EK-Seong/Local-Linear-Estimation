function b = beta_LL(x,h,Y,X)
    n = size(Y,1);
    Z = [ones(n,1),X-x];

    k = zeros(1,n);
    for i = 1:n
        k(1,i) = tri_kernel((X(i,1)-x)/h);
    end
    K = diag(k);

    b = (Z'*K*Z)\(Z'*K*Y);
    return;
end