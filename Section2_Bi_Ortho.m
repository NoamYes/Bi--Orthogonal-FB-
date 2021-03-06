clear all;
clc;
close all;
dbstop if error

%% Section 1.a - Bi Orthogonal Filter Banks

delta_sp = 10^(-72/20);
delta = 0.123;
fs = 2;
filterFunc = [0.5-delta 0.5+delta];
dev = [delta_sp delta_sp];

fp = 1/2 - delta;
b = firhalfband(62,fp);

[Q_zeros,Q_poles,k] = tf2zpk(b,1);
fvtool(b,1,'polezero')
title('Pole - Zero Map of Q Filter')

realZeros = Q_zeros(imag(Q_zeros) == 0);
leftZeros = setdiff(Q_zeros, realZeros);
oncirc_zeros = leftZeros(abs(abs(leftZeros)-1) < 1e-10);
leftZeros = setdiff(leftZeros, oncirc_zeros);
incirc_zeros = leftZeros(abs(leftZeros) < 1);
leftZeros = setdiff(leftZeros, incirc_zeros);
outofcirc_zeros = leftZeros(abs(leftZeros) > 1);
leftZeros = setdiff(leftZeros, outofcirc_zeros);

H0_zeros = [incirc_zeros(2:4:end); ...
1./incirc_zeros(2:4:end); ...
oncirc_zeros(1:4:end)];
H0_zeros = [H0_zeros; conj(H0_zeros)];
H1_zeros = [incirc_zeros(3:4:end); ...
1./incirc_zeros(3:4:end); ...
oncirc_zeros(3:4:end)];
H1_zeros = [H1_zeros; conj(H1_zeros); realZeros];


h0gain = abs(prod(1-H0_zeros));
h0 = zp2tf(H0_zeros, [], sqrt(2)/h0gain);
h1gain = abs(prod(1-H1_zeros));
h1 = zp2tf(H1_zeros, [], sqrt(2)/h1gain);

H0 = tf(h0,1);
H1 = tf(h1,1);

figure(2)
pzmap(H0,H1)
title('H0 and H1 zeros map consisting Q zeros')
legend({'H0 Low Pass','H1 High Pass'});
ylabel('Imaginary Axis');
xlabel('Real Axis');

figure(3)
freqz(h0)
title('H0 - Low Pass Amplitude and Phase')
figure(4)
freqz(h1)
title('H1 - H1 Pass Amplitude and Phase')

%% Section 2.c

n = 0:127;
x_n = exp(-n/10).*sin(2*n/3);
[f0, f1] = createBiOrth(h0, h1);
[y_n, v1, v2] = two_channel_FB(x_n, h0, h1, f0, f1);
y_n = 0.5*y_n;

figure(5)
subplot(2,1,1)
plot(x_n)
hold on;
subplot(2,1,1)
plot(y_n)
title('x[n] and y[n], delay = 34')
legend({'x[n]','y[n]'});
ylabel('Amp');

d_n = y_n(35:end) - x_n(1:end-34);
subplot(2,1,2)
plot(d_n)
hold on;

title('d[n] - Diff of x and y, considering delay = 34')
ylabel('Amp');

%% 
figure(6)

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
title('x[n] and y[n]]')
legend({'x[n]','y[n]'});
ylabel('Amp');

d_n = y_n(35:end) - x_n(1:end-34);
subplot(3,1,3)
plot(d_n)
SNR = db((norm(x_n)/norm(d_n)).^2);
title('d[n] - Diff of x and y')
ylabel('Amp');


