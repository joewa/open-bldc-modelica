within OpenBLDC.Blocks.ClosedLoop;

model ProportionalClocked
extends Modelica.Blocks.Icons.DiscreteBlock;
extends ProportionalPartial;
  parameter Modelica.Units.SI.Period t_s = 0.02 "Sample period";
  Modelica.Clocked.RealSignals.Sampler.SampleClocked sampler_r annotation(
    Placement(visible = true, transformation(origin = {-40, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Clocked.RealSignals.Sampler.Sample sampler_y annotation(
    Placement(visible = true, transformation(origin = {-20, -20}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  Modelica.Clocked.RealSignals.Sampler.Hold zeroOrderHold annotation(
    Placement(visible = true, transformation(origin = {68, 0}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  Modelica.Clocked.ClockSignals.Clocks.PeriodicRealClock periodicClock(period = t_s)  annotation(
    Placement(visible = true, transformation(origin = {-54, -14}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
equation
  connect(sampler_r.y, feedback.u1) annotation(
    Line(points = {{-34, 0}, {-28, 0}}, color = {0, 0, 127}));
  connect(sampler_y.y, feedback.u2) annotation(
    Line(points = {{-20, -14}, {-20, -8}}, color = {0, 0, 127}));
  connect(r, sampler_r.u) annotation(
    Line(points = {{-100, 0}, {-48, 0}}, color = {0, 0, 127}));
  connect(y, sampler_y.u) annotation(
    Line(points = {{0, -100}, {0, -40}, {-20, -40}, {-20, -28}}, color = {0, 0, 127}));
  connect(limiter.y, zeroOrderHold.u) annotation(
    Line(points = {{52, 0}, {60, 0}}, color = {0, 0, 127}));
  connect(zeroOrderHold.y, u) annotation(
    Line(points = {{74, 0}, {100, 0}}, color = {0, 0, 127}));
  connect(periodicClock.y, sampler_r.clock) annotation(
    Line(points = {{-48, -14}, {-40, -14}, {-40, -8}}, color = {175, 175, 175}));
end ProportionalClocked;