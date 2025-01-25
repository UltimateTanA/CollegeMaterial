t = 1:1:1000;
elements = 1000;
X = zeros(1,elements);
w = randn(1,elements);
X(1) = 0;
for i = 2:elements
    X(i) = 0.98*X(i-1)+w(i);
end
mu =255;
n=256;
[sqnr_dpcm, X_quan_dpcm,TX_end] = d_pcm(X,n);
figure;
plot(X);
title('Original Signal')
xlim([1, 1000]);
figure;
plot(TX_end);
title('Transmission Signal')
xlim([1, 1000]);
figure;
plot(X_quan_dpcm)
title('Receiver End output')
xlim([1, 1000]);
figure;
plot(X-X_quan_dpcm)
title('DPCM Error')
xlim([1, 1000]);