
function [train, test] = prepareInputData(inputData, name)
%Prepares Input by partitioning into training and test sets
%inputData - matrix
%name - string of fileName
    rows = size(inputData,1);
    train =  inputData(1:(3/4)* rows,:);
    test = inputData((3/4)*rows+1:end,:);
    dlmwrite(strcat('Training/', name), train, '\t'); 
    dlmwrite(strcat('Testing/', name), test, '\t'); 
end