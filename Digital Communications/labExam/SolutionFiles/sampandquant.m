function [s_out, sq_out, sqh_out, Delta, SQNR] = sampandquant(sig_in, L, td, ts)
% SAMPANDQUANT Function for sampling and quantization with zero-order hold
% Usage:
%   [s_out, sq_out, sqh_out, Delta, SQNR] = sampandquant(sig_in, L, td, ts)
% Inputs:
%   sig_in - Input signal vector
%   L - Number of uniform quantization levels
%   td - Original sampling period of sig_in
%   ts - New sampling period (ts/td must be a positive integer)
% Outputs:
%   s_out - Sampled output
%   sq_out - Sampled and quantized output
%   sqh_out - Sampled, quantized, and zero-order hold output
%   Delta - Quantization interval
%   SQNR - Signal-to-Quantization Noise Ratio

% Check if the new sampling period is an integer multiple of the original
if rem(ts / td, 1) == 0
    nfac = round(ts / td);
    p_zoh = ones(1, nfac); % Zero-order hold pattern

    % Downsample the input signal
    s_out = downsample(sig_in, nfac);

    % Quantize the downsampled signal
    [sq_out, Delta, SQNR] = uniquan(s_out, L);

    % Upsample to match the original signal length
    s_out = upsample(s_out, nfac);
    sq_out = upsample(sq_out, nfac);

    % Apply zero-order hold
    sqh_out = kron(sq_out, p_zoh);

else
    % Display a warning if ts/td is not an integer
    warning('Error! ts/td is not an integer.');
    s_out = [];
    sq_out = [];
    sqh_out = [];
    Delta = [];
    SQNR = [];
end
end
