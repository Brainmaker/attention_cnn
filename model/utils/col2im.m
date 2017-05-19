function [ y ] = col2im( mat )
    %COL2IM  Convert matrix columns to images
    %   Args:
    %     mat: [ n_krnls * (im_size * im_size) ]
    %   Returns:
    %     y: [ im_size * im_size * n_krnls  ]
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    n_krnls = size(mat, 1);
    im_size = sqrt(size(mat, 2));
    y = reshape(mat', [im_size, im_size, n_krnls]);
    y = permute(y, [2, 1, 3]);
    
end