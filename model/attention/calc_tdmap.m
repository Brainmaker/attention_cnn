function [ td_map ] = calc_tdmap( g, bu, W_, hp )
    %GETTDMAP Get top-down saliency map.
    %   Args:
    %     g:
    %     bu:
    %     W:
    %     hp:
    %   Returns:
    %     td_map:
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    W_ = max(W_, 0);
    if ismatrix(W_) % Full-connected layer
        W = W_;
        X = W * bu;
        %Y = compete(g, hp) ./ X;
        Y = g ./ X;
        Z = W' * Y;
        td_map = bu .* Z;
    else % Convolutional layer
        W = krnl2col(W_);
        WT = krnl2col(permute(W_, [1, 2, 4, 3]));
        bu_col = im2col(padding(bu));
        X = W * bu_col;
        X = col2im(X);
        Y = compete(g, hp) ./ X; 
        Y = im2col(padding(Y));
        Z = WT * Y;
        Z = col2im(Z);
        td_map = bu .* Z;
    end
end




































