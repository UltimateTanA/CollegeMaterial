% MATLAB script for Illustrative Problem 5.2
 % Initialization:
 K = 20; % Number of samples
 A = 1;  % Signal amplitude
 % Defining signal waveforms:
 s_0 = A * ones(1, K);                    
% Constant signal
 s_1 = [A * ones(1, K/2), -A * ones(1, K/2)];  % Bipolar signal
 % Initialize output signals:
 r_0 = zeros(1, K);
 r_1 = zeros(1, K);
 % Case 1: noise ~ N(0, 0)
 noise = randn(1, K);
 % Sub-case s = s_0:
 s = s_0;
 r = s + noise;  % Received signal
 for n = 1:K
    r_0(n) = sum(r(1:n) .* s_0(1:n));
    r_1(n) = sum(r(1:n) .* s_1(1:n));
 end
 % Plotting the results:
 subplot(3, 2, 1)
 plot(0:K, [0, r_0], '-', 0:K, [0, r_1], '--')
 set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'})
 axis([0, 20, -5, 30])
 xlabel('(a) \sigma^2 = 0 & S_0 is transmitted', 'fontsize', 10)
 % Sub-case s = s_1:
 s = s_1;
 r = s + noise;
 for n = 1:K
    r_0(n) = sum(r(1:n) .* s_0(1:n));
    r_1(n) = sum(r(1:n) .* s_1(1:n));
 end
 subplot(3, 2, 2)
 plot(0:K, [0, r_0], '-', 0:K, [0, r_1], '--')
 set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'})
 axis([0, 20, -5, 30])
 xlabel('(b) \sigma^2 = 0 & S_1 is transmitted', 'fontsize', 10)
 % Case 2: noise ~ N(0, 0.1)
 noise = 0.1 * randn(1, K);
 % Sub-case s = s_0:
 s = s_0;
 r = s + noise;
 for n = 1:K
    r_0(n) = sum(r(1:n) .* s_0(1:n));
    r_1(n) = sum(r(1:n) .* s_1(1:n));
 end
 subplot(3, 2, 3)
 plot(0:K, [0, r_0], '-', 0:K, [0, r_1], '--')
 set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'})
 axis([0, 20, -5, 30])
 xlabel('(c) \sigma^2 = 0.1 & S_0 is transmitted', 'fontsize', 10)
 % Sub-case s = s_1:
 s = s_1;
 r = s + noise;
 for n = 1:K
    r_0(n) = sum(r(1:n) .* s_0(1:n));
    r_1(n) = sum(r(1:n) .* s_1(1:n));
 end
 subplot(3, 2, 4)
 plot(0:K, [0, r_0], '-', 0:K, [0, r_1], '--')
 set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'})
 axis([0, 20, -5, 30])
 xlabel('(d) \sigma^2 = 0.1 & S_1 is transmitted', 'fontsize', 10)
 % Case 3: noise ~ N(0, 1)
 noise = randn(1, K);
 % Sub-case s = s_0:
 s = s_0;
 r = s + noise;
 for n = 1:K
    r_0(n) = sum(r(1:n) .* s_0(1:n));
    r_1(n) = sum(r(1:n) .* s_1(1:n));
 end
 subplot(3, 2, 5)
 plot(0:K, [0, r_0], '-', 0:K, [0, r_1], '--')
 set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'})
 axis([0, 20, -5, 30])
 xlabel('(e) \sigma^2 = 1 & S_0 is transmitted', 'fontsize', 10)
 % Sub-case s = s_1:
 s = s_1;
 r = s + noise;
 for n = 1:K
    r_0(n) = sum(r(1:n) .* s_0(1:n));
    r_1(n) = sum(r(1:n) .* s_1(1:n));
 end
 subplot(3, 2, 6)
 plot(0:K, [0, r_0], '-', 0:K, [0, r_1], '--')
 set(gca, 'XTickLabel', {'0', '5Tb', '10Tb', '15Tb', '20Tb'})
 axis([0, 20, -5, 30])
 xlabel('(f) \sigma^2 = 1 & S_1 is transmitted', 'fontsize', 10)
 % Display the plots
 subtitle('Signal Detection Scenarios');