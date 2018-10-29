function [u] = PeriodicInput(N,periods,bias,variance)
%INPUTSIGNAL Create random periodic input singals
%   N           signal length
%   periods     number of periods
%   bias        signal offset
%   variance    signal variance

u_period = sqrt(variance)*randn(N,1)+bias;
u = repmat(u_period,periods,1);
end

