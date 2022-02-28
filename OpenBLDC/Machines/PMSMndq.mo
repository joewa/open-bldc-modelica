within OpenBLDC.Machines;
model PMSMndq
  "Nph-PMSM stator frame model without mutual inductance but salient magnetics"
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
  parameter SI.Inductance L_mdq2 = (L_md + L_mq) / 2;
  parameter SI.Inductance L_msail = (L_mq - L_md); // / 2;
  parameter Integer ppz = 1 "Pairs of poles";
  parameter Integer m = 3 "Number of phases";
  parameter SI.Angle ang_p(displayUnit = "rad") = 2 / m * pi
    "Electrical angle between 2 phases";
    // ang_pi als Vektor mit linspace konstruieren. Dann ang_pi als parameter ersetzbar machen.
  parameter SI.MagneticFlux PhaseBEMF = 2 / 3 * 1.04
    "Back EMF constant of one single phase (peak value) [VS/rad]";
  SI.MagneticFlux psi_m = PhaseBEMF / ppz;
  output SI.Angle phiMechanical = flange.phi - support.phi;
  output SI.AngularVelocity wMechanical(displayUnit = "1/min") = der(phiMechanical);
  output SI.Angle phiElectrical = ppz * phiMechanical;
  output SI.AngularVelocity wElectrical = ppz * wMechanical;
  Rotational.Components.Inertia inertia_rotor(J = Jr);
  Rotational.Components.Inertia inertia_housing(J = Js);
  Rotational.Sources.Torque2 torque2;
  SI.Torque tau_el;
  SI.MagneticFlux flux[m];
  SI.Torque tau[m];

  Rotational.Interfaces.Flange_a flange annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Rotational.Interfaces.Support support annotation(Placement(transformation(extent = {{90,-90},{110,-70}})));

  Modelica.Electrical.Polyphase.Basic.VariableInductor selfInductor(m=m)
    annotation (Placement(transformation(extent={{-56,30},{-36,50}})));
  Modelica.Electrical.Polyphase.Basic.Resistor resistor(                      m=m, R=fill(
        R_p, m))
    annotation (Placement(transformation(extent={{-32,30},{-12,50}})));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage u(m=m) "back EMF"
    annotation (Placement(transformation(extent={{-8,30},{12,50}})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_sp(m=m)
    "Positive stator plug"
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_sn(m=m)
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
  connect(u.plug_n, plug_sn) annotation (Line(
      points={{12,40},{12,72},{-60,72},{-60,100}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(selfInductor.plug_p, plug_sp) annotation (Line(
      points={{-56,40},{-56,60},{60,60},{60,100}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics));
end PMSMndq;
