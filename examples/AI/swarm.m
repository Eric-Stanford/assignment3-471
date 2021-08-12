function vel = swarm(rr,ro,ra,x,blind_neighbors, N, dxi)
% FILE: swarm.m implements a Boids-like behavior
%
% DESCRIPTION:
% Boids-like repulsion-orientation-attraction behavior based on the 
% behavior described by Couzin et al. in the Collective Memory paper. 
%
% INPUTS:
% rr - radius of repulsion
% ro - radius of orientation
% ra - radius of attraction
% x - matrix containing the pose of all the robots
% blind_neighbors - matrix tracking the robots in a robot's blind spot
% N - the number of robots in the swarm
% dxi - the original velocity of all the robots
%
% OUTPUTS:
% vel - the resulting velocity of the robots
%
% TODO:
% 1. orient matrix
% 2. attract matrix
% 3. dxi(1:2, i) for orientation
% 4. dxi(1:2, i) for attraction

%% Authors: Safwan Alam, Musad Haque - 2018
%%%%%%%%%%%%%

dist = distances_from_others(x, N); %dist(i,j) is the distance between i and j

%Initialize
repulse = zeros(N, N); %repulse(i,j)=1 will indicate j is in i's repulsion zone
orient = zeros(N, N); %orient(i,j)=1 will indicate j is in i's orientation zone
attract = zeros(N, N); %attract(i,j)=1 will indicate j is in i's attraction zone

%Determine who to repulse, orient with, and/or attract to (i.e., populate
%the repulse, orient, and attract matrices)
for ii = 1:1:N
    for jj = 1:1:N
        if (ii ~= jj)
            if dist(ii, jj) <= rr
                repulse(ii, jj) = true;
            elseif dist(ii, jj) > rr && dist(ii,jj) <= ro
                %orient(... ??? COMPLETE and uncomment!!!!!
                orient(ii, jj) = true;
            elseif dist(ii, jj) > ro && dist(ii,jj) <= ra
                %attract(... ??? COMPLETE and uncomment!!!!!
                attract(ii, jj) = true;
            else
            end
        end
    end
end

%Keep a copy of the original velocity vector
dxi_old = dxi;

for ii = 1:1:N
    if any(repulse(ii, :))
        %priority is to repulse
        for jj = 1:1:N
            if repulse(ii, jj) && ~blind_neighbors(ii,jj)
                dxi(1:2, ii) = -x(1:2, jj) + x(1:2, ii) + dxi(1:2, ii);
            end
        end
    else
        %if not busy repulsing... orient and attract
        for jj = 1:1:N
            if orient(ii, jj) && ~blind_neighbors(ii,jj)
                %was originally dxi(1:2, i) = ??? COMPLETE and uncomment!!!!!
                dxi(1:2, ii) = x(1:2, jj) + x(1:2, ii);
                
            end
            if attract(ii, jj) && ~blind_neighbors(ii,jj)
                %was originally dxi(1:2, i) = ??? COMPLETE and uncomment!!!!!
                dxi(1:2, ii) = x(1:2, jj) + -x(1:2, ii) + dxi(1:2, ii);
            end
        end
    end
    %Normalize the velocity
    if norm(dxi(1:2, ii)) ~= 0
        dxi(1:2, ii) = dxi(1:2, ii)/norm(dxi(1:2, ii));
    end
end

vel = dxi;

end


