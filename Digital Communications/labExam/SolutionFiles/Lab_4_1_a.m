t = 0:0.01:3;
a = t.*(t<1.5)+(-t+3).*(t>=1.5);
mu = 255;
[sqnr8,a_quan8,code8] = u_pcm(a,8);
q_error8 = a - a_quan8;
figure;
hold on;
plot(t,a)
plot(t,a_quan8)
title('8-level uniform PCM quantizer output')
figure;
plot(t,q_error8)
title('Quantization error for 8 Level')
fprintf('SQNR for 8 Level Encoder is: %f dB\n', sqnr8);
[sqnr16,a_quan16,code16] = u_pcm(a,16);
q_error16 = a - a_quan16;
figure;
hold on;
plot(t,a)
plot(t,a_quan16)
title('16-level uniform PCM quantizer output')
figure;
plot(t,q_error16)
title('Quantization error for 16 Level')
fprintf('SQNR for 16 Level Encoder is: %f dB\n', sqnr16);