%% %Parametric Equation Calculations from MM position data

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
tic
[P1SensorExport] = importMMfile('P1_SensorExport.txt', 11, 20);
%[P1SensorExport] = importMMfile('P1_SensorExport.txt', 11, 100);
%% seperate joint segments
% arrange the four marker data vectors from each segment plate in one cell per segment with all the plane (x,y,z) averages

%not a function because export function in MM variable based on data
%collected. will need to make more versatile.
frame = P1SensorExport(:,1);
frame = cell2mat(frame);

trunkX = P1SensorExport(:,2:5);
trunkY = P1SensorExport(:,30:33);
trunkZ = P1SensorExport(:,58:61);

rArmX = P1SensorExport(:,6:9);
rArmY = P1SensorExport(:,34:37);
rArmZ = P1SensorExport(:,62:65);

rHandX = P1SensorExport(:,10:13);
rHandY = P1SensorExport(:,38:41);
rHandZ = P1SensorExport(:,66:69);

rForearmX = P1SensorExport(:,14:17);
rForearmY = P1SensorExport(:,42:45);
rForearmZ = P1SensorExport(:,70:73);

lArmX = P1SensorExport(:,18:21);
lArmY = P1SensorExport(:,46:49);
lArmZ = P1SensorExport(:,74:77);

lHandX = P1SensorExport(:,22:25);
lHandY = P1SensorExport(:,50:53);
lHandZ = P1SensorExport(:,78:81);

lForearmX = P1SensorExport(:,26:29);
lForearmY = P1SensorExport(:,54:57);
lForearmZ = P1SensorExport(:,82:85);

%% Local coordinate system - using trunk

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

[slope, yint, lineP1rArm, parallelLineP1rArm] = twoDline(rArmP1(:,1), rArmP1(:,2), rArmP2(:,1), rArmP2(:,2), rArmP1);
[slope, yint, lineP2rArm, parallelLineP2rArm] = twoDline(rArmP2(:,1), rArmP2(:,2), rArmP3(:,1), rArmP3(:,2), rArmP2);
[slope, yint, lineP3rArm, parallelLineP3rArm] = twoDline(rArmP1(:,1), rArmP1(:,2), rArmP3(:,1), rArmP3(:,2), rArmP3);
[slope, yint, lineP4rArm, parallelLineP4rArm] = twoDline(rArmP1(:,1), rArmP1(:,2), rArmP4(:,1), rArmP4(:,2), rArmP4);

figure(01)
subplot (2,1,1)
plot(lineP1trunk) %blue
hold on
plot(lineP2trunk) %red
plot(lineP3trunk) %yellow
plot(lineP4trunk) %purp
title('Two Dimension Line Trunk');
xlabel('Time');
ylabel('Position');
legend('Point 1','Point 2','Point 3','Point 4');

subplot(2,1,2)
plot(lineP1rArm) %blue
hold on
plot(lineP2rArm) %red
plot(lineP3rArm) %yellow
plot(lineP4rArm) %purp
title('Two Dimension Line Right Arm');
xlabel('Time');
ylabel('Position');
legend('Point 1','Point 2','Point 3','Point 4');
hold off

%POSITION
figure (03);
subplot(4,1,1)
plot(frame,rArmP1(:,1))
ylabel 'position'

%VELOCITY
[v]=derivative(rArmP1(:,1),frame);
subplot(4,1,2)
plot(frame,v)
ylabel 'velocity'

%ACCELERATION
[a] = derivative(v,frame);
subplot(4,1,3)
plot (frame,a)
ylabel 'acceleration'

%JERK
[j] = derivative(a,frame);
subplot(4,1,4)
plot (frame,j)
ylabel 'jerk'
%% 3D line
%call threePointPlane fucntion to calculate 3d line, define plane and solve 3D line equation
% R^3 = r +tv = (x, y, z) + t(a,b,c)
%for each segment to be calculated
%loop fucntion to represent plane across time

for i = 1:length(trunkP1)
    [line_trunk(i,:), Plane_trunk(i), xPlane_trunk(i,:), yPlane_trunk(i,:), zPlane_trunk(i,:)] = threePointPlane (trunkP1(i,:), trunkP2(i,:), trunkP3(i,:),trunkP4(i,:));
    %%%%%%[line, xPlane, yPlane, zPlane] = threePointPlane (trunkP1, trunkP2, trunkP3, trunkP3);
    [line_rArm(i,:), Plane_rArm(i), xPlane_rArm(i,:), yPlane_rArm(i,:), zPlane_rArm(i,:)] = threePointPlane (rArmP1, rArmP2, rArmP3,rArmP4);
    [line_rForearm(i,:), Plane_rForearm(i), xPlane_rForearm(i,:), yPlane_rForearm(i,:), zPlane_rForearm(i,:)] = threePointPlane (rForearmP1, rForearmP2, rForearmP3,rForearmP4);
    % [normalVector_rHand, line_rHand, Plane_rHand, xPlane_rHand, yPlane_rHand, zPlane_rHand] = threePointPlane (rHandP1, rHandP2, rHandP3, rHandP4);
    [line_lArm(i,:), Plane_lArm(i), xPlane_lArm(i,:), yPlane_lArm(i,:), zPlane_lArm(i,:)] = threePointPlane (lArmP1, lArmP2, lArmP3,lArmP4);
    [line_lForearm(i,:), Plane_lForearm(i), xPlane_lForearm(i,:), yPlane_lForearm(i,:), zPlane_lForearm(i,:)] = threePointPlane (lForearmP1, lForearmP2, lForearmP3, lForearmP4);
    % [normalVector_lHand, line_lHand, Plane_lHand, xPlane_lHand, yPlane_lHand, zPlane_lHand] = threePointPlane (lHandP1, lHandP2, lHandP3, lHandP4);
end
%% Data Visualization
choice = menu('Would you like to view your data?: Press yes no','Yes','No');
    if choice == 2
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

%[] = plotExport (figure(02),'Trunk','tif')


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
    end
toc
%%BUG CHECK fucntion

%{
choice = menu('Would you like to view your data?: Press yes no','Yes','No');
    if choice == 2
else
    %Trunk
figure(02)
fplot3(line_trunk(1),line_trunk(2),line_trunk(3))
hold on
subplot(3,1,1)
fmesh(xPlane_trunk)
subplot(3,1,2)
fmesh(yPlane_trunk)
subplot(3,1,3)
fmesh(zPlane_trunk)
title('Trunk');
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
subplot(3,1,2)
fmesh(yPlane_rArm)
subplot(3,1,3)
fmesh(zPlane_rArm)
title('Right Arm');
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
subplot(3,1,2)
fmesh(yPlane_rForearm)
subplot(3,1,3)
fmesh(zPlane_rForearm)
title('Right Forearm');
xlabel('X axis');
ylabel('Y axis');
zlabel('Z axis');
hold off

%Left Arm
figure(04)
fplot3(line_lArm(1),line_lArm(2),line_lArm(3))
hold on
subplot(3,1,1)
fmesh(xPlane_lArm)
subplot(3,1,2)
fmesh(yPlane_lArm)
subplot(3,1,3)
fmesh(zPlane_lArm)
title('Left Arm');
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
subplot(3,1,2)
fmesh(yPlane_lForearm)
subplot(3,1,3)
fmesh(zPlane_lForearm)
title('Left Forearm');
xlabel('X axis');
ylabel('Y axis');
zlabel('Z axis');
hold off
end
%}

%{
figure(01)
plot(lineP1trunk)
hold on
plot(lineP2trunk)
plot(lineP3trunk)
title('Linear Trunk Line');
xlabel('X axis');
ylabel('Y axis');
legend('Point 1','Point 2','Point3', 'Point4');
hold off

figure(02)
fplot3(line(1),line(2),line(3))
hold on
fmesh(zPlane)
title('Linear Trunk Line')
hold off

figure(03)
fplot3(line(1),line(2),line(3))
hold on
fmesh(xPlane)
hold off

figure(04)
fplot3(line(1),line(2),line(3))
hold on
fmesh(yPlane)
hold off

figure(05)
fplot3(line(1),line(2),line(3))
hold on
fmesh(xPlane)
fmesh(yPlane)
fmesh(zPlane)
hold off
%}
