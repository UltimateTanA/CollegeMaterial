% 1 The Fourier transform of the rectangular pulse in Illustrative Problem 6.1 and the
% power spectrum Sv (j) can be computed numerically with MATLAB by using the
% discrete Fourier transform (DFf) or the FFf algorithm. Let us normalize T = 1 and
% sigma_a ^2= 1. Then sample the rectangular pulse g(t) at t = k/10 fork = 0, 1, 2, ... , 127.
% This yields the sequence {gk} of sample values of g(t). Use MATLAB to compute the
% 128-point DFf of {gk} and plot the values IGml2 form = 0, 1, ... , 127. Also plot
% the exact spectrum I G(j) 12 given in (6.2.13) and compare the two results.


%Parameters
T = 1;
sigma_a = 1;
N = 128;
t = (0:N-1)/10;
%Rectangular pulse
g = double(t<T); 
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