within OpenBLDC.Blocks.ClosedLoop;

partial block ProportionalPartial
  parameter Real k_p = 25 "Proportional gain";
  parameter Real u_max = 10 "Maximum set value";
  Modelica.Blocks.Interfaces.RealInput r annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-94, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput u annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {92, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput y annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -96}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Math.Gain gain(k = k_p)  annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = u_max, uMin = -u_max)  annotation(
    Placement(visible = true, transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(feedback.y, gain.u) annotation(
    Line(points = {{-11, 0}, {-3, 0}}, color = {0, 0, 127}));
  connect(gain.y, limiter.u) annotation(
    Line(points = {{21, 0}, {28, 0}}, color = {0, 0, 127}));
end ProportionalPartial;