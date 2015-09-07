% c1 = load('Class1.txt');
% c2 = load('Class2.txt');
% c3 = load('Class3.txt');
% classes = {'Class1.txt';'Class2.txt';'Class3.txt'};
% classes = cellstr(classes);
[trainc1, testc1] = prepareInputData('Class1.txt');
[trainc2, testc2] = prepareInputData('Class2.txt');
[trainc3, testc3] = prepareInputData('Class3.txt');
% prepLists(classes);
trainc = [trainc1; trainc2; trainc3];
testc = [testc1;testc2;testc3];
hold on;
u1 = mean(trainc1)';
u2 = mean(trainc2)';
u3 = mean(trainc3)';
% plot(u1(1),u1(2),'o');
% plot(u2(1),u2(2),'*');
% plot(u3(1),u3(2),'s');

E_ = inv(cov(trainc));
w_12_ = (E_*(u1-u2))';
w_23_ = (E_*(u2-u3))';
w_31_ = (E_*(u3-u1))';

x_0_12 = 1/2*(u1+u2);

x_0_23 = 1/2*(u2+u3);

x_0_31 = 1/2*(u3+u1);

region1 = [(w_12_*(u1 - x_0_12))/abs(w_12_*(u1 - x_0_12)), (w_23_*(u1 - x_0_23))/abs(w_23_*(u1 - x_0_23)), (w_31_*(u1 - x_0_31))/abs(w_31_*(u1 - x_0_31))]
region2 = [(w_12_*(u2 - x_0_12))/abs(w_12_*(u2 - x_0_12)), (w_23_*(u2 - x_0_23))/abs(w_23_*(u2 - x_0_23)), (w_31_*(u2 - x_0_31))/abs(w_31_*(u2 - x_0_31))]
% hold on;



syms x h w;
x = [h, w]';
eqn1 = w_12_*(x-x_0_12)
eqn2 = w_23_*(x-x_0_23)
eqn3 = w_31_*(x-x_0_31)

ezplot(eqn1,[-10,25,-25,25])
ezplot(eqn2,[-10,25,-25,25])
ezplot(eqn3,[-10,25,-25,25])

mVal11 = subs(eqn1,x,u1);
mVal12 = subs(eqn2,x,u1);
mVal13 = subs(eqn3,x,u1);

mVal21 = subs(eqn1,x,u2);
mVal22 = subs(eqn2,x,u2);
mVal23 = subs(eqn3,x,u2);

mVal31 = subs(eqn1,x,u3);
mVal32 = subs(eqn2,x,u3);
mVal33 = subs(eqn3,x,u3);

hold on

for i = -10:0.25:25
    for j = -25:0.25:25
        if(liesInRegion([i,j]',mVal32,mVal33,x,eqn2,eqn3)== true)
          plot(i,j,'.r');
        elseif(liesInRegion([i,j]',mVal11,mVal13,x,eqn1,eqn3)== true)
          plot(i,j,'.b');
        else
          plot(i,j,'.g');
        end
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
    end
end

hold on

plot(testc1(:,1), testc1(:,2),'.c');
plot(testc2(:,1), testc2(:,2),'.y');
plot(testc3(:,1), testc3(:,2),'.m');
% eqn = w_12_*(x- x_0_12) == 0;
% y = solve(eqn)
% eval(h);
% plot(y, h);
% 
% plot(trainc2(:,1), trainc2(:,2),'kd');
