clear all;
clc;
close all;

%% Section 1.a

rp = 3;           % Passband ripple
rs = rp;          % Stopband ripple
f = pi/2;    % Cutoff frequencies
a = [1 0];        % Desired amplitudes
fs = pi;

[n,fo,ao,w] = firpmord([f-0.01*f f],[1 0],[0.01 0.01],fs);
b = firpm(n,fo,ao,w);
freqz(b,1,1024,fs)
title('Lowpass Filter Designed to Specifications')
















%% Question 5 - STFT

