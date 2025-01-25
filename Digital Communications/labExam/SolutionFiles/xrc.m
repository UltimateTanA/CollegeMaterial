function y = xrc(f,alpha,T)
if abs(f)> ((1+alpha)/(2*T))
    y = 0;
elseif abs(f)>((1-alpha)/(2*T))
    y = (T/2)*(1+cos(pi*T/alpha*(abs(f) - (1-alpha)/(2*T))));
else
    y = T;
end
end