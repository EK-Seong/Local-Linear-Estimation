%% Hansen Chapter 19 Nonparametric Regression

% Data from bivariate Normal
W = mvnrnd([1,2],[[2,1];[1,2]],200);
Y = W(:,1);
X = W(:,2);


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

%% Hansen 19.19 Replication
cps = readmatrix("C:\Users\eunkyu\Metrics Data\Econometrics Data\cps09mar\cps09mar.xlsx");
earnings = cps(:,5);
hours = cps(:,6);
week = cps(:,6);
age = cps(:,1);
education = cps(:,4);

lwage = log(earnings./(hours.*week));
experience = age - education -6;

sample = cps(:,2)==1 & cps(:,4)==12 & cps(:,11)==2;
Y = lwage(sample);
X = experience(sample);


% Cross-Validation Bandwidth Selection(Local Linear)
h = 2:0.1:11;
cv_criteriaLL = zeros(size(h,2),1);
cv = 10000;
h_cvLL = 0.1;
for i = 1:size(h,2)
    CV_hi = CV_LL(h(1,i),Y,X);
    cv_criteriaLL(i,1) = CV_hi;
    if CV_hi < cv
        cv = CV_hi;
        h_cvLL = h(1,i);
    end
end

% Cross-Validation Bandwidth Selection(Nadaraya-Watson)

cv_criteriaNW = zeros(size(h,2),1);
cv = 10000;
h_cvNW = 0.1;
for i = 1:size(h,2)
    CV_hi = CV_NW(h(1,i),Y,X);
    cv_criteriaNW(i,1) = CV_hi;
    if CV_hi < cv
        cv = CV_hi;
        h_cvNW = h(1,i);
    end
end

figure
plot(h,cv_criteriaLL, ...
    h,cv_criteriaNW)
legend 'Local linear' 'Nadaraya-Watson'


% Local linear estimation
x = 0:2:40;
betaLL = zeros(size(x,2),2);
for i = 1:size(x,2)
    betaLL(i,:) = beta_LL(x(1,i),h_cvLL,Y,X)';
end


% Nadaraya-Watson estimation

betaNW = zeros(size(x,2),1);
for i = 1:size(x,2)
    betaNW(i,1) = beta_NW(x(1,i),h_cvNW,Y,X)';
end

% OLS fitted value
XwConst = [ones(size(Y,1),1),X,X.^2/100];
beta_ols = ((XwConst'*XwConst)\XwConst'*Y);
fit_ols = [ones(size(x,2),1),x',x'.^2/100]*beta_ols;

figure
plot(X,Y,'.', ...
    x,fit_ols(:,1), ...
    x,betaLL(:,1),'-', ...
    x,betaNW(:,1))
ylim([2.3,2.9])
xlim([0,40])
legend 'obs' 'ols' 'LL' 'NW'

