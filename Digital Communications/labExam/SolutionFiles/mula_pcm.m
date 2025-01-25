function [sqnr,a_quan,code] = mula_pcm(a,n,mu)
    [y,maximum] = mulaw(a,mu);
    [sqnr,y_q,code] = u_pcm(y,n);
    a_quan = invmulaw(y_q,mu);
    a_quan = maximum*a_quan;
    sqnr = 20*log10(norm(a)/norm(a-a_quan));
end