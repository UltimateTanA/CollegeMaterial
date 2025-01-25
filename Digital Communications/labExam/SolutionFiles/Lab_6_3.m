 N = 31; % Number of samples
 T = 1; % Symbol duration
 alpha = 1/4; % Roll-off factor
 n = -(N-1)/2:(N-1)/2;
 g_T = zeros(1, length(n));
 g_T(n==0) = 1;
 g_T(n==1) = 0.25;
 g_T(n==-1) = 0.25;
 g_T = real(g_T);
 [G_T, W] = freqz(g_T, 1);
 magG_T_in_dB = 20 * log10(abs(G_T) / max(abs(G_T)));
 g_R = g_T;
 imp_resp_of_cascade = conv(g_R, g_T);
 figure;
 stem(n, g_T, 'filled');
 title('Impulse Response g_T');
 xlabel('n');
 ylabel('Amplitude');
 grid on;
 figure;
 plot(W/pi, magG_T_in_dB);
 title('Magnitude Spectrum of g_T (in dB)');
 xlabel('Normalized Frequency (\times\pi rad/sample)');
 ylabel('Magnitude (dB)');
 grid on;
 n_cascade = -(N-1):(N-1); % The correct range for the convolved output
 figure;
 stem(n_cascade, imp_resp_of_cascade, 'filled');
 title('Impulse Response of the Cascade (g_R * g_T)');
 xlabel('n');
 ylabel('Amplitude');
 grid on;