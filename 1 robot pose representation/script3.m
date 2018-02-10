R = rotz(0.1) * roty(0.2) * rotz(0.3);

R = eul2r(0.1, 0.2, 0.3)

gamma = tr2eul(R)

R = eul2r(0.1 , -0.2, 0.3)

tr2eul(R)

eul2r(ans)

R = eul2r(0.1, 0, 0.3)

tr2eul(R)