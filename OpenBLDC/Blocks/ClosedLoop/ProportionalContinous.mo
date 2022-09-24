within OpenBLDC.Blocks.ClosedLoop;

block ProportionalContinous
extends Modelica.Blocks.Icons.Block;
extends ProportionalPartial;
equation
  connect(r, feedback.u1) annotation(
    Line(points = {{-100, 0}, {-8, 0}}, color = {0, 0, 127}));
  connect(y, feedback.u2) annotation(
    Line(points = {{0, -100}, {0, -60}, {-20, -60}, {-20, -8}}, color = {0, 0, 127}));
  connect(limiter.y, u) annotation(
    Line(points = {{52, 0}, {100, 0}}, color = {0, 0, 127}));
end ProportionalContinous;