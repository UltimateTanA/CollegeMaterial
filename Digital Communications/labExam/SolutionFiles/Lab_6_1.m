%Illustrative Problem 6.8
 N = 31; % Number of samples
 T = 1; % Symbol duration
 alpha = 1/4; % Roll-off factor
 n = -(N-1)/2:(N-1)/2;
 g_T = zeros(1, length(n));
 for i = 1:length(n)
    for m = -(N-1)/2:(N-1)/2
        g_T(i) = g_T(i) + sqrt(xrc(4*m/(N*T), alpha, T)) * exp(1j*2*pi*m*n(i)/N);
    end
 end
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
 stem(conv_index,imp_resp_of_cascade);
 title('Impulse Response of the Cascade');
 xlabel('n');
 ylabel('Amplitude');
 grid on
% 
%  Observations:
%  • The transmitter filter  is symmetric and influences the frequency spectrum by controlling the 
% bandwidth and the smoothness of the transition band.
%  • The frequency response of the transmitter filter  shows how the filter effectively manages the 
% trade-off between bandwidth and ISI, with a gradual roll-off controlled by the roll-off factor α.
%  • The convolution plot (impulse_response_of_the_cascade) shows the combined effect of the transmitter 
% and receiver filters. We observe a central peak with minimal interference at non-sampling points, 
% illustrating the system’s ability to eliminate ISI.