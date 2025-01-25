function y = PAM_modulation(x,Fs,M)
x = x - (M-1)/2; % Center around 0
x = 2*x/(M-1); % Normalisation
y = zeros(length(x)*Fs,1);
p = 0;
for k = 1:Fs:length(y)
    p = p + 1;
    y(k:(k+Fs-1)) = x(p) * ones(Fs,1); % stretch each sample in x by Fs times.
end
end
