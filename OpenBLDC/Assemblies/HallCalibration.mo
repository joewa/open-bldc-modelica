within OpenBLDC.Assemblies;
model HallCalibration "Constant speed demonstrate hall sensor commutation"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m = 3 "Number of phases";
  parameter Integer ppz = 1 "Motor pairs of poles";
  parameter Modelica.SIunits.Resistance R_p = 0.33/2
    "Motor per phase resistance";
  parameter Modelica.SIunits.Inductance L_p = 3.5e-5/2
    "Motor per phase inductance";
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData annotation(Placement(transformation(extent = {{44,46},{64,66}})));
  Sensors.HallDigital123 hallDigital123 annotation(Placement(transformation(extent = {{12,-32},{32,-12}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed = 2 * pi * 10) annotation(Placement(transformation(extent = {{-62,-32},{-42,-12}})));
  Machines.PMSM pMSM_ab(                                    PhaseBEMF = 0.1,
    R_p=R_p,
    L_p=L_p,
    ppz=ppz)                                                                 annotation(Placement(transformation(extent = {{-50,74},{-30,94}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent={{-18,
            -174},{2,-154}})));
  Blocks.HallDecode hallDecode annotation(Placement(transformation(extent = {{54,-32},{74,-12}})));
  Machines.PMSM pMSM_bc(                                    PhaseBEMF = 0.1,
    R_p=R_p,
    L_p=L_p,
    ppz=ppz)                                                                 annotation(Placement(transformation(extent = {{-50,46},{-30,66}})));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(transformation(extent = {{-92,-10},{-72,10}})));
  Machines.PMSM pMSM_ac(                                    PhaseBEMF = 0.1,
    R_p=R_p,
    L_p=L_p,
    ppz=ppz)                                                                 annotation(Placement(transformation(extent = {{-50,18},{-30,38}})));
  Machines.PMSM pMSM_run(                                    PhaseBEMF = 0.1,
    R_p=R_p,
    L_p=L_p,
    ppz=ppz)                                                                  annotation(Placement(transformation(extent = {{-50,-80},{-30,-60}})));
  Converters.SwitchingIdeal.Inverter3ph inverter3ph annotation(Placement(transformation(extent = {{-100,-80},{-80,-60}})));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation(Placement(transformation(extent = {{-140,-108},{-120,-88}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage battery(V = 15) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-130,-70})));
  Blocks.TestCtrl3phPWM testCtrl3phPWM annotation(Placement(transformation(extent = {{-120,-40},{-100,-20}})));
  Converters.SwitchingIdeal.Inverter3ph inverter3ph1
                                                    annotation(Placement(transformation(extent={{-98,
            -126},{-78,-106}})));
  Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
    smpm(useSupport=true,
    p=ppz,
    fsNominal=490,
    Rs=R_p,
    alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,

    VsOpenCircuit=11.1,
    Lmd=L_p,
    Lmq=L_p,
    useDamperCage=false)
    annotation (Placement(transformation(extent={{-48,-160},{-28,-140}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_a(m = m, k = 1) annotation(Placement(transformation(extent={{-58,
            -112},{-70,-98}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox
                                 terminalBox(terminalConnection="Y")
    annotation (Placement(transformation(extent={{-48,-136},{-28,-116}},
          rotation=0)));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_b(m=m, k=2)
    annotation (Placement(transformation(extent={{-46,-120},{-58,-106}})));
  Modelica.Electrical.MultiPhase.Basic.PlugToPin_p plugToPin_c(m=m, k=3)
    annotation (Placement(transformation(extent={{-58,-130},{-70,-116}})));
equation
  connect(constantSpeed.flange,hallDigital123.flange) annotation(Line(points = {{-42,-22},{12,-22}}, color = {0,0,0}, smooth = Smooth.None));
  connect(fixed.flange,pMSM_ab.support) annotation(Line(points={{-8,-164},{-8,
          76},{-30,76}},                                                                        color = {0,0,0}, smooth = Smooth.None));
  connect(pMSM_ab.a2,pMSM_ab.b2) annotation(Line(points = {{-50,90.40000000000001},{-58,90.40000000000001},{-58,82.40000000000001},{-50,82.40000000000001}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_ab.c2,pMSM_ab.b2) annotation(Line(points = {{-50,74.40000000000001},{-58,74.40000000000001},{-58,82.40000000000001},{-50,82.40000000000001}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_ab.a1,pMSM_ab.b1) annotation(Line(points = {{-50,93.59999999999999},{-66,93.59999999999999},{-66,85.59999999999999},{-50,85.59999999999999}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_ab.flange,constantSpeed.flange) annotation(Line(points = {{-30,84},{0,84},{0,-22},{-42,-22}}, color = {0,0,0}, smooth = Smooth.None));
  connect(hallDigital123.y,hallDecode.u) annotation(Line(points = {{32,-22},{54,-22}}, color = {0,0,127}, smooth = Smooth.None));
  connect(pMSM_bc.a2,pMSM_bc.b2) annotation(Line(points = {{-50,62.4},{-58,62.4},{-58,54.4},{-50,54.4}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_bc.c2,pMSM_bc.b2) annotation(Line(points = {{-50,46.4},{-58,46.4},{-58,54.4},{-50,54.4}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_ac.a2,pMSM_ac.b2) annotation(Line(points = {{-50,34.4},{-58,34.4},{-58,26.4},{-50,26.4}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_ac.c2,pMSM_ac.b2) annotation(Line(points = {{-50,18.4},{-58,18.4},{-58,26.4},{-50,26.4}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_ac.support,fixed.flange) annotation(Line(points={{-30,20},{-8,20},
          {-8,-164}},                                                                           color = {0,0,0}, smooth = Smooth.None));
  connect(pMSM_bc.support,fixed.flange) annotation(Line(points={{-30,48},{-8,48},
          {-8,-164}},                                                                           color = {0,0,0}, smooth = Smooth.None));
  connect(ground1.p,pMSM_ab.a1) annotation(Line(points = {{-82,10},{-82,93.59999999999999},{-50,93.59999999999999}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_bc.b1,pMSM_bc.c1) annotation(Line(points = {{-50,57.6},{-66,57.6},{-66,49.6},{-50,49.6}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_bc.b1,ground1.p) annotation(Line(points = {{-50,57.6},{-82,57.6},{-82,10}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_ac.a1,ground1.p) annotation(Line(points = {{-50,37.6},{-82,37.6},{-82,10}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_ac.c1,pMSM_ac.a1) annotation(Line(points = {{-50,21.6},{-66,21.6},{-66,37.6},{-50,37.6}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_bc.flange,constantSpeed.flange) annotation(Line(points = {{-30,56},{0,56},{0,-22},{-42,-22}}, color = {0,0,0}, smooth = Smooth.None));
  connect(pMSM_ac.flange,constantSpeed.flange) annotation(Line(points = {{-30,28},{0,28},{0,-22},{-42,-22}}, color = {0,0,0}, smooth = Smooth.None));
  connect(pMSM_run.a2,pMSM_run.b2) annotation(Line(points = {{-50,-63.6},{-58,-63.6},{-58,-71.59999999999999},{-50,-71.59999999999999}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_run.c2,pMSM_run.b2) annotation(Line(points = {{-50,-79.59999999999999},{-58,-79.59999999999999},{-58,-71.59999999999999},{-50,-71.59999999999999}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_run.support,fixed.flange) annotation(Line(points={{-30,-78},{-8,
          -78},{-8,-164}},                                                                         color = {0,0,0}, smooth = Smooth.None));
  connect(pMSM_run.flange,constantSpeed.flange) annotation(Line(points = {{-30,-70},{0,-70},{0,-22},{-42,-22}}, color = {0,0,0}, smooth = Smooth.None));
  connect(inverter3ph.p_a,pMSM_run.a1) annotation(Line(points = {{-80,-66},{-66,-66},{-66,-60.4},{-50,-60.4}}, color = {0,0,255}, smooth = Smooth.None));
  connect(inverter3ph.p_b,pMSM_run.b1) annotation(Line(points = {{-80,-70},{-66,-70},{-66,-68.40000000000001},{-50,-68.40000000000001}}, color = {0,0,255}, smooth = Smooth.None));
  connect(inverter3ph.p_c,pMSM_run.c1) annotation(Line(points = {{-80,-74},{-66,-74},{-66,-76.40000000000001},{-50,-76.40000000000001}}, color = {0,0,255}, smooth = Smooth.None));
  connect(ground2.p,battery.n) annotation(Line(points = {{-130,-88},{-130,-80}}, color = {0,0,255}, smooth = Smooth.None));
  connect(ground2.p,inverter3ph.p_n) annotation(Line(points = {{-130,-88},{-116,-88},{-116,-74},{-100,-74}}, color = {0,0,255}, smooth = Smooth.None));
  connect(battery.p,inverter3ph.p_p) annotation(Line(points = {{-130,-60},{-116,-60},{-116,-66},{-100,-66}}, color = {0,0,255}, smooth = Smooth.None));
  connect(testCtrl3phPWM.lCtrl,inverter3ph.ctrl_l) annotation(Line(points = {{-100,-36},{-88,-36},{-88,-59.4}}, color = {255,0,255}, smooth = Smooth.None));
  connect(testCtrl3phPWM.hCtrl,inverter3ph.ctrl_h) annotation(Line(points = {{-100,-24},{-92,-24},{-92,-59.4}}, color = {255,0,255}, smooth = Smooth.None));
  connect(hallDecode.y[1],testCtrl3phPWM.angle) annotation(Line(points={{74,-22},
          {86,-22},{86,-50},{-148,-50},{-148,-30},{-120,-30}},                                                                            color = {0,0,127}, smooth = Smooth.None));
  connect(testCtrl3phPWM.hCtrl, inverter3ph1.ctrl_h) annotation (Line(
      points={{-100,-24},{-76,-24},{-76,-92},{-90,-92},{-90,-105.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(testCtrl3phPWM.lCtrl, inverter3ph1.ctrl_l) annotation (Line(
      points={{-100,-36},{-72,-36},{-72,-96},{-86,-96},{-86,-105.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(smpm.support, fixed.flange) annotation (Line(
      points={{-28,-160},{-8,-160},{-8,-164}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(smpm.flange, constantSpeed.flange) annotation (Line(
      points={{-28,-150},{0,-150},{0,-22},{-42,-22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(smpm.plug_sn, terminalBox.plug_sn) annotation (Line(
      points={{-44,-140},{-44,-136}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(smpm.plug_sp, terminalBox.plug_sp) annotation (Line(
      points={{-32,-140},{-32,-136}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph1.p_a, plugToPin_a.pin_p) annotation (Line(
      points={{-78,-112},{-72,-112},{-72,-105},{-65.2,-105}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph1.p_b, plugToPin_b.pin_p) annotation (Line(
      points={{-78,-116},{-66,-116},{-66,-113},{-53.2,-113}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph1.p_c, plugToPin_c.pin_p) annotation (Line(
      points={{-78,-120},{-72,-120},{-72,-123},{-65.2,-123}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_a.plug_p, terminalBox.plugSupply) annotation (Line(
      points={{-62.8,-105},{-38,-105},{-38,-134}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_b.plug_p, terminalBox.plugSupply) annotation (Line(
      points={{-50.8,-113},{-38,-113},{-38,-134}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(plugToPin_c.plug_p, terminalBox.plugSupply) annotation (Line(
      points={{-62.8,-123},{-38,-123},{-38,-134}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph1.p_p, battery.p) annotation (Line(
      points={{-98,-112},{-106,-112},{-106,-60},{-130,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph1.p_n, ground2.p) annotation (Line(
      points={{-98,-120},{-116,-120},{-116,-88},{-130,-88}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-200,
            -200},{100,100}}),                                                                        graphics), Documentation(info = "<html>
    <p>This model demonstrates how to do the placement of the hall sensors with the induced phase current.</p>
    </html>"));
end HallCalibration;
