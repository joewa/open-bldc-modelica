within OpenBLDC.Machines;
model PMSMndq
  "Nph-PMSM stator frame model without mutual inductance but salient magnetics"
  extends Modelica.Icons.MotorIcon;
  import Modelica.Constants.pi;
  import Modelica.Electrical.Analog;
  import Modelica.Mechanics.Rotational;
  import Modelica.SIunits;
  parameter SIunits.Inertia Jr = 0.0027 "Inertia of the rotor";
  parameter SIunits.Inertia Js = 1 "Inertia of the stator";
  parameter SIunits.Resistance R_p = 0.54 "Per phase resistance";
  parameter SIunits.Inductance L_md = 0.00145
    "Stator main field inductance in d-axis";
  parameter SIunits.Inductance L_mq = 0.00145
    "Stator main field inductance in q-axis";
  parameter SIunits.Inductance L_mdq2 = (L_md + L_mq) / 2;
  parameter SIunits.Inductance L_msail = (L_mq - L_md); // / 2;
  parameter Integer ppz = 1 "Pairs of poles";
  parameter Integer m = 3 "Number of phases";
  parameter SIunits.Angle ang_p(displayUnit = "rad") = 2 / m * pi
    "Electrical angle between 2 phases";
  parameter SIunits.MagneticFlux PhaseBEMF = 2 / 3 * 1.04
    "Back EMF constant of one single phase (peak value) [VS/rad]";
  SIunits.MagneticFlux psi_m = PhaseBEMF / ppz;
  output SIunits.Angle phiMechanical = flange.phi - support.phi;
  output SIunits.AngularVelocity wMechanical(displayUnit = "1/min") = der(phiMechanical);
  output SIunits.Angle phiElectrical = ppz * phiMechanical;
  output SIunits.AngularVelocity wElectrical = ppz * wMechanical;
  Rotational.Components.Inertia inertia_rotor(J = Jr);
  Rotational.Components.Inertia inertia_housing(J = Js);
  Rotational.Sources.Torque2 torque2;
  Modelica.SIunits.Torque tau_el;
  SIunits.MagneticFlux flux[m];
  SIunits.Torque tau[m];

  Rotational.Interfaces.Flange_a flange annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Rotational.Interfaces.Support support annotation(Placement(transformation(extent = {{90,-90},{110,-70}})));

  Modelica.Electrical.MultiPhase.Basic.VariableInductor selfInductor(m=m)
    annotation (Placement(transformation(extent={{-56,30},{-36,50}})));
  Modelica.Electrical.MultiPhase.Basic.Resistor resistor(     R={R_p,R_p,R_p}, m=m)
    annotation (Placement(transformation(extent={{-32,30},{-12,50}})));
  Modelica.Electrical.MultiPhase.Sources.SignalVoltage u(m=m) "back EMF"
    annotation (Placement(transformation(extent={{-8,30},{12,50}})));
  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_sp(m=m)
    "Positive stator plug"
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plug_sn(m=m)
    "Negative stator plug"
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
equation
  for i in 1:m loop
    flux[i] = psi_m * cos(phiElectrical + (i-1) * ang_p);
    u.v[i] = wElectrical * flux[i];
    selfInductor.L[i] = L_mdq2 + L_msail * cos(-2*phiElectrical + (i-1) * ang_p);
    tau[i] = ppz * flux[i] * u.plug_n.pin[i].i;
  end for;
  tau_el = sum(tau);
  tau_el = torque2.tau;
  connect(flange,inertia_rotor.flange_a);
  connect(inertia_rotor.flange_b,torque2.flange_a);
  connect(torque2.flange_b,inertia_housing.flange_a);
  connect(inertia_housing.flange_b,support);
  connect(u.plug_p, resistor.plug_n) annotation (Line(
      points={{-8,40},{-12,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(resistor.plug_p, selfInductor.plug_n) annotation (Line(
      points={{-32,40},{-36,40}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(selfInductor.plug_p, plug_sp) annotation (Line(
      points={{-56,40},{-56,68},{60,68},{60,100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(u.plug_n, plug_sn) annotation (Line(
      points={{12,40},{12,76},{-60,76},{-60,100}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics));
end PMSMndq;
