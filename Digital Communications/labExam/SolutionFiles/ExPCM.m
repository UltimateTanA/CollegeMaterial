% Example of sampling, quantization, and zero-order hold
clear; clf;

% Time settings
td = 0.002; % Original sampling period (500 Hz)
t = 0:td:1; % Time interval of 1 second

% Signal generation
xsig = sin(2 * pi * t) - sin(6 * pi * t); % 1Hz + 3Hz sinusoids
Lsig = length(xsig);

% Fourier transform parameters
Lfft = 2^nextpow2(Lsig);
Xsig = fftshift(fft(xsig, Lfft));
Fmax = 1 / (2 * td);
Faxis = linspace(-Fmax, Fmax, Lfft);

% New sampling rate (50 Hz)
ts = 0.02;
Nfactor = ts / td;

% Signal processing: 16-level uniform quantizer
[s_out, sq_out, sqh_out1, Delta, SQNR] = sampandquant(xsig, 16, td, ts);

% Plot original signal and 16-level PCM signal in the time domain
figure(1);
subplot(2, 1, 1);
sfig1 = plot(t, xsig, 'k', t, sqh_out1(1:Lsig), 'b');
set(sfig1, 'LineWidth', 2);
title('Signal \it{g}(\it{t}) and its 16-level PCM signal');
xlabel('Time (sec.)');

% Signal processing: 4-level uniform quantizer
[s_out, sq_out, sqh_out2, Delta, SQNR] = sampandquant(xsig, 4, td, ts);

% Plot original signal and 4-level PCM signal in the time domain
subplot(2, 1, 2);
sfig2 = plot(t, xsig, 'k', t, sqh_out2(1:Lsig), 'b');
set(sfig2, 'LineWidth', 2);
title('Signal \it{g}(\it{t}) and its 4-level PCM signal');
xlabel('Time (sec.)');

% Fourier transform of the PCM signals
SQH1 = fftshift(fft(sqh_out1, Lfft));
SQH2 = fftshift(fft(sqh_out2, Lfft));

% Apply ideal LPF to filter the PCM signals
BW = 10; % Bandwidth is no larger than 10 Hz
H_lpf = zeros(1, Lfft);
H_lpf(Lfft/2 - BW : Lfft/2 + BW - 1) = 1; % Ideal LPF

% Filter and reconstruct 16-level PCM signal
S1_recv = SQH1 .* H_lpf; % Ideal filtering
s_recv1 = real(ifft(fftshift(S1_recv)));
s_recv1 = s_recv1(1:Lsig);

% Filter and reconstruct 4-level PCM signal
S2_recv = SQH2 .* H_lpf; % Ideal filtering
s_recv2 = real(ifft(fftshift(S2_recv)));
s_recv2 = s_recv2(1:Lsig);

% Plot the filtered signals against the original signal
figure(2);
subplot(2, 1, 1);
sfig3 = plot(t, xsig, 'b-', t, s_recv1, 'b-.');
legend('Original', 'Recovered');
set(sfig3, 'LineWidth', 2);
title('Signal \it{g}(\it{t}) and filtered 16-level PCM signal');
xlabel('Time (sec.)');

subplot(2, 1, 2);
sfig4 = plot(t, xsig, 'b-', t, s_recv2(1:Lsig), 'b-.');
legend('Original', 'Recovered');
set(sfig4, 'LineWidth', 2);
title('Signal \it{g}(\it{t}) and filtered 4-level PCM signal');
xlabel('Time (sec.)');
