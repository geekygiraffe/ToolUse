%function [dataFolder, dataFile, cond1File, cond2File, theFiles, theFilesC1, theFilesC2, fullFileName, fullFileNameCond1, fullFileNameCond2, fileDataList, fileCondList1, fileCondList2] = importTool;
function [dataFolder, dataFile, theFiles, forkFileC1, forkFileC2, milkFileC1, milkFileC2, hammerFileC1, hammerFileC2, fullFileName, fullFileNameForkC1, fullFileNameMilkC1, fullFileNameHammerC1, fullFileNameForkC2, fullFileNameMilkC2, fullFileNameHammerC2, fileDataList, fileForkListC1, fileMilkListC1, fileHammerListC1, fileForkListC2, fileMilkListC2, fileHammerListC2] = importTool;
%[dataFolder, dataFile, cond1File, cond2File, theFiles,  theFilesC1, theFilesC2, forkFile, milkFile, hammerFile, fullFileName, fullFileNameCond1, fullFileNameCond2, fullFileNameFork, fullFileNameMilk, fullFileNameHammer, fileDataList, fileCondList1, fileCondList2, fileForkList, fileMilkList, fileHammerList] = importTool;
% function imports all .txt files within folder specified by 'dataFolder'
% will need to adjust '...\Data\XXXX' folder based on data being analyzed.
% ! should be able to have that as an input for function!%
% Data is imported as a structure 'subjectTrials' within script with data
% fields as data, text data which is the header, colheaders which is the
% order of the variables exported from Motion Moniter

% @geekyGiraffe 1/31/2017
%%
% % 'dataFolder' --> file path to subject data
% ! uiget to mousclick to desitination (multiple user friendly)
% % 'fileStruct' --> grabs all the files with designated format within specificed dataFolder %[indicated by *.zzz]-wildcard
% % stuct array with fields: name; folder; date; bytes; isdir; datenum
% % length is indicidive of how many .txt files are within folder

%import all the files from a single subject into a structure
dataFolder = 'U:\SMIL_PhD\euclideanVector\Data\Pilot01';
fileStruct = fullfile(dataFolder, '*.txt');
theFiles = dir(fileStruct);

%import each task into a condition specific structure: fork hammer milk
fileStructForkC1 = fullfile(dataFolder, '*C1_fork.txt');
theFilesForkC1 = dir(fileStructForkC1);

fileStructForkC2 = fullfile(dataFolder, '*C2_fork.txt');
theFilesForkC2 = dir(fileStructForkC2);

fileStructMilkC1 = fullfile(dataFolder, '*C1_milk.txt');
theFilesMilkC1 = dir(fileStructMilkC1);

fileStructMilkC2 = fullfile(dataFolder, '*C2_milk.txt');
theFilesMilkC2 = dir(fileStructMilkC2);

fileStructHammerC1 = fullfile(dataFolder, '*C1_hammer.txt');
theFilesHammerC1 = dir(fileStructHammerC1);

fileStructHammerC2 = fullfile(dataFolder, '*C2_hammer.txt');
theFilesHammerC2 = dir(fileStructHammerC2);


for i = 1:length(theFiles);
    dataFile{i} = theFiles(i).name;
    fullFileName{i} = fullfile(dataFolder, dataFile{i}); %fullfile builds the full file name from parts, takes the given file path of folder and data file
    fileDataList{i} = fullFileName{i};
end

for f = 1:length(theFilesForkC1);
    forkFileC1{f} = theFilesForkC1(f).name;
    fullFileNameForkC1{f} = fullfile(dataFolder, forkFileC1{f}); %fullfile builds the full file name from parts, takes the given file path of folder and data file
    fileForkListC1{f} = fullFileNameForkC1{f};
end
for f = 1:length(theFilesForkC2);
    forkFileC2{f} = theFilesForkC2(f).name;
    fullFileNameForkC2{f} = fullfile(dataFolder, forkFileC2{f}); %fullfile builds the full file name from parts, takes the given file path of folder and data file
    fileForkListC2{f} = fullFileNameForkC2{f};
end

for m = 1:length(theFilesMilkC1);
    milkFileC1{m} = theFilesMilkC1(m).name;
    fullFileNameMilkC1{m} = fullfile(dataFolder, milkFileC1{m}); %fullfile builds the full file name from parts, takes the given file path of folder and data file
    fileMilkListC1{m} = fullFileNameMilkC1{m};
end
for m = 1:length(theFilesMilkC2);
    milkFileC2{m} = theFilesMilkC2(m).name;
    fullFileNameMilkC2{m} = fullfile(dataFolder, milkFileC2{m}); %fullfile builds the full file name from parts, takes the given file path of folder and data file
    fileMilkListC2{m} = fullFileNameMilkC2{m};
end

for h = 1:length(theFilesHammerC1);
    hammerFileC1{h} = theFilesHammerC1(h).name;
    fullFileNameHammerC1{h} = fullfile(dataFolder, hammerFileC1{h}); %fullfile builds the full file name from parts, takes the given file path of folder and data file
    fileHammerListC1{h} = fullFileNameHammerC1{h};
end
for h = 1:length(theFilesHammerC2);
    hammerFileC2{h} = theFilesHammerC2(h).name;
    fullFileNameHammerC2{h} = fullfile(dataFolder, hammerFileC2{h}); %fullfile builds the full file name from parts, takes the given file path of folder and data file
    fileHammerListC2{h} = fullFileNameHammerC2{h};
end
%import each condition into a seperate structure
% % % fileStructCondition1 = fullfile(dataFolder, 'P1C1*.txt');
% % % theFilesC1 = dir(fileStructCondition1);
% % % 
% % % fileStructCondition2 = fullfile(dataFolder, 'P1C2*.txt');
% % % theFilesC2 = dir(fileStructCondition2);

% for j = length(theFilesC1);
%     cond1File{j} = theFilesC1(j).name;
%     fullFileNameCond1{j} = fullfile(dataFolder,cond1File{j});
%     fileCondList1{j} = fullFileNameCond1{j};
% end
% 
% for k = length(theFilesC2);
%     cond2File{k} = theFilesC2(k).name;
%     fullFileNameCond2{k} = fullfile(dataFolder,cond2File{k});
%     fileCondList2{k} = fullFileNameCond2{k};
% end

