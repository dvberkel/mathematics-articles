createE := function(c)
  local M, row, r, i;
  M := [];
  for r in [1..c] do
    row := [];
    for i in [1..c] do
      if (r-1 <= i) and (i <= r+1) then
        row[i] := 1;
      else
        row[i] := 0;
      fi;
    od;
    M[r] := row;
  od;
  return M;
end;