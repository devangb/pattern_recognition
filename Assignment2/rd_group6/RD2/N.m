function gaussDensity = N(d,DataPoint,Mean,Cov)

gaussDensity=(1/(((2*pi)^(d/2))*(det(Cov)^(1/2))))*exp((-1/2)*(DataPoint-Mean)*inv(Cov)*(transpose(DataPoint-Mean)));