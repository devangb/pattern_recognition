function likelihood =  getNaiveLikelihood(x, meu, sigma, numOfAttributes)
	likelihood = 1;
	for i = 1:numOfAttributes
		likelihood = likelihood * (exp(-(power((x(i)-meu(i))/sqrt(sigma(i)), 2)/2))/ (sqrt(2*pi*sigma(i))));
	end
end