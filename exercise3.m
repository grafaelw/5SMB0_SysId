function [r, data_prbs, G0_prbs] = exercise3(M, N, m, x, result)

    [r_rgs] = idinput(N, 'rgs', [-x x],[-M M],[m, m, 1]);
    r_prbs = idinput(N,'prbs',[0 1/3],[-M M]);
    % [r_prbs] = idinput(N, 'prbs', [-x x],[-M M],[m, m, 1]);
    
    [u_rgs, y_rgs] = assignment_sys_12(r_rgs);
    [u_prbs, y_prbs] = assignment_sys_12(r_prbs);
    data_rgs = iddata(y_rgs, u_rgs);
    data_prbs = iddata(y_prbs, u_prbs);
    
    G0_rgs = etfe(data_rgs,m,N);
    G0_prbs = etfe(data_prbs,m,N);
    
    %% plot 
    
    if result
        figure
        bodeplot(G0_rgs)
        hold on
        bodeplot(G0_prbs)
        legend('RGS excitation', 'PRBS excitation')
        grid on
    end

    hold off
    %Going form r to u there is a filter with cut-off frequency of ~ 2.2 Hz and
    %a saturation block between -2 and 2.
    r = idinput(N, 'prbs', [-x x],[-M M],[m, m, 1]);
end