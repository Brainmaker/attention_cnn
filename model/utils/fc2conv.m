function [ map3d ] = fc2conv( x, map_size, n_krnls )
    %FC2COV Convert full-connected layer output vectors to convolutional maps
    %   Args:
    %     x: [ n * 1 ]
    %     map_size: size of convolutional maps
    %     n_krnls: deepth of convolutional maps, i.e. number of kernels
    %   Returns:
    %     map3d: [ map_size * map_size * n_krnls ]
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    map3d = reshape(x, [map_size, map_size, n_krnls]);
    
end

