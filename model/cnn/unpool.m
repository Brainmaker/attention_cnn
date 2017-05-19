function [ unpooled_map ] = unpool( pooled_map, pooled_map_cord )
    %UNPOOL Unpooling of pooled maps
    %   Args:
    %     pooled_map: [ pooled_map_size * pooled_map_size * deepth ]
    %     pooled_map_cord: [ pooled_map_size * pooled_map_size * 2 * deepth ]
    %   Returns:
    %     unpooled_map: [unpooled_map_size * unpooled_map_size * deepth]
    %   Notes:
    %     In VGG16, unpooled_map_size = pooled_map_size * 2
    %
    %   Author: Wan Xiaolin <wanxl13@lzu.edu.cn>
    
    [pooled_map_size, ~, deepth] = size(pooled_map);
    unpooled_map_size = pooled_map_size * 2;
    unpooled_map = zeros(unpooled_map_size, unpooled_map_size, deepth);
    
    for i = 1 : deepth
        row_cord = pooled_map_cord(:, :, 1, i);
        col_cord = pooled_map_cord(:, :, 2, i);
        pool_val = pooled_map(:, :, i);
        for j = 1 : numel(row_cord)
            unpooled_map(row_cord(j), col_cord(j), i) = pool_val(j);
        end
    end
    
end

