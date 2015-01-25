within OpenBLDC.Machines;
model PMSMm "3ph-PMSM stator frame model with mutual inductance"
  extends Modelica.Icons.MotorIcon;
  import Modelica.Constants.pi;
  import Modelica.Electrical.Analog;
  import Modelica.Mechanics.Rotational;
  import Modelica.SIunits;
  parameter SIunits.Inertia Jr = 0.0027 "Inertia of the rotor";
  parameter SIunits.Inertia Js = 1 "Inertia of the stator";
  parameter SIunits.Resistance R_p = 0.54 "Per phase resistance";
  parameter SIunits.Inductance L_p = 0.00145 "Per phase inductance";
  parameter Real m_k(min=0, max=0.999) = 0 "Mutual coupling coefficient";
  parameter Integer ppz = 1 "Pairs of poles";
  parameter SIunits.Angle ang_p(displayUnit = "rad") = 2 / 3 * pi
    "Electrical angle between 2 phases";
  parameter SIunits.MagneticFlux PhaseBEMF = 2 / 3 * 1.04
    "Back EMF constant of one single phase (peak value) [VS/rad]";
  constant Integer m = 3 "Number of phases";
  parameter SIunits.Inductance L_3 = L_p * (1 - m_k / 3) "Override L_v3";
  parameter SIunits.Inductance L_M = m_k / 3 * L_p "Override L_M";
  SIunits.MagneticFlux psi_m = PhaseBEMF / ppz;
  output SIunits.Angle phiMechanical = flange.phi - support.phi;
  output SIunits.AngularVelocity wMechanical(displayUnit = "1/min") = der(phiMechanical);
  output SIunits.Angle phiElectrical = ppz * phiMechanical;
  output SIunits.AngularVelocity wElectrical = ppz * wMechanical;
  Rotational.Components.Inertia inertia_rotor(J = Jr);
  Rotational.Components.Inertia inertia_housing(J = Js);
  Rotational.Sources.Torque2 torque2;
  Modelica.SIunits.Torque tau_el;
  SIunits.MagneticFlux flux_a;
  SIunits.MagneticFlux flux_b;
  SIunits.MagneticFlux flux_c;
  SIunits.Torque tau_a;
  SIunits.Torque tau_b;
  SIunits.Torque tau_c;
  Analog.Interfaces.Pin a1 annotation(extent = [-110,86;-90,106]);
  Analog.Interfaces.Pin b1 annotation(extent = [-110,6;-90,26]);
  Analog.Interfaces.Pin c1 annotation(extent = [-110,-74;-90,-54]);

  Analog.Interfaces.Pin a2 annotation(extent = [-110,54;-90,74]);
  Analog.Interfaces.Pin b2 annotation(extent = [-110,-26;-90,-6]);
  Analog.Interfaces.Pin c2 annotation(extent = [-110,-106;-90,-86]);
  Rotational.Interfaces.Flange_a flange annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Rotational.Interfaces.Support support annotation(Placement(transformation(extent = {{90,-90},{110,-70}})));

  Modelica.Electrical.MultiPhase.Basic.MutualInductor mutualInductor(L=[L_3,-
        L_M,-L_M; -L_M,L_3,-L_M; -L_M,-L_M,L_3])
    annotation (Placement(transformation(extent={{-56,30},{-36,50}})));
  Modelica.Electrical.MultiPhase.Basic.Resistor resistor(m=3, R={R_p,R_p,R_p})
    annotation (Placement(transformation(extent={{-32,30},{-12,50}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_a1(m=m, k=1)
    annotation (Placement(transformation(extent={{-66,80},{-86,100}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_a2(m=m, k=1)
    annotation (Placement(transformation(extent={{-66,60},{-86,80}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_b1(m=m, k=2)
    annotation (Placement(transformation(extent={{-66,0},{-86,20}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_b2(m=m, k=2)
    annotation (Placement(transformation(extent={{-66,-20},{-86,0}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_c1(m=m, k=3)
    annotation (Placement(transformation(extent={{-66,-80},{-86,-60}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_c2(m=m, k=3)
    annotation (Placement(transformation(extent={{-66,-100},{-86,-80}})));
  Modelica.Electrical.MultiPhase.Sources.SignalVoltage u
    annotation (Placement(transformation(extent={{-8,30},{12,50}})));
equation
  flux_a = psi_m * cos(phiElectrical + 0 * ang_p);
  flux_b = psi_m * cos(phiElectrical + 1 * ang_p);
  flux_c = psi_m * cos(phiElectrical + 2 * ang_p);
  u.v[1] = wElectrical * flux_a;
  u.v[2] = wElectrical * flux_b;
  u.v[3] = wElectrical * flux_c;
  tau_a = ppz * flux_a * a2.i;
  tau_b = ppz * flux_b * b2.i;
  tau_c = ppz * flux_c * c2.i;
  tau_el = -(tau_a + tau_b + tau_c);
  tau_el = torque2.tau;
  connect(flange,inertia_rotor.flange_a);
  connect(inertia_rotor.flange_b,torque2.flange_a);
  connect(torque2.flange_b,inertia_housing.flange_a);
  connect(inertia_housing.flange_b,support);
  connect(u.plug_n, plugToPin_a1.plug_p) annotation (Line(
      points={{12,40},{12,90},{-74,90}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(u.plug_n, plugToPin_b1.plug_p) annotation (Line(
      points={{12,40},{12,10},{-74,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(u.plug_n, plugToPin_c1.plug_p) annotation (Line(
      points={{12,40},{12,-70},{-74,-70}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(u.plug_p, resistor.plug_n) annotation (Line(
      points={{-8,40},{-12,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.plug_p, mutualInductor.plug_n) annotation (Line(
      points={{-32,40},{-36,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mutualInductor.plug_p, plugToPin_a2.plug_p) annotation (Line(
      points={{-56,40},{-60,40},{-60,70},{-74,70}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mutualInductor.plug_p, plugToPin_b2.plug_p) annotation (Line(
      points={{-56,40},{-60,40},{-60,-10},{-74,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(mutualInductor.plug_p, plugToPin_c2.plug_p) annotation (Line(
      points={{-56,40},{-60,40},{-60,-90},{-74,-90}},
      color={0,0,255},
      smooth=Smooth.None));
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
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics));
end PMSMm;
