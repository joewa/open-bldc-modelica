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
  Modelica.Blocks.Sources.Constant constZeroPoint5[3](each k = 0.5) annotation(
    Placement(visible = true, transformation(extent = {{138, 42}, {150, 54}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = -1) annotation(
    Placement(visible = true, transformation(origin = {20, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product[3] annotation(
    Placement(visible = true, transformation(origin = {140, 74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add[3] annotation(
    Placement(visible = true, transformation(origin = {180, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold[3](each threshold = -0.5)  annotation(
    Placement(visible = true, transformation(origin = {111, -35}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold[3](each threshold = 0.5)  annotation(
    Placement(visible = true, transformation(origin = {111, -68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Nand nand[3] annotation(
    Placement(visible = true, transformation(origin = {161, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Routing.Replicator replicator(nout = 3)  annotation(
    Placement(visible = true, transformation(origin = {60, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant dutyCycleOne[3](each k = 1)  annotation(
    Placement(visible = true, transformation(origin = {179, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch switch[3] annotation(
    Placement(visible = true, transformation(origin = {229, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
  connect(combiTable1Ds.y, product.u2) annotation(
    Line(points = {{73, 34}, {90, 34}, {90, 68}, {128, 68}}, color = {0, 0, 127}, thickness = 0.5));
  connect(product.y, add.u1) annotation(
    Line(points = {{151, 74}, {168, 74}}, color = {0, 0, 127}, thickness = 0.5));
  connect(constZeroPoint5.y, add.u2) annotation(
    Line(points = {{150.6, 48}, {158.6, 48}, {158.6, 62}, {167.6, 62}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTable1Ds.y, greaterEqualThreshold.u) annotation(
    Line(points = {{73, 34}, {90, 34}, {90, -35}, {99, -35}}, color = {0, 0, 127}, thickness = 0.5));
  connect(combiTable1Ds.y, lessEqualThreshold.u) annotation(
    Line(points = {{73, 34}, {90, 34}, {90, -68}, {99, -68}}, color = {0, 0, 127}, thickness = 0.5));
  connect(greaterEqualThreshold.y, nand.u1) annotation(
    Line(points = {{122, -35}, {141, -35}, {141, -60}, {149, -60}}, color = {255, 0, 255}, thickness = 0.5));
  connect(lessEqualThreshold.y, nand.u2) annotation(
    Line(points = {{122, -68}, {149, -68}}, color = {255, 0, 255}, thickness = 0.5));
  connect(nand.y, lCtrl) annotation(
    Line(points = {{172, -60}, {260, -60}}, color = {255, 0, 255}, thickness = 0.5));
  connect(gain.y, replicator.u) annotation(
    Line(points = {{31, 80}, {48, 80}}, color = {0, 0, 127}));
  connect(replicator.y, product.u1) annotation(
    Line(points = {{71, 80}, {128, 80}}, color = {0, 0, 127}, thickness = 0.5));
  connect(nand.y, switch.u2) annotation(
    Line(points = {{172, -60}, {201, -60}, {201, 60}, {217, 60}}, color = {255, 0, 255}, thickness = 0.5));
  connect(dutyCycleOne.y, switch.u3) annotation(
    Line(points = {{190, 20}, {211, 20}, {211, 52}, {217, 52}}, color = {0, 0, 127}, thickness = 0.5));
  connect(add.y, switch.u1) annotation(
    Line(points = {{191, 68}, {217, 68}}, color = {0, 0, 127}, thickness = 0.5));
  connect(switch.y, hCtrl) annotation(
    Line(points = {{240, 60}, {260, 60}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-280, -100}, {260, 140}}), graphics),
    Icon(coordinateSystem(extent = {{-280, -100}, {260, 140}}, preserveAspectRatio = false), graphics),
    Documentation(info = "<html>
<p>Mit dem Rampen-algorithmus am Besten direkt auf das PWM und Br&uuml;ckentreiber gehen. Dann kann dort auch gleich der einfache Hall-Regler eingebaut werden.</p>
</html>"));
end SensorCtrl3phContinuous;