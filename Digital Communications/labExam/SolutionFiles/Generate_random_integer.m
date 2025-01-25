function out = Generate_random_integer(p,q,r) % p and q Dim of OP matrix r is two eleemnt vector specifying range
    r = [0,r-1];
    r = sort(r);
    %ensure bounds are integers
    r(1) = ceil(r(1));
    r(2) = floor(r(2));
    if r(1) == r(2)
        out = ones(p,q) * r(1);
    end
    d = r(2) - r(1); % range diff
    r1 = rand(p,q); % gen uniform random matrix
    out = ones(p,q) * r(1);
    for i = 1:d
        index = find(r1>=i/(d+1)); 
        out(index) = (r(1) + 1) * index./index; % set value to r(1) + i, shifting up 1 for each iteration
    end
end