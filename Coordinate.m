%% %Parametric Equation Calculations from MM position data

%import data from a folder defined as 'dataFolder' 
% code intends to caclulate segments position given individual marker position data
% Step One: define line between two points on a segment
% Step Two: define second line perpendicular to first
% Step Three: Identify segment plane
%   This code utillizes the trunk segment as the local coordinate system
% Step Three: compare matrix between segments to get joint angles
% compare two coordinates between segements to get angles

%* Potential improvements: normalize local coordinate system to adjust for
% any movement trunk expereinces

%*either user defined or 'smart' selection of which three points are used
%to define the plane in order to avoid situations such as marker drop out
%creating errors in future calculatons
%   *filter function could also be implemented to intropolate or fit/correct any faulty data points before
%   performing calculations.

%created by Jessica McDonnell December 1, 2016

%% call function to import file from motion monitor
[dataFolder,dataFile,theFiles,forkFile,milkFile,hammerFile,fullFileName,fullFileNameFork,fullFileNameMilk,fullFileNameHammer,fileDataList,fileForkList, fileMilkList, fileHammerList] = importTool;
%[dataFolder, dataFile, cond1File, cond2File, theFiles,  theFilesC1, theFilesC2, forkFile, milkFile, hammerFile, fullFileName, fullFileNameCond1, fullFileNameCond2, fullFileNameFork, fullFileNameMilk, fullFileNameHammer, fileDataList, fileCondList1, fileCondList2, fileForkList, fileMilkList, fileHammerList] = importTool;
%function [ dataFolder, dataFile, cond1File, cond2File, dataFiles, theFilesC1, theFilesC2, fullFileName, fullFileNameCond1, fullFileNameCond2, fileDataList, fileCondList1, fileCondList2] = importTool;
%[dataFile, dataFolder, theFiles, fullFileName, fileDataList] = importTool;

%loop through imported file folder and pull in data files into cell
%'subject trials'

for i = 1:length(dataFile)
totalTrials(i) = importdata(fullFileName{1,i})';
%need to normalize collection time to put frame numbers in cell
%virtual event markers in MM (manual) or user defined

%%frame(i) = subjectTrials(i).data(:,1); 
end
% % % % %sort data according to condition
% % % % for j = 1:length(cond1File)
% % % % cond1Trials(j) = importdata(fullFileNameCond1{1,j})';
% % % % end
% % % % 
% % % % for k = 1:length(cond2File)
% % % % cond2Trials(k) = importdata(fullFileNameCond2{1,k})';
% % % % end

for f = 1:length(forkFile)
forkTrials(f) = importdata(fullFileNameFork{1,f})';
end

for m = 1:length(milkFile)
milkTrials(m) = importdata(fullFileNameMilk{1,m})';
end

for h = 1:length(hammerFile)
hammerTrials(h) = importdata(fullFileNameHammer{1,h})';
end
%sort data according to various variables

%% seperate joint segments
% arrange the four marker data vectors from each segment plate in one cell per segment with all the plane (x,y,z) averages
% for i = 1:18
% %frame(:,i) = subjectTrials(i).data(:,1); 
% trunk = totalTrials(i
% % end

%{
%not a function because export function in MM variable based on data
%collected. will need to make more versatile.

trunkX = sensorExport(:,2:5);
trunkY = sensorExport(:,30:33);
trunkZ = sensorExport(:,58:61);

rArmX = sensorExport(:,6:9);
rArmY = sensorExport(:,34:37);
rArmZ = sensorExport(:,62:65);

rHandX = sensorExport(:,10:13);
rHandY = sensorExport(:,38:41);
rHandZ = sensorExport(:,66:69);

rForearmX = sensorExport(:,14:17);
rForearmY = sensorExport(:,42:45);
rForearmZ = sensorExport(:,70:73);

lArmX = sensorExport(:,18:21);
lArmY = sensorExport(:,46:49);
lArmZ = sensorExport(:,74:77);

lHandX = sensorExport(:,22:25);
lHandY = sensorExport(:,50:53);
lHandZ = sensorExport(:,78:81);

lForearmX = sensorExport(:,26:29);
lForearmY = sensorExport(:,54:57);
lForearmZ = sensorExport(:,82:85);
%}
%% Local coordinate system - using trunk
%{

%call fucntion xyz2mat to get all segments to be evaluated into mat files
%with xyz components arranged into column vectors
[trunkP1, trunkP2, trunkP3, trunkP4] = xyz2mat (trunkX, trunkY, trunkZ);
[rArmP1, rArmP2, rArmP3, rArmP4] = xyz2mat (rArmX, rArmY, rArmZ);
[rForearmP1, rForearmP2, rForearmP3, rForearmP4] = xyz2mat (rForearmX, rForearmY, rForearmZ);
[rHandP1, rHandP2, rHandP3, rHandP4] = xyz2mat (rHandX, rHandY, rHandZ);
[lArmP1, lArmP2, lArmP3, lArmP4] = xyz2mat (lArmX, lArmY, lArmZ);
[lForearmP1, lForearmP2, lForearmP3, lForearmP4] = xyz2mat (lForearmX, lForearmY, lForearmZ);
[lHandP1, lHandP2, lHandP3, lHandP4] = xyz2mat (lHandX, lHandY, lHandZ);

%% 2D line
%call y= mx+b function ('twoDline')

[slope, yint, lineP1trunk, parallelLineP1trunk] = twoDline(trunkP1(:,1), trunkP1(:,2), trunkP2(:,1), trunkP2(:,2), trunkP1);
[slope, yint, lineP2trunk, parallelLineP2trunk] = twoDline(trunkP2(:,1), trunkP2(:,2), trunkP3(:,1), trunkP3(:,2), trunkP2);
[slope, yint, lineP3trunk, parallelLineP3trunk] = twoDline(trunkP1(:,1), trunkP1(:,2), trunkP3(:,1), trunkP3(:,2), trunkP3);
[slope, yint, lineP4trunk, parallelLineP4trunk] = twoDline(trunkP1(:,1), trunkP1(:,2), trunkP4(:,1), trunkP4(:,2), trunkP4);

% figure(01)
% plot(lineP1trunk) %blue
% hold on
% plot(lineP2trunk) %red
% plot(lineP3trunk) %yellow
% plot(lineP4trunk) %purp
% 
% title('Two Dimension Line');
% xlabel('Time');
% ylabel('Position');
% legend('Point 1','Point 2','Point 3','Point 4');
% hold off
% % saves graph to a .tif file for manuscrip submission

%print -dtiff 'Two Dimension Line.tif'
%*opportunity to create conditional statement to select the three points to
%*be used to define the plane
%*filter 
%% 3D line
%call threePointPlane fucntion to calculate 3d line, define plane and solve 3D line equation
% R^3 = r +tv = (x, y, z) + t(a,b,c)
%for each segment to be calculated
%loop fucntion to represent plane across time

for i = 1:length(trunkP1)
    [line_trunk(i,:), Plane_trunk(i), xPlane_trunk(i,:), yPlane_trunk(i,:), zPlane_trunk(i,:)] = threePointPlane (trunkP1(i,:), trunkP2(i,:), trunkP3(i,:),trunkP4(i,:));
    [line_rArm(i,:), Plane_rArm(i), xPlane_rArm(i,:), yPlane_rArm(i,:), zPlane_rArm(i,:)] = threePointPlane (rArmP1, rArmP2, rArmP3,rArmP4);
    [line_rForearm(i,:), Plane_rForearm(i), xPlane_rForearm(i,:), yPlane_rForearm(i,:), zPlane_rForearm(i,:)] = threePointPlane (rForearmP1, rForearmP2, rForearmP3,rForearmP4);
%    [normalVector_rHand, line_rHand, Plane_rHand, xPlane_rHand, yPlane_rHand, zPlane_rHand] = threePointPlane (rHandP1, rHandP2, rHandP3, rHandP4);
    [line_lArm(i,:), Plane_lArm(i), xPlane_lArm(i,:), yPlane_lArm(i,:), zPlane_lArm(i,:)] = threePointPlane (lArmP1, lArmP2, lArmP3,lArmP4);
    [line_lForearm(i,:), Plane_lForearm(i), xPlane_lForearm(i,:), yPlane_lForearm(i,:), zPlane_lForearm(i,:)] = threePointPlane (lForearmP1, lForearmP2, lForearmP3, lForearmP4);
%    [normalVector_lHand, line_lHand, Plane_lHand, xPlane_lHand, yPlane_lHand, zPlane_lHand] = threePointPlane (lHandP1, lHandP2, lHandP3, lHandP4);
end

%% Data Visualization
choice = menu('Would you like to view your data?: Press yes no','Yes','No');
if choice == 2
    return
else
    %Trunk
    figure(02)
    fplot3(line_trunk(1),line_trunk(2),line_trunk(3))
    hold on
    subplot(3,1,1)
    fmesh(xPlane_trunk)
    title('Trunk');
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    subplot(3,1,2)
    fmesh(yPlane_trunk)
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    subplot(3,1,3)
    fmesh(zPlane_trunk)
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    hold off


    %Right Arm
    figure(03)
    fplot3(line_rArm(1),line_rArm(2),line_rArm(3))
    hold on
    subplot(3,1,1)
    fmesh(xPlane_rArm)
    title('Right Arm');
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    subplot(3,1,2)
    fmesh(yPlane_rArm)
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    subplot(3,1,3)
    fmesh(zPlane_rArm)
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    hold off
    
    %Right Forearm
    figure(04)
    fplot3(line_rForearm(1),line_rForearm(2),line_rForearm(3))
    hold on
    subplot(3,1,1)
    fmesh(xPlane_rForearm)
    title('Right Forearm');
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    subplot(3,1,2)
    fmesh(yPlane_rForearm)
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    subplot(3,1,3)
    fmesh(zPlane_rForearm)
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    hold off
    
%{
    %Left Arm
    figure(04)
    fplot3(line_lArm(1),line_lArm(2),line_lArm(3))
    hold on
    subplot(3,1,1)
    fmesh(xPlane_lArm)
    title('Left Arm');
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    subplot(3,1,2)
    fmesh(yPlane_lArm)
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    subplot(3,1,3)
    fmesh(zPlane_lArm)
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    hold off
    
    %Left Forearm
    figure(05)
    fplot3(line_lForearm(1),line_lForearm(2),line_lForearm(3))
    hold on
    subplot(3,1,1)
    fmesh(xPlane_lForearm)
    title('Left Forearm');
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    subplot(3,1,2)
    fmesh(yPlane_lForearm)
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    subplot(3,1,3)
    fmesh(zPlane_lForearm)
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    hold off
%}
end

%toc

%%BUG CHECK fucntion

%}