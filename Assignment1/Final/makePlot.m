function = makePlot()
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
	
end