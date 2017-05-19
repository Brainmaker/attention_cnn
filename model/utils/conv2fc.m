function [ x ] = conv2fc( map3d )
    %CONV2FC Convert convolutional feature maps to column vectors. 
    %   Args:
    %     map3d: [ map_size * map_size * n_krnls ]
    %   Returns:
    %     x: [ n * 1 ]
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    [map_size, ~, n_krnls] = size(map3d);
    n = map_size * map_size * n_krnls;
    x = reshape(map3d, [n, 1]);
    
end

