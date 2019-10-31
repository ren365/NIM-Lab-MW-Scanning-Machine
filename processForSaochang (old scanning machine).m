%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Postprocessing of scanning machine for NIM Group uses
% Author: Zehao Wang
% Contact Email: zehaow@cmu.edu (valid before Dec. 2020)
% Backup  Email: zehaow@zju.edu.cn (always valid)
% Description: It process with old scanning machine
%   It is currently in 207 room out of use.
% Github: https://github.com/ren365/NIM-Lab-MW-Scanning-Machine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%说明
%文件夹下需要有扫场点文件
%目前写的是对称点集
fileName='points.txt';%扫场点文件
OrderOfwhich=2;
outputName=['showed',num2str(OrderOfwhich)];
number=400;step=5;
num=number/step+1;
Frequency=5e9;
planet='xz-y';%'xy-z';%'xz-y'or'yz-x'
amplitude=zeros(num,num);
angles=zeros(num,num);
showed=zeros(num,num);
%点坐标导入
eval(strcat('points =','load(',39,fileName,39,');'));
fileNum=length(points);

%预处理
x0=num2str(points(1,1));y0=num2str(points(1,2));z0=num2str(points(1,3));
% if(planet=='xz-y')
	% x0=num2str(points(1,1));y0=num2str(points(1,2));z0=num2str(points(1,3));
% elseif(planet=='xy-z')
	% x0=num2str(points(1,1));y0=num2str(points(1,3));z0=num2str(points(1,2));
% else
	% x0=num2str(points(1,3));y0=num2str(points(1,2));z0=num2str(points(1,1));
% end
absx0=strrep(x0,'-','');absy0=strrep(y0,'-','');absz0=strrep(z0,'-','');
filName=strcat('X',x0,'.0Y',y0,'.0Z',z0,'.0.dat');
eval(strcat('X',absx0,'Y',absy0,'Z',absz0,' =','load(',39,filName,39,');'));
temp=strcat('X',absx0,'Y',absy0,'Z',absz0);
startF=eval(strcat(temp,'(1,1)'));
endF=eval(strcat(temp,'(',num2str(length(eval(temp))),',1)'));
ObjectFrequencyPlace=floor((Frequency-startF)/(endF-startF)*(length(eval(temp))-1))+1;

%加载&信息提取
for k=1:fileNum
	x=points(k,1);y=points(k,2);z=points(k,3);
	x0=num2str(x);y0=num2str(y);z0=num2str(z);
	absx0=strrep(x0,'-','');absy0=strrep(y0,'-','');absz0=strrep(z0,'-','');
	filName=strcat('X',x0,'.0Y',y0,'.0Z',z0,'.0.dat');
	eval(strcat('X',absx0,'Y',absy0,'Z',absz0,' =','load(',39,filName,39,');'));
	temp=strcat('X',absx0,'Y',absy0,'Z',absz0);
	temp=strrep(temp,'-','_');
	temp2=eval(strcat(temp,'(',num2str(ObjectFrequencyPlace),',2)'));
	temp3=eval(strcat(temp,'(',num2str(ObjectFrequencyPlace),',3)'));
	temp4=temp2+j*temp3;
	
	if(planet=='xz-y')
		
	elseif(planet=='xy-z')
		z=y;
	else
		x=y;
	end
	
	amplitude(x/step+1,z/step+1)=abs(temp4);
	angles(x/step+1,z/step+1)=angle(temp4);
	showed(x/step+1,z/step+1)=real(temp4);
	eval(['clear ',temp]);
	if(mod(k,100)==0)
		fprintf('Totl:%d ; Adding line %d00\n',fileNum,k/100);
	end
end

%后期处理
maxM0=max(showed);
maxm=max(maxM0);
xmesh =1:step:number+step;
ymesh =1:step:number+step;
%建立场图形
%surf(xmesh,ymesh,amplitude);shading interp;
surf(xmesh,ymesh,showed);shading interp;
set(gca,'DataAspectRatio',[1 1 1]);view(2);
cd ../
eval([outputName,'= showed;']);
outputName=['''',outputName,'.mat''',',''showed'''];
eval(['save(',outputName,');']);
