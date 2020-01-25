Read("base.gap");

dimensions := function(c, F)
  local w, dimensions, dimension, n;
  w := createW(c, F);
  dimensions := [0];
  n := 1;
  repeat
    dimension := Size(NullspaceMat((w^n){[1..c]}{[1..c]}));
    Add(dimensions, dimension);
    n := n + 1;
  until dimension = c;
  return dimensions;
end;
