function [ weights2d ] = fcp2col( weights4d )
    %FCP2COL Rearrange 4-D full-connected layer parameters to matrix
    %   Args:
    %     weights4d: [ kr_size * kr_size * n_krnls * output_size ]
    %   Returns:
    %     weights2d: [ input_size * output_size ]
    %       input_size = kr_size*kr_size*n_krnls
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    [map_size, ~, n_krnls, output_size] = size(weights4d);
    n = map_size * map_size * n_krnls;
    weights2d = reshape(weights4d, [n, output_size])'; % Transportation
end

