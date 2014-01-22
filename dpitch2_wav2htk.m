function dpitch2_wav2htk(infile, outfile)
% dpitch2_wav2htk(infile, outfile)
%   Write a new HTK file of features for a particular input audio
%   file, where the features are the 25-dim spectral
%   cross-correlation features.
% 2014-01-16 Dan Ellis dpwe@ee.columbia.edu

P.t_win = 0.032;
P.t_hop = 0.010;

% Read audio
[d,sr] = audioread(infile, 0, 1);

% Pad with enough to make first window be first 10ms
t_pad = (P.t_win - P.t_hop)/2;
dp = [zeros(round(t_pad*sr),1); d; zeros(round(t_pad*sr),1)];

% Calculate delta-pitch features
dpftr = dpitch2(dp, sr, P);

% Write out HTK format
typecode = 9; % "User"
% writehtk expects each frame as a row, not columns
writehtk(outfile, dpftr', P.t_hop, typecode);
