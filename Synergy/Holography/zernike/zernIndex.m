function [ nm ] = zernIndex( nollIndex )
%ZERNINDEX Returns n and m based on the noll index
switch(nollIndex)
    case 1
        n=0;
        m=0;
    case 2
        n=1;
        m=1;
    case 3
        n=1;
        m=-1;
    case 4
        n=2;
        m=0;
    case 5
        n=2;
        m=-2;
    case 6
        n=2;
        m=2;
    case 7
        n=3;
        m=-1;
    case 8
        n=3;
        m=1;
    case 9
        n=3;
        m=-3;
    case 10
        n=3;
        m=3;
    case 11
        n=4;
        m=0;
    case 12
        n=4;
        m=2;
    case 13
        n=4;
        m=-2;
    case 14
        n=4;
        m=4;
    case 15
        n=4;
        m=-4;
    case 16
        n=5;
        m=1;
    case 17
        n=5;
        m=-1;
    case 18
        n=5;
        m=3;
    case 19
        n=5;
        m=-3;
    case 20
        n=5;
        m=5;
    case 21
        n=5;
        m=-5;
    case 22
        n=6;
        m=0;
    case 23
        n=6;
        m=2;
    case 24
        n=6;
        m=-2;
    case 25
        n=6;
        m=4;
    case 26
        n=6;
        m=-4;
    case 27
        n=6;
        m=6;
    case 28
        n=6;
        m=-6;
    case 29
        n=7;
        m=1;
    case 30
        n=7;
        m=-1;
    case 31
        n=7;
        m=3;
    case 32
        n=7;
        m=-3;
    case 33
        n=7;
        m=5;
    case 34
        n=7;
        m=-5;
    case 35
        n=7;
        m=7;
    case 36
        n=7;
        m=-7;
    case 37
        n=8;
        m=0;
    case 38
        n=8;
        m=2;
    case 39
        n=8;
        m=-2;
    case 40
        n=8;
        m=4;
    case 41
        n=8;
        m=-4;
    case 42
        n=8;
        m=6;
    case 43
        n=8;
        m=-6;
    case 44
        n=8;
        m=8;
    case 45
        n=8;
        m=-8;
end

nm = [n,m];

end

