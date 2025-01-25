[audio_signal, fs] = audioread('sample.wav');
audio_signal = audio_signal';  
bits = 8;  
levels = 2^bits;  
p = 5;  
mu = 0.0001;  
N = length(audio_signal);  
e = zeros(1, N);  
x_hat = zeros(1, N);  
w = zeros(p, N);  
quantized_signal = zeros(1, N);  
for k = 1:p
    w(k, 1) = 0;  
end
 for n = p+1:N
    
    x_hat(n) = sum(w(:, n)' .* audio_signal(n-1:-1:n-p));
    e(n) = audio_signal(n) - x_hat(n);
    delta = 2 / levels;  
    quantized_error = round(e(n) / delta) * delta;  
    quantized_signal(n) = x_hat(n) + quantized_error;  
    for k = 1:p
        w(k, n+1) = w(k, n) + (mu / (sum(audio_signal(n-1:-1:n-p).^2))) * audio_signal(n-k) * e(n);
    end
 end
quantization_error = audio_signal - quantized_signal;
sqnr = 20 * log10(norm(audio_signal) / norm(quantization_error));
figure;
plot(audio_signal);
title('Original Audio Signal');
xlabel('Sample Number');
ylabel('Amplitude');
figure;
plot(quantized_signal);
title('Quantized Signal (DPCM with LMS Predictor)');
xlabel('Sample Number');
ylabel('Amplitude');
figure;
plot(quantization_error);  
title('Quantization Error');
xlabel('Sample Number');
ylabel('Error Amplitude');
disp(['SQNR for mu = ', num2str(mu), ' is: ', num2str(sqnr), ' dB']);
final_w = w(:, end);  
disp('Final DPCM Predictor Coefficients (w):');
disp(final_w);

% 
%  The DPCM with Least Mean Square Predictor provides efficient compression.
%  • It has a good trade off between accuracy and compression.
%  • The quantization error is minimized through adaptive coefficient updates in the LMS predictor.
%  • The longer the signal, the more accurate is the LMS predictor since we have more value to update the 
% coefficients with.
%  • The larger the prediction order, the more accurate is the LMS predictor since it takes into account 
% multiple previous values, and makes a better judgement of the future values