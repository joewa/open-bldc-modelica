within OpenBLDC.Assemblies;
model MotorComparison
  "Compare per phase model with the model from the standard library"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m = 3 "Number of phases";
  parameter Integer ppz = 6 "Motor pairs of poles";
  parameter Modelica.SIunits.Resistance R_p = 0.33/2
    "Motor per phase resistance";
  parameter Modelica.SIunits.Inductance L_p = 3.5e-5/2
    "Motor per phase inductance";
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData annotation(Placement(transformation(extent = {{44,46},{64,66}})));
  Sensors.HallDigital123 hallDigital123 annotation(Placement(transformation(extent={{32,-32},
            {52,-12}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=8000
        *2*Modelica.Constants.pi/60)                                                       annotation(Placement(transformation(extent={{-48,-32},
            {-28,-12}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent={{0,-178},
            {20,-158}})));
  Blocks.HallDecode hallDecode annotation(Placement(transformation(extent={{74,-32},
            {94,-12}})));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(transformation(extent={{-132,
            -170},{-112,-150}})));
  Machines.PMSM pMSM_run(
    R_p=R_p,
    L_p=L_p,
    ppz=ppz,
    PhaseBEMF=0.005)                                                          annotation(Placement(transformation(extent={{-52,-80},
            {-32,-60}})));
  Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
    smpm(useSupport=true,
    p=ppz,
    Rs=R_p,
    alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
    Lmd=L_p,
    Lmq=L_p,
    useDamperCage=false,
    fsNominal=1000,
    VsOpenCircuit=5/sqrt(2))
    annotation (Placement(transformation(extent={{-80,-160},{-60,-140}})));

  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_a(m = m, k = 1) annotation(Placement(transformation(extent={{-90,
            -112},{-102,-98}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox
                                 terminalBox(terminalConnection="Y")
    annotation (Placement(transformation(extent={{-80,-136},{-60,-116}},
          rotation=0)));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_b(m=m, k=2)
    annotation (Placement(transformation(extent={{-78,-120},{-90,-106}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_c(m=m, k=3)
    annotation (Placement(transformation(extent={{-90,-130},{-102,-116}})));
  Modelica.Mechanics.Rotational.Components.Disc disc(deltaPhi=90/ppz*(2*pi/360))
    annotation (Placement(transformation(extent={{-52,-160},{-32,-140}})));
  Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio=-1)
    annotation (Placement(transformation(extent={{-24,-160},{-4,-140}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch1b(Goff=1e-3)
    annotation (Placement(transformation(extent={{-152,-78},{-140,-66}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch1c(Goff=1e-3)
    annotation (Placement(transformation(extent={{-152,-92},{-140,-80}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch1a(Goff=1e-3)
    annotation (Placement(transformation(extent={{-152,-64},{-140,-52}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch2b(Goff=1e-3)
    annotation (Placement(transformation(extent={{-152,-122},{-140,-110}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch2c(Goff=1e-3)
    annotation (Placement(transformation(extent={{-152,-136},{-140,-124}})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch2a(Goff=1e-3)
    annotation (Placement(transformation(extent={{-152,-108},{-140,-96}})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=5e-3)
    annotation (Placement(transformation(extent={{-200,-40},{-180,-20}})));
equation
  connect(constantSpeed.flange,hallDigital123.flange) annotation(Line(points={{-28,-22},
          {32,-22}},                                                                                 color = {0,0,0}, smooth = Smooth.None));
  connect(hallDigital123.y,hallDecode.u) annotation(Line(points={{52,-22},{74,
          -22}},                                                                       color = {0,0,127}, smooth = Smooth.None));
  connect(pMSM_run.a2,pMSM_run.b2) annotation(Line(points={{-52,-63.6},{-60,
          -63.6},{-60,-71.6},{-52,-71.6}},                                                                                               color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_run.c2,pMSM_run.b2) annotation(Line(points={{-52,-79.6},{-60,
          -79.6},{-60,-71.6},{-52,-71.6}},                                                                                                    color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_run.support,fixed.flange) annotation(Line(points={{-32,-78},{10,
          -78},{10,-168}},                                                                         color = {0,0,0}, smooth = Smooth.None));
  connect(pMSM_run.flange,constantSpeed.flange) annotation(Line(points={{-32,-70},
          {20,-70},{20,-22},{-28,-22}},                                                                         color = {0,0,0}, smooth = Smooth.None));
  connect(smpm.plug_sn, terminalBox.plug_sn) annotation (Line(
      points={{-76,-140},{-76,-136}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(smpm.plug_sp, terminalBox.plug_sp) annotation (Line(
      points={{-64,-140},{-64,-136}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_a.plug_p, terminalBox.plugSupply) annotation (Line(
      points={{-94.8,-105},{-70,-105},{-70,-134}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_b.plug_p, terminalBox.plugSupply) annotation (Line(
      points={{-82.8,-113},{-70,-113},{-70,-134}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_c.plug_p, terminalBox.plugSupply) annotation (Line(
      points={{-94.8,-123},{-70,-123},{-70,-134}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(terminalBox.starpoint, ground1.p) annotation (Line(
      points={{-79,-134},{-122,-134},{-122,-150}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ground1.p, pMSM_run.a2) annotation (Line(
      points={{-122,-150},{-122,-63.6},{-52,-63.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(smpm.support, fixed.flange) annotation (Line(
      points={{-60,-160},{10,-160},{10,-168}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(smpm.flange, disc.flange_a) annotation (Line(
      points={{-60,-150},{-52,-150}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(disc.flange_b, idealGear.flange_a) annotation (Line(
      points={{-32,-150},{-24,-150}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(idealGear.flange_b, constantSpeed.flange) annotation (Line(
      points={{-4,-150},{20,-150},{20,-22},{-28,-22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(switch1c.n, pMSM_run.c1) annotation (Line(
      points={{-140,-86},{-94,-86},{-94,-76.4},{-52,-76.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch1b.n, pMSM_run.b1) annotation (Line(
      points={{-140,-72},{-96,-72},{-96,-68.4},{-52,-68.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch1a.n, pMSM_run.a1) annotation (Line(
      points={{-140,-58},{-96,-58},{-96,-60.4},{-52,-60.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch2a.n, plugToPin_a.pin_p) annotation (Line(
      points={{-140,-102},{-114,-102},{-114,-105},{-97.2,-105}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch2b.n, plugToPin_b.pin_p) annotation (Line(
      points={{-140,-116},{-114,-116},{-114,-113},{-85.2,-113}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch2c.n, plugToPin_c.pin_p) annotation (Line(
      points={{-140,-130},{-114,-130},{-114,-123},{-97.2,-123}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch1a.p, switch1b.p) annotation (Line(
      points={{-152,-58},{-152,-72}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch1b.p, switch1c.p) annotation (Line(
      points={{-152,-72},{-152,-86}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch1c.p, switch2a.p) annotation (Line(
      points={{-152,-86},{-152,-102}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch2a.p, switch2b.p) annotation (Line(
      points={{-152,-102},{-152,-116}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch2b.p, switch2c.p) annotation (Line(
      points={{-152,-116},{-152,-130}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch2c.p, ground1.p) annotation (Line(
      points={{-152,-130},{-152,-150},{-122,-150}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(booleanStep.y, switch1a.control) annotation (Line(
      points={{-179,-30},{-162,-30},{-162,-53.8},{-146,-53.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanStep.y, switch1b.control) annotation (Line(
      points={{-179,-30},{-162,-30},{-162,-67.8},{-146,-67.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanStep.y, switch1c.control) annotation (Line(
      points={{-179,-30},{-162,-30},{-162,-81.8},{-146,-81.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanStep.y, switch2a.control) annotation (Line(
      points={{-179,-30},{-162,-30},{-162,-97.8},{-146,-97.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanStep.y, switch2b.control) annotation (Line(
      points={{-179,-30},{-162,-30},{-162,-111.8},{-146,-111.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(booleanStep.y, switch2c.control) annotation (Line(
      points={{-179,-30},{-162,-30},{-162,-125.8},{-146,-125.8}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-200,
            -200},{100,100}}),                                                                        graphics), Documentation(info = "<html>
    <p>This model demonstrates how to do the placement of the hall sensors with the induced phase current.</p>
    </html>"),
    experiment(StopTime=0.01));
end MotorComparison;
