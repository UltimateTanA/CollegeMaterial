function x = invmulaw(y,mu)
    x = (((1+mu).^(abs(y))-1)./mu).*sign(y);
end