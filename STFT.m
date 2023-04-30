function [spec, J] = STFT(voiceSig, shiftLen, winLen, win)
% これはSTFTを実行するために使用する関数です

padSig = [zeros(shiftLen, 1); voiceSig]; % 先頭に0行列⁺オーディオデータ
sigLen = size(padSig, 1); % サイズ表示
padSig = [padSig; zeros(winLen-1, 1)]; % 先頭0オーディオデータ⁺最後に0行列
J = ceil(sigLen/shiftLen)-1; % フレーム分割数
spec = zeros(winLen, J); % から行列

% STFT
for i=1:J % 1~J回処理の繰り返し
    startPoint = shiftLen*(i - 1) + 1; % 初めの点
    tmp = padSig(startPoint:startPoint+(winLen-1), :); % 指定範囲の点をとる
    tmp1 = tmp .* win; % y要素の掛け算
    tmp2 = fft(tmp1); % 短時間フーリエ変換
    tmp3 = abs(tmp2);  % 絶対値表示
    tmp4 = 20 * log10(tmp3); % 2乗して
    spec(:, i) = tmp4; % 作成したから行列
end
end