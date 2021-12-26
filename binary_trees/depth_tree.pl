depth(nil, 0).
depth(t(L,_,R), Depth):-
    depth(L, DepthL),
    depth(R, DepthR),
    Depth is max(DepthL, DepthR) + 1.