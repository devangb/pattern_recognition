function bayes(path)
	dotcolors = [0,100,0; 0,0,255; 139,0,0; 184,134,11]/255;
	colors = [152,251,152; 135,206,235; 240,128,128; 255,215,0]/255;

	
	numOfAttributes = 2 ;% d
	[trainData, testData, minX, maxX, minY, maxY, numOfClasses] = prepareInputData(path);

	allTogether = [];
	means = cell(1,numOfClasses);
	covariances = cell(1,numOfClasses);
	sumCovariances = zeros(numOfAttributes,numOfAttributes);
	sumRows = 0;

	for c = 1:numOfClasses
	  allTogether = [allTogether ; trainData{c}];
	  means{c} = mean(trainData{c})';
	  covariances{c} = cov(trainData{c});  %For different covariance
	  sumCovariances = sumCovariances + covariances{c};
	  nrows{c} = size(trainData{c} , 1);
	  testrows{c} = size(testData{c}, 1);
	  sumRows = sumRows + nrows{c};  %Not required
	end

	SIGMA = cov(allTogether);   %For all classes together
	AVGSIGMA = sumCovariances/numOfClasses; %For average covariance

	   
	getLikelihood=@(x,mean,var) (1/((2*pi)*det(sqrt(var))))*exp((-0.5)*(x-mean)'*inv(var)*(x-mean));

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
	            likelihood = getLikelihood([i j]', means{c}, SIGMA);
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
	            likelihood = getLikelihood([testData{i}(c,1) testData{i}(c,2)]', means{k}, SIGMA);
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
	            likelihood = getLikelihood([i j]', means{c}, AVGSIGMA);
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
	            likelihood = getLikelihood([testData{i}(c,1) testData{i}(c,2)]', means{k}, AVGSIGMA);
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
	            likelihood = getLikelihood([i j]', means{c}, covariances{c});
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
	            likelihood = getLikelihood([testData{i}(c,1) testData{i}(c,2)]', means{k}, covariances{k});
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
%end
	
