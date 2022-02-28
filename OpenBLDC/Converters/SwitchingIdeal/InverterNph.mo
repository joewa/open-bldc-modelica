within OpenBLDC.Converters.SwitchingIdeal;
model InverterNph "m-phase inverter (wrapper)"
  extends OpenBLDC.Icons.Converter;
  import Modelica.Units.SI;
  parameter Integer m = 3 "Number of phases";
  parameter SI.Resistance RonSwitch = 1e-005 "Ron of Switch";
  parameter SI.Conductance GoffSwitch = 1e-005 "Gon of Switch";
  parameter SI.Resistance RonDiode = 1e-005 "Ron of Diode";
  parameter SI.Conductance GoffDiode = 1e-005 "Gon of Diode";
  Modelica.Blocks.Interfaces.BooleanInput ctrl_l[m] annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {20,106})));
  Modelica.Blocks.Interfaces.BooleanInput ctrl_h[m] annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {-20,106})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p_p "Positive supply pin" annotation(Placement(transformation(extent = {{-110,30},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin p_n "Negative supply pin" annotation(Placement(transformation(extent = {{-110,-50},{-90,-30}})));
  Inverter inverter(m = m) annotation(Placement(transformation(extent = {{-22,-10},{0,10}})));
  Modelica.Electrical.Polyphase.Basic.Star star_p(m = m) annotation(Placement(transformation(extent = {{-60,30},{-80,50}})));
  Modelica.Electrical.Polyphase.Basic.Star star_n(m = m) annotation(Placement(transformation(extent = {{-62,-50},{-82,-30}})));
  Modelica.Blocks.Interfaces.RealOutput v_dc "dc link voltage" annotation(Placement(transformation(extent = {{-90,-90},{-110,-70}})));
  Modelica.Blocks.Interfaces.RealOutput v[m] "output voltage" annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 90, origin = {0,-100})));
  Modelica.Blocks.Interfaces.RealOutput i[m] "output current" annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 90, origin = {40,-100})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor annotation(Placement(transformation(extent = {{-10,10},{10,-10}}, rotation = 270, origin = {-88,-16})));
  Modelica.Electrical.Polyphase.Basic.Resistor r_sense_L(m=m, R=fill(3600.0, m))
    "Impedance of voltage divider for phase voltage measurement" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-32,-40})));
protected
  parameter SI.Resistance ronSwitch[:] = fill(RonSwitch, m);
  parameter SI.Conductance goffSwitch[:] = fill(GoffSwitch, m);
  parameter SI.Resistance ronDiode[:] = fill(RonDiode, m);
  parameter SI.Conductance goffDiode[:] = fill(GoffDiode, m);
  parameter SI.Voltage vknee[:] = fill(0, m);
public
  Modelica.Electrical.Polyphase.Basic.Resistor r_sense_H(m=m, R=fill(10000.0,
        m)) "Impedance of voltage divider for phase voltage measurement"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={6,-24})));
  Modelica.Electrical.Polyphase.Basic.Capacitor c_sense(m=m, C=fill(0.5e-9, m))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-32,-20})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_m(m=m)
    "m-phase motor plug"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(ctrl_l,inverter.ctrl_l) annotation(Line(points = {{20,106},{20,80},{-8.800000000000001,80},{-8.800000000000001,10.6}}, color = {255,0,255}, smooth = Smooth.None));
  connect(ctrl_h,inverter.ctrl_h) annotation(Line(points = {{-20,106},{-20,80},{-13.2,80},{-13.2,10.6}}, color = {255,0,255}, smooth = Smooth.None));
  connect(p_p,star_p.pin_n) annotation(Line(points = {{-100,40},{-80,40}}, color = {0,0,255}, smooth = Smooth.None));
  connect(p_n,star_n.pin_n) annotation(Line(points = {{-100,-40},{-82,-40}}, color = {0,0,255}, smooth = Smooth.None));
  connect(star_p.plug_p,inverter.plugH) annotation(Line(points = {{-60,40},{-42,40},{-42,4},{-22,4}}, color = {0,0,255}, smooth = Smooth.None));
  connect(star_n.plug_p,inverter.plugL) annotation(Line(points = {{-62,-40},{-46,-40},{-46,-4},{-22,-4}}, color = {0,0,255}, smooth = Smooth.None));
  connect(voltageSensor.n,p_n) annotation(Line(points = {{-88,-26},{-88,-40},{-100,-40}}, color = {0,0,255}, smooth = Smooth.None));
  connect(voltageSensor.p,p_p) annotation(Line(points = {{-88,-6},{-88,40},{-100,40}}, color = {0,0,255}, smooth = Smooth.None));
  connect(voltageSensor.v,v_dc) annotation(Line(points = {{-78,-16},{-54,-16},{-54,-80},{-100,-80}}, color = {0,0,127}, smooth = Smooth.None));
  connect(inverter.v,v) annotation(Line(points = {{-15.4,-10},{-16,-10},{-16,-70},{0,-70},{0,-100}}, color = {0,0,127}, smooth = Smooth.None));
  connect(inverter.i,i) annotation(Line(points = {{-6.6,-10},{-6,-10},{-6,-60},{40,-60},{40,-100}}, color = {0,0,127}, smooth = Smooth.None));
  connect(r_sense_L.plug_n, star_n.plug_p) annotation (Line(
      points={{-42,-40},{-62,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(r_sense_H.plug_p, inverter.plug_p) annotation (Line(
      points={{6,-14},{6,0},{0,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(r_sense_L.plug_p, r_sense_H.plug_n) annotation (Line(
      points={{-22,-40},{6,-40},{6,-34}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(c_sense.plug_n, r_sense_L.plug_n) annotation (Line(
      points={{-42,-20},{-42,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(c_sense.plug_p, r_sense_L.plug_p) annotation (Line(
      points={{-22,-20},{-22,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter.plug_p, plug_m) annotation (Line(
      points={{0,0},{100,0}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics), DymolaStoredErrors, Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end InverterNph;
