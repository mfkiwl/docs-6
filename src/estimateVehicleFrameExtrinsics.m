% estimateVehicleFrameExtrinsics.m
% 
% Estimate the transform from the body (B) frame to the vehicle (V) frame.
% See "estimation_of_vehicle_frame_extrinsics.pdf" in doc/derivations.

clear; clc; 
%----- Setup
tStartSec = 0;  
tStopSec = 5000;
nx = 6;
% sigmas for the zero-velocity measurements along the vehicle y and z axes,
% in meters
sigma_y = 0.02;
sigma_z = 0.05;

%----- Set directory
addpath(genpath('../../navsol'));
datadir  = '/vtrak3/data2/sensoriumDatasets/lupChallengeProcessing/2019May12-rover/todd/ppengine/simulated/true_atlans';

%----- Pull in data
load([datadir '/poseandtwist.mat']);
pt = poseandtwist'; clear poseandtwist;

%----- Format data
tVec = pt(:,2) + pt(:,3);
tVec00 = pt(1,2) + pt(1,3);
tVec0 = tVec - tVec00;
iidum = find(tVec0 >= tStartSec & tVec0 <= tStopSec);
pt = pt(iidum,:);
tVec0 = tVec0(iidum);
tVec = tVec(iidum);
rW = pt(:,4:6);
qBW = pt(:,7:10);
vBoW = pt(:,11:13);
omegaB = pt(:,14:16);
[N,~] = size(qBW); 

%----- Plot
figure(1);clf;
scatter(pt(:,4),pt(:,5),30,'filled');
title('Horizontal deviation from reference location'); grid on;
xlabel('East (m)'); ylabel('North (m)');  axis equal;

%----- Estimate extrinsic parameters
lVoB_bar = [0.6739,    0.7591 + 0.11,   -1.4332]';
e_bar = zeros(3,1);
RVB_bar = [0 -1 0; 1 0 0; 0 0 1];
RaInvT_diag = zeros(2*N, 1);
RaInvT_diag(1:2:end) = (1/sigma_y) * ones(N,1);
RaInvT_diag(2:2:end) = (1/sigma_z) * ones(N,1);
RaInvT = diag(RaInvT_diag);

for jj=1:5
  HBig = zeros(2*N,nx);
  zBig = zeros(2*N,1);
  vVoV_mat = zeros(N,3);
  for ii=1:N
    RBW = quat2dc(qBW(ii,:)');
    vBoB = RBW*(vBoW(ii,:)');
    wB = omegaB(ii,:)';
    a = RVB_bar*(vBoB + cross(wB,lVoB_bar));
    hp_bar = a;
    vVoV_mat(ii,:) = hp_bar';
    h_bar = hp_bar(2:3);
    H1 = [a(3) 0 -a(1); -a(2) a(1) 0];
    H2p = RVB_bar*crossProductEquivalent(wB);
    H2 = H2p(2:3,:);
    H = [H1, H2];
    x_bar = [e_bar; lVoB_bar];
    z_tilde = -h_bar + H*x_bar;
    zBig(2*ii - 1: 2*ii) = z_tilde;
    HBig(2*ii - 1: 2*ii, :) = H; 
  end
  HBig = RaInvT*HBig;
  zBig = RaInvT*zBig;
  [QBig,RBig] = qr(HBig);
  zv = QBig' * zBig;
  x_hat = inv(RBig(1:nx,:))*zv(1:nx);
  e_bar = x_hat(1:3);
  lVoB_bar = x_hat(4:6);
  RVB_bar = euler2dcm(e_bar)*RVB_bar;
  e_bar = zeros(3,1);
  x_hat';
end

qVB_hat = dc2quat(RVB_bar)'
eVB_hat_deg = dcm2euler(RVB_bar)' * 180/pi
lVoB_hat = lVoB_bar'

% Compensate for correlation between yaw rate and velocity in the Vy
% direction
figure(3);clf;
plot(omegaB(:,3), vVoV_mat(:,2), '.')
xlabel('\omega_{Bz} (rad/s)');
ylabel('v_{0y}');
axis equal; grid on;
Rwzvy = corrcoef([omegaB(:,3), vVoV_mat(:,2)])
pVec = polyfit(omegaB(:,3), vVoV_mat(:,2), 1);
vVoy_model = polyval(pVec,omegaB(:,3));
hold on;
plot(omegaB(:,3), vVoy_model, 'g.');
vVoVy_compensated = vVoV_mat(:,2) - vVoy_model;
% The model assumed by the PPose config file is P(0) + P(1)*omegaBz +
% P(2)*omegaBz^2 + ... P(N)*omegaBz^N
pVec_for_ppose_config = fliplr(pVec)

% Test the extrinsics estimates by examining the vehicle-referenced
% velocity, whose Y and Z components should be near zero.
figure(2);clf;
subplot(311);
plot(tVec0,vVoV_mat(:,1));
ylabel('X');
title('Velocity of Vehicle at V_0, expressed in the V frame (m/s)');
grid on;
subplot(312);
plot(tVec0,vVoVy_compensated);
ylabel('Y'); 
grid on;
subplot(313);
plot(tVec0,vVoV_mat(:,3));
grid on;
ylabel('Z');
xlabel('Time (sec)');


vy_mean = mean(vVoVy_compensated)
vy_rms = rms(vVoVy_compensated)
vz_mean = mean(vVoV_mat(:,3))
vz_rms = rms(vVoV_mat(:,3))




