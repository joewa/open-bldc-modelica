within OpenBLDC.Converters.Continous;

model SwitchFreeRunning "Universal m-phase inverter"
  extends OpenBLDC.Interfaces.PartialInverter;
  import Modelica.Units.SI;
  parameter Integer m(min = 1) = 3 "Number of phases";
  parameter SI.Resistance RonSwitch = 1e-005 "Ron of Switch";
  parameter SI.Conductance GoffSwitch = 1e-005 "Gon of Switch";
  parameter SI.Resistance RonDiode = 1e-005 "Ron of Diode";
  parameter SI.Conductance GoffDiode = 1e-005 "Gon of Diode";
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch sw(m = m, Ron = ronSwitch, Goff = goffSwitch) annotation(
    Placement(visible = true, transformation(origin = {-80, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Polyphase.Ideal.IdealDiode dH(m = m, Vknee = vknee, Ron = ronDiode, Goff = goffDiode) annotation(
    Placement(visible = true, transformation(origin = {-40, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Electrical.Polyphase.Ideal.IdealDiode dL(m = m, Vknee = vknee, Ron = ronDiode, Goff = goffDiode) annotation(
    Placement(visible = true, transformation(origin = {-40, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.BooleanInput ctrl[m] annotation(
    Placement(visible = true, transformation(origin = {0, 106}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(extent = {{-21, 61}, {19, 101}}, rotation = 270)));
  Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(m = m) "Output voltage sensor" annotation(
    Placement(visible = true, transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealOutput v[m] "Output voltage at plug_p" annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-40, -100})));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensor(m = m) annotation(
    Placement(transformation(extent = {{40, -10}, {60, 10}})));
  Modelica.Blocks.Interfaces.RealOutput i[m] "Output current at plug_p" annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {40, -100})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plugIn(m = m) annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -1}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  parameter SI.Resistance ronSwitch[:] = fill(RonSwitch, m);
  parameter SI.Conductance goffSwitch[:] = fill(GoffSwitch, m);
  parameter SI.Resistance ronDiode[:] = fill(RonDiode, m);
  parameter SI.Conductance goffDiode[:] = fill(GoffDiode, m);
  parameter SI.Voltage vknee[:] = fill(0, m);
equation
  connect(voltageSensor.plug_n, plugL) annotation(
    Line(points = {{-60, -20}, {-60, -40}, {-100, -40}}, color = {0, 0, 255}));
  connect(voltageSensor.v, v) annotation(
    Line(points = {{-71, -10}, {-76, -10}, {-76, -60}, {-40, -60}, {-40, -100}}, color = {0, 0, 127}));
  connect(voltageSensor.plug_p, currentSensor.plug_p) annotation(
    Line(points = {{-60, 0}, {40, 0}}, color = {0, 0, 255}));
  connect(currentSensor.plug_n, plug_p) annotation(
    Line(points = {{60, 0}, {100, 0}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(currentSensor.i, i) annotation(
    Line(points = {{50, -11}, {40, -11}, {40, -100}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(plugL, dL.plug_p) annotation(
    Line(points = {{-100, -40}, {-60, -40}, {-60, -30}, {-40, -30}}, color = {0, 0, 255}));
  connect(dH.plug_n, plugH) annotation(
    Line(points = {{-40, 30}, {-61, 30}, {-61, 40}, {-100, 40}}, color = {0, 0, 255}));
  connect(plugIn, sw.plug_p) annotation(
    Line(points = {{-100, 0}, {-90, 0}}, color = {0, 0, 255}));
  connect(sw.plug_n, currentSensor.plug_p) annotation(
    Line(points = {{-70, 0}, {40, 0}}, color = {0, 0, 255}));
  connect(sw.plug_n, dH.plug_p) annotation(
    Line(points = {{-70, 0}, {-40, 0}, {-40, 10}}, color = {0, 0, 255}));
  connect(sw.plug_n, dL.plug_n) annotation(
    Line(points = {{-70, 0}, {-40, 0}, {-40, -10}}, color = {0, 0, 255}));
  connect(ctrl, sw.control) annotation(
    Line(points = {{0, 106}, {0, 70}, {-80, 70}, {-80, 12}}, color = {255, 0, 255}, thickness = 0.5));
  annotation(
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics),
    DymolaStoredErrors,
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Text(lineColor = {0, 0, 255}, extent = {{-50, -60}, {-30, -90}}, textString = "v"), Text(lineColor = {0, 0, 255}, extent = {{30, -60}, {50, -90}}, textString = "i"), Text(lineColor = {0, 0, 255}, extent = {{-86, 50}, {-42, 30}}, textString = "plugH", fontSize = 36, horizontalAlignment = TextAlignment.Left), Text(lineColor = {0, 0, 255}, extent = {{-86, -28}, {-42, -48}}, textString = "plugL", fontSize = 36, horizontalAlignment = TextAlignment.Left), Text(lineColor = {0, 0, 255}, extent = {{24, 12}, {86, -8}}, textString = "plug_p", fontSize = 36, horizontalAlignment = TextAlignment.Right)}),
  Documentation(info = "<html><head></head><body>Switch that drives an inductive load at plug_p providng a free running path to the rails at plugL and plugH.<div><br></div><div>TODO: The VoltageSensor is likely not appropriate here.</div></body></html>"));
end SwitchFreeRunning;