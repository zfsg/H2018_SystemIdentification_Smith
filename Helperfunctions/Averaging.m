function [u_av] = Averaging(u,N,periods,transient)
%AVERAGING Average multiple periods of a signal
%   u           input singal
%   N           period length
%   periods     number of periods
%   transient   bool, remove first period if true

%optionally loose the first period for getting rid of the transient
if transient
    u = u(N+1:end);
    periods = periods -1;
end
%reshape to simplify averaging
u_re = reshape(u,N,[]);
%sum up and divide by the number of periods
u_av = sum(u_re,2)/(periods);
end

