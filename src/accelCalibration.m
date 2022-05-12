% accelCalibration.m  
%
% A basic accelerometer calibration procedure based on the orienting the X, Y,
% and Z axes of the U (IMU) and B (body) frame with and against the gravity
% vector.
%
% W is the local ENU frame
% G is the ECEF frame
% B is the body frame
% U is the IMU frame
%
% Accelerometer measurement model for stationary platform (aW = omegaB =
% omegaBDot = 0):
%
% fU = SFa*RUB*RBW*RWG(cG - gG) + ba0U + baU + vaU
%
% where gG is the local gravity vector in G and cG is the local centripetal
% acceleration vector in G.  All units are standard SI.  See imu.h for
% details.  This calibration script attempts to determine ba0U, SFa, and RBU =
% RUB'.

clear; clc;
%----- Setup
addpath(genpath('../../navsol'));
navConstants;
% Local gravitational acceleration (m/s^2) 
[rG,vG,epochYear] = getAntLoc('ASE0');
gG = gravityVector(rG);
% Local centripetal acceleration
cG = -(OmegaE^2)*[rG(1:2);0];
% The specific force on a particle in the G frame is cG - gG.  We won't be
% able to define the local ENU up any better than aligning it with the
% apparent gravity vector, so the only way cW enters into the calibration
% is in reducing the apparent gravitational acceleration.
gApparent = norm(cG - gG);
% Raw specific force X component measured when local ENU Up aligned with U
% (+/-) X axis
fxpU =  9.7953;
fxnU = -9.7953;
% Raw specific force Y component measured when local ENU Up aligned with U
% (+/-) Y axis
fypU =  9.7961; 
fynU = -9.7945; 
% Raw specific force Z component measured when local ENU Up aligned with U
% (+/-) Z axis
fzpU =  9.7907;
fznU = -9.7975;
% Raw specific force measurement (all 3 axes) when local ENU Up aligned with
% B +X axis
fXpU = [9.7955    0.0534    0.0223]';
% Raw specific force measurement (all 3 axes) when local ENU Up aligned with
% B +Y axis
fYpU = [-0.0636    9.7962   -0.0297]';
% Raw specific force measurement (all 3 axes) when local ENU Up aligned with
% B +Z axis
fZpU = [-0.0504   -0.0258    9.7916]';

%----- Calibrate
% Static bias estimation on each axis
ba0U = [fxpU + fxnU; fypU + fynU; fzpU + fznU]/2;
% Scale factor estimation on each axis
sx = (fxpU - fxnU)/2/gApparent;
sy = (fypU - fynU)/2/gApparent;
sz = (fzpU - fznU)/2/gApparent;
SFa = diag([sx,sy,sz]);
SFaInv = inv(SFa);
% RBU estimation
v1U = SFaInv*(fXpU - ba0U); v1U = v1U/norm(v1U);
v2U = SFaInv*(fYpU - ba0U); v2U = v2U/norm(v2U);
v3U = SFaInv*(fZpU - ba0U); v3U = v3U/norm(v3U);
e1 = [1;0;0]; e2 = [0;1;0]; e3 = [0;0;1];
aVec = [1;1;1];
vBMat = [e1';e2';e3'];
vUMat = [v1U';v2U';v3U'];
RBU = wahbaSolver(aVec,vUMat,vBMat);
qBU = dc2quat(RBU);
SFaVec = diag(SFa);

if(0)
% For sensorium from plate to antenna array.  
RAB = [1 0 0; 0 -1 0; 0 0 -1];
RAU = RAB*RBU;
qBU = dc2quat(RAU);
end

%----- Output results
disp('--------------------- Calibration results -----------------------')
disp(['Static accelerometer bias ba0U: ' ...
      num2str(ba0U(1)) ' '  num2str(ba0U(2)) ' '  num2str(ba0U(3))]);
disp(['Scale factor diagonal elements diag(SFa): ' ...
      num2str(SFaVec(1)) ' '  num2str(SFaVec(2)) ' '  num2str(SFaVec(3))]);
disp(['U-to-B quaternion qBU: ' ...
      num2str(qBU(1)) ' '  num2str(qBU(2)) ' '  ...
      num2str(qBU(3)) ' '  num2str(qBU(4))]);
disp('-----------------------------------------------------------------')


