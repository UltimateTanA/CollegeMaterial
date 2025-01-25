% Example of sampling, quantization, and zero-order hold
clear; clf;

% Time settings
td = 0.002; % Original sampling period (500 Hz)
t = 0:td:1; % Time interval of 1 second

% Signal generation
xsig = sin(2 * pi * t) - sin(6 * pi * t); % 1Hz + 3Hz sinusoids
Lsig = length(xsig);

% New sampling rate (50 Hz)
ts = 0.02;
Nfactor = ts / td;

% Signal processing: sampling and quantization
[s_out, sq_out, sqh_out, Delta, SQNR] = sampandquant(xsig, 16, td, ts);

% Fourier transform parameters
Lfft = 2^nextpow2(Lsig);
Fmax = 1 / (2 * td);
Faxis = linspace(-Fmax, Fmax, Lfft);

% Fourier transform of signals
Xsig = fftshift(fft(xsig, Lfft));
S_out = fftshift(fft(s_out, Lfft));

% Plot original and sampled signals in time domain
figure(1);
subplot(3, 1, 1);
sf1 = plot(t, xsig, 'k', 'LineWidth', 2);
hold on;
sf2 = plot(t, s_out(1:Lsig), 'b', 'LineWidth', 2);
hold off;
xlabel('Time (sec)');
title('Signal \it{g}(\it{t}) and its uniform samples');

% Plot spectrum of the original signal
subplot(3, 1, 2);
sf3 = plot(Faxis, abs(Xsig), 'LineWidth', 1);
xlabel('Frequency (Hz)');
axis([-150 150 0 300]);
title('Spectrum of \it{g}(\it{t})');

% Plot spectrum of the sampled signal
subplot(3, 1, 3);
sf4 = plot(Faxis, abs(S_out), 'LineWidth', 1);
xlabel('Frequency (Hz)');
axis([-150 150 0 300 / Nfactor]);
title('Spectrum of \it{g_T}(\it{t})');

% Ideal reconstruction using LPF
BW = 10; % Bandwidth no larger than 10 Hz
H_lpf = zeros(1, Lfft);
H_lpf(Lfft / 2 - BW : Lfft / 2 + BW - 1) = 1; % Ideal LPF
S_recv = Nfactor * S_out .* H_lpf; % Ideal filtering
s_recv = real(ifft(fftshift(S_recv)));
s_recv = s_recv(1:Lsig);

% Plot ideal reconstruction
figure(2);
subplot(2, 1, 1);
sf5 = plot(Faxis, abs(S_recv), 'LineWidth', 1);
xlabel('Frequency (Hz)');
axis([-150 150 0 300]);
title('Spectrum of ideal filtering (reconstruction)');

subplot(2, 1, 2);
sf6 = plot(t, xsig, 'k-.', t, s_recv(1:Lsig), 'b', 'LineWidth', 2);
legend('Original signal', 'Reconstructed signal');
xlabel('Time (sec)');
title('Original signal versus ideally reconstructed signal');

% Non-ideal reconstruction using zero-order hold
ZOH = ones(1, Nfactor);
s_ni = kron(downsample(s_out, Nfactor), ZOH);
S_ni = fftshift(fft(s_ni, Lfft));
S_recv2 = S_ni .* H_lpf; % Ideal filtering
s_recv2 = real(ifft(fftshift(S_recv2)));
s_recv2 = s_recv2(1:Lsig);

% Plot non-ideal reconstruction
figure(3);
subplot(2, 1, 1);
sf7 = plot(t, xsig, 'b', t, s_ni(1:Lsig), 'b', 'LineWidth', 2);
xlabel('Time (sec)');
title('Original signal versus flat-top reconstruction');

subplot(2, 1, 2);
sf8 = plot(t, xsig, 'b', t, s_recv2(1:Lsig), 'b--', 'LineWidth', 2);
legend('Original signal', 'LPF reconstruction');
xlabel('Time (sec)');
title('Original and flat-top reconstruction after LPF');
