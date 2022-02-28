within OpenBLDC.Machines;
model PMSMdq_3ph
  "3ph-PMSM stator frame model without mutual inductance but salient magnetics"
  extends Modelica.Electrical.Machines.Icons.TransientMachine;
  import Modelica.Constants.pi;
  import Modelica.Electrical.Analog;
  import Modelica.Mechanics.Rotational;
  import Modelica.Units.SI;
  parameter SI.Inertia Jr = 0.0027 "Inertia of the rotor";
  parameter SI.Inertia Js = 1 "Inertia of the stator";
  parameter SI.Resistance R_p = 0.54 "Per phase resistance";
  parameter SI.Inductance L_md = 0.00145
    "Stator main field inductance in d-axis";
  parameter SI.Inductance L_mq = 0.00145
    "Stator main field inductance in q-axis";
  parameter Integer ppz = 1 "Pairs of poles";
  parameter Integer m = 3 "Number of phases";
  parameter SI.Angle ang_p(displayUnit = "rad") = 2 / m * pi
    "Electrical angle between 2 phases";
  parameter SI.MagneticFlux PhaseBEMF = 2 / 3 * 1.04
    "Back EMF constant of one single phase (peak value) [VS/rad]";
  Analog.Interfaces.Pin a1 annotation(extent = [-110,86;-90,106]);
  Analog.Interfaces.Pin b1 annotation(extent = [-110,6;-90,26]);
  Analog.Interfaces.Pin c1 annotation(extent = [-110,-74;-90,-54]);

  Analog.Interfaces.Pin a2 annotation(extent = [-110,54;-90,74]);
  Analog.Interfaces.Pin b2 annotation(extent = [-110,-26;-90,-6]);
  Analog.Interfaces.Pin c2 annotation(extent = [-110,-106;-90,-86]);
  Rotational.Interfaces.Flange_a flange annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Rotational.Interfaces.Support support annotation(Placement(transformation(extent = {{90,-90},{110,-70}})));

  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_a1(m=m, k=1)
    annotation (Placement(transformation(extent={{-66,80},{-86,100}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_a2(m=m, k=1)
    annotation (Placement(transformation(extent={{-66,60},{-86,80}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_b1(m=m, k=2)
    annotation (Placement(transformation(extent={{-66,0},{-86,20}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_b2(m=m, k=2)
    annotation (Placement(transformation(extent={{-66,-20},{-86,0}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_c1(m=m, k=3)
    annotation (Placement(transformation(extent={{-66,-80},{-86,-60}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_c2(m=m, k=3)
    annotation (Placement(transformation(extent={{-66,-100},{-86,-80}})));
  PMSMndq pMSMndq(
    Jr=Jr,
    Js=Js,
    R_p=R_p,
    L_md=L_md,
    L_mq=L_mq,
    ppz=ppz,
    m=3,
    PhaseBEMF=PhaseBEMF)
    annotation (Placement(transformation(extent={{22,-82},{42,-62}})));
equation
  connect(a1, plugToPin_a1.pin_p) annotation (Line(
      points={{-100,96},{-90,96},{-90,90},{-78,90}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(a2, plugToPin_a2.pin_p) annotation (Line(
      points={{-100,64},{-90,64},{-90,70},{-78,70}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(b1, plugToPin_b1.pin_p) annotation (Line(
      points={{-100,16},{-90,16},{-90,10},{-78,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(b2, plugToPin_b2.pin_p) annotation (Line(
      points={{-100,-16},{-90,-16},{-90,-10},{-78,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(c1, plugToPin_c1.pin_p) annotation (Line(
      points={{-100,-64},{-90,-64},{-90,-70},{-78,-70}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(c2, plugToPin_c2.pin_p) annotation (Line(
      points={{-100,-96},{-90,-96},{-90,-90},{-78,-90}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSMndq.flange, flange) annotation (Line(
      points={{42,-72},{72,-72},{72,0},{100,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(pMSMndq.support, support) annotation (Line(
      points={{42,-80},{100,-80}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(pMSMndq.plug_sp, plugToPin_a2.plug_p) annotation (Line(
      points={{38,-62},{38,70},{-74,70}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSMndq.plug_sp, plugToPin_b2.plug_p) annotation (Line(
      points={{38,-62},{38,-10},{-74,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSMndq.plug_sp, plugToPin_c2.plug_p) annotation (Line(
      points={{38,-62},{38,-46},{-36,-46},{-36,-90},{-74,-90}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSMndq.plug_sn, plugToPin_a1.plug_p) annotation (Line(
      points={{26,-62},{26,90},{-74,90}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSMndq.plug_sn, plugToPin_b1.plug_p) annotation (Line(
      points={{26,-62},{26,10},{-74,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSMndq.plug_sn, plugToPin_c1.plug_p) annotation (Line(
      points={{26,-62},{26,-32},{-56,-32},{-56,-70},{-74,-70}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics));
end PMSMdq_3ph;
