within OpenBLDC.Assemblies.ClosedLoopSystems;

model DCMotorPosition "Simple DC motor servo"
  extends Modelica.Icons.Example;
  import Modelica.Electrical.Analog;
  import Modelica.Mechanics.Rotational;
  parameter Real kp = 25 "Proportional gain";
  OpenBLDC.Machines.BrushedDC emotor annotation(
    Placement(visible = true, transformation(origin = {30, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.SignalVoltage vsource annotation(
    Placement(visible = true, transformation(origin = {10, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  Modelica.Electrical.Analog.Basic.Ground gnd annotation(
    Placement(visible = true, transformation(origin = {10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(
    Placement(visible = true, transformation(origin = {40, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation(
    Placement(visible = true, transformation(origin = {60, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Step step(height = 1, startTime = 0.25)  annotation(
    Placement(visible = true, transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  replaceable OpenBLDC.Blocks.ClosedLoop.ProportionalContinous positionController annotation(
    Placement(visible = true, transformation(origin = {-20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(gnd.p, emotor.pin_n) annotation(
    Line(points = {{10, -20}, {17, -20}, {17, 0}, {24, 0}}, color = {0, 0, 255}));
  connect(gnd.p, vsource.n) annotation(
    Line(points = {{10, -20}, {10, -10}}, color = {0, 0, 255}));
  connect(vsource.p, emotor.pin_p) annotation(
    Line(points = {{10, 10}, {36, 10}, {36, 0}}, color = {0, 0, 255}));
  connect(emotor.support, fixed.flange) annotation(
    Line(points = {{40, -18}, {40, -30}}));
  connect(emotor.flange, angleSensor.flange) annotation(
    Line(points = {{40, -10}, {60, -10}, {60, -20}}));
  connect(step.y, positionController.r) annotation(
    Line(points = {{-38, 0}, {-30, 0}}, color = {0, 0, 127}));
  connect(positionController.u, vsource.v) annotation(
    Line(points = {{-10, 0}, {-2, 0}}, color = {0, 0, 127}));
  connect(angleSensor.phi, positionController.y) annotation(
    Line(points = {{60, -40}, {60, -50}, {-20, -50}, {-20, -10}}, color = {0, 0, 127}));
initial equation
  emotor.phiMechanical = 0;
end DCMotorPosition;