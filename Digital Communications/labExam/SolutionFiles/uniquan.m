function [q_out, Delta, SQNR] = uniquan(sig_in, L)
% UNIQUAN Uniform quantization function
% Usage:
%   [q_out, Delta, SQNR] = uniquan(sig_in, L)
% Inputs:
%   sig_in - Input signal vector
%   L - Number of uniform quantization levels
% Outputs:
%   q_out - Quantized output
%   Delta - Quantization interval
%   SQNR - Signal-to-Quantization Noise Ratio

% Calculate the positive and negative peak values of the input signal
sig_pmax = max(sig_in); % Positive peak
sig_nmax = min(sig_in); % Negative peak

% Compute the quantization interval
Delta = (sig_pmax - sig_nmax) / L;

% Define quantization levels
q_level = sig_nmax + Delta / 2 : Delta : sig_pmax - Delta / 2;

% Calculate signal length
L_sig = length(sig_in);

% Map input signal to quantization levels
sigp = (sig_in - sig_nmax) / Delta + 0.5; % Convert to range [0.5, L + 0.5]
qindex = round(sigp); % Round to nearest level index
qindex = min(max(qindex, 1), L); % Ensure index is in valid range [1, L]

% Generate quantized output using quantization levels
q_out = q_level(qindex);

% Calculate Signal-to-Quantization Noise Ratio (SQNR)
SQNR = 20 * log10(norm(sig_in) / norm(sig_in - q_out));

end
