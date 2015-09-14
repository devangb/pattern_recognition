x = [1:0.1:10];
a = figure();
hold on;
plot(x,sin(x));
plot(x,tan(x));

path = 'b/a/';
print(a,strcat(path,'st'),'-dpng');
b = figure();

hold on;
plot(x,cos(x));
plot(x,log(x));
%path = 'b/a/';
print(b,strcat(path,'cl'),'-dpng');