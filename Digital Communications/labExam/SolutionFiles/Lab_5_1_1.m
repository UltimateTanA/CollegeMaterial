T = 1;
delta_f = 1/(100*T);
f = -5/T:delta_f:5/T;
sigma_a = 1;
Sv = sigma_a^2*sinc(f*T).^2;
plot(f,Sv);
title('Illustrative Problem 6.1 Power Spectral Density');
xlabel('Frequency (Hz)');
ylabel('Sv(f)');
grid on;