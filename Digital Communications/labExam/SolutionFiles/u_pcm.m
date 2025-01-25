function [sqnr, a_quan, code, b_quan] = u_pcm(a, n)
    amax = max(abs(a));
    a_quan = a / amax; % normalisation
    b_quan = a_quan; % normalized store in b
    d = 2 / n;  %step size
    q = d .* (0:n-1); % Q levels
    q = q - ((n-1) / 2) * d;
    
    for i = 1:n
        %Find value in a_quan fall in range of q(i) replace with q(i)
        a_quan(find((q(i) - d/2 <= a_quan) & (a_quan <= q(i) + d/2))) =q(i) .* ones(1, length(find((q(i) - d/2 <= a_quan) & (a_quan <= q(i) + d/2))));
        %Encode each in index i-1 and store in b_quan
        b_quan(find(a_quan == q(i))) = (i - 1) .* ones(1, length(find(a_quan == q(i))));
    end
    
    a_quan = a_quan * amax;
    %Bits needed to represent
    nu = ceil(log2(n));
    code = zeros(length(a), nu);
    
    for i = 1:length(a)
        for j = nu:-1:0
            %det bit for each q value
            %if jth bit is 1 by div with 2^j. Set corr bit to 1 and
            %subtract 2^j
            if fix(b_quan(i) / (2^j)) == 1
                code(i, (nu - j)) = 1;
                b_quan(i) = b_quan(i) - 2^j;
            end
        end
    end
    
    sqnr = 20 * log10(norm(a) / norm(a - a_quan));
end
