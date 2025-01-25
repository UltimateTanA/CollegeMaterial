%Q2. Write your own code for sampling and reconstructing sum of two cosine functions of duration 2 seconds 
%and frequency 5 Hz and 8 Hz, respectively. You need to choose the sampling rate yourself, considering all the 
%aspects of sampling theory studied in the lectures.

t = 2;
f1 = 5;
f2 = 8;
t1 = linspace(0,t,1000);
x1 = cos(2*pi*f1*t1);
x2 = cos(2*pi*f2*t1);

x = x1 + x2;

for rate = [10 25 50 100]
    t_sampled = 0:1/rate:t;
    x_sampled = cos(2*pi*f1*t_sampled) + cos(2*pi*f2*t_sampled);
    x_reconstr = interp1(t_sampled,x_sampled,t1,'linear');

    figure;
    subplot(3,1,1);
    plot(t1,x,'b');
    title('Original Continuous Signal');
    xlabel('Time');
    ylabel('Amplitude');

    subplot(3,1,2);
    stem(t_sampled,x_sampled,'r');
    title('Sampled Signal');
    xlabel('Time');
    ylabel('Amplitude');

    subplot(3,1,3);
    plot(t1,x_reconstr,'g');
    title('Reconstructed Signal');
    xlabel('Time');
    ylabel('Amplitude');
    sgtitle(['Sampling Rate= ' num2str(rate) 'Hz']);
end