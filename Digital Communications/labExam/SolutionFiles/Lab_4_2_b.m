 for j=1:length(level)
    [sqnrl_mu_law(j),a_quan,code] = mula_pcm(gaussian,level(j),u);
    figure;
    plot(a_quan)
    title([num2str(level(i)),'-level uniform Mu Law PCM Quantizer output'],'with mu = 255')
 end
 figure;
 plot(level,sqnrl_mu_law,'o-')
 xlabel('Levels');
 ylabel('SQNR(dB)');
 title('SQNR vs Level for Mu Law Uniform PCM');
 grid on;

 % DPCM reduces redundancy 
 % SQNR increase as #q level increase
 % mu law improve SQNR compared to uniform PCM