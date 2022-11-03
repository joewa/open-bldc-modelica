within OpenBLDC.Blocks;

block SensorCtrl3phContinuous "Commutation applying PWM"
  extends OpenBLDC.Icons.ControlLaw;
  parameter Integer PwmMode = 1 "Two-leg (1) or single-leg (2) mode";
  parameter Modelica.Units.SI.Duration DelayCommutation = 20e-006 "Delay commutation";
  parameter Modelica.Units.SI.Duration TimeoutCommutation = 0.01 "Motor has stopped when Timeout";
  // das noch an der induzierten Spannung festmachen
  //Boolean chAngle;
  //Integer intAngle;
  Modelica.Blocks.Interfaces.RealOutput hCtrl[3] annotation(
    Placement(transformation(extent = {{250, 50}, {270, 70}}), iconTransformation(extent = {{80, 50}, {100, 70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl[3] annotation(
    Placement(transformation(extent = {{250, -70}, {270, -50}}), iconTransformation(extent = {{80, -70}, {100, -50}})));
  Modelica.Blocks.Interfaces.RealInput angle "Decoded hall" annotation(
    Placement(transformation(extent = {{-300, -20}, {-260, 20}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table = [0, 0, 0, 0; 1, 1, -1, 0; 2, 0, -1, 1; 3, -1, 0, 1; 4, -1, 1, 0; 5, 0, 1, -1; 6, 1, 0, -1]) annotation(
    Placement(transformation(extent = {{52, 24}, {72, 44}})));
  Modelica.Blocks.Interfaces.RealInput v[3] "voltage per phase" annotation(
    Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -100})));
  Modelica.Blocks.Interfaces.RealInput dutyCycle "Commanded duty cycle" annotation(
    Placement(transformation(extent = {{-300, 60}, {-260, 100}})));
  PhaseDiffVoltageNph phaseDiffVoltageNph annotation(
    Placement(transformation(extent = {{14, -64}, {34, -44}})));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(visible = true, transformation(extent = {{-60, 24}, {-40, 44}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 7) annotation(
    Placement(visible = true, transformation(extent = {{-104, 24}, {-84, 44}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput v_dc annotation(
    Placement(visible = true, transformation(origin = {60, -100}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Math.Gain gain(k = 1) annotation(
    Placement(visible = true, transformation(origin = {20, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Routing.Replicator replicator(nout = 3) annotation(
    Placement(visible = true, transformation(origin = {60, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenBLDC.Blocks.HalfBridgeLogicBLDCContinuous halfBridgeLogicBLDCContinuous[3] annotation(
    Placement(visible = true, transformation(origin = {150, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.IntegerConstant pwmMode[3](each k = 1) annotation(
    Placement(visible = true, transformation(extent = {{118, 35}, {128, 45}}, rotation = 0)));
equation
//intAngle = integer(angle);
//chAngle = change(intAngle);
  connect(angle, combiTable1Ds.u) annotation(
    Line(points = {{-280, 0}, {20, 0}, {20, 34}, {50, 34}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(v, phaseDiffVoltageNph.u) annotation(
    Line(points = {{0, -100}, {0, -54}, {14, -54}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(angle, feedback.u2) annotation(
    Line(points = {{-280, 0}, {-50, 0}, {-50, 26}}, color = {0, 0, 127}));
  connect(const.y, feedback.u1) annotation(
    Line(points = {{-83, 34}, {-58, 34}}, color = {0, 0, 127}));
  connect(dutyCycle, gain.u) annotation(
    Line(points = {{-280, 80}, {8, 80}}, color = {0, 0, 127}));
  connect(gain.y, replicator.u) annotation(
    Line(points = {{31, 80}, {48, 80}}, color = {0, 0, 127}));
  connect(pwmMode.y, halfBridgeLogicBLDCContinuous.pwm_Mode) annotation(
    Line(points = {{129, 40}, {133, 40}, {133, 46}, {140, 46}}, color = {255, 127, 0}, thickness = 0.5));
  connect(combiTable1Ds.y, halfBridgeLogicBLDCContinuous.val) annotation(
    Line(points = {{73, 34}, {90, 34}, {90, 54}, {140, 54}}, color = {0, 0, 127}, thickness = 0.5));
  connect(replicator.y, halfBridgeLogicBLDCContinuous.pulses) annotation(
    Line(points = {{71, 80}, {91, 80}, {91, 62}, {140, 62}}, color = {0, 0, 127}, thickness = 0.5));
  connect(halfBridgeLogicBLDCContinuous.hCtrl, hCtrl) annotation(
    Line(points = {{160, 60}, {260, 60}}, color = {0, 0, 127}, thickness = 0.5));
  connect(halfBridgeLogicBLDCContinuous.lCtrl, lCtrl) annotation(
    Line(points = {{160, 48}, {240, 48}, {240, -60}, {260, -60}}, color = {255, 0, 255}, thickness = 0.5));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-280, -100}, {260, 140}}), graphics),
    Icon(coordinateSystem(extent = {{-280, -100}, {260, 140}}, preserveAspectRatio = false), graphics),
    Documentation(info = "<html>
<p>Mit dem Rampen-algorithmus am Besten direkt auf das PWM und Br&uuml;ckentreiber gehen. Dann kann dort auch gleich der einfache Hall-Regler eingebaut werden.</p>
</html>"));
end SensorCtrl3phContinuous;