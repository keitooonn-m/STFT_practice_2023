%%STFT
info = audioinfo("kitamuravoice.wav"); % オーディオファイル情報の取得
[y,samplefs] = audioread("kitamuravoice.wav"); % オーディオファイルの読み込み
 
% t = 0:seconds(1/samplefs):seconds(info.Duration); % 経過時間を表すyと
% t = t(1:end-1); % 同じ長さのベクトル t を作成

y1 = y(:,1); %kitamuravooice Lch抽出

L = 1024; %ウィンドウの長さ
shiftLen = L/2; %シフト幅
W = hann(L); %ハンウィンドウ
A = zeros(shiftLen,1); % 先頭に0行列追加
B = zeros(L,1); % 最後に0行列追加
b = [A; y1]; % 先頭に0行列⁺オーディオデータ
sigLen = size(b, 1); % サイズ表示
y1 = [A; y1; B]; % 連結
J = ceil(sigLen/shiftLen)-1; %フレーム分割数
x = zeros(L, J); %から行列

for i=1:J % 1~J回処理の繰り返し
    startPoint = shiftLen*(i - 1) + 1; % 初めの点
    tmp = y1(startPoint:startPoint+(L-1), :); % 指定範囲の点をとる
    a = tmp.*W; % y要素の掛け算
    x1 = fft(a); % 短時間フーリエ変換
    x(:, i) = x1; % 作成したから行列
end