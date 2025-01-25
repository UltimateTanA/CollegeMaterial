N = 20;
 A = 1;
 t = 0:N;
 s0 = A*ones(1,N);
 s1 = [A*ones(1,N/2), - A*ones(1,N/2)];
 y0 = zeros(1,N);
 y1 = zeros(1,N);
 %Case 1 noise ~ N(0,0)
 noise = randn(1,N);
 %Sub case 1 s = s0:
 y = s0 +noise;
 y0 = conv(y,fliplr(s0));
 y1 = conv(y,fliplr(s1));
 subplot(3,2,1);
 plot(t,[0,y0(1:N)],'-k',t,[0,y1(1:N)],'--k')
 set(gca,'XTickLabel',{'0','5Tb','10Tb','15Tb','20Tb'})
 axis([0 20 -30 30])
 xlabel('(a) \sigma_A^2 = 0 & S_0 is transmitted')
 %Sub case 2 s = s1:
 y = s1 +noise;
 y0 = conv(y,fliplr(s0));
 y1 = conv(y,fliplr(s1));
 subplot(3,2,2);
 plot(t,[0,y0(1:N)],'-k',t,[0,y1(1:N)],'--k')
 set(gca,'XTickLabel',{'0','5Tb','10Tb','15Tb','20Tb'})
 axis([0 20 -30 30])
 xlabel('(b) \sigma_A^2 = 0 & S_1 is transmitted')
 %Case 2 noise ~ N(0,0.1)
 noise = randn(1,N)*0.1;
 %Sub case 1 s = s0:
 y = s0 +noise;
 y0 = conv(y,fliplr(s0));
 y1 = conv(y,fliplr(s1));
 subplot(3,2,3);
 plot(t,[0,y0(1:N)],'-k',t,[0,y1(1:N)],'--k')
 set(gca,'XTickLabel',{'0','5Tb','10Tb','15Tb','20Tb'})
 axis([0 20 -30 30])
 xlabel('(c) \sigma_A^2 = 0.1 & S_0 is transmitted')
 %Sub case 2 s = s1:
 y = s1 +noise;
 y0 = conv(y,fliplr(s0));
 y1 = conv(y,fliplr(s1));
 subplot(3,2,4);
 plot(t,[0,y0(1:N)],'-k',t,[0,y1(1:N)],'--k')
 set(gca,'XTickLabel',{'0','5Tb','10Tb','15Tb','20Tb'})
 axis([0 20 -30 30])
 xlabel('(d) \sigma_A^2 = 0.1 & S_1 is transmitted')
 %Case 3 noise ~ N(0,1)
 noise = randn(1,N);
 %Sub case 1 s = s0:
 y = s0 +noise;
 y0 = conv(y,fliplr(s0));
 y1 = conv(y,fliplr(s1));
 subplot(3,2,5);
 plot(t,[0,y0(1:N)],'-k',t,[0,y1(1:N)],'--k')
 set(gca,'XTickLabel',{'0','5Tb','10Tb','15Tb','20Tb'})
 axis([0 20 -30 30])
 xlabel('(e) \sigma_A^2 = 1 & S_0 is transmitted')
 %Sub case 2 s = s1:
 y = s1 +noise;
 y0 = conv(y,fliplr(s0));
 y1 = conv(y,fliplr(s1));
 subplot(3,2,6);
 plot(t,[0,y0(1:N)],'-k',t,[0,y1(1:N)],'--k')
 set(gca,'XTickLabel',{'0','5Tb','10Tb','15Tb','20Tb'})
 axis([0 20 -30 30])
 xlabel('(f) \sigma_A^2 = 1 & S_1 is transmitted')
 sgtitle('Illustrative Problem 5.4');