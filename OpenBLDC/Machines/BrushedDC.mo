within OpenBLDC.Machines;

model BrushedDC "Simple DC-Machine model"
extends Modelica.Electrical.Machines.Icons.TransientMachine;
  import Modelica.Electrical.Analog;
  import Modelica.Mechanics.Rotational;
  import Modelica.Units.SI;
  parameter SI.Inertia Jr=27e-3 "Inertia of the rotor";
  parameter SI.Inertia Js=1 "Inertia of the stator";
  parameter SI.Resistance R_p=0.54 "Per phase resistance";
  parameter SI.Inductance L_p=1.45e-3 "Per phase inductance";
  parameter SI.MagneticFlux Bemf=1.04 "Back EMF constant [VS/rad]";

  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
  annotation (Diagram);
  Rotational.Interfaces.Flange_a flange annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Rotational.Interfaces.Support support annotation(Placement(transformation(extent = {{90,-90},{110,-70}})));
  output SI.Angle phiMechanical = flange.phi-support.phi;
  output SI.AngularVelocity wMechanical(displayUnit="1/min") = der(phiMechanical);
  Rotational.Components.Inertia inertia_rotor(J=Jr);
  Rotational.Components.Inertia inertia_housing(J=Js);
  Rotational.Sources.Torque2 torque2;
  Analog.Basic.Resistor r_a(R=R_p);
  Analog.Basic.Inductor l_a(L=L_p);
  Analog.Sources.SignalVoltage emf;
equation
  //Electrical network
  connect(pin_n, r_a.p);
  connect(r_a.n, l_a.p);
  connect(l_a.n, emf.p);
  connect(emf.n, pin_p);
  //Electrical <=> mechanical
  emf.v = -wMechanical * Bemf;
  torque2.tau = Bemf * pin_n.i;
  //Mechanical stuff
  connect(flange, inertia_rotor.flange_a);
  connect(inertia_rotor.flange_b, torque2.flange_a);
  connect(torque2.flange_b, inertia_housing.flange_a);
  connect(inertia_housing.flange_b, support);
end BrushedDC;