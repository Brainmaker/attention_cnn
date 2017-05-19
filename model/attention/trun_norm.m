function [ y ] = trun_norm( x )
    %NORMLIZE Truncate input at zero and map input value to [0, 1]
    %   Note:
    %     trun_norm() truncate input x at zero so that only POSITIVE PART are
    %     normlied.
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    pos_part = max(x, 0);
    M = max(pos_part(:));
    m = min(pos_part(:));
    y = (pos_part - m) / (M - m);
    
end

