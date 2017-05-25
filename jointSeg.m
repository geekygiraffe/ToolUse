function [trunk, shoulderR, shoulderL, elbowR, elbowL, wristR, wristL] = jointSeg (activity)

%function seperates the imported condition and task data into seperate body segments and trials. 
% activity = fork, milk, hammer from structure
% outputs are concatenating trials and segments

% @geekyGiraffe May 25th
%%
trunkT1 = activity(:,1).data(:,2:4);
trunkT2 = activity(:,2).data(:,2:4);
trunkT3 = activity(:,3).data(:,2:4);
trunk = {trunkT1; trunkT2; trunkT3};

RshoulderT1 = activity(:,1).data(:,5:7);
RshoulderT2 = activity(:,2).data(:,5:7);
RshoulderT3 = activity(:,3).data(:,5:7);
shoulderR = {RshoulderT1; RshoulderT2; RshoulderT3};

RelbowT1 = activity(:,1).data(:,8:10);
RelbowT2 = activity(:,2).data(:,8:10);
RelbowT3 = activity(:,3).data(:,8:10);
elbowR = {RelbowT1; RelbowT2; RelbowT3};

RwristT1 = activity(:,1).data(:,11:13);
RwristT2 = activity(:,2).data(:,11:13);
RwristT3 = activity(:,3).data(:,11:13);
wristR = {RwristT1; RwristT2; RwristT3};

LshoulderT1 = activity(:,1).data(:,14:16);
LshoulderT2 = activity(:,2).data(:,14:16);
LshoulderT3 = activity(:,3).data(:,14:16);
shoulderL = {LshoulderT1; LshoulderT1; LshoulderT1};

LelbowT1 = activity(:,1).data(:,17:19);
LelbowT2 = activity(:,2).data(:,17:19);
LelbowT3 = activity(:,3).data(:,17:19);
elbowL = {LelbowT1; LelbowT2; LelbowT3};

LwristT1 = activity(:,1).data(:,20:22);
LwristT2 = activity(:,2).data(:,20:22);
LwristT3 = activity(:,3).data(:,20:22);
wristL = {LwristT1; LwristT2; LwristT3};
end

%{
% function [trunk, shoulderR, shoulderL, elbowR, elbowL, wristR, wristL] = jointSeg (condition)
% trunk = totalTrials(:,1).data(:,2:4)
% shoulderR = totalTrials(:,1).data(:,5:7)
% elbowR = totalTrials(:,1).data(:,8:10)
% wristR = totalTrials(:,1).data(:,11:13)
% shoulderL = totalTrials(:,1).data(:,14:16)
% elbowL = totalTrials(:,1).data(:,17:19)
% wristL = totalTrials(:,1).data(:,20:22)
% shoulderLglobal = totalTrials(:,1).data(:,23:25)
% shoulderRglobal = totalTrials(:,1).data(:,26:28)
% elbowLglobal = totalTrials(:,1).data(:,29:31)
% elbowRglobal = totalTrials(:,1).data(:,32:34)
% wristLglobal = totalTrials(:,1).data(:,35:37)
% wristRglobal = totalTrials(:,1).data(:,38:40)
% end
%}