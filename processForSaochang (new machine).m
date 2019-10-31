%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Postprocessing of scanning machine for NIM Group uses
% Author: Zehao Wang
% Contact Email: zehaow@cmu.edu (valid before Dec. 2020)
% Backup  Email: zehaow@zju.edu.cn (always valid)
% Description: It subtract the environment noise from 
%   the experiment results.
% Github: https://github.com/ren365/NIM-Lab-MW-Scanning-Machine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
showed2=load('showed2.mat') % contrast result
showed1=load('showed1.mat') % experiment result
showed1=struct2cell(showed1);showed2=struct2cell(showed2);
showed1=cell2mat(showed1);showed2=cell2mat(showed2);
number=402;step=3;% the number per colonm and jump several 
                  % points which is same to your points 
                  % generation file
xmesh =1:step:number+step;
ymesh =1:step:number+step;
showedResult=showed1-showed2;
%if you want the amplitude or phase of the showedResult
% try "abs(showedResult)" or ...(I forget but easily find
% in the website.
surf(xmesh,ymesh,showedResult);shading interp;
set(gca,'DataAspectRatio',[1 1 1]);view(2);

% surf(xmesh,ymesh,showed1);shading interp;
% set(gca,'DataAspectRatio',[1 1 1]);view(2);

% surf(xmesh,ymesh,showed2);shading interp;
% set(gca,'DataAspectRatio',[1 1 1]);view(2);