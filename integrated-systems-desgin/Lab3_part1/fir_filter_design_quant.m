close all;
clear;

%%
% load wav audio file
[x, Fs] = audioread('speech_15.wav');

% calculate the discrete fourier transform of signal
% using 1024 dft samples
nfft= 2^10;
X= fft(x, nfft);
fstep = Fs/nfft;
fvec= fstep*(0: nfft/2-1);
[MaxMag,I] = max(2*abs(X(1:nfft/2)));   % determine peak amplitude
fprintf('\nNoise: %d Hz, %d dB\n', fvec(I), MaxMag);

% plotting signal dft
figure(1);
plot(fvec, 2*abs(X(1:nfft/2)))
title('Single-Sided Amplitude Spectrum of x(t)')
xlabel('Frequency (Hz)')
ylabel('|X(f)|')

%%
% FIR Window Bandstop filter design.

Fs = 17000;  % Sampling Frequency

Fpass1 = fvec(I)-300;       % First Passband Frequency
Fstop1 = fvec(I)-200;       % First Stopband Frequency
Fstop2 = fvec(I)+400;    	% Second Stopband Frequency
Fpass2 = fvec(I)+500;       % Second Passband Frequency
Dpass1 = 10^(0.5/20);         % First Passband Ripple
Dstop  = 10^(-(MaxMag)/20);	% Stopband Attenuation
Dpass2 = 10^(0.2/20);         % Second Passband Ripple
flag   = 'scale';           % Sampling Flag

% Calculate the optimal filter order (number of taps).
% Using the Parks McClellan (Remez Exchange) FIR design method.
[n, fo, ao, w]  = firpmord([Fpass1 Fstop1 Fstop2 Fpass2], [1 0 1], [Dpass1 Dstop Dpass2], Fs);
% Calculating the BandStop FIR filter coefficients using the FIRPM function.
N = 350;
b = firpm(N, fo, ao, w);
% Store the filter in a filter object
Hd = dfilt.dffir(b);

%%
% obtain filtered audio
y = filter(Hd,x);
% play and write full precision filtered audio
% sound(y, Fs);
audiowrite('filtered_full_prec_speech_15.wav', y, Fs);

%%
% calculate the discrete fourier transform of filtered signal
% using 1024 dft samples
nfft= 2^10;
Y = fft(y, nfft);
fstep = Fs/nfft;
fvec= fstep*(0: nfft/2-1);

% plotting filtered signal dft
figure(2);
plot(fvec, 2*abs(Y(1:nfft/2)))
title('Single-Sided Amplitude Spectrum of x(t)')
xlabel('Frequency (Hz)')
ylabel('|X(f)|')

%%
% Generate Magnitude Response
freqz(Hd);

%%
% Under-quantisation with presision of 2^(-7)
% Using custom function 'quantise' from line ?
b_q0 = quantise(b, 4);
Hd_q0 = dfilt.dffir(b_q0);
% Generate Magnitude Response of Under-quantised filter
freqz(Hd_q0);

% obtain hamming weight for each coef
hw0 = hamming_weight(b_q0, N, 'uint8');
hw0_sum = sum(hw0);
% calulate number of adders required for filter
% HW-1 per tap
adders_q0 = adders(hw0, N);

%%
% Appropriately-quantisation with presision of 2^(-15)
b_q1 = quantise(b, 16);
Hd_q1 = dfilt.dffir(b_q1);
% Generate Magnitude Response of Appropriately-quantised filter
freqz(Hd_q1);

% obtain hamming weight for each coef
hw1 = hamming_weight(b_q1, N, 'uint16');
hw1_sum = sum(hw1);
% calulate number of adders required for filter
% HW-1 per tap
adders_q1 = adders(hw1, N);

%%
% Appropriately-quantisation with presision of 2^(-31)
b_q2 = quantise(b, 32);
Hd_q2 = dfilt.dffir(b_q2);
% Generate Magnitude Response of Over-quantised filter
freqz(Hd_q2);

% obtain hamming weight for each coef
hw2 = hamming_weight(b_q2, N, 'uint32');
hw2_sum = sum(hw2);
% calulate number of adders required for filter
% HW-1 per tap
adders_q2 = adders(hw2, N);

%%
% obtain filtered audio
y = filter(Hd_q1,x);
% play and write filtered and quantisied audio
sound(y, Fs);
audiowrite('filtered_quant_speech_15.wav', y, Fs);

%%
% calculate the discrete fourier transform of filtered signal
% using 1024 dft samples
nfft= 2^10;
Y = fft(y, nfft);
fstep = Fs/nfft;
fvec= fstep*(0: nfft/2-1);

% plotting filtered signal dft
figure(3);
plot(fvec, 2*abs(Y(1:nfft/2)))
title('Single-Sided Amplitude Spectrum of x(t)')
xlabel('Frequency (Hz)')
ylabel('|X(f)|')

%%
% function to quantise input filter coefficients to given presision
function b_q = quantise(coef, N_mag_bits)
    % least sifnificant bit we can hold 
    lsb = 2^(-N_mag_bits);
    % use scaling factor (lsb) to obtain number of lsbs in each coef
    int_part = coef ./ lsb;
    % round quantisation value
    int_part = round(int_part);
    % obtain quantised coefficients
    b_q = int_part .* lsb;
end

%%
% function to calculate hamming weight for the filter coefficients
function hw = hamming_weight(coef, N, cast)
    % init list of hamming weights for each coef
    hw = zeros(1,N+1);
    % loop for each coef
    for i=1:N+1
        % cast fraction to a Cast-bit int
        temp = typecast(coef(i), cast);
        % sum the number of 1's in binary rep
        hw(i) = sum(dec2bin(temp(length(temp))) == '1');
    end
end

%%
% function to calculate adder required for a filter
function adders = adders(hw, N)
    % loop for each coef
    adders = 0;
    for i=1:N+1
        % if coef is not 0
        if hw(i) ~= 0
            % add hamming weight -1 to total adders
            adders = adders + (hw(i)-1);
        end
    end
end
