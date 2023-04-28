%%STFT
info = audioinfo("kitamuravoice.wav"); % オーディオファイル情報の取得
[y,samplefs] = audioread("kitamuravoice.wav"); % オーディオファイルの読み込み
 
% t = 0:seconds(1/samplefs):seconds(info.Duration); % 経過時間を表すyと
% t = t(1:end-1); % 同じ長さのベクトル t を作成

voiceSig = y(:,1); % kitamuravooice Lch抽出

winLen = 1024; % ウィンドウの長さ
shiftLen = winLen/2; % シフト幅
win = hann(winLen); % ハンウィンドウ
padSig = [zeros(shiftLen, 1); voiceSig]; % 先頭に0行列⁺オーディオデータ
sigLen = size(padSig, 1); % サイズ表示
padSig = [padSig; zeros(winLen-1, 1)]; % 先頭0オーディオデータ⁺最後に0行列
J = ceil(sigLen/shiftLen)-1; % フレーム分割数
spec = zeros(winLen, J); % から行列

for i=1:J % 1~J回処理の繰り返し
    startPoint = shiftLen*(i - 1) + 1; % 初めの点
    tmp = padSig(startPoint:startPoint+(winLen-1), :); % 指定範囲の点をとる
    tmp1 = tmp .* win; % y要素の掛け算
    tmp2 = fft(tmp1); % 短時間フーリエ変換
    spec(:, i) = tmp2; % 作成したから行列
end