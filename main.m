clc; clear; close all;

%% 10秒の440Hzの正弦波の音をサンプリング周波数44100Hz

time = 10; % 正弦波の時間[s]
samplefs = 44100; % サンプリング周波数[Hz]
fs = 440; % 正弦波の周波数[Hz]
timeAxis = linspace(0, time, time * samplefs); % 正弦波sinの横軸
omega = 2 * pi * fs; % 角周波数

y = sin(omega * timeAxis); % 正弦波sinの縦軸
tmp = 20 * log10(abs(fft(y))); % FFT,絶対値表示,2乗

imagesc(tmp')
ylim([0, samplefs/2]);
axis xy
colorbar

%plot(timeAxis, y); % 正弦波表示
% sound(y, samplefs); % 音を流す

%% STFT

% オーディオファイルの読み込み
audioName = "kitamuravoice"; % 音声ファイルの選択（"kitamuravoice" or "sweepsignal" or "katovoice"）
[y,samplefs] = audioread(audioName + ".wav"); % 音声ファイルの選択

voiceSig = y(:, 1); % kitamuravooice Lch抽出

% パラメータ設定
winLen = 1024; % ウィンドウの長さ
shiftLen = winLen/2; % シフト幅
win = hann(winLen); % ハンウィンドウ

% STFT
[spec, J] = STFT(voiceSig, shiftLen, winLen, win); % STFT関数

% パワースペクトログラムの表示
xAxis = linspace(0, size(voiceSig, 1)/samplefs, J);
yAxis = linspace(0, samplefs, winLen);
imagesc(xAxis, yAxis, spec) 
ylim([0 samplefs/2]);
axis xy
colorbar
xlabel('時間 [s]');
ylabel('周波数 [Hz]');