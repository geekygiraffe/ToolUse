%function [dataFolder, dataFile, cond1File, cond2File, theFiles, theFilesC1, theFilesC2, fullFileName, fullFileNameCond1, fullFileNameCond2, fileDataList, fileCondList1, fileCondList2] = importTool;
function [dataFolder, dataFile, theFiles, forkFile, milkFile, hammerFile, fullFileName, fullFileNameFork, fullFileNameMilk, fullFileNameHammer, fileDataList, fileForkList, fileMilkList, fileHammerList] = importTool;
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

%import each condition into a seperate structure
% % % fileStructCondition1 = fullfile(dataFolder, 'P1C1*.txt');
% % % theFilesC1 = dir(fileStructCondition1);
% % % 
% % % fileStructCondition2 = fullfile(dataFolder, 'P1C2*.txt');
% % % theFilesC2 = dir(fileStructCondition2);

%import each task into a structure: fork hammer milk
fileStructFork = fullfile(dataFolder, '*_fork.txt');
theFilesFork = dir(fileStructFork);

fileStructMilk = fullfile(dataFolder, '*_milk.txt');
theFilesMilk = dir(fileStructMilk);

fileStructHammer = fullfile(dataFolder, '*_hammer.txt');
theFilesHammer = dir(fileStructHammer);


for i = 1:length(theFiles);
    dataFile{i} = theFiles(i).name;
    fullFileName{i} = fullfile(dataFolder, dataFile{i}); %fullfile builds the full file name from parts, takes the given file path of folder and data file
    fileDataList{i} = fullFileName{i};
end

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

for f = 1:length(theFilesFork);
    forkFile{f} = theFilesFork(f).name;
    fullFileNameFork{f} = fullfile(dataFolder, forkFile{f}); %fullfile builds the full file name from parts, takes the given file path of folder and data file
    fileForkList{f} = fullFileNameFork{f};
end

for m = 1:length(theFilesMilk);
    milkFile{m} = theFilesMilk(m).name;
    fullFileNameMilk{m} = fullfile(dataFolder, milkFile{m}); %fullfile builds the full file name from parts, takes the given file path of folder and data file
    fileMilkList{m} = fullFileNameMilk{m};
end

for h = 1:length(theFilesHammer);
    hammerFile{h} = theFilesHammer(h).name;
    fullFileNameHammer{h} = fullfile(dataFolder, hammerFile{h}); %fullfile builds the full file name from parts, takes the given file path of folder and data file
    fileHammerList{h} = fullFileNameHammer{h};
end
