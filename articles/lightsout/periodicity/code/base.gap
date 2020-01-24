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

createW := function(c, F)
  local Ec;
  Ec := createE(c);
  return F * BlockMatrix([
    [1, 1, -1*Ec],
    [1, 2, -IdentityMat(c)],
    [2, 1, IdentityMat(c)]
  ], 2, 2);
end;