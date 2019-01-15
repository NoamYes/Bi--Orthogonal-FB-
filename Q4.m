clear all;
clc;
close all;
dbstop if error

%% Section 1.a

delta_sp = 10^(-72/20);
delta = 0.123;
fs = 2;
filterFunc = [0.5-delta 0.5+delta];
[n,fo,ao,w] = firpmord(filterFunc,[1 0],[delta_sp delta_sp], fs);
b0 = firpm(n,fo,ao,w);
figure(1)
[h0,w0] = freqz(b0,1,1024,fs);
freqz(b0,1,1024,fs)
title('H0(\theta)')
N= length(b0);

b1 = b0.*(-ones(1,N)).^(1:N);
figure(2)
freqz(b1,1,1024,fs);
[h1,w1] = freqz(b1,1,1024,fs);
title('H1(\theta)')


%% Section 1.b

figure(3)
plot(w0, 10*log10(abs(h0).^2+abs(h1).^2));
title('|(H0(\theta)|^2+|H0(\theta+\pi)|^2')
xlabel('\theta [rads]')
ylabel('Magnitude [dB]')

%% Section 1.c

n = 0:127;
x_n = exp(-n/10).*sin(2*n/3);
h0 = b0;
[h1, f0, f1] = createQMF(h0);
[y_n, v1, v2] = two_channel_FB(x_n, h0, h1, f0, f1);

figure(4)
subplot(2,1,1)
plot(x_n)
hold on;
subplot(2,1,1)
plot(y_n)
title('x[n] and y[n], delay = 32')
legend({'x[n]','y[n]'});
ylabel('Amp');


%% Section 1.d

d_n = y_n(33:end) - x_n(1:end-32);
subplot(2,1,2)
plot(d_n)
hold on;

title('d[n] - Diff of x and y, considering delay = 32')
ylabel('Amp');


figure(5)

subplot(3,1,1)
plot(v1)
hold on;
plot(v2)
title('Analysis signals - v1[n] and v2[n]')
legend({'v1[n]','v2[n]'});

subplot(3,1,2)
plot(x_n)
hold on;
subplot(3,1,2)
plot(y_n)
title('x[n] and y[n], delay = 32')
legend({'x[n]','y[n]'});
ylabel('Amp');

d_n = y_n(33:end) - x_n(1:end-32);
subplot(3,1,3)
plot(d_n)
SNR = db((norm(x_n)/norm(d_n)).^2);
title('d[n] - Diff of x and y, considering delay = 32, SNR = 29.86')
ylabel('Amp');




