function [train test] = datasets( dir1, dir2, dir3 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    trainData = cell(1,3)
    testData = cell(1,3)
    Files1 = dir(strcat(dir1,'*.jpg_color_edh_entropy'))
    Files2 = dir(strcat(dir2,'*.jpg_color_edh_entropy'))
    Files3 = dir(strcat(dir3,'*.jpg_color_edh_entropy'))
    trainnum1 = floor(3*length(Files1)/4)
    trainnum2 = floor(3*length(Files2)/4)
    trainnum3 = floor(3*length(Files3)/4)
    
    for i = 1:trainnum1
        fileName = Files1(i).name
        inputData = load([dir1, fileName])
        trainData{1}{i} = inputData(:,:)
    end
    
    for i = 1:trainnum2
        fileName = Files2(i).name
        inputData = load([dir2, fileName])
        trainData{2}{i} = inputData(:,:)
    end
    
    for i = 1:trainnum3
        fileName = Files3(i).name
        inputData = load([dir3, fileName])
        trainData{3}{i} = inputData(:,:)
    end
    
    for i = trainnum1+1:length(Files1)
        fileName = Files1(i).name
        inputData = load([dir1, fileName])
        testData{1}{i} = inputData(:,:)
    end
    
    for i = trainnum2+1:length(Files2)
        fileName = Files2(i).name
        inputData = load([dir2, fileName])
        testData{2}{i} = inputData(:,:)
    end
    
    for i = trainnum3+1:length(Files3)
        fileName = Files3(i).name
        inputData = load([dir3, fileName])
        testData{3}{i} = inputData(:,:)
    end
    train = trainData
    test = testData
end

