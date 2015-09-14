function [trainData, testData, minX, maxX, minY, maxY, numOfClasses] = prepareInputData(path)  
%UNTITLED Summary of this function goes here
%   Cell array with each index contains a class's data (attribute table)
    
    
    command = ['ls',' ',path,' -l| grep Class | wc -l'];
    [~,output] = system(command);
    numOfClasses = str2double(output);
    trainData = cell(1,numOfClasses);
    testData = cell(1,numOfClasses);
    
    maxX = 0;
    maxY = 0;
    minX = 0;
    minY = 0;
    dirpath = (strcat(path,'*.txt'));
    Files=dir(dirpath);
   % system('mkdir Training');
   % system('mkdir Testing');;
        
    for i=1:length(Files)
        fileName=Files(i).name;
        inputData = load([path, fileName]);
        rows = size(inputData,1);
        trainData{i} =  inputData(1:floor((3/4)* rows),:);
        testData{i} = inputData(floor((3/4)*rows)+1:end,:);
       % dlmwrite([path, 'Training/', fileName], trainData{i}, '\t'); 
       % dlmwrite([path, 'Testing/', fileName], testData{i}, '\t'); 
        minX = min(min(trainData{i}(:,1)), minX);
        minY = min(min(trainData{i}(:,2)), minY);
        maxX = max(max(trainData{i}(:,1)), maxX);
        maxY = max(max(trainData{i}(:,2)), maxY);
    end 
end

  