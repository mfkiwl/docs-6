% onlineImuCalibration.m
% 
% Online IMU calibration based on state information from the
% PoseAndTwistEst24 state estimator

clear; clc; 
%----- Setup
tStartSec = 140; 
tStopSec = 1220;
ablim = 0.1;
aslim = 0.1;
gslim = 0.1;
noSigmas = 0;

%----- Original parameters
ORIENTATION_IMU_B = [ 0.0048322    -0.027249     -0.99901      0.03506];
ACCELEROMETER_SCALE_FACTORS_U = [0.9748      0.96744      0.94591];
GYRO_SCALE_FACTORS_U = [0.98633      0.99249       1.0009];
POS_IMU_B = [ 0.486 -0.121 -0.238];

%----- Set directory
addpath(genpath('../../navsol'));
%datadir  = '/vtrak3/data2/lynxDatasets/owvrJan2020';
%datadir = '/vtrak3/data2/lynxDatasets/quadTesting/2020/june23';
datadir = '/vtrak3/data2/lynxDatasets/summer2021';

%----- Pull in diagnostic data from PpEngine
command = ['diagsplitppe.sh ' datadir  '/diagnostics.log .'];
system(command);
pt = load('poseandtwist24.txt');
tVec = pt(:,2) + pt(:,3);
tVec00 = pt(1,2) + pt(1,3);
tVec0 = tVec - tVec00;
iidum = find(tVec0 >= tStartSec & tVec0 <= tStopSec);
tVec0 = tVec(iidum) - tVec00;
pt = pt(iidum,:);
beBU = pt(:,4:6);
bSFaInv = pt(:,7:9);
bSFgInv = pt(:,10:12);
blB = pt(:,22:24);

beBU_std = sqrt(pt(:,13:15));
bSFaInv_std = sqrt(pt(:,16:18));
bSFgInv_std = sqrt(pt(:,19:21));
blB_std = sqrt(pt(:,25:27));

beBU_mean = mean(beBU)
bSFaInv_mean = mean(bSFaInv)
bSFgInv_mean = mean(bSFgInv)
blB_mean = mean(blB)

%----- Updated parameters
dRBU = euler2dcm(beBU_mean');
fprintf('\nUpdated parameters: \n');
ORIENTATION_IMU_B = dc2quat(dRBU*quat2dc(ORIENTATION_IMU_B'))'
ACCELEROMETER_SCALE_FACTORS_U = ...
    1./(bSFaInv_mean + 1./ACCELEROMETER_SCALE_FACTORS_U)
GYRO_SCALE_FACTORS_U = 1./(bSFgInv_mean + 1./GYRO_SCALE_FACTORS_U)
eORIENTATION_IMU_B_deg = ...
    dcm2euler(quat2dc([ORIENTATION_IMU_B]))'*180/pi
POS_IMU_B = POS_IMU_B + blB_mean

%----- Plot
if(noSigmas)
    figure(1);clf;
subplot(311)
plot(tVec0,beBU(:,1),'b','linewidth',2); grid on;
title('Attitude bias estimates (as Euler angles)');
ylabel('\phi (rad)');
ylim(ablim*[-1 1]);
subplot(312)
plot(tVec0,beBU(:,2),'b','linewidth',2); grid on;
ylabel('\theta (rad)');
ylim(ablim*[-1 1]);
subplot(313)
plot(tVec0,beBU(:,3),'b','linewidth',2); 
ylabel('\psi (rad)');
ylim(ablim*[-1 1]);
xlabel('Time since first epoch (s)'); grid on;

figure(2);clf;
subplot(311)
plot(tVec0,bSFaInv(:,1),'b','linewidth',2); grid on;
title('Accel scale factor error estimates');
ylabel('x (rad)');
ylim(aslim*[-1 1]);
subplot(312)
plot(tVec0,bSFaInv(:,2),'b','linewidth',2); grid on;
ylabel('y (rad)');
ylim(aslim*[-1 1]);
subplot(313)
plot(tVec0,bSFaInv(:,3),'b','linewidth',2); 
ylabel('z (rad)');
ylim(aslim*[-1 1]);
xlabel('Time since first epoch (s)'); grid on;

figure(3);clf;
subplot(311)
plot(tVec0,bSFgInv(:,1),'b','linewidth',2); grid on;
title('Gyro scale factor error estimates');
ylabel('x (rad)');
ylim(gslim*[-1 1]);
subplot(312)
plot(tVec0,bSFgInv(:,2),'b','linewidth',2); grid on;
ylabel('y (rad)');
ylim(gslim*[-1 1]);
subplot(313)
plot(tVec0,bSFgInv(:,3),'b','linewidth',2); 
ylabel('z (rad)');
ylim(gslim*[-1 1]);
xlabel('Time since first epoch (s)'); grid on;

figure(4);clf;
subplot(311)
plot(tVec0,blB(:,1),'r','linewidth',2); grid on;
title('Lever arm error estimates');
ylabel('x (m)');
ylim(gslim*[-1 1]);
subplot(312)
plot(tVec0,blB(:,2),'r','linewidth',2); grid on;
ylabel('y (m)');
ylim(gslim*[-1 1]);
subplot(313)
plot(tVec0,blB(:,3),'r','linewidth',2); 
ylabel('z (m)');
ylim(gslim*[-1 1]);
xlabel('Time since first epoch (s)'); grid on;

else
figure(1);clf;
t2 = [tVec0; flipud(tVec0)];
subplot(311)
stdx = [beBU(:,1) + beBU_std(:,1); flipud(beBU(:,1) - beBU_std(:,1))];
fill(t2, stdx, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,beBU(:,1),'b','linewidth',2); grid on;
title('Attitude bias estimates (as Euler angles)');
ylabel('\phi (rad)');
ylim(ablim*[-1 1]);
subplot(312)
stdy = [beBU(:,2) + beBU_std(:,2); flipud(beBU(:,2) - beBU_std(:,2))];
fill(t2, stdy, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,beBU(:,2),'b','linewidth',2); grid on;
ylabel('\theta (rad)');
ylim(ablim*[-1 1]);
subplot(313)
stdz = [beBU(:,3) + beBU_std(:,3); flipud(beBU(:,3) - beBU_std(:,3))];
fill(t2, stdz, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,beBU(:,3),'b','linewidth',2); 
ylabel('\psi (rad)');
ylim(ablim*[-1 1]);
xlabel('Time since first epoch (s)'); grid on;

figure(2);clf;
t2 = [tVec0; flipud(tVec0)];
subplot(311)
stdx = [bSFaInv(:,1) + bSFaInv_std(:,1); flipud(bSFaInv(:,1) - bSFaInv_std(:,1))];
fill(t2, stdx, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,bSFaInv(:,1),'b','linewidth',2); grid on;
title('Accel scale factor error estimates');
ylabel('x (rad)');
ylim(aslim*[-1 1]);
subplot(312)
stdy = [bSFaInv(:,2) + bSFaInv_std(:,2); flipud(bSFaInv(:,2) - bSFaInv_std(:,2))];
fill(t2, stdy, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,bSFaInv(:,2),'b','linewidth',2); grid on;
ylabel('y (rad)');
ylim(aslim*[-1 1]);
subplot(313)
stdz = [bSFaInv(:,3) + bSFaInv_std(:,3); flipud(bSFaInv(:,3) - bSFaInv_std(:,3))];
fill(t2, stdz, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,bSFaInv(:,3),'b','linewidth',2); 
ylabel('z (rad)');
ylim(aslim*[-1 1]);
xlabel('Time since first epoch (s)'); grid on;

figure(3);clf;
t2 = [tVec0; flipud(tVec0)];
subplot(311)
stdx = [bSFgInv(:,1) + bSFgInv_std(:,1); flipud(bSFgInv(:,1) - bSFgInv_std(:,1))];
fill(t2, stdx, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,bSFgInv(:,1),'b','linewidth',2); grid on;
title('Gyro scale factor error estimates');
ylabel('x (rad)');
ylim(gslim*[-1 1]);
subplot(312)
stdy = [bSFgInv(:,2) + bSFgInv_std(:,2); flipud(bSFgInv(:,2) - bSFgInv_std(:,2))];
fill(t2, stdy, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,bSFgInv(:,2),'b','linewidth',2); grid on;
ylabel('y (rad)');
ylim(gslim*[-1 1]);
subplot(313)
stdz = [bSFgInv(:,3) + bSFgInv_std(:,3); flipud(bSFgInv(:,3) - bSFgInv_std(:,3))];
fill(t2, stdz, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,bSFgInv(:,3),'b','linewidth',2); 
ylabel('z (rad)');
ylim(gslim*[-1 1]);
xlabel('Time since first epoch (s)'); grid on;

figure(4);clf;
t2 = [tVec0; flipud(tVec0)];
subplot(311)
stdx = [blB(:,1) + blB_std(:,1); flipud(blB(:,1) - blB_std(:,1))];
fill(t2, stdx, 'r', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,blB(:,1),'r','linewidth',2); grid on;
title('Lever arm error estimates');
ylabel('x (m)');
ylim(gslim*[-1 1]);
subplot(312)
stdy = [blB(:,2) + blB_std(:,2); flipud(blB(:,2) - blB_std(:,2))];
fill(t2, stdy, 'r', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,blB(:,2),'r','linewidth',2); grid on;
ylabel('y (m)');
ylim(gslim*[-1 1]);
subplot(313)
stdz = [blB(:,3) + blB_std(:,3); flipud(blB(:,3) - blB_std(:,3))];
fill(t2, stdz, 'r', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,blB(:,3),'r','linewidth',2); 
ylabel('z (m)');
ylim(gslim*[-1 1]);
xlabel('Time since first epoch (s)'); grid on;
end


p1 = [1364    73         560         420]';
p2 = [1364   577         560         420]';
p3 = [798   577   560   420]';
h = figure(1); set(h,'position', p3);
h = figure(2); set(h,'position', p2);
h = figure(3); set(h,'position', p1);


