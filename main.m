clc;
clear all;
close all;

result = true;

m = 128;
N = 1024;

if result
    [M, cut_off_freq, x] = exercise1(true);
    % G0_tf = exercise2(N, M, m, x, true);
    N = 3000;
    [r, data_prbs, G0_prbs] = exercise3(M, N, m, x, true);
    exercise4(data_prbs, G0_prbs, true);
end



