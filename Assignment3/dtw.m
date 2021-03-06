function [distance] = dtw(feature1,feature2)
    matrix = zeros(length(feature1),length(feature2));
    for i = 1:length(feature1)
        for j = 1:length(feature2)
            matrix(i,j) = dist(feature1(i), feature2(j));
        end
    end
    for i = 2:length(feature1)
        matrix(i,1) = matrix(i-1,1)+matrix(i,1);
    end
    for j = 2:length(feature2)
        matrix(1,j) = matrix(1,j-1)+matrix(1,j);
    end
    for i = 2:length(feature1)
        for j = 2:length(feature2)
            matrix(i,j) = matrix(i,j) + min(matrix(i-1,j),min(matrix(i-1,j-1),matrix(i,j-1)));
        end
    end
    distance = matrix(length(feature1),length(feature2));
end