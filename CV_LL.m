% This function returns the cross-validation criterion of the Local linear estimator, given bandwidth
% For estimation of IMSE, we use LOO prediction error
% Input arguments are bandwidth(h), dep var(Y), regressor(X)

function cv = CV_LL(h,Y,X)
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