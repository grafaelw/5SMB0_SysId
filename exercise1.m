function [M, cut_off_freq, x] = exercise1(result)
% Created an r which goes form a 0 to a large value, noticed it would
% saturate after y=2, same for the negative side, therefore:
resolution = 0.001;
largenumber = 1000;
frequency = -largenumber:resolution: largenumber;                       %Hz
r = frequency;
[u, y] = assignment_sys_12(r);
M = max(u);

% Create Z-transform of the transferfunction given in assignment of the
% Butterworth filter:

n_filt = [0.505 1.01 0.505];
m_filt = [1 0.7478 0.2722];
Fz = filt(n_filt, m_filt);

cut_off_freq = bandwidth(Fz);    % read from the bode plot in rad/s
x = cut_off_freq/pi;

if result
    figure("Name","Bode Plot", "NumberTitle","off")
    freqz(n_filt, m_filt)
    hold on
    plot(x,-3,'r*')
    ylim([-20 3]);
    copygraphics(gcf);
end


% State answers in the command window:
fprintf('Exercise 1:\n')
fprintf('Created an r which goes form a 0 to a large value, noticed it would saturate after y=2, \nsame for the negative side, therefore: M = %d\n', M)
fprintf('The definition of cross-over frequency is given by the bandwidth. \nThe value for x is given by cut-off-freq = x*pi so:\n cut-off frequency = %d rad/s \n x = \t\t\t\t %d \n', cut_off_freq, x)
fprintf('\n')
end