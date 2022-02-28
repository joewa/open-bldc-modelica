within OpenBLDC.Machines;
model SM_PermanentMagnet_WRP
  "Wrapper for the 3ph-PMSM stator frame model from the MSL"
  extends Modelica.Electrical.Machines.Icons.TransientMachine;
  import Modelica.Constants.pi;
  import Modelica.Electrical.Analog;
  import Modelica.Mechanics.Rotational;
  import Modelica.Units.SI;
  constant Integer m = 3 "Number of phases";
  parameter SI.Frequency fsNominal "Nominal frequency";
  parameter SI.Voltage VsOpenCircuit
    "Open circuit RMS voltage per phase @ fsNominal";
  parameter SI.Inertia Jr = 0.0027 "Inertia of the rotor";
  parameter SI.Inertia Js = 1 "Inertia of the stator";
  parameter SI.Resistance R_p = 0.54 "Per phase resistance";
  parameter SI.Inductance L_md = 0.00145
    "Stator main field inductance in d-axis";
  parameter SI.Inductance L_mq = 0.00145
    "Stator main field inductance in d-axis";
  parameter Real m_k(min=0, max=0.999) = 0.5 "Mutual coupling coefficient";
  parameter Integer ppz = 1 "Pairs of poles";
  parameter SI.Angle ang_p(displayUnit = "rad") = 2 / 3 * pi
    "Electrical angle between 2 phases";
  parameter SI.MagneticFlux PhaseBEMF = 2 / 3 * 1.04
    "Back EMF constant of one single phase (peak value) [VS/rad]";
  SI.MagneticFlux psi_m = PhaseBEMF / ppz;
  SI.Angle phiMechanical = flange.phi - support.phi;
  SI.AngularVelocity wMechanical(displayUnit = "1/min") = der(phiMechanical);
  SI.Angle phiElectrical = ppz * phiMechanical;
  SI.AngularVelocity wElectrical = ppz * wMechanical;

  Analog.Interfaces.Pin a1 annotation(extent = [-110,86;-90,106]);
  Analog.Interfaces.Pin b1 annotation(extent = [-110,6;-90,26]);
  Analog.Interfaces.Pin c1 annotation(extent = [-110,-74;-90,-54]);

  Analog.Interfaces.Pin a2 annotation(extent = [-110,54;-90,74]);
  Analog.Interfaces.Pin b2 annotation(extent = [-110,-26;-90,-6]);
  Analog.Interfaces.Pin c2 annotation(extent = [-110,-106;-90,-86]);
  Rotational.Interfaces.Flange_a flange annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Rotational.Interfaces.Support support annotation(Placement(transformation(extent = {{90,-90},{110,-70}})));
  Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet
    smpm(
    p=ppz,
    fsNominal=fsNominal,
    Rs=R_p,
    alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    Jr=Jr,
    useSupport=true,
    Js=Js,
    useThermalPort=false,
    VsOpenCircuit=VsOpenCircuit,
    Lmd=L_md,
    Lmq=L_mq,
    useDamperCage=false,
    Lszero=sqrt(L_md*L_mq)*(1 - m_k),
    Lssigma=0.001/(2*pi*fsNominal))
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));

  Rotational.Components.Disc disc(deltaPhi=90/ppz*(2*pi/360)) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-50})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_a1(m=m, k=1)
    annotation (Placement(transformation(extent={{-20,80},{-40,100}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_a2(m=m, k=1)
    annotation (Placement(transformation(extent={{-20,60},{-40,80}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_b1(m=m, k=3)
    annotation (Placement(transformation(extent={{-20,0},{-40,20}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_b2(m=m, k=3)
    annotation (Placement(transformation(extent={{-20,-20},{-40,0}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_c1(m=m, k=2)
    annotation (Placement(transformation(extent={{-20,-80},{-40,-60}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_c2(m=m, k=2)
    annotation (Placement(transformation(extent={{-20,-100},{-40,-80}})));

equation
  connect(smpm.support, support) annotation (Line(
      points={{40,-80},{100,-80}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(smpm.flange, disc.flange_a) annotation (Line(
      points={{40,-70},{70,-70},{70,-60}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(disc.flange_b, flange) annotation (Line(
      points={{70,-40},{70,0},{100,0}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(a1, plugToPin_a1.pin_p) annotation (Line(
      points={{-100,96},{-66,96},{-66,90},{-32,90}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(a2, plugToPin_a2.pin_p) annotation (Line(
      points={{-100,64},{-66,64},{-66,70},{-32,70}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(b1, plugToPin_b1.pin_p) annotation (Line(
      points={{-100,16},{-66,16},{-66,10},{-32,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(b2, plugToPin_b2.pin_p) annotation (Line(
      points={{-100,-16},{-66,-16},{-66,-10},{-32,-10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(c1, plugToPin_c1.pin_p) annotation (Line(
      points={{-100,-64},{-66,-64},{-66,-70},{-32,-70}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(c2, plugToPin_c2.pin_p) annotation (Line(
      points={{-100,-96},{-66,-96},{-66,-90},{-32,-90}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_a1.plug_p, smpm.plug_sn) annotation (Line(
      points={{-28,90},{24,90},{24,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_b1.plug_p, smpm.plug_sn) annotation (Line(
      points={{-28,10},{24,10},{24,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_c1.plug_p, smpm.plug_sn) annotation (Line(
      points={{-28,-70},{-12,-70},{-12,-34},{24,-34},{24,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_c2.plug_p, smpm.plug_sp) annotation (Line(
      points={{-28,-90},{0,-90},{0,-48},{36,-48},{36,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_b2.plug_p, smpm.plug_sp) annotation (Line(
      points={{-28,-10},{36,-10},{36,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_a2.plug_p, smpm.plug_sp) annotation (Line(
      points={{-28,70},{36,70},{36,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics),
      Documentation(info="<html>
<p>TODO: Implement appropriate usage of Lszero...</p>
</html>"));
end SM_PermanentMagnet_WRP;
