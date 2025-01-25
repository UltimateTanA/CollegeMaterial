% (a) Generate uniform random variables
 n = 1e6; 
x = rand(1, n); 
% (b) Calculate the average of every 100 elements
 m = 100; 
y = zeros(1, n/m); 
for i = 1:n/m
    y(i) = mean(x((i-1)*m + 1:i*m)); 
end
 % (c) Plot the histogram of y
 figure; 
histogram(y, 50); 
xlabel('Value'); 
title('Histogram of Averages (Y)'); 
ylabel('Frequency');