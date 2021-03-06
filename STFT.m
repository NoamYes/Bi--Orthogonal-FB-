close all
clear all
clc
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
axis('xy')
title(['DSTFT [WinLen, overlap, nfft] = ['  num2str(win_len) ', '  num2str(noverlap) ', ' num2str(nfft)  ']']);

% 5.b.2

win_len = 1024;
noverlap = floor(0.75*win_len);
nfft = 1536;
[X2,X_one_sided2] = dstft(x,win_len, noverlap, nfft);
figure(2)
colormap(c)
imagesc(db(abs(X_one_sided2)));
axis('xy')
title(['DSTFT [WinLen, overlap, nfft] = ['  num2str(win_len) ', '  num2str(noverlap) ', ' num2str(nfft)  ']']);

% 5.b.3

win_len = 4096;
noverlap = floor(0.5*win_len);
nfft = 6144;
[X3,X_one_sided3] = dstft(x,win_len, noverlap, nfft);
figure(3)
colormap(c);
imagesc(db(abs(X_one_sided3)));
axis('xy')
title(['DSTFT [WinLen, overlap, nfft] = ['  num2str(win_len) ', '  num2str(noverlap) ', ' num2str(nfft)  ']']);


%% IDSTFT

x_hat = idsftf(X3, win_len, noverlap, nfft);
Ts = 1/fs;
t = Ts*(1:length(x));
t_hat = Ts*(1:length(x_hat));
figure(4)

plot(t, (x),'-', 'LineWidth', 1.5);
title(['x(t) and x_hat(t) reconstructed with WOLA']) 
xlabel('t [secs]')
ylabel('Amp')
legend({'x(t)'})
hold on;

plot(t_hat, (x_hat),'-', 'LineWidth', 1.5);
legend({'x_hat(t)'})

