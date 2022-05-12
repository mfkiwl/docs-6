% poseAndTwistAnal.m
% 
% Analysis of PoseAndTwist report data

clear; clc; 
%----- Setup
tStartSec = 0; 
tStopSec  = 1000;
alim = 0.5;  % m/s^2
dlim = 0.2;  % m
paperFigs = 0;
deltat_fixup = 0; 
apply_shift = true;

%----- Set directory
addpath(genpath('../../navsol'));
datadir = '/vtrak3/data2/icarusDatasets/feb2022/2022-02-25/1/data_gnss/todd/loose';
datadirT = '/vtrak3/data2/icarusDatasets/feb2022/2022-02-25/1/data_gnss/todd/loose/truth';

%----- Pull in data
load([datadir '/poseandtwist.mat']);
pt = poseandtwist'; clear poseandtwist;
load([datadirT '/poseandtwist.mat']);
ptT = poseandtwist'; clear poseandtwist;

%----- Analyze data
tVec = pt(:,2) + pt(:,3);
tVec00 = pt(1,2) + pt(1,3);
tVec0 = tVec - tVec00;
iidum = find(tVec0 >= tStartSec & tVec0 <= tStopSec);
pt = pt(iidum,:);
tVec0 = tVec0(iidum);
tVec = tVec(iidum);
e_std = sqrt(pt(:,26:28));
baU_std = sqrt(pt(:,35:37));
bgU_std = sqrt(pt(:,38:40));
baU = pt(:,17:19);
bgU = pt(:,20:22);
rW_std = sqrt(pt(:,23:25));
rW = pt(:,4:6);
qBW = pt(:,7:10);
qBWT_raw = ptT(:,7:10);
vW = pt(:,11:13);
omegaB = pt(:,14:16);
tVecT = ptT(:,2) + ptT(:,3);
tVec0T = tVecT - tVec00;
rWT_raw = ptT(:,4:6);
rWT = interp1(tVec0T + deltat_fixup, rWT_raw, tVec0, 'spline');
drW = rW - rWT;
if(apply_shift)
[Ns, ~] = size(drW);
iidum = find(tVec0 - tVec0(1) < 200);
drW_offset = median(drW(iidum,:));
drW = drW - ones(Ns,1)*drW_offset;
end

%----- Plot
figure(1);clf;
hsc = scatter(pt(:,4),pt(:,5), 30,'filled');
hsc.MarkerFaceColor = [0 0 1];
title('Horizontal deviation from reference location'); grid on;
xlabel('East (m)'); ylabel('North (m)');  axis equal;
%xlim([0 1000]);
%ylim([-500, 300]);

figure(2);clf;
t2 = [tVec0; flipud(tVec0)];
subplot(311)
stdx = [baU(:,1) + baU_std(:,1); flipud(baU(:,1) - baU_std(:,1))];
fill(t2, stdx, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,baU(:,1),'b','linewidth',2); grid on;
ylabel('X (m/s^2)');
ylim(alim*[-1 1]);
title('Accelerometer Bias Estimates');
subplot(312)
stdy = [baU(:,2) + baU_std(:,2); flipud(baU(:,2) - baU_std(:,2))];
fill(t2, stdy, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,baU(:,2),'b','linewidth',2); grid on;
ylabel('Y (m/s^2)');
ylim(alim*[-1 1]);
subplot(313)
stdz = [baU(:,3) + baU_std(:,3); flipud(baU(:,3) - baU_std(:,3))];
fill(t2, stdz, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,baU(:,3),'b','linewidth',2); 
ylabel('Z (m/s^2)');
ylim(alim*[-1 1]);
xlabel('Time since first epoch (s)'); grid on;
if(paperFigs)
    subplot(311); figset;
    subplot(312); figset;
    subplot(313); figset;
end

figure(3);clf;
plot(tVec0,bgU);
title('Rate gyro bias estimates');
ylabel('rad/s');
xlabel('Time since first epoch (s)'); grid on;
legend('x','y','z');

figure(4);clf;
t2 = [tVec0; flipud(tVec0)];
subplot(311)
stdx = [rW_std(:,1); flipud(-rW_std(:,1))];
fill(t2, stdx, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,drW(:,1),'b','linewidth',2); grid on;
ylabel('E (m)');
ylim(dlim*[-1 1]);
title('Position Error');
subplot(312)
stdy = [rW_std(:,2); flipud(-rW_std(:,2))];
fill(t2, stdy, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,drW(:,2),'b','linewidth',2); grid on;
ylabel('N (m)');
ylim(dlim*[-1 1]);
subplot(313)
stdz = [rW_std(:,3); flipud(-rW_std(:,3))];
fill(t2, stdz, 'b', 'FaceAlpha', 0.3,'linestyle', 'none');
hold on;
plot(tVec0,drW(:,3),'b','linewidth',2); 
ylabel('U (m)');
ylim(dlim*[-1 1]);
xlabel('Time since first epoch (s)'); grid on;
if(paperFigs)
    subplot(311); figset;
    subplot(312); figset;
    subplot(313); figset;
end

% Velocity
if(0)
figure(5);clf;
subplot(311)
hold on;
plot(tVec0,vW(:,1),'b','linewidth',2); grid on;
ylabel('E');
title('Velocity (m/s)');
subplot(312)
plot(tVec0,vW(:,2),'b','linewidth',2); grid on;
ylabel('N');
subplot(313)
plot(tVec0,vW(:,3),'b','linewidth',2); 
ylabel('U');
xlabel('Time since first epoch (s)'); grid on;
std_velocity = std(vW)
mean_velocity = mean(vW)
end

% Attitude
if(0)
%figure(6);clf;
[N,~] = size(e_std);
rpy = zeros(N,3);
for ii=1:N
    rpy(ii,:) = dcm2euler(quat2dc(qBW(ii,:)))';
end
[N,~] = size(qBWT_raw);
rpyT_raw = zeros(N,3);
for ii=1:N
    rpyT_raw(ii,:) = dcm2euler(quat2dc(qBWT_raw(ii,:)))';
end
headingT = interp1(tVec0T + deltat_fixup, unwrap(rpyT_raw(:,3)),...
                   tVec0, 'spline');
heading_error = unwrap(rpy(:,3) - headingT);
he0 = 2*pi*round(heading_error(1)/2/pi);
heading_error0 = heading_error - he0;
% plot(tVec0, heading_error0, 'b','linewidth',2);
% xlabel('Time since first epoch (s)'); grid on;
% ylabel('Error (rad)')
% title('Heading Error');
figure(7);clf;
subplot(211)
plot(tVec0, rpy(:,1:2)*180/pi, 'linewidth', 2);
ylabel('degrees')
title('Roll and Pitch');
legend('Roll', 'Pitch'); grid on;
subplot(212)
plot(tVec0, unwrap(rpy(:,3))*180/pi, 'linewidth', 2);
ylabel('degrees');
title('Yaw');
xlabel('Time since first epoch (s)'); grid on;
end

std_baUx1000 = std(baU)*1000
baU_mean = mean(baU)
baU_rms = rms(baU);
bgU_mean = mean(bgU)
bgU_rms = rms(bgU);
maxAbsENU = max(abs(drW))
rmsENU = rms(drW)
norm_rmsENU = norm(rmsENU)

p1 = [1364    73         560         420]';
p3 = [1364   577         560         420]';
p2 = [798   577   560   420]';
h = figure(1); set(h,'position', p1);
h = figure(2); set(h,'position', p2);
h = figure(3); set(h,'position', p3);
h = figure(4); set(h,'position', p3);

%drFull = sqrt(drW(:,1).^2 + drW(:,2).^2 + drW(:,3).^2);
%peaks = drFull(857:200:end);
