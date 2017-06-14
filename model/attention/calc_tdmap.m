function [ td_map ] = calc_tdmap( td, bu, W, hp )
    %GETTDMAP Calculate top-down saliency map on the given parameters.
    %   Args:
    %     td: Top-down signal.
    %     bu: Bottom-up saliency map.
    %     W: NN weights, conv kernel or full-connected layer weights.
    %     hp: Hyperparamters.
    %   Returns:
    %     td_map: Top-down saliency map.
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    W = max(W, 0);
    if ismatrix(W)  % Full-connected layer
        X = W * bu;
        Y = td ./ X;
        Z = W' * Y;
        td_map = bu .* Z;
    else  % Convolutional layer
        WT = krnl2col(permute(W, [1, 2, 4, 3]));
        W = krnl2col(W);
        bu_col = im2col(padding(bu));
        X = W * bu_col;
        X = col2im(X);
        Y = compete(td, hp) ./ X; 
        Y = im2col(padding(Y));
        Z = WT * Y;
        Z = col2im(Z);
        td_map = bu .* Z;
    end
end
