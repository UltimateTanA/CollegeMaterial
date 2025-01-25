% Write a MATLAB program to compute the power spectrum Sv (j) of the signal
% v ( t) when the pulse g ( t) is  g(t) = 1/2(1-cos(2pit/T)) 0<=t<=T, 0 ow
% and sequence {a_n} of signal amplitudes has correlation function given by
% (6.2.14) Illustrative Problem 6.2 R_a(m) = 1 when m = 0, 1/2 when m = -1
% 1 and 0 ow
 

% Parameters
 T = 1;                % Duration of the rectangular pulse
 sigma_a = 1;         % Amplitude scaling factor
 N = 128;             % Number of points
 t = (0:N-1)/10;      % Time vector
 % Modified pulse g(t)
 g = 0.5 * (1 - cos(2 * pi * t / T)) .* (t >= 0 & t <= T);
 % Calculate 128 point DFT using FFT
 G = fft(g, N);
 G_sq_mag = abs(G).^2;  % Square magnitude of DFT
 % Define the correlation function R_a(m)
 R_a = zeros(1, N); 
R_a(1) = 1;         % R_a(0)
 R_a(2) = 1/2;      % R_a(1)
 R_a(N-1) = 1/2;    % R_a(-1)
 % Compute the Power Spectrum S_v(f) by taking FFT of R_a
 S_v = fft(R_a, N);
 % Frequency vector (adjusted to match size of S_v)
 f = (0:N-1) * (1/(N * (10)));  % Sampling frequency is 1/10
 % Plot the Power Spectrum S_v(f)
 figure;
 plot(f, abs(S_v).^2);
 title('Power Spectrum S_v(f)');
 xlabel('Frequency (Hz)');
 ylabel('S_v(f)');
 grid on;
  % Plot DFT Square Magnitude
 figure;
 stem(0:N-1, G_sq_mag, 'filled');
 title('DFT Square Magnitude |G_m|^2');
 xlabel('m (DFT Index)');
 ylabel('|G_m|^2');
 grid on;
 T = 1; % Pulse duration
 t = linspace(0, T, 1000); % Time vector for simulation
 N = 100;
 g_t = @(t) (1 - cos(2*pi*t/T)) / T .* (t >= 0 & t <= T); % g(t) definition
 a_n = zeros(N, 1); % Initialize a_n
 frequencies = linspace(0, 10, 1000);
 R_a = zeros(size(frequencies)); % Initialize R_a as a vector
 for n = 1:N
    a_n(n) = sqrt(2/T) * integral(@(t) g_t(t) .* cos(2*pi*n*t/T), 0, T);
    R_a = R_a + a_n(n) * cos(2*pi*n*frequencies/T); 
end
 S_v = abs(R_a) .^ 2; % Compute the power spectrum
 % Plot the power spectrum
 figure;
 plot(frequencies, S_v);
 title('Power Spectrum S_v(f)');
 xlabel('Frequency (Hz)');
 ylabel('|S_v(f)|^2');
 grid on;
