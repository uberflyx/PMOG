function [ n,m ] = zernIndex( nollIndex )
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
end

end

