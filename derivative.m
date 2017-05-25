function [derivativeData] = derivative(data,trialData)
%DERIVATIVE FUNCTION
% calculates derivatives of position data

%@geekyGiraffe October 2014
%%

m=length(trialData);

%first point
derivativeData(1) = (data(2)-data(1))/(trialData(2)-trialData(1))

for i= 2:(m-1)
        derivativeData(i)= (data(i+1)-data(i-1))/(trialData(i+1)-trialData(i-1));
end

%last point
derivativeData(m) = (data(m)-data(m-1))/(trialData(m)-trialData(m-1))