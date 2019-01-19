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
title('Zeros Map of H0 Low Pass Filter')
figure(4)
freqz(h1)
title('Zeros Map of H1 High Pass Filter')

