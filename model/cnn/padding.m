% -*- coding: utf-8 -*-
%
% Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
%
% tensor3d: [ height * width * deepth ]
% y: [ (height + 2) * (width + 2) * deepth ]

function [ y ] = padding( tensor3d )
    %PADDING Pad input image
    %   Zero padding in the image border.
    [ height, width, deepth ] = size(tensor3d);
    row_zpad = zeros(1, width, deepth);
    col_zpad = zeros(height+2, 1, deepth);
    y = [col_zpad, [row_zpad; tensor3d; row_zpad], col_zpad];
    
end