%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Points creatation for NIM Group uses
% Author: Zehao Wang
% Contact Email: zehaow@cmu.edu (valid before Dec. 2020)
% Backup  Email: zehaow@zju.edu.cn (always valid)
% Description: It generate the dots figure like a 
%   volcanic mountain.
% Github: https://github.com/ren365/NIM-Lab-MW-Scanning-Machine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Important Usage: make sure your grammar following this rule
%---------------------
% if(planet=='xz-y')
%    fprintf(fid,'%7d   %7d   %7d   %7d   \r\n',x,y,z,flag);
% elseif(planet=='xy-z')
%    fprintf(fid,'%7d   %7d   %7d   %7d   \r\n',x,z,y,flag);
% else
%    fprintf(fid,'%7d   %7d   %7d   %7d   \r\n',y,x,z,flag);
% end
%---------------------
% if don't know the meaning of 'xz-y', just take a look at  
%   the scanning machine's software!


%the length is 350 / 2 =175
%the start point is (25,25)
%so that is of importance to set the antalas at (25,25)
fid=fopen('E:\\实验室与打工\\sys\\扫场程序备份\\points.txt','wt'); %output addresss
startPoint=0;
step=5; % sparse the figure, every 5 step per point, otherwise it takes
        % long time to get the final results (always 2 days : )
size=400; % Total figure's size
planet='xz-y';%'xy-z';%'xz-y'or'yz-x'


% Following are processing for specific project...
centerX=size/2-startPoint; 
centerY=size/2-startPoint;
InnerRadius=60;
OuterRadius=159;
mountainHeight=14;
upOrDown=true;%means up
for i=0:step:size %x
	%snake modes
	if(upOrDown==true)
		for j=0:step:size %z
			length=sqrt((i-centerX)^2+(centerY-j)^2);
			flag=0;
			%中心置零-外层抬升
			if(length<InnerRadius)
				flag=1;
				y=-mountainHeight;
			elseif(length<OuterRadius)
				y=-ceil((OuterRadius-length)/(OuterRadius-InnerRadius)*mountainHeight);
			else
				y=0;
			end
			x=i;z=j;
			%[x,y,z,flag,(OuterRadius-length)/(OuterRadius-InnerRadius)]
			if(planet=='xz-y')
				fprintf(fid,'%7d   %7d   %7d   %7d   \r\n',x,y,z,flag);
			elseif(planet=='xy-z')
				fprintf(fid,'%7d   %7d   %7d   %7d   \r\n',x,z,y,flag);
			else
				fprintf(fid,'%7d   %7d   %7d   %7d   \r\n',y,x,z,flag);
			end
		end
		upOrDown=~upOrDown;%change
	else
		for j=size:-step:0 %z
			length=sqrt((i-centerX)^2+(centerY-j)^2);
			flag=0;
			%中心置零-外层抬升
			if(length<InnerRadius)
				flag=1;
				y=-mountainHeight;
			elseif(length<OuterRadius)
				y=-ceil((OuterRadius-length)/(OuterRadius-InnerRadius)*mountainHeight);
			else
				y=0;
			end
			x=i;z=j;
			%[x,y,z,flag,(OuterRadius-length)/(OuterRadius-InnerRadius)]
			if(planet=='xz-y')
				fprintf(fid,'%7d   %7d   %7d   %7d   \r\n',x,y,z,flag);
			elseif(planet=='xy-z')
				fprintf(fid,'%7d   %7d   %7d   %7d   \r\n',x,z,y,flag);
			else
				fprintf(fid,'%7d   %7d   %7d   %7d   \r\n',y,x,z,flag);
			end
		end
		upOrDown=~upOrDown;%change	
	end
end
fclose(fid);

