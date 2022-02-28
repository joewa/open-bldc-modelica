within OpenBLDC.Blocks;

block SensorCtrl3phStateGraphNG "Commutation applying PWM"
  extends OpenBLDC.Icons.ControlLaw;
  parameter Integer PwmMode = 1 "Two-leg (1) or single-leg (2) mode";
  parameter Modelica.Units.SI.Duration DelayCommutation = 20e-006 "Delay commutation";
  parameter Modelica.Units.SI.Duration TimeoutCommutation = 0.01 "Motor has stopped when Timeout";
  // das noch an der induzierten Spannung festmachen
  //Boolean chAngle;
  //Integer intAngle;
  Modelica.Blocks.Interfaces.BooleanOutput hCtrl[3] annotation(
    Placement(transformation(extent = {{250, 50}, {270, 70}}), iconTransformation(extent = {{80, 50}, {100, 70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl[3] annotation(
    Placement(transformation(extent = {{250, -70}, {270, -50}}), iconTransformation(extent = {{80, -70}, {100, -50}})));
  Modelica.Blocks.Interfaces.RealInput angle "Decoded hall" annotation(
    Placement(transformation(extent = {{-300, -20}, {-260, 20}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table = [0, 0, 0, 0; 1, 1, -1, 0; 2, 0, -1, 1; 3, -1, 0, 1; 4, -1, 1, 0; 5, 0, 1, -1; 6, 1, 0, -1]) annotation(
    Placement(transformation(extent = {{52, 24}, {72, 44}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression[3](each y = PwmMode) annotation(
    Placement(transformation(extent = {{164, -78}, {184, -58}})));
  Modelica.Blocks.Interfaces.RealInput v[3] "voltage per phase" annotation(
    Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -100})));
  Modelica.Blocks.Interfaces.RealInput dutyCycle "Commanded duty cycle" annotation(
    Placement(transformation(extent = {{-300, 60}, {-260, 100}})));
  PulseLogic pulseLogic(PwmVarFrequency = false) annotation(
    Placement(transformation(extent = {{156, 38}, {176, 58}})));
  HalfBridgeLogicBLDC halfBridgeLogicINSD[3] annotation(
    Placement(transformation(extent = {{198, 38}, {218, 58}})));
  Modelica.Blocks.Sources.BooleanStep switchOn(startTime = 0.1e-5) annotation(
    Placement(transformation(extent = {{118, -10}, {138, 10}})));
  PhaseDiffVoltageNph phaseDiffVoltageNph annotation(
    Placement(transformation(extent = {{14, -64}, {34, -44}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot annotation(
    Placement(visible = true, transformation(extent = {{200, 80}, {220, 100}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(extent = {{-60, 24}, {-40, 44}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 7) annotation(
    Placement(visible = true, transformation(extent = {{-104, 24}, {-84, 44}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput v_dc annotation(
    Placement(visible = true, transformation(origin = {60, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
equation
//intAngle = integer(angle);
//chAngle = change(intAngle);
  connect(pulseLogic.bridgeModeOut, halfBridgeLogicINSD.val) annotation(
    Line(points = {{176, 48}, {198, 48}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(integerExpression.y, halfBridgeLogicINSD.pwm_Mode) annotation(
    Line(points = {{185, -68}, {190, -68}, {190, 40}, {198, 40}}, color = {255, 127, 0}, smooth = Smooth.None));
  connect(pulseLogic.y, halfBridgeLogicINSD[1].pulses) annotation(
    Line(points = {{176, 56}, {188, 56}, {188, 55.8}, {198, 55.8}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(pulseLogic.y, halfBridgeLogicINSD[2].pulses) annotation(
    Line(points = {{176, 56}, {188, 56}, {188, 55.8}, {198, 55.8}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(pulseLogic.y, halfBridgeLogicINSD[3].pulses) annotation(
    Line(points = {{176, 56}, {188, 56}, {188, 55.8}, {198, 55.8}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(halfBridgeLogicINSD.hCtrl, hCtrl) annotation(
    Line(points = {{218, 54}, {236, 54}, {236, 60}, {260, 60}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(halfBridgeLogicINSD.lCtrl, lCtrl) annotation(
    Line(points = {{218, 42}, {238, 42}, {238, -60}, {260, -60}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(dutyCycle, pulseLogic.dutyCycle) annotation(
    Line(points = {{-280, 80}, {-62, 80}, {-62, 56}, {156, 56}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(combiTable1Ds.y, pulseLogic.bridgeModeIn) annotation(
    Line(points = {{73, 34}, {114, 34}, {114, 48}, {156, 48}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(switchOn.y, pulseLogic.active) annotation(
    Line(points = {{139, 0}, {148, 0}, {148, 40}, {156, 40}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(angle, combiTable1Ds.u) annotation(
    Line(points = {{-280, 0}, {20, 0}, {20, 34}, {50, 34}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(v, phaseDiffVoltageNph.u) annotation(
    Line(points = {{0, -100}, {0, -54}, {14, -54}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(angle, feedback.u2) annotation(
    Line(points = {{-280, 0}, {-50, 0}, {-50, 26}}, color = {0, 0, 127}));
  connect(const.y, feedback.u1) annotation(
    Line(points = {{-83, 34}, {-58, 34}}, color = {0, 0, 127}));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-280, -100}, {260, 140}}), graphics),
    Icon(coordinateSystem(extent = {{-280, -100}, {260, 140}}, preserveAspectRatio = false), graphics),
    Documentation(info = "<html>
<p>Mit dem Rampen-algorithmus am Besten direkt auf das PWM und Br&uuml;ckentreiber gehen. Dann kann dort auch gleich der einfache Hall-Regler eingebaut werden.</p>
</html>"));
end SensorCtrl3phStateGraphNG;