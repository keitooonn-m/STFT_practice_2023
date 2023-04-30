%%パワースペクトル表示
info = audioinfo("kitamuravoice.wav"); % オーディオファイル情報の取得
[y,samplefs] = audioread("kitamuravoice.wav"); % オーディオファイルの読み込み

voiceSig = y(:,1); % kitamuravooice Lch抽出

winLen = 1024; % ウィンドウの長さ
shiftLen = winLen/2; % シフト幅
win = hann(winLen); % ハンウィンドウ
padSig = [zeros(shiftLen, 1); voiceSig]; % 先頭に0行列⁺オーディオデータ
sigLen = size(padSig, 1); % サイズ表示
padSig = [padSig; zeros(winLen-1, 1)]; % 先頭0オーディオデータ⁺最後に0行列
J = stat(sigLen, shiftLen); % フレーム分割数
spec = zeros(winLen, J); % から行列

for i=1:J % 1~J回処理の繰り返し
    startPoint = shiftLen*(i - 1) + 1; % 初めの点
    tmp = data(padSig, startPoint, winLen); 
    tmp1 = STFT(tmp, win); 
    spec(:, i) = tmp1; % 作成したから行列に代入
end

xAxis = linspace(0, size(voiceSig, 1)/samplefs, J);
yAxis = linspace(0, samplefs, winLen);
imagesc(xAxis, yAxis, spec) 
ylim([0 samplefs/2]);
axis xy
colorbar

function J = stat(x, y) % フレーム分割数
    J = ceil(x/y)-1; 
end

function tmp = data(x, y, z) % 指定範囲のデータ取得
    tmp = x(y:y+(z-1), :); 
end

function tmp1 = STFT(x, y) %STFT
    a = x .* y; % 要素の掛け算
    b = fft(a); % 短時間フーリエ変換
    c = abs(b);  % 絶対値表示
    tmp1 = 20 * log10(c); % 2乗
end
