createT := function(c, r)
    local T, n, row, column, indices;
    n := c * r;
    T := NullMat(n, n);
    for row in [1..n] do
        indices := [row - c, row, row + c];
        if not (row - 1) mod c = 0 then
            Add(indices, row - 1);
        fi;
        if not (row - 1) mod c = c-1 then
            Add(indices, row + 1);
        fi;
        for column in indices do
            if 1 <= column and column <= n then
                T[row][column] := 1;
            fi;
        od;
   od;

    return T; 
end;