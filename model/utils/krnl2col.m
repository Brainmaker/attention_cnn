function [ y ] = krnl2col( krnls )
    %KRNL2COL Rearrange convolutional kernel to matrix column
    %   Args:
    %     krnls: [ kr_size * kr_size * deepth * n_krnls ]
    %   Returns:
    %     y: [ n_krnls * (kr_size^2 * deepth) ]
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    [kr_size, ~, deepth, n_krnls] = size(krnls);
    y = reshape(krnls, [kr_size*kr_size*deepth, n_krnls])';
    
end