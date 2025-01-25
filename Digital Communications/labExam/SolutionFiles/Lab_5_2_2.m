 % Repeat the computation in Problem 6.1 when the pulse g(t) is given as
 % g(t) = 1/2(1-cos(2pit/T)) 0<=t<=T, 0 ow Let T = 1
%Parameters
T = 1;
sigma_a = 1;
N = 128;
t = (0:N-1)/10;
%Redefined Pulse
g = 0.5 * (1 - cos(2 * pi * t / T)) .* (t >= 0 & t <= T);
%Calculate 128 point DFT using FFT
G = fft(g,N);
%Calculate sq. magnitude of DFT
G_sq_mag = abs(G).^2;
%Exact spectrum
delta_f = 1/(100*T);
f = -5/T:delta_f:5/T;
Sv = sigma_a^2*sinc(f*T).^2;
%Plot
figure;
stem(0:N-1,G_sq_mag,'filled');
title('DFT Square Magnitude |G_m|^2');
xlabel('m (DFT Index)');
ylabel('|G_m|^2');
grid on;
figure;
plot(f,Sv);
title('Exact Power Spectrum |G(f)|^2');
xlabel('Frequency (Hz)');
ylabel('S_v(f)');
grid on;