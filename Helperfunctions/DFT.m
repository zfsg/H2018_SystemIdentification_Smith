function [U] = DFT(u)
%DTF Perfom the discrete fourier transform of a sequence
%Source: Lecture 2.53
%   u nx1 vector - input signal
%   U nx1 vector - dft(u)

N = numel(u);

%Transpose u if necessary
if N == size(u,2)
    u = u.';
end

n = 0:N-1;
[omega_N, ~] = omega_n(N);

%Perform DFT with a matrix vector multiplication
%The summation over omega_n is vectorized
U = exp(-1i*omega_N*n)*u;
end

