function [ conv_map ] = conv2d( input_map, krnls, bias )
    %CONV2D 2-D convolution of multidimensional activation maps
    %   Args:
    %     input_map: [ height * width * deepth ]
    %     krnls: [ kr_size * kr_size * deepth * n_krnls ]
    %     bias: [ n_krnls * 1 ]
    %   Return:
    %     conv_map : [ height * width * n_krnls ]
    %   Notes:
    %     In vgg16: height == width
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    x = im2col(padding(input_map));
    W = krnl2col(krnls);
    y = max(W * x + bias, 0); % ReLU
    conv_map = col2im(y);
     
end
