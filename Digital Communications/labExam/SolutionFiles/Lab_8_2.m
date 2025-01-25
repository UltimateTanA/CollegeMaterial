N = 20; 
A = 1;
t = 0:N; 
s0 = A * ones(1, N);
s1 = [A * ones(1, N/2), -A * ones(1, N/2)];
variances = [0.1, 1, 3];
num_variances = length(variances);
figure;
for idx = 1:num_variances
sigma2 = variances(idx);
% Case: noise ~ N(0, sigma2)
noise = randn(1, N) * sqrt(sigma2);
% Sub-case s = s0:
y0 = s0 + noise; 
output0 = conv(y0, fliplr(s0));
% Sub-case s = s1:
y1 = s1 + noise; 
output1 = conv(y1, fliplr(s1));
subplot(3, 2, idx * 2 - 1);
plot(t, [0, output0(1:N)], '-k', t, [0, output1(1:N)], '--k');
title(['\sigma^2 = ' num2str(sigma2) ' & S_0 is transmitted']);
set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'});
axis([0 20 -30 30]);
xlabel('Time (Tb)');
subplot(3, 2, idx * 2);
plot(t, [0, output0(1:N)], '-k', t, [0, output1(1:N)], '--k');
title(['\sigma^2 = ' num2str(sigma2) ' & S_1 is transmitted']);
set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'});
axis([0 20 -30 30]);
xlabel('Time (Tb)');
end
sgtitle('Exercise Problem 5.4');