## script 1
    1. this is an exmple of how to represent translation and rotation. and how to compute a point projection to a transformed coordinate
       `P1=inv(T1)*[P;1]`


## script2
    1. this script shows how to rotate about a certain point: translate to it, rotate, then translate back
        `transl2(C)*R*transl2(-C)`

## script3
    1. this script shows how to do rotation in 3d with euler angles
       ` rotz(0.1) `  `eul2r(0.1,0.2,0.3)`
    2. given rotation how to find euler angles
        `tr2eul(R)`
