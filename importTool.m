function [ dataFolder, dataFile, cond1File, cond2File, theFiles, theFilesC1, theFilesC2, fullFileName, fullFileNameCond1, fullFileNameCond2, fileDataList, fileCondList1, fileCondList2] = importTool;
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

%import all the files into a structure
dataFolder = 'U:\SMIL_PhD\euclideanVector\Data\Pilot01';
fileStruct = fullfile(dataFolder, '*.txt');
theFiles = dir(fileStruct);

%import each condition into a structure
fileStructCondition1 = fullfile(dataFolder, 'P1C1*.txt');
theFilesC1 = dir(fileStructCondition1);
fileStructCondition2 = fullfile(dataFolder, 'P1C2*.txt');
theFilesC2 = dir(fileStructCondition2);

%import each task into a structure

% conditionFiles = dir(fileStructCondition1);
%
% fileStructCondition2 = fullfile(dataFolder, 'P1C2*.txt');
% conditionFiles = dir(fileStructCondition2);
%
% fileStructTask = fullfile(dataFolder, '*_fork.txt');
% taskForkFiles = dir(fileStructTask)

for i = 1:length(theFiles);
    for j = length(theFilesC1);
        for k = length(theFilesC2);
%            for l = length(theFilesTask);
                dataFile{i} = theFiles(i).name;
                cond1File{j} = theFilesC1(j).name
                cond2File{k} = theFilesC2(k).name
                fullFileName{i} = fullfile(dataFolder, dataFile{i}); %fullfile builds the full file name from parts, takes the given file path of folder and data file
                fullFileNameCond1{j} = fullfile(dataFolder,cond1File{j});
                fullFileNameCond2{k} = fullfile(dataFolder,cond2File{k});
                
                fileDataList{i} = fullFileName{i};
                fileCondList1{j} = fullFileNameCond1{j};
                fileCondList2{k} = fullFileNameCond1{k};
        end
    end
    end
