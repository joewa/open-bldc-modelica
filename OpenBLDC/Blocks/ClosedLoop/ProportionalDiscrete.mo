within OpenBLDC.Blocks.ClosedLoop;

model ProportionalDiscrete
extends Modelica.Blocks.Icons.DiscreteBlock;
extends ProportionalPartial;
  parameter Modelica.Units.SI.Period t_s = 0.02 "Sample period";
  Modelica.Blocks.Discrete.Sampler sampler_r(samplePeriod = t_s)  annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Discrete.Sampler sampler_y(samplePeriod = t_s)  annotation(
    Placement(visible = true, transformation(origin = {-20, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold(samplePeriod = t_s)  annotation(
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(r, sampler_r.u) annotation(
    Line(points = {{-100, 0}, {-62, 0}}, color = {0, 0, 127}));
  connect(sampler_r.y, feedback.u1) annotation(
    Line(points = {{-38, 0}, {-28, 0}}, color = {0, 0, 127}));
  connect(sampler_y.y, feedback.u2) annotation(
    Line(points = {{-20, -18}, {-20, -8}}, color = {0, 0, 127}));
  connect(y, sampler_y.u) annotation(
    Line(points = {{0, -100}, {0, -60}, {-20, -60}, {-20, -42}}, color = {0, 0, 127}));
  connect(limiter.y, zeroOrderHold.u) annotation(
    Line(points = {{52, 0}, {58, 0}}, color = {0, 0, 127}));
  connect(zeroOrderHold.y, u) annotation(
    Line(points = {{82, 0}, {100, 0}}, color = {0, 0, 127}));
end ProportionalDiscrete;