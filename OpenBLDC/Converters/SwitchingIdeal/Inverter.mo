within OpenBLDC.Converters.SwitchingIdeal;
model Inverter "Universal m-phase inverter"
  extends OpenBLDC.Interfaces.PartialInverter;
  import Modelica.Units.SI;
  parameter Integer m(min = 1) = 3 "Number of phases";
  parameter SI.Resistance RonSwitch = 1e-005 "Ron of Switch";
  parameter SI.Conductance GoffSwitch = 1e-005 "Gon of Switch";
  parameter SI.Resistance RonDiode = 1e-005 "Ron of Diode";
  parameter SI.Conductance GoffDiode = 1e-005 "Gon of Diode";
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch swH(m = m, Ron = ronSwitch, Goff = goffSwitch) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-20,20})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch swL(m = m, Ron = ronSwitch, Goff = goffSwitch) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-20,-20})));
  Modelica.Electrical.Polyphase.Ideal.IdealDiode dH(m = m, Vknee = vknee, Ron = ronDiode, Goff = goffDiode) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 90, origin = {-40,20})));
  Modelica.Electrical.Polyphase.Ideal.IdealDiode dL(m = m, Vknee = vknee, Ron = ronDiode, Goff = goffDiode) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 90, origin = {-40,-20})));
  Modelica.Blocks.Interfaces.BooleanInput ctrl_l[m] annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {20,106})));
  Modelica.Blocks.Interfaces.BooleanInput ctrl_h[m] annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {-20,106})));
  Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(m = m)
    "Output voltage sensor"                                                                         annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-60,-10})));
  Modelica.Blocks.Interfaces.RealOutput v[m] "Output voltage at plug_p" annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-40,-100})));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor currentSensor(m = m) annotation(Placement(transformation(extent = {{40,-10},{60,10}})));
  Modelica.Blocks.Interfaces.RealOutput i[m] "Output current at plug_p" annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {40,-100})));
protected
  parameter SI.Resistance ronSwitch[:] = fill(RonSwitch, m);
  parameter SI.Conductance goffSwitch[:] = fill(GoffSwitch, m);
  parameter SI.Resistance ronDiode[:] = fill(RonDiode, m);
  parameter SI.Conductance goffDiode[:] = fill(GoffDiode, m);
  parameter SI.Voltage vknee[:] = fill(0, m);
equation
  connect(dL.plug_p,swL.plug_n) annotation(Line(points = {{-40,-30},{-20,-30}}, color = {0,0,255}, smooth = Smooth.None));
  connect(dL.plug_n,swL.plug_p) annotation(Line(points = {{-40,-10},{-20,-10}}, color = {0,0,255}, smooth = Smooth.None));
  connect(dH.plug_p,swH.plug_n) annotation(Line(points = {{-40,10},{-20,10}}, color = {0,0,255}, smooth = Smooth.None));
  connect(dH.plug_n,swH.plug_p) annotation(Line(points = {{-40,30},{-20,30}}, color = {0,0,255}, smooth = Smooth.None));
  connect(ctrl_h,swH.control) annotation(Line(points = {{-20,106},{-20,40},{0,40},{0,20},{-13,20}}, color = {255,0,255}, smooth = Smooth.None));
  connect(ctrl_l,swL.control) annotation(Line(points = {{20,106},{20,-20},{-13,-20}}, color = {255,0,255}, smooth = Smooth.None));
  connect(plugH,swH.plug_p) annotation(Line(points = {{-100,40},{-60,40},{-60,30},{-20,30}}, color = {0,0,255}, smooth = Smooth.None));
  connect(plugL,swL.plug_n) annotation(Line(points = {{-100,-40},{-60,-40},{-60,-30},{-20,-30}}, color = {0,0,255}, smooth = Smooth.None));
  connect(voltageSensor.plug_n,plugL) annotation(Line(points = {{-60,-20},{-60,-40},{-100,-40}}, color = {0,0,255}, smooth = Smooth.None));
  connect(voltageSensor.v,v) annotation(Line(points = {{-71,-10},{-76,-10},{-76,-60},{-40,-60},{-40,-100}}, color = {0,0,127}, smooth = Smooth.None));
  connect(swH.plug_n,currentSensor.plug_p) annotation(Line(points = {{-20,10},{-20,0},{40,0}}, color = {0,0,255}, smooth = Smooth.None));
  connect(swL.plug_p,currentSensor.plug_p) annotation(Line(points = {{-20,-10},{-20,0},{40,0}}, color = {0,0,255}, smooth = Smooth.None));
  connect(voltageSensor.plug_p,currentSensor.plug_p) annotation(Line(points = {{-60,0},{40,0}}, color = {0,0,255}, smooth = Smooth.None));
  connect(currentSensor.plug_n,plug_p) annotation(Line(points = {{60,0},{100,0}}, color = {0,0,255}, smooth = Smooth.None));
  connect(currentSensor.i,i) annotation(Line(points = {{50,-11},{40,-11},{40,-100}}, color = {0,0,127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics), DymolaStoredErrors, Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics={  Text(extent = {{-50,-60},{-30,-90}}, lineColor = {0,0,255}, textString = "v"),Text(extent = {{30,-60},{50,-90}}, lineColor = {0,0,255}, textString = "i"),Text(extent = {{-86,50},{-42,30}}, lineColor = {0,0,255}, fontSize = 36, textString = "plugH",
            horizontalAlignment =                                                                                                   TextAlignment.Left),Text(extent = {{-86,-28},{-42,-48}}, lineColor = {0,0,255}, fontSize = 36,
            horizontalAlignment =                                                                                                   TextAlignment.Left, textString = "plugL"),Text(extent = {{24,12},{86,-8}}, lineColor = {0,0,255}, fontSize = 36,
            horizontalAlignment =                                                                                                   TextAlignment.Right, textString = "plug_p")}));
end Inverter;
