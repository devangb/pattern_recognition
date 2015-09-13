function [train, test] = partitionInputData(classNo)
%Prepares Input by partitioning into training and test sets
%inputData - matrix
%name - string of fileName
    fileName = strcat( strcat('class', num2str(classNo)) ,'.txt');
    inputData = load(fileName);
    rows = size(inputData,1);
    train =  inputData(1:floor((3/4)* rows),:);
    test = inputData(floor((3/4)*rows)+1:end,:);
    system('mkdir Training');
    system('mkdir Testing');
    dlmwrite(strcat('Training/', fileName), train, '\t'); 
    dlmwrite(strcat('Testing/', fileName), test, '\t'); 
end