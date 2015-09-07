function [ trainList, testList ] = prepLists( classList )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%     trainList = [];
%     testList = [];
%    whos trainList
%    whos testList
    for i = 1:size(classList)
        whos classList
        [train, test] = prepareInputData(classList{i});
        trainList(i) = train;
        testList(i) = test;
    
end

