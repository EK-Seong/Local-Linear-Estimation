%% Hansen Chapter 19 Nonparametric Regression

% Data from bivariate Normal
W = mvnrnd([1,2],[[2,1];[1,2]],200);
Y = W(:,1);
X = W(:,2);
% OLS fitted value
XwConst = [ones(size(Y,1),1),X];
ols = XwConst*((XwConst'*XwConst)\XwConst'*Y);

% Cross-Validation Bandwidth Selection
h = 0.1:0.1:20;
cv_criteria = zeros(size(h,2),1);
cv = 10000;
h_cv = 0.1;
for i = 1:size(h,2)
    CV_hi = CV(h(1,i),Y,X);
    cv_criteria(i,1) = CV(h(1,i),Y,X);
    if CV_hi < cv
        cv = CV_hi;
        h_cv = h(1,i);
    end
end
figure
plot(h,cv_criteria)
legend

% Local linear estimation
x = min(X):0.1:max(X);
beta = zeros(size(x,2),2);
for i = 1:size(x,2)
    beta(i,:) = beta_LL(x(1,i),h_cv,Y,X)';
end

figure
plot(X,Y,'.', ...
    X,ols,'-',...
    x,beta(:,1),'--')
legend

%%