% y = prcos(rollfac,length,T)

function y = prcos(rollfac,length,T)
%rollfac = 0 to 1 is rolloff factor
%length is onesided pulse length in the number of T
%length = 2T + 1
% T is oversampling rate
y = rcosfir(rollfac,length,T,1,'normal');
end