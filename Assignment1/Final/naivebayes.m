function naivebayes(path)
	path
	dotcolors = [0,100,0; 0,0,255; 139,0,0; 184,134,11]/255;
	colors = [152,251,152; 135,206,235; 240,128,128; 255,215,0]/255;

	
	numOfAttributes = 2 ;% d
	[trainData, testData, minX, maxX, minY, maxY, numOfClasses] = prepareInputData(path);

	allTogether = [];
	means = cell(1,numOfClasses);
	variances = cell(1,numOfClasses);
	sumCovariances = zeros(1,numOfAttributes)';

	for c = 1:numOfClasses
	  allTogether = [allTogether ; trainData{c}];
	  means{c} = mean(trainData{c})';
	  variances{c} = var(trainData{c})';
       testrows{c} = size(testData{c}, 1);
	%   for a = 1:numOfAttributes
	%     variances{c} = [variances{c} var(trainData{c}(:,a))]  %For different covariance
	%   end
	  sumCovariances = sumCovariances + variances{c};
	  % multivariantPdf(c) = exp(-((X-U)'*inv(SIGMA)*(X-U))/2)/(((2*pi)^(numOfAttributes/2))*(det(SIGMA)^(1/2)));
	end

	SIGMA = var(allTogether);   %For all classes together
	AVGSIGMA = sumCovariances/numOfClasses;
	MAVG = mean(AVGSIGMA);
	AVGSIGMA = [MAVG MAVG];

	Xmin = minX-2;
	Xmax = maxX+2;
	Ymin = minY-2;
	Ymax = maxY+2;
	Xsteps = (Xmax-Xmin)/400;
	Ysteps = (Ymax-Ymin)/400;

	xrange = Xmin:Xsteps:Xmax;
	yrange = Ymin:Ysteps:Ymax;

	%%%%%%%%%%%%%%%%
	%ALLTOGETHER
	%%%%%%%%%%%%%%%%

	clear regions
	regions = cell(1:numOfClasses);
    total = length(xrange)*length(yrange);
	count = 0;
	for i = xrange
	    for j = yrange
	       maxLikelihood = 0;
	       maxIndex = 1;
	       for c = 1:numOfClasses 
               
	            likelihood = getNaiveLikelihood([i j]', means{c}, SIGMA, numOfAttributes);
                if(likelihood > maxLikelihood);
	                maxLikelihood = likelihood;
                    
	                maxIndex = c;
                end
           end
	       regions{maxIndex} = [ regions{maxIndex}; [i,j] ];
          
	    end
	end

	totalcorrect = 0;
	totalnegative = 0;
	
	confusion = zeros(numOfClasses, numOfClasses);

	for i = 1:numOfClasses    
	    for c = 1:testrows{i}
	        maxLikelihood = 0;
	        maxIndex = 1;
	        for k = 1:numOfClasses
	            likelihood = getNaiveLikelihood([testData{i}(c,1) testData{i}(c,2)]', means{k}, SIGMA, numOfAttributes);
	            if(likelihood > maxLikelihood);
	                 maxLikelihood = likelihood;
	                 maxIndex = k;
	            end
	        end
	        confusion(i,maxIndex) = confusion(i,maxIndex) +1;
	        if(maxIndex == i)
	            totalcorrect = totalcorrect+1;
	        else
	            totalnegative = totalnegative+1;
	        end
	    end
	end

	confusion
	totalcorrect
	totalnegative
	accuracy = totalcorrect*100/(totalcorrect+totalnegative)

	fig = figure();
	hold on;
	xlabel('Attribute 1');
	ylabel('Attribute 2');
	axis([Xmin Xmax Ymin Ymax]);
	for i = 1:numOfClasses
	    plot(regions{i}(:,1), regions{i}(:,2), '*' ,'color', colors(i,:));
	end
	for i = 1:numOfClasses
	    plot(trainData{i}(:,1), trainData{i}(:,2), 's', 'color', dotcolors(i,:));
	end
	print(fig, strcat(path,'all_cov'),'-dpng');

	%%%%%%%%%%%%%%%%
	%AVERAGE
	%%%%%%%%%%%%%%%%
	

	clear regions
	regions = cell(1:numOfClasses);
    total = length(xrange)*length(yrange);
	count = 0;
	for i = xrange
	    for j = yrange
	       maxLikelihood = 0;
	       maxIndex = 1;
	       for c = 1:numOfClasses 
	            likelihood = getNaiveLikelihood([i j]', means{c}, AVGSIGMA, numOfAttributes);
	            if(likelihood > maxLikelihood);
	                maxLikelihood = likelihood;
	                maxIndex = c;
	            end
	       end
	       regions{maxIndex} = [ regions{maxIndex}; [i,j] ];
         
	    end
	end

	totalcorrect = 0;
	totalnegative = 0;
	
	confusion = zeros(numOfClasses, numOfClasses);

	for i = 1:numOfClasses    
	    for c = 1:testrows{i}
	        maxLikelihood = 0;
	        maxIndex = 1;
	        for k = 1:numOfClasses
	            likelihood = getNaiveLikelihood([testData{i}(c,1) testData{i}(c,2)]', means{k}, AVGSIGMA, numOfAttributes);
	            if(likelihood > maxLikelihood);
	                 maxLikelihood = likelihood;
	                 maxIndex = k;
	            end
	        end
	        confusion(i,maxIndex) = confusion(i,maxIndex) +1;
	        if(maxIndex == i)
	            totalcorrect = totalcorrect+1;
	        else
	            totalnegative = totalnegative+1;
	        end
	    end
	end

	confusion
	totalcorrect
	totalnegative
	accuracy = totalcorrect*100/(totalcorrect+totalnegative)

	fig = figure();
	hold on;
	xlabel('Attribute 1');
	ylabel('Attribute 2');
	axis([Xmin Xmax Ymin Ymax]);
	for i = 1:numOfClasses
	    plot(regions{i}(:,1), regions{i}(:,2), '*' ,'color', colors(i,:));
	end
	for i = 1:numOfClasses
	    plot(trainData{i}(:,1), trainData{i}(:,2), 's', 'color', dotcolors(i,:));
	end
	print(fig, strcat(path,'avg_cov'),'-dpng');

	%%%%%%%%%%%%%%%%
	%DIFFERENT
	%%%%%%%%%%%%%%%%


	clear regions
	regions = cell(1:numOfClasses);
    total = length(xrange)*length(yrange);
	count = 0;
	for i = xrange
	    for j = yrange
	       maxLikelihood = 0;
	       maxIndex = 1;
	       for c = 1:numOfClasses 
	            likelihood = getNaiveLikelihood([i j]', means{c}, variances{c}, numOfAttributes);
	            if(likelihood > maxLikelihood);
	                maxLikelihood = likelihood;
	                maxIndex = c;
	            end
	       end
	       regions{maxIndex} = [ regions{maxIndex}; [i,j] ];
           %  count = count + 1;
	       % progress = (count*100)/total
	    end
	end

	totalcorrect = 0;
	totalnegative = 0;
	
	confusion = zeros(numOfClasses, numOfClasses);

	for i = 1:numOfClasses    
	    for c = 1:testrows{i}
	        maxLikelihood = 0;
	        maxIndex = 1;
	        for k = 1:numOfClasses
	            likelihood = getNaiveLikelihood([testData{i}(c,1) testData{i}(c,2)]', means{k}, variances{k}, numOfAttributes);
	            if(likelihood > maxLikelihood);
	                 maxLikelihood = likelihood;
	                 maxIndex = k;
	            end
	        end
	        confusion(i,maxIndex) = confusion(i,maxIndex) +1;
	        if(maxIndex == i)
	            totalcorrect = totalcorrect+1;
	        else
	            totalnegative = totalnegative+1;
	        end
	    end
	end

	confusion
	totalcorrect
	totalnegative
	accuracy = totalcorrect*100/(totalcorrect+totalnegative)

	fig = figure();
	hold on;
	xlabel('Attribute 1');
	ylabel('Attribute 2');
	axis([Xmin Xmax Ymin Ymax]);
	for i = 1:numOfClasses
	    plot(regions{i}(:,1), regions{i}(:,2), '*' ,'color', colors(i,:));
	end
	for i = 1:numOfClasses
	    plot(trainData{i}(:,1), trainData{i}(:,2), 's', 'color', dotcolors(i,:));
	end
	print(fig, strcat(path,'diff_cov'),'-dpng');
end