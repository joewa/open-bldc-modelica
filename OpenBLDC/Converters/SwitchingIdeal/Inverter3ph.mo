within OpenBLDC.Converters.SwitchingIdeal;
model Inverter3ph "3-phase inverter (wrapper)"
  extends OpenBLDC.Icons.Converter;
  import Modelica.Units.SI;
  constant Integer m = 3 "Number of phases";
  parameter SI.Resistance RonSwitch = 1e-005 "Ron of Switch";
  parameter SI.Conductance GoffSwitch = 1e-005 "Gon of Switch";
  parameter SI.Resistance RonDiode = 1e-005 "Ron of Diode";
  parameter SI.Conductance GoffDiode = 1e-005 "Gon of Diode";
  Modelica.Blocks.Interfaces.BooleanInput ctrl_l[m] annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {20,106})));
  replaceable Modelica.Blocks.Interfaces.BooleanInput ctrl_h[m] annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {-20,106})));
  Modelica.Electrical.Analog.Interfaces.Pin p_a annotation(Placement(transformation(extent = {{90,30},{110,50}})));
  Modelica.Electrical.Analog.Interfaces.Pin p_b annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.Pin p_c annotation(Placement(transformation(extent = {{90,-50},{110,-30}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p_p "Positive supply pin" annotation(Placement(transformation(extent = {{-110,30},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin p_n "Negative supply pin" annotation(Placement(transformation(extent = {{-110,-50},{-90,-30}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_a(m = m, k = 1) annotation(Placement(transformation(extent = {{40,30},{60,50}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_b(m = m, k = 2) annotation(Placement(transformation(extent = {{40,-10},{60,10}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_c(m = m, k = 3) annotation(Placement(transformation(extent = {{40,-50},{60,-30}})));
  Modelica.Blocks.Interfaces.RealOutput v_dc "dc link voltage" annotation(Placement(transformation(extent = {{-90,-90},{-110,-70}})));
  Modelica.Blocks.Interfaces.RealOutput v[m] "output voltage" annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 90, origin = {0,-100})));
  Modelica.Blocks.Interfaces.RealOutput i[m] "output current" annotation(Placement(transformation(extent = {{10,-10},{-10,10}}, rotation = 90, origin = {40,-100})));
  replaceable InverterNph inverterNph(GoffDiode = GoffDiode,GoffSwitch = GoffSwitch, RonDiode = RonDiode, RonSwitch = RonSwitch, m = 3)  annotation(
    Placement(visible = true, transformation(origin = {-8.88178e-16, 8.88178e-16}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
protected
  parameter SI.Voltage vknee[:] = fill(0, m);
equation
  connect(plugToPin_a.pin_p, p_a) annotation(
    Line(points = {{52, 40}, {100, 40}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(plugToPin_b.pin_p, p_b) annotation(
    Line(points = {{52, 0}, {100, 0}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(plugToPin_c.pin_p, p_c) annotation(
    Line(points = {{52, -40}, {100, -40}}, color = {0, 0, 255}, smooth = Smooth.None));
  connect(p_p, inverterNph.p_p) annotation(
    Line(points = {{-100, 40}, {-70, 40}, {-70, 6}, {-15, 6}}, color = {0, 0, 255}));
  connect(p_n, inverterNph.p_n) annotation(
    Line(points = {{-100, -40}, {-69, -40}, {-69, -6}, {-15, -6}}, color = {0, 0, 255}));
  connect(inverterNph.plug_m, plugToPin_a.plug_p) annotation(
    Line(points = {{15, 0}, {30, 0}, {30, 40}, {48, 40}}, color = {0, 0, 255}));
  connect(inverterNph.plug_m, plugToPin_b.plug_p) annotation(
    Line(points = {{15, 0}, {48, 0}}, color = {0, 0, 255}));
  connect(inverterNph.plug_m, plugToPin_c.plug_p) annotation(
    Line(points = {{15, 0}, {30, 0}, {30, -40}, {48, -40}}, color = {0, 0, 255}));
  connect(inverterNph.v, v) annotation(
    Line(points = {{0, -15}, {0, -100}}, color = {0, 0, 127}, thickness = 0.5));
  connect(inverterNph.i, i) annotation(
    Line(points = {{6, -15}, {6, -71}, {40, -71}, {40, -100}}, color = {0, 0, 127}, thickness = 0.5));
  connect(inverterNph.v_dc, v_dc) annotation(
    Line(points = {{-15, -12}, {-30, -12}, {-30, -80}, {-100, -80}}, color = {0, 0, 127}));
  connect(ctrl_h, inverterNph.ctrl_h) annotation(
    Line(points = {{-20, 106}, {-20, 30}, {-4, 30}, {-4, 16}, {-3, 16}}, color = {255, 0, 255}, thickness = 0.5));
  connect(ctrl_l, inverterNph.ctrl_l) annotation(
    Line(points = {{20, 106}, {20, 30}, {3, 30}, {3, 16}}, color = {255, 0, 255}, thickness = 0.5));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics), DymolaStoredErrors, Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end Inverter3ph;