within OpenBLDC.Assemblies;
model MotorComparisonLzero "Test setup to compare the effect of Lzero"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m = 3 "Number of phases";
  parameter Integer ppz = 6 "Motor pairs of poles";
  parameter Modelica.SIunits.Resistance R_p = 0.33/2
    "Motor per phase resistance";
  parameter Modelica.SIunits.Inductance L_p = 3.5e-5/2
    "Motor per phase inductance";
  parameter Real m_k(min=0, max=0.999) = 0.5 "Mutual coupling coefficient";
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData annotation(Placement(transformation(extent = {{44,46},{64,66}})));
  Sensors.HallDigital123 hallDigital123 annotation(Placement(transformation(extent={{32,-32},
            {52,-12}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=500
        *2*Modelica.Constants.pi/60)                                                       annotation(Placement(transformation(extent={{-48,-32},
            {-28,-12}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent={{0,-178},
            {20,-158}})));
  Blocks.HallDecode hallDecode annotation(Placement(transformation(extent={{74,-32},
            {94,-12}})));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(transformation(extent={{-134,
            -180},{-114,-160}})));
  Machines.PMSMm pMSM_run(
    R_p=R_p,
    ppz=ppz,
    PhaseBEMF=5/1000,
    L_p=L_p,
    m_k=m_k)                                                                  annotation(Placement(transformation(extent={{-52,-80},
            {-32,-60}})));

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
  Modelica.Blocks.Sources.BooleanPulse booleanStep(startTime=5e-3, period=50e-6)
    annotation (Placement(transformation(extent={{-200,-40},{-180,-20}})));
  Machines.SM_PermanentMagnet_WRP sM_PermanentMagnet_WRP1(
    fsNominal=1000,
    R_p=R_p,
    ppz=ppz,
    VsOpenCircuit=5/sqrt(2)*2*pi/ppz,
    L_md=L_p,
    L_mq=L_p,
    m_k=m_k)
    annotation (Placement(transformation(extent={{-52,-140},{-32,-120}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=10)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-152,-150})));
  Modelica.Electrical.Analog.Ideal.IdealDiode d1 annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-117,-155})));
  Modelica.Electrical.Analog.Ideal.IdealDiode d2 annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-109,-155})));
  Modelica.Electrical.Analog.Ideal.IdealDiode d3 annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-101,-155})));
  Modelica.Electrical.Analog.Ideal.IdealDiode d4 annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-93,-155})));
  Modelica.Electrical.Analog.Ideal.IdealDiode d5 annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-85,-155})));
  Modelica.Electrical.Analog.Ideal.IdealDiode d6 annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-77,-155})));
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
  connect(switch1c.n, pMSM_run.c1) annotation (Line(
      points={{-140,-86},{-68,-86},{-68,-76.4},{-52,-76.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch1b.n, pMSM_run.b1) annotation (Line(
      points={{-140,-72},{-130,-72},{-130,-68.4},{-52,-68.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(switch1a.n, pMSM_run.a1) annotation (Line(
      points={{-140,-58},{-96,-58},{-96,-60.4},{-52,-60.4}},
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
  connect(sM_PermanentMagnet_WRP1.support, fixed.flange) annotation (Line(
      points={{-32,-138},{10,-138},{10,-168}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sM_PermanentMagnet_WRP1.flange, constantSpeed.flange) annotation (
      Line(
      points={{-32,-130},{20,-130},{20,-22},{-28,-22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sM_PermanentMagnet_WRP1.c2, sM_PermanentMagnet_WRP1.b2) annotation (
      Line(
      points={{-52,-139.6},{-56,-139.6},{-56,-140},{-60,-140},{-60,-131.6},{-52,
          -131.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sM_PermanentMagnet_WRP1.a2, sM_PermanentMagnet_WRP1.b2) annotation (
      Line(
      points={{-52,-123.6},{-56,-123.6},{-56,-124},{-60,-124},{-60,-131.6},{-52,
          -131.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sM_PermanentMagnet_WRP1.a1, switch2a.n) annotation (Line(
      points={{-52,-120.4},{-66,-120.4},{-66,-102},{-140,-102}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sM_PermanentMagnet_WRP1.b1, switch2b.n) annotation (Line(
      points={{-52,-128.4},{-70,-128.4},{-70,-116},{-140,-116}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sM_PermanentMagnet_WRP1.c1, switch2c.n) annotation (Line(
      points={{-52,-136.4},{-132,-136.4},{-132,-130},{-140,-130}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sM_PermanentMagnet_WRP1.b2, ground1.p) annotation (Line(
      points={{-52,-131.6},{-124,-131.6},{-124,-160}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_run.b2, ground1.p) annotation (Line(
      points={{-52,-71.6},{-124,-71.6},{-124,-160}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage.n, ground1.p) annotation (Line(
      points={{-152,-160},{-124,-160}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage.p, switch2c.p) annotation (Line(
      points={{-152,-140},{-152,-130}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ground1.p, d1.p) annotation (Line(
      points={{-124,-160},{-117,-160}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(d2.p, ground1.p) annotation (Line(
      points={{-109,-160},{-124,-160}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(d3.p, ground1.p) annotation (Line(
      points={{-101,-160},{-124,-160}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(d4.p, ground1.p) annotation (Line(
      points={{-93,-160},{-124,-160}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(d5.p, ground1.p) annotation (Line(
      points={{-85,-160},{-124,-160}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(d6.p, ground1.p) annotation (Line(
      points={{-77,-160},{-124,-160}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(d6.n, sM_PermanentMagnet_WRP1.c1) annotation (Line(
      points={{-77,-150},{-76,-150},{-76,-136.4},{-52,-136.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(d5.n, switch2b.n) annotation (Line(
      points={{-85,-150},{-84,-150},{-84,-116},{-140,-116}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(d4.n, switch2a.n) annotation (Line(
      points={{-93,-150},{-92,-150},{-92,-102},{-140,-102}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(d3.n, switch1c.n) annotation (Line(
      points={{-101,-150},{-100,-150},{-100,-86},{-140,-86}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(d2.n, pMSM_run.b1) annotation (Line(
      points={{-109,-150},{-108,-150},{-108,-68.4},{-52,-68.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(d1.n, switch1a.n) annotation (Line(
      points={{-117,-150},{-116,-150},{-116,-58},{-140,-58}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-200,
            -200},{100,100}}),                                                                        graphics), Documentation(info="<html>
<p>This model is used to compare the stator frame PMSM model with the model from the MSL.</p>
<p>Play around with the coupling coefficient <code>m_k</code> and observe the impact on the motor currents.</p>
</html>"),
    experiment(StopTime=0.01));
end MotorComparisonLzero;
