[trainData, testData, minX, maxX, minY, maxY, numOfClasses] = prepareInputData();

[rows, cols] = size(trainData{1});


syms X a1 a2;

multivariantPdf(1:numOfClasses) = X;
numOfAttributes = 2 ;% d

X = [a1 a2]';

allTogether = [];
means = cell(1,numOfClasses);
covariances = cell(1,numOfClasses);
sumCovariances = zeros(numOfAttributes,numOfAttributes);

for c = 1:numOfClasses
  allTogether = [allTogether ; trainData{c}];
  means{c} = mean(trainData{c})';
  covariances{c} = cov(trainData{c});  %For different covariance
  sumCovariances = sumCovariances + covariances{c};
  % multivariantPdf(c) = exp(-((X-U)'*inv(SIGMA)*(X-U))/2)/(((2*pi)^(numOfAttributes/2))*(det(SIGMA)^(1/2)));
end

SIGMA = cov(allTogether);   %For all classes together
AVGSIGMA = sumCovariances/numOfClasses; %For average covariance

   

getLikelihood=@(x,mean,var) (1/((2*pi)*det(sqrt(var))))*exp((-0.5)*(x-mean)'*inv(var)*(x-mean));

dotcolors = [0,100,0; 0,0,255; 139,0,0; 184,134,11]/255;
colors = [152,251,152; 135,206,235; 240,128,128; 255,215,0]/255;

xrange = minX-5:0.1:maxX+5;
yrange = minY-5:0.1:maxY+5;

% total = length(xrange)*length(yrange)
% count = 0;

regions = cell(1:numOfClasses);

for i = xrange
    for j = yrange
       maxLikelihood = 0;
       maxIndex = 1;
       for c = 1:numOfClasses 
%             likelihood = subs(multivariantPdf(c),[a1, a2],[i, j]);
            likelihood = getLikelihood([i j]', means{c}, AVGSIGMA );
            if(likelihood > maxLikelihood);
                maxLikelihood = likelihood;
                maxIndex = c;
            end
       end
       regions{maxIndex} = [ regions{maxIndex}; [i,j] ];
%        count = count + 1;
%        progress = (count*100)/total
    end
end

hold on;
title('Interlock Data:Bayesian Classification:Average Covariance');
xlabel('Attribute 1');
ylabel('Attribute 2');
axis([minX-5 maxX+5 minY-5 maxY+5]);
for i = 1:numOfClasses
    plot(regions{i}(:,1), regions{i}(:,2), '*' ,'color', colors(i,:));
end
for i = 1:numOfClasses
    plot(testData{i}(:,1), testData{i}(:,2), 'o', 'color', dotcolors(i,:));
end
% axis([minX-5 maxX+5 minY-5 maxY+5])
% u1 = mean(trainc1)';
% u2 = mean(trainc2)';
% u3 = mean(trainc3)';
% 
% E_ = inv(cov(trainc));
% w_12_ = (E_*(u1-u2))';
% w_23_ = (E_*(u2-u3))';
% w_31_ = (E_*(u3-u1))';
% 
% x_0_12 = 1/2*(u1+u2);
% 
% x_0_23 = 1/2*(u2+u3);
% 
% x_0_31 = 1/2*(u3+u1);


% for i = -10:0.5:25
%     for j = -25:0.5:25
%         if(w_12_*([i,j]'- x_0_12) > 0)
%           plot(i,j,'.r');
%         elseif(w_12_*([i,j]'- x_0_12) < 0)
%           plot(i,j,'.b');
%         end
%         if(w_12_*([i,j]'- x_0_12) > 0 && w_23_*([i,j]'- x_0_23) > 0)
%           plot(i,j,'.r');
%         elseif(w_12_*([i,j]'- x_0_12) > 0 && w_23_*([i,j]'- x_0_23) <= 0 )
%           plot(i,j,'.g');
%         elseif(w_12_*([i,j]'- x_0_12) <= 0 && w_23_*([i,j]'- x_0_23) > 0)
%             plot(i,j,'.b');
%         end
%         else
%           plot(i,j,'.g');
%         end
%     end
% end

% syms x h w;
% x = [h, w]';
% eqn1 = w_12_*(x-x_0_12);
% eqn2 = w_23_*(x-x_0_23);
% eqn3 = w_31_*(x-x_0_31);
% 
% val1 = double(subs(eqn2,x,u1))
% val2 = double(subs(eqn3,x,u1))
% 
% plot(val1,val2,'MarkerFaceColor', 'b0e0e6');

% liesInRegion([1,4]',val1, val2,x, eqn2,eqn3)
% 
% for i = -10:2:25
%     for j = -25:2:25
%     
%     end
% end

% 
% solve(eqn1,h)

% hold on;
% subseqn1 = subs(eqn1, h, -10:0.1:25)
% plot([-25:0.1:10],subseqn1)
%plot([-10 -10:0.1:25 25], [-10 subs(eqn1,{h w},{-10:0.1:25}) -10]);

% plot1 = ezplot(eqn1,[-10,25,-25,25]);
%plot2 = ezplot(eqn2,[-10,25,-25,25]);
%plot3 = ezplot(eqn3,[-10,25,-25,25]);


% xd1 = get(plot1, 'XData');xd2 = get(plot2, 'XData');
% yd1 = get(plot1, 'YData'); yd2 = get(plot2, 'YData');
% X = [xd1,fliplr(xd2)];
% Y = [yd1, fliplr(yd2)];
% plot(-10:0.1:25, yd2);
%in_1_2 = solve(eqn1 == eqn2)
%in_2_3 = solve(eqn2,eqn3);
%in_3_1 = solve(eqn3,eqn1);
%inx_1_2 = double(in_1_2(1))
%iny_1_2 = double(in_1_2(2))

%fill([xd1 xd2], [yd1 yd2],'r')
%fill([xd1(xd1 < in_1_2(1)) xd2(xd2 < in_1_2(2))],[yd1(yd1 < in_1_2(2)) yd2(yd2 < in_1_2(2))],'b');
%fill([],[],'r');

%plot(trainc(:,1), trainc(:,2),'kd');

% eqn = w_12_*(x- x_0_12) == 0;
% y = solve(eqn)
% eval(h);
% plot(y, h);
% 
% plot(trainc2(:,1), trainc2(:,2),'kd');


% subs(sin(x),x,[1:5])
% subs(sin(x),x,[1 0.1 5])
% subs(sin(x),x,[1:0.1:5])
% plot([1:0.1:5],subs(sin(x),x,[1:0.1:5]))
% 
% syms x
% f1 = 0.05*x;
% f2 = log10(x);
% x0 = double(solve(f1 == f2)); % and manually check it is a single value in the range we want
% figure
% h1 = ezplot(f1);
% hold on
% h2 = ezplot(f2);
% xd1 = get(h1, 'XData'); xd2 = get(h2, 'XData');
% yd1 = get(h1, 'YData'); yd2 = get(h2, 'YData');
% % limit to finite values
% yd2 = max(yd2, -5);
% % revert one line, since we need to “circle” around the areas to fill
% xd2 = xd2(end:-1:1);
% yd2 = yd2(end:-1:1);
% fill([xd1(xd1 < x0) xd2(xd2 < x0)], [yd1(xd1 < x0) yd2(xd2 < x0)], 'b');
% fill([xd1(xd1 > x0) xd2(xd2 > x0)], [yd1(xd1 > x0) yd2(xd2 > x0)], 'r');