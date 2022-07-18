function G0_tf = exercise2(N, xc, M, m, x, result)

r = idinput([N,1,xc], 'sine', [0, x],[-M M],[m, 10, 1]);
r1 = idinput([N,1,xc*4], 'sine', [0, x],[-M M],[m, 10, 1]);
% [r] = idinput(N, 'rgs', [-x x],[-M M],[m, m, 1]);
[u, y] = assignment_sys_12(r);
[u1, y1] = assignment_sys_12(r1);

data = iddata(y, u);

%%2.2 The bodeplot has two resanence peaks, at around 675 rad/s and 1500
%%rad/s. After the second resonance peak the effect of the noise takes over
%%and the graph becomes less readable/usable.
G0 = etfe(data,m,N);
[G0_tf, G0_noi, ~] = spa(data); %Could tweak this by adding more arguments, like M, w, maxsize.
if result
    figure
%     subplot(2,1,1)
    bodeplot(G0)
%     subplot(2,1,2)
%     plot(fc/pi,cxy)
%     nyquist(G0)

    figure
    subplot(2,1,1)
    bodeplot(G0_tf)
    subplot(2,1,2)
    nyquist(G0_tf)

    figure
    R_yu1 = cpsd(y, u,[],[],N*xc);
    R_u1 = cpsd(u, u,[],[],N*xc);
    R_y1 = cpsd(y, y,[],[],N*xc);

    R_yu2 = cpsd(y1,u1,[],[],N*xc*4);
    R_u2 = cpsd(u1, u1,[],[],N*xc*4);
    R_y2 = cpsd(y1, y1,[],[],N*xc*4);

    R_v1 = (R_y1 - abs(R_yu1).^2./R_u1);
    R_v2 = (R_y2 - abs(R_yu2).^2./R_u2);
    plot(linspace(0,3,length(R_v1)),R_v1)
    set(gca,'FontWeight','bold')
    hold on
    plot(linspace(0,3,length(R_v2)),R_v2)
    ylabel("$\Phi_v(\omega)$","Interpreter","latex",'FontSize',14,'FontWeight','bold');xlabel("$\theta$","Interpreter","latex",'FontSize',14,'FontWeight','bold');
    legend("N=1024","N=4096",'FontSize',14,'FontWeight','bold')

    %v_mag_bode = etfe(R_v);

    %bode(G0_noi)
    %tmp = G0_noi;

end

