 %for duobinary pulse
 N = 31;
 T = 1;
 W = 1/(2*T);
 n = -(N-1)/2:(N-1)/2;
 grid on
 for i = 1:length(n)
    g_T(i) = 0;
    for m = -(N-1)/2:(N-1)/2
        if (abs((4*m)/(N*T)) <= W)
            g_T(i) = g_T(i) + sqrt((1/W)*cos((2*pi*m)/(N*T*W)))*exp(-1i*2*pi*m*n(i)/N);
        end
    end
 end
 g_T = real(g_T); 
n2 = 0:N-1;
 [G_T, W] = freqz(g_T, 1);
 magG_T_in_dB = 20 * log10(abs(G_T) / max(abs(G_T)));
 g_R = g_T;
 imp_resp_of_cascade = conv(g_R, g_T);
 figure;
 stem(n2, g_T);
 title('Transmitter Filter g_T(n)');
 xlabel('n');
 ylabel('Amplitude');
 grid on
 figure;
 plot(W/(2*pi), magG_T_in_dB);
 title('Frequency Response of g_T');
 xlabel('frequency (Hz)');
 ylabel('Magnitude (dB)');
 grid on
 figure;
 stem(0:length(imp_resp_of_cascade)-1, imp_resp_of_cascade);
 title('Impulse Response of the Cascade');
 xlabel('n');
 ylabel('Amplitude');
 grid on

% Observations:
%  • The impulse response shows a central peak, with significant side lobes, representing the ISI due to the 
% duobinary scheme. This is because duobinary signaling is a partial-response signaling scheme designed 
% to control the ISI rather than eliminate it.
%  • The controlled ISI is seen as smaller peaks at non-zero sampling intervals, which is a feature of 
% duobinary signaling.
%  • The main lobe of the impulse response corresponds to the primary symbol, and the adjacent lobes 
% represent contributions from adjacent symbols, reflecting the ISI.
%  • This constructive interference at non-zero sampling points is inherent to duobinary signaling