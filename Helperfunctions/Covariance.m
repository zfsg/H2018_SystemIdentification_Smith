function [seq,lags] = Covariance(mode,seq1,seq2)
%COVARIANCE Calculate the covariance or autocovariance
%   Detailed explanation goes here
%   mode    string defining the mode
%   seq1    Nx1 signal
%   seq2    Nx1 signal
%   seq     (2*N-1)x1 output sequence

switch nargin
    case 2
        %Check input validity
        if size(seq1,1) == 1
            seq1 = seq1.';
        elseif size(seq1,2) == 1
        else
            error('Input must be a Nx1 signal.');
        end
        if mode == "zero-mean"
            %Lecture slides 2018, 3.35
            N = size(seq1,1);
            lags = (-N+1:N-1).';
            seq = zeros(size(lags));
            seq_static = [zeros(N-1,1);seq1;zeros(N-1,1)];
            seq_shifted = [seq1; zeros(2*(N-1),1)];
            for i = 1:size(lags,1)
                scaling = sum(seq_static&seq_shifted);
                seq(i) = sum(seq_static.*seq_shifted)/scaling;
                seq_shifted = circshift(seq_shifted,1);
            end
        elseif mode == "general"
            error('Not implemented yet.');
        else
            error('mode must be either "zero-mean" or "general"!');
        end
    case 3
        % Check input validity
        if size(seq1,1) == 1 && size(seq2,1) == 1
            seq1 = seq1.';
            seq2 = seq2.';
        elseif size(se1,2) == 1 && size(seq2,2) == 1
        else
            error('Input must be a Nx1 signal.');
        end
        if mode == "zero-mean"
            N = size(seq1,1);
            %Lecture slides 3.35 assuming equivalency of autocovariance and
            %crosscovariance
            lags = (-N+1:N-1).';
            seq = zeros(size(lags));
            seq_static = [zeros(N-1,1);seq1;zeros(N-1,1)];
            seq_shifted = [seq2; zeros(2*(N-1),1)];
            for i = 1:size(lags,1)
                scaling = sum(seq_static&seq_shifted);
                seq(i) = sum(seq_static.*seq_shifted)/scaling;
                seq_shifted = circshift(seq_shifted,1);
            end
        elseif mode == "general"
            error('Not implemented yet.');
        else
            error('mode must be either "zero-mean" or "general"!');
        end
end
end

