function [seq,lags] = Correlation(mode,seq1,seq2)
%CORRELATION Calculate the correlation or autocorrelation of signals
%   mode    string defining the mode
%   seq1    Nx1 signal
%   seq2    Nx1 signal
%   seq     (2*N-1)x1 output sequence

switch nargin
    case 2
        % Check input validty
        if size(seq1,1) == 1
            seq1 = seq1.';
        elseif size(seq1,2) == 1
        else
            error('Input must be a Nx1 signal.');
        end
        N = size(seq1,1);
        % Check mode
        if mode == "periodic"
            %Lecture slides 2018, 2.19
            lags = (floor(-N/2):floor(N/2)).';
            seq = zeros(size(lags));
            seq_shifted = circshift(seq1,1);
            for i = 1:size(lags,1)
                seq(i) = 1/N*sum(seq1.*seq_shifted);
                seq_shifted = circshift(seq_shifted,1);
            end
        elseif mode == "finen"
            %Lecture slides 2018, 2.13
            %returns only nonzero entries
            lags = (-N+1:N-1).';
            seq = zeros(size(lags));
            seq_static = [zeros(N-1,1);seq1;zeros(N-1,1)];
            seq_shifted = [seq1; zeros(2*(N-1),1)];
            for i = 1:size(lags,1)
                seq(i) = sum(seq_static.*seq_shifted);
                seq_shifted = circshift(seq_shifted,1);
            end
        elseif mode == "rand"
            %Lecture slides 2018, 2.28
            %The autocovariance is estimated by the autocorrelation of the zero
            %mean shifted signals
            warning('Instead of the autocorrelation, an estimate of the autocovariance of the zero mean shifted signals is calculated, as proposed in the lecture.');
            lags = (-N+1:N-1).';
            seq = zeros(size(lags));
            seq1 = seq1-mean(seq1);
            seq_static = [zeros(N-1,1);seq1;zeros(N-1,1)];
            seq_shifted = [seq1; zeros(2*(N-1),1)];
            for i = 1:size(lags,1)
                seq(i) = sum(seq_static.*seq_shifted);
                seq_shifted = circshift(seq_shifted,1);
            end
        else
            error('mode must be either periodic "periodic", finite energy "finen" or random "rand".')
        end
        
    case 3
        % Check input validty
        if size(seq1,1) == 1 && size(seq2,1) == 1
            seq1 = seq1.';
            seq2 = seq2.';
        elseif size(seq1,2) == 1 && size(seq2,2) == 1
        else
            error('Input must be a Nx1 signal.');
        end
        if size(seq1,1) ~= size(seq2,1)
            error('seq1, seq2, must be vectors of the same length!');
        end
        
        N = size(seq1,1);
        % Check mode
        if mode == "periodic"
            lags = (floor(-N/2):floor(N/2)).';
            seq = zeros(size(lags));
            
            %For periodic signals values that are out of bounds are
            %actually looped around. The same can be accomplished using a
            %circular shift of the lag-shifted vector.
            seq_shifted = circshift(seq2,1);
            for i = 1:size(lags,1)
                seq(i) = 1/N*sum(seq1.*seq_shifted);
                seq_shifted = circshift(seq_shifted,1);
            end
        elseif mode == "finen"
            %Lecture slides 2018, 2.13, adapted for crosscorrelation
            %returns only nonzero entries
            lags = (-N+1:N-1).';
            seq = zeros(size(lags));
            seq_static = [zeros(N-1,1);seq1;zeros(N-1,1)];
            seq_shifted = [seq2; zeros(2*(N-1),1)];
            for i = 1:size(lags,1)
                seq(i) = sum(seq_static.*seq_shifted);
                seq_shifted = circshift(seq_shifted,1);
            end
        elseif mode == "rand"
            %Lecture slides 2018, 2.28
            %The crosscovariance is estimated by the crosscorrelation of the zero
            %mean shifted signals
            warning('Instead of the crosscorrelation, an estimate of the crosscovariance of the zero mean shifted signals is calculated, as proposed in the lecture.');
            lags = (-N+1:N-1).';
            seq = zeros(size(lags));
            seq1 = seq1 - mean(seq1);
            seq2 = seq2 - mean(seq2);
            seq_static = [zeros(N-1,1);seq1;zeros(N-1,1)];
            seq_shifted = [seq2; zeros(2*(N-1),1)];
            for i = 1:size(lags,1)
                seq(i) = sum(seq_static.*seq_shifted);
                seq_shifted = circshift(seq_shifted,1);
            end
        else
            error('mode must be either periodic `periodic`, finite energy `finen` or random `rand`.')
        end
end
end

