function [ pred ] = predict( bu1_81, class_name )
    %PREDICT 
    pred.cls_prob = 0;
    pred.cls_id   = 0;
    pred.result   = '';
    
    [pred.cls_prob, pred.cls_id] = max(softmax(bu1_81));
    pred.result = [ ...
        'Class Name: ', string(class_name{pred.cls_id}), '; ', ...
        'Class ID: ', num2str(pred.cls_id), '; ', ...
        'Class Probability: ', num2str(pred.cls_prob), ';'];
end

