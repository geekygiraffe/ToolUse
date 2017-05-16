function [derivativeData] = derivative(data,time)
%DERIVATIVE FUNCTION
% calculates derivatives of position
%@geekyGiraffe

m=length(data);

%first point
derivativeData(1) = (data(2)-data(1))/(time(2)-time(1))

for i= 2:(m-1)
        derivativeData(i)= (data(i+1)-data(i-1))/(time(i+1)-time(i-1));
end

%last point
derivativeData(m) = (data(m)-data(m-1))/(time(m)-time(m-1))