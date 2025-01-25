 t = 1:1:1000;
 elements = 1000;
 gaussian = randn(1,elements);
 level = [4,8,16,32,64,128,256,512,1024];
 sqnrl = size(level);
 sqnrl_mu_law = size(level);
 a_quan = zeros(length(level),length(gaussian));
 u = 255;
 for i = 1:length(level)
    [sqnrl(i),a_quan,code] = u_pcm(gaussian,level(i));
    figure;
    plot(a_quan)
    title([num2str(level(i)),'-level uniform PCM Quantizer output'])
 end
 figure;
 plot(level,sqnrl,'o-')
 xlabel('Levels');
 ylabel('SQNR(dB)');
 title('SQNR vs Level for Uniform PCM');
 grid on;