function [trainData, testData, minX, maxX, minY, maxY, numOfClasses] = prepareInputData()  
%UNTITLED Summary of this function goes here
%   Cell array with each index contains a class's data (attribute table)
    [~,output] = system('ls -l| grep Class | wc -l');
    numOfClasses = str2double(output);
    trainData = cell(1,numOfClasses);
    testData = cell(1,numOfClasses);
    
    maxX = 0;
    maxY = 0;
    minX = 0;
    minY = 0;
    for i=1:numOfClasses
        [trainData{i}, testData{i}] = partitionInputData(i);
        minX = min(min(trainData{i}(:,1)), minX);
        minY = min(min(trainData{i}(:,2)), minY);
        maxX = max(max(trainData{i}(:,1)), maxX);
        maxY = max(max(trainData{i}(:,2)), maxY);
    end
%     hold on;
%     plot(trainData{1}(:,1), trainData{1}(:,2),'.c')
%     plot(trainData{2}(:,1), trainData{2}(:,2),'.b')
%     plot(trainData{3}(:,1), trainData{3}(:,2),'.g') 
end

  