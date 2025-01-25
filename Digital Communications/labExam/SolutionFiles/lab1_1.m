%{
 Q4.(a) Use the function contFT to compute the Fourier transform of s(t) = 3sinc(2t 
− 3), where the unit of time 
is a microsecond, the signal is sampled at the rate of 16 MHz, and truncated to the 
range [−8, 8] microseconds. 
We wish to attain a frequency resolution of 1 KHz or better. Plot the magnitude of 
the Fourier transform versus 
frequency, making sure you specify the units on the frequency axis. Check that the 
plot conforms to your 
expectations.
 (b) Plot the phase of the Fourier transform obtained in (a) versus frequency 
(again, make sure the units on the 
frequency axis are specified). What is the range of frequencies over which the 
phase plot has meaning?
 %}
fs = 16e6;
ts = 1/fs;
tstart = -8;
tend = 8;
time_interval = tstart:ts*1e6:tend;

signal_timedomain = 3*sinc(2*time_interval -3);

df_desired = 1;

[X,f,df] = contFT(signal_timedomain,tstart,ts*1e6,df_desired);

figure;
plot(f,abs(X));
xlabel('Frequency (kHz');
ylabel('Magnitude Spectrum');
title('Magnitude Spectrum of s(t)');

figure;
plot(f,angle(X));
xlabel('Frequency (kHz');
ylabel('Phase Spectrum');
title('Phase Spectrum of s(t)');
