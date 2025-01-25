ts=1/16; %sampling interval
 time_interval = 0:ts:1; %sampling time instants
 %%time domain signal evaluated at sampling instants
 signal_timedomain = sin(pi*time_interval); %sinusoidal pulse in our example
 fs_desired = 1/160; %desired frequency granularity
 Nmin = ceil(1/(fs_desired*ts)); %minimum length DFT for desired frequency granularity
 %for efficient computation, choose FFT size to be power of 2
 Nfft = 2^(nextpow2(Nmin)) %FFT size = the next power of 2 at least as big as Nmin
 %Alternatively, one could also use DFT size equal to the minimum length
 %Nfft=Nmin;
 %note: fft function in Matlab is just the DFT when Nfft is not a power of 2
 %freq domain signal computed using DFT
 %fft function of size Nfft automatically zeropads as needed
 signal_freqdomain = ts*fft(signal_timedomain,Nfft);
 %fftshift function shifts DC to center of spectrum
 signal_freqdomain_centered = fftshift(signal_freqdomain);
 fs=1/(Nfft*ts); %actual frequency resolution attained
 %set of frequencies for which Fourier transform has been computed using DFT
 freqs = ((1:Nfft)-1-Nfft/2)*fs;
 %plot the magnitude spectrum
 plot(freqs,abs(signal_freqdomain_centered));
 xlabel('Frequency');
 ylabel('Magnitude Spectrum')