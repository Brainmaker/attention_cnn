function [ y ] = compete( x, beta )
    %COMPETE
    y = max(x - beta * mean(x(:)), 0);
end

