% clc;clear all;close all;
% % from Q4 we have (N = 3000): 
% load('Q4.mat')
% nb = 5;nf = 8;nk = 0;
% oe580 = oe([Q4(:,2) Q4(:,1)], [nb nf nk]);
% % cross correlation test >>> which is good
% figure
% resid([Q4(:,2) Q4(:,1)],oe580)
% B = oe580.B;F=oe580.F;      %Theoretical values
% var_theory = diag(getcov(oe580))'
%% for Exercise 5, we have:  nb = 4; nc = 3; nd=4; nf =4; nk = 1;
clc;clear all;close all;
% from Q4 we have (N = 3000): 
load('est_model_and_dataPRBS.mat')
nb = 4;nf = 4;nk = 1;
oe441_5 = oe(data_prbs, [nb nf nk]);
B = oe441_5.B;F=oe441_5.F;      %Theoretical values
% Monte Carlo without init
N5 = 1000;
N_c = 3;
M = 2;
Range5 = [-M, M]; Band5 = [0 1/N_c];
nb = 4; nf = 4; nk = 1; % From Q4

for i = 1:100
    r5(:,i) = idinput(N5,'rbs',Band5,Range5);
    [u5(:,i), y5(:,i)] = assignment_sys_12(r5(:,i));
    OE_modelout = oe(iddata(y5(:,i),u5(:,i)), [nb nf nk]); 
    OE.B(i,:) = OE_modelout.B; OE.F(i,:) = OE_modelout.F;   % Monte Carlo
end
Theoret_cov = diag(getcov(OE_modelout))';
OE.meanB = mean(OE.B); OE.meanF = mean(OE.F);
OE.varB = var(OE.B); OE.varF = var(OE.F);

% B_theory =      2.2972    1.8589    1.4432    0.2831
% B_monte_mean =  0.0093    2.0458    2.4121    1.4112

% F_theory =     -1.6009    1.9016   -1.3594    0.7479
% F_monte_mean =  0.2988    1.0136    0.7857    0.1468

% var_theory =  0.0141    0.2072    0.5423    0.0323    0.0143    0.0069    0.0113    0.0129
% var_monte  =  0.0093    2.0458    2.4121    1.4112    0.2988    1.0136    0.7857    0.1468

% monte carlo with init
OE.medianB = median(OE.B); OE.medianF = median(OE.F);
M_init = idpoly([],OE.medianB,[],[],OE.medianF);

for i = 1:100
    r5med(:,i) = idinput(N5,'rbs',Band5,Range5);
    [u5med(:,i), y5med(:,i)] = assignment_sys_12(r5med(:,i));
    M_oe = oe([y5med(:,i) u5med(:,i)],M_init);
    OEmed.B(i,:) = M_oe.B; OEmed.F(i,:) = M_oe.F;
end
Theoret_med_cov = diag(getcov(M_oe))';
OEmed.meanB = mean(OEmed.B); OEmed.meanF = mean(OEmed.F);
OEmed.varB = var(OEmed.B); OEmed.varF = var(OEmed.F);

% B_theory =      2.2972       1.8589       1.4432       0.2831
% B_monte_mean =  0.0093       2.0458       2.4121       1.4112
% B_monte_init =  0.0000670    0.0003429    0.0006264    0.0000905

% F_theory =     -1.6009         1.9016        -1.3594         0.7479
% F_monte_mean =  0.2988         1.0136         0.7857         0.1468
% F_monte_init =  0.000001870    0.000004168    0.000003695    0.000001280
 
% var_theory =       0.0141       0.2072       0.5423       0.0323       0.0143         0.0069         0.0113         0.0129
% var_monte  =       0.0093       2.0458       2.4121       1.4112       0.2988         1.0136         0.7857         0.1468
% var_monte_init  =  0.0000670    0.0003429    0.0006264    0.0000905   0.000001870    0.000004168    0.000003695    0.000001280


%%  Signal generation performed once
N6 = 1000; Range6 = [-M, M]; Band6 = [0 1/N_c];
r6 = idinput(N6,'rbs',Band6,Range6);
[u6, y6] = assignment_sys_12(r6);
%% Exercise 6.1 --> Monte Carlo simulation for precise tuning into BJ
load('Q6.mat')
nb = 4; nc = 3; nd = 4; nf = 4; nk = 1;
BJ44341 = bj([Q6(:,2) Q6(:,1)],[nb nc nd nf nk]);
present(BJ44341)
compare([Q6(:,2) Q6(:,1)],BJ44341,1)    %1 step ahead prediction (not asked)
figure
resid([Q6(:,2) Q6(:,1)],BJ44341)

% design BJ
% calculate the variance : diag(getcov...
% Then do the monte carlo 

% figure
% etfe_data=etfe([Q6(:,2) Q6(:,1)],[]);
% bodeplot(etfe_data);
% hold on
% etfe_bj = 
%% 6.2
cov_mat = getcov(BJ44341);
var_th6 = diag(getcov(BJ44341))'

% var_oe = theory = 0.0002  0.0039  0.1978  0.0133  0.0010  0.0825  0.5805  1.2717  1.4092  0.9364  0.3001  0.0332  0.0011
% var_monte       = 0.0013  0.0062  0.0297  0.0457  0.1049  0.0039  0.0010  0.0001  0.0003  0.0018  0.0006  0.0010  0.0008 
% var_monte_init  = 0.0006  0.0097  0.6502  0.0198  0.0104  0.2438  1.7220  3.8545  4.3450  2.9111  0.9446  0.1109  0.0043 
%var_ bj          = 0.0001  0.0009  0.0021  0.0049  0.0042  0.0581  0.0617  0.0078  0.0028  0.0575  0.0752  0.0314  0.0267




%% antwoorden op vraag 6: 
% 6.1: Based on the anaysis done in q4 and q5, an OE model is obtained for
% which the the conclusion is that the estimation is consistent (according
% to the cross correlation test and also the fact that the input is P.E
% high sufficient order and G0 belongs to G. However, it can be seen that
% the variances are relatively high. To reduse the variance, it is
% attempted to design a Box Jenkins model. The advantage of this model is
% that it also takes the behaviour of the noise into the consideration when
% designing such a model and the G0 can be reused from the OE model. 
%Using ident tool (the system identofocation tool within MATLAB), it can be
% observed that re-using G0 from OE model comes in handy since the
% cross-correlation plot from residual lies within the confidence interval.
% The auto-correlation which is related to the H0 can also be estimated by
% adjusting the parameters nc and nd. Doing so, leads to the following
% order of parameters, in total: 
% nb = 5; nc = 4; nd = 4; nf = 8; nk = 0;
% Based on the residual test plot, it can be seen that both tests have
% passed. Therefore, it can be stated that G0 and H0 are properly
% estimated. 
%
%6.2: Extracting the relevant variances from diag(get(cov)) shown above, 
% leads to the fact the variances from BJ model becomes much more closer to
% the theoretical ones. In fact the variances reduce with a factor 6-7 in
% comparison to monte carlo with and without initialization. This drastic
% reduction comes from modelling the H0 as well.

