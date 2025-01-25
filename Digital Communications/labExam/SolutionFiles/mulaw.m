function [y,a] = mulaw(x,mu)
    a = max(abs(x));
    y = (log(1+mu*abs(x/a))./log(1+mu)).*sign(x);
end