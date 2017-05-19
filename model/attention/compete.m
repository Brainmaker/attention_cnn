function [ y ] = compete( x, beta )
    %COMPETE Competitive annotation function
    y = max(x - beta * mean(x(:)), 0);
end

