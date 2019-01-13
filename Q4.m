clear all;
clc;
close all;

%% Section 1.a

rp = 3;           % Passband ripple
rs = rp;          % Stopband ripple
f = pi/2;    % Cutoff frequencies
a = [1 0];        % Desired amplitudes
fs = pi;

dev = [(10^(rp/20)-1)/(10^(rp/20)+1)  10^(-rs/20)]; 
[n,fo,ao,w] = firpmord(f,a,dev, fs);
b = firpm(n,fo,ao,w);
freqz(b,1,1024,fs)
title('Lowpass Filter Designed to Specifications')