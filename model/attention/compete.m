function [ y ] = compete( x, beta )
    %COMPETE competative annotation function
    y = max(x - beta * mean(x(:)), 0);
end

