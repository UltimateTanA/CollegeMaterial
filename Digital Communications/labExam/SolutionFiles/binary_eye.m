%generate and plot eye diagrams

clear;
clf;
data_bits = sign(randn(1, 400));                       
symbol_period = 64;     
Impulse_train = upsample(data_bits, symbol_period); 
yrz = conv(Impulse_train, prz(symbol_period)); 
yrz = yrz (1:end-symbol_period+1);
ynrz = conv(Impulse_train, pnrz(symbol_period)); 
ynrz = ynrz(1:end-symbol_period+1) ;
ysine = conv(Impulse_train, psine(symbol_period)); 
ysine = ysine (1:end-symbol_period+1);
Trucate_raised_cosine_period = 4; 
yrcos = conv(Impulse_train, prcos(0.5, Trucate_raised_cosine_period, symbol_period)); 
yrcos = yrcos(2 * Trucate_raised_cosine_period * symbol_period : end-2*Trucate_raised_cosine_period*symbol_period + 1); 
eye_diagram_l = eyediagram(yrz, 2*symbol_period, symbol_period, symbol_period/2);
title('RZ eye-diagram');
eye_diagram_2 = eyediagram(ynrz , 2*symbol_period, symbol_period, symbol_period/2);
title('NRZ eye-diagram');
eye_diagram_3 = eyediagram(ysine, 2*symbol_period, symbol_period, symbol_period/2);
title('Half-sine eye-diagram');
eye_diagram_4 = eyediagram(yrcos, 2*symbol_period, symbol_period) ;
title('Raised-cosine eye-diagram');
