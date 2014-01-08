within OpenBLDC.Converters.SwitchingIdeal;
model Inverter3ph "3-phase inverter (wrapper)"
  extends OpenBLDC.Icons.Converter;
  constant Integer m = 3 "Number of phases";

  parameter Modelica.SIunits.Resistance RonSwitch=1e-5 "Ron of Switch";
  parameter Modelica.SIunits.Conductance GoffSwitch=1e-5 "Gon of Switch";
  parameter Modelica.SIunits.Resistance RonDiode=1e-5 "Ron of Diode";
  parameter Modelica.SIunits.Conductance GoffDiode=1e-5 "Gon of Diode";
protected
  parameter Modelica.SIunits.Resistance ronSwitch[:]=fill(RonSwitch,m);
  parameter Modelica.SIunits.Conductance goffSwitch[:]=fill(GoffSwitch,m);
  parameter Modelica.SIunits.Resistance ronDiode[:]=fill(RonDiode,m);
  parameter Modelica.SIunits.Conductance goffDiode[:]=fill(GoffDiode,m);
  parameter Modelica.SIunits.Voltage vknee[:]=fill(0,m);
public
  Modelica.Blocks.Interfaces.BooleanInput ctrl_l[m]
                                                 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={20,106})));
  Modelica.Blocks.Interfaces.BooleanInput ctrl_h[m]
                                                 annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-20,106})));

  Modelica.Electrical.Analog.Interfaces.Pin p_a
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Electrical.Analog.Interfaces.Pin p_b
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.Pin p_c
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p_p "Positive supply pin"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin p_n "Negative supply pin"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Inverter inverter(m=m)
    annotation (Placement(transformation(extent={{-22,-10},{0,10}})));
  Modelica.Electrical.MultiPhase.Basic.Star star_p(m=m)
    annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
  Modelica.Electrical.MultiPhase.Basic.Star star_n(m=m)
    annotation (Placement(transformation(extent={{-60,-50},{-80,-30}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_a(m=m, k=1)
    annotation (Placement(transformation(extent={{40,30},{60,50}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_b(m=m, k=2)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_c(m=m, k=3)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
equation
  connect(ctrl_l, inverter.ctrl_l) annotation (Line(
      points={{20,106},{20,80},{-8.8,80},{-8.8,10.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ctrl_h, inverter.ctrl_h) annotation (Line(
      points={{-20,106},{-20,80},{-13.2,80},{-13.2,10.6}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(p_p, star_p.pin_n) annotation (Line(
      points={{-100,40},{-80,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(p_n, star_n.pin_n) annotation (Line(
      points={{-100,-40},{-80,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(star_p.plug_p, inverter.plugH) annotation (Line(
      points={{-60,40},{-42,40},{-42,4},{-22,4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(star_n.plug_p, inverter.plugL) annotation (Line(
      points={{-60,-40},{-42,-40},{-42,-4},{-22,-4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter.plug_p, plugToPin_a.plug_p) annotation (Line(
      points={{0,0},{24,0},{24,40},{48,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter.plug_p, plugToPin_b.plug_p) annotation (Line(
      points={{0,0},{48,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter.plug_p, plugToPin_c.plug_p) annotation (Line(
      points={{0,0},{24,0},{24,-40},{48,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_a.pin_p, p_a) annotation (Line(
      points={{52,40},{100,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_b.pin_p, p_b) annotation (Line(
      points={{52,0},{100,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_c.pin_p, p_c) annotation (Line(
      points={{52,-40},{100,-40}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},
            {100,100}}),       graphics), DymolaStoredErrors,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end Inverter3ph;
