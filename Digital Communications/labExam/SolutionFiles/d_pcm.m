function [sqnr_dpcm, X_quan_dpcm, TX_end] = d_pcm(X, n)
    d = zeros(1, length(X)); % Difference between signal and predicted value
    dq = zeros(1, length(X)); % Quantized difference signal
    mq = zeros(1, length(X)); % Predicted value for each sample
    D = (max(X) - min(X)) / n; % Step size
    q = D .* (0:n-1); % Quantisation levels
    q = q - ((n-1) / 2) * D; % center around zero
    
    for k = 1:length(X)
        if k == 1
            d(k) = X(k); % First sample
        else
            d(k) = X(k) - mq(k-1); 
        end
        
        % Clip to ensure remain in range
        if d(k) > max(X)
            d(k) = max(X);
        elseif d(k) < min(X)
            d(k) = min(X);
        end
        %Find Q range
        q_val = 1;
        for i = 1:n
            if (q(i) - D / 2 <= d(k)) && (d(k) <= q(i) + D / 2)
                q_val = i;
            end
        end
        %store q value in dq
        dq(k) = q(q_val);
        
        if k == 1
            mq(k) = dq(k);
        else
            mq(k) = dq(k) + mq(k-1);
        end
    end
    
    TX_end = dq;
    
    % Reconstruct
    R_out = zeros(1, length(X));
    for k = 1:length(X)
        if k == 1
            R_out(k) = dq(k);
        else
            R_out(k) = dq(k) + R_out(k-1);
        end
    end
    
    X_quan_dpcm = R_out;
    sqnr_dpcm = 20 * log10(norm(X) / norm(X - R_out));
end
