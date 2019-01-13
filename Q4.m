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
%freqz(b,1,1024,fs)
title('Lowpass Filter Designed to Specifications')
















%% Question 5 - STFT

[x, fs] = audioread('sentence_male_speaker.wav');
% soundsc(x, fs);

% 5.b.1

win_len = 128;
noverlap = floor(0.75*win_len);
c = jet;
nfft = 192;
[X1,X_one_sided1] = dstft(x,win_len, noverlap, nfft);
figure(1)
colormap(c)
imagesc(db(abs(X_one_sided1)));
set(gca,'YDir','normal');
title(['DSTFT [WinLen, overlap, nfft] = ['  num2str(win_len) ', '  num2str(noverlap) ', ' num2str(nfft)  ']']);

% 5.b.2

win_len = 1024;
noverlap = floor(0.75*win_len);
nfft = 1536;
[X2,X_one_sided2] = dstft(x,win_len, noverlap, nfft);
figure(2)
colormap(c)
imagesc(db(abs(X_one_sided2)));
set(gca,'YDir','normal');
title(['DSTFT [WinLen, overlap, nfft] = ['  num2str(win_len) ', '  num2str(noverlap) ', ' num2str(nfft)  ']']);

% 5.b.3

win_len = 4096;
noverlap = floor(0.5*win_len);
nfft = 6144;
[X3,X_one_sided3] = dstft(x,win_len, noverlap, nfft);
figure(3)
colormap(c);
imagesc(db(abs(X_one_sided3)));
set(gca,'YDir','normal');
title(['DSTFT [WinLen, overlap, nfft] = ['  num2str(win_len) ', '  num2str(noverlap) ', ' num2str(nfft)  ']']);


