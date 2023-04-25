function cv = CV(h,Y,X)
    n = size(Y,1);

    cv = 0;
    for i = 1:n
        d = ones(n,1,"logical");
        d(i,1) = false;
        Yi = Y(d);
        Xi = X(d);
        b = beta_LL(X(i,1),h,Yi,Xi);
        cv = cv + (Y(i,1)-b(1,1))^2;
    end
    cv = cv/n;
return;
end