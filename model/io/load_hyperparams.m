function [ hp ] = load_hyperparams( using_hyperparams )
    %LOAD_HYPERPARAMS
    if using_hyperparams
        hp.alpha = 1;
        hp.beta = cell(8, 3);
        hp.beta{8, 1} = 0;
        hp.beta{7, 1} = 0;
        hp.beta{6, 1} = 0;
        hp.beta{5, 3} = 1;
        hp.beta{5, 2} = 1;
        hp.beta{5, 1} = 1;
        hp.beta{4, 3} = 1;
        hp.beta{4, 2} = 1;
        hp.beta{4, 1} = 1;
        hp.beta{3, 3} = 1;
        hp.beta{3, 2} = 0.5;
        hp.beta{3, 1} = 0.1;
        hp.beta{2, 2} = 0.05;
        hp.beta{2, 1} = 0.05;
        hp.beta{1, 2} = 0.05;
        hp.beta{1, 1} = 0;
    else
        hp.alpha = 1;
        hp.beta = cell(8, 3);
        hp.beta{8, 1} = 0;
        hp.beta{7, 1} = 0;
        hp.beta{6, 1} = 0;
        hp.beta{5, 3} = 0;
        hp.beta{5, 2} = 0;
        hp.beta{5, 1} = 0;
        hp.beta{4, 3} = 0;
        hp.beta{4, 2} = 0;
        hp.beta{4, 1} = 0;
        hp.beta{3, 3} = 0;
        hp.beta{3, 2} = 0;
        hp.beta{3, 1} = 0;
        hp.beta{2, 2} = 0;
        hp.beta{2, 1} = 0;
        hp.beta{1, 2} = 0;
        hp.beta{1, 1} = 0;
    end

end

