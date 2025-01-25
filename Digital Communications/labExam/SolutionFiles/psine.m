%Sinusoid pulse of width T

function pout = psine(T);
pout = sin(pi*[0:T-1]/T);
end