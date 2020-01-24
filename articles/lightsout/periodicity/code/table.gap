Read("period.gap");

F := Z(2);

for column in [1..10] do
  dims := dimensions(column, F);
  Display(dims);
od;