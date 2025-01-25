clear;
clf;

M = 4;
sample_freq = 20;
points = 500;
msg = Generate_random_integer(points,1,M);
msg_PAM = PAM_modulation(msg,sample_freq,M);

for alpha = [0 0.05 0.01 0.2]
    msg_PAM = msg_PAM + alpha*msg_PAM.^2;
    span = 10; % filter length
    rolloff = 0.5;
    samples = 4; % #samples per symbol
    rcv_a = rcosdesign(rolloff,span,samples,'sqrt');
    eyediagram(rcv_a,2*samples);
end
% 
% clear;
% clf;
% 
% M = 4;
% sample_freq = 20;
% points = 500;
% msg = Generate_random_integer(points, 1, M);
% msg_PAM = PAM_modulation(msg, sample_freq, M);
% 
% for alpha = [0 0.05 0.1 0.2]
%     % Apply non-linear distortion
%     distorted_msg_PAM = msg_PAM + alpha * msg_PAM.^2;
% 
%     % Raised cosine filter parameters
%     span = 10; % filter length
%     rolloff = 0.5;
%     samples = 4; % samples per symbol
% 
%     % Apply raised cosine filter to the distorted signal
%     rcv_a = rcosdesign(rolloff, span, samples, 'sqrt');
%     filtered_msg_PAM = conv(distorted_msg_PAM, rcv_a, 'same');
% 
%     % Plot the eye diagram of the filtered distorted signal
%     eyediagram(filtered_msg_PAM, 2 * sample_freq);
%     title(['Eye Diagram for \alpha = ', num2str(alpha)]);
% end
