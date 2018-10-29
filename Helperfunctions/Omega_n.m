function [omega,idx] = Omega_n(N,mode)
%OMEGA_N This function returns the frequency vectors associated with the
%DFT
%   N = Number of frequencies used
%   mode = string indicating positiv 'p', negativ 'p0', or all frequencies
%   returned, where all is default behaviour

if N <= 0 || N ~= round(N)
    error('N must be a natural number!')
end

switch nargin
    case 1
        %Default case, whole frequency vector is returned
        %Source: Lecture slides 2018, 3.13
        omega = (2*pi/N)*(0:N-1)';
        idx = (1:N)';
    case 2
        %Either only positive or only negative frequencies are returned
        
        %Source: Lecture slides 2018, 3.13
        omega = (2*pi/N)*(0:N-1).';
        idx = (1:N)';
        
        if mode == 'p' %returning positive frequencies
            idx = find(omega > 0 & omega < pi);
        elseif mode == 'p0' %returning non-negative frequencies
            idx = find(omega >= 0 & omega < pi);
        else
            error('Usage: "mode" argument must be either char(p) for returning positive frequencies or char(n) for returning negative frequencies.')
        end     
end
end

