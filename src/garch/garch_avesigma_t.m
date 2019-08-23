function sigmaAve = garch_avesigma_t(Theta, r, sigmaSq0)
% sigmaAve = garch_avesigma_t(Theta, r, sigmaSq0) computes the conditional
% standard deviations by averaging over those given by sampled parameters.
%
% Input:
% Theta    - matrix of observed parameter vectors, where each row is an
%            observation, and each column is a parameter.
% r        - vector of returns.
% sigmaSq0 - variance of the first period.
%
% Output:
% sigmaAve - vector of average conditional standard deviations, containing
%            one more element than the number of returns, where the last
%            element is the out-of-sample one-period-ahead forecast.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 10, 2014

    nRet = numel(r);
    nTheta = size(Theta, 1);
    
    sigmaSum = zeros(nRet + 1, 1);
    for i = 1:nTheta
        mu = Theta(i, 2);
        omega = Theta(i, 3);
        alpha = Theta(i, 4);
        beta = Theta(i, 5);
        a = r - mu;
        sigmaSq = garch_sigmasq(a, sigmaSq0, omega, alpha, beta);
        sigmaSum = sigmaSum + sqrt(sigmaSq);
    end
    sigmaAve = sigmaSum ./ nTheta;
end