within OpenBLDC.Assemblies;
model HallCalibration "Constant speed demonstrate hall sensor commutation"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m=3 "Number of phases";

  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData
    smeeData
    annotation (Placement(transformation(extent={{44,46},{64,66}})));
  Sensors.HallDigital123 hallDigital123
    annotation (Placement(transformation(extent={{12,-32},{32,-12}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=2*
        pi*2)
    annotation (Placement(transformation(extent={{-62,-32},{-42,-12}})));
  Machines.PMSM pMSM_ab(
    R_p=0.33/2,
    L_p=3.5e-05/2,
    PhaseBEMF=0.1)
    annotation (Placement(transformation(extent={{-50,74},{-30,94}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed
    annotation (Placement(transformation(extent={{-20,-96},{0,-76}})));
  Blocks.HallDecode hallDecode
    annotation (Placement(transformation(extent={{54,-32},{74,-12}})));
  Machines.PMSM pMSM_bc(
    R_p=0.33/2,
    L_p=3.5e-05/2,
    PhaseBEMF=0.1)
    annotation (Placement(transformation(extent={{-50,46},{-30,66}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
  Machines.PMSM pMSM_ac(
    R_p=0.33/2,
    L_p=3.5e-05/2,
    PhaseBEMF=0.1)
    annotation (Placement(transformation(extent={{-50,18},{-30,38}})));
  Machines.PMSM pMSM_run(
    R_p=0.33/2,
    L_p=3.5e-05/2,
    PhaseBEMF=0.1)
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  Converters.SwitchingIdeal.Inverter3ph inverter3ph
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Electrical.Analog.Basic.Ground ground2
    annotation (Placement(transformation(extent={{-140,-108},{-120,-88}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage battery(V=3)  annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-130,-70})));
  replaceable Blocks.TestCtrl3ph
                     testCtrl3ph
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
equation
  connect(constantSpeed.flange, hallDigital123.flange) annotation (Line(
      points={{-42,-22},{12,-22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(fixed.flange, pMSM_ab.support)
                                      annotation (Line(
      points={{-10,-86},{-10,76},{-30,76}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(pMSM_ab.a2, pMSM_ab.b2)
                            annotation (Line(
      points={{-50,90.4},{-58,90.4},{-58,82.4},{-50,82.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_ab.c2, pMSM_ab.b2)
                            annotation (Line(
      points={{-50,74.4},{-58,74.4},{-58,82.4},{-50,82.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_ab.a1, pMSM_ab.b1)
                            annotation (Line(
      points={{-50,93.6},{-66,93.6},{-66,85.6},{-50,85.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_ab.flange, constantSpeed.flange)
                                             annotation (Line(
      points={{-30,84},{0,84},{0,-22},{-42,-22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(hallDigital123.y, hallDecode.u) annotation (Line(
      points={{32,-22},{54,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pMSM_bc.a2, pMSM_bc.b2)
                            annotation (Line(
      points={{-50,62.4},{-58,62.4},{-58,54.4},{-50,54.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_bc.c2, pMSM_bc.b2)
                            annotation (Line(
      points={{-50,46.4},{-58,46.4},{-58,54.4},{-50,54.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_ac.a2, pMSM_ac.b2)
                            annotation (Line(
      points={{-50,34.4},{-58,34.4},{-58,26.4},{-50,26.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_ac.c2, pMSM_ac.b2)
                            annotation (Line(
      points={{-50,18.4},{-58,18.4},{-58,26.4},{-50,26.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_ac.support, fixed.flange) annotation (Line(
      points={{-30,20},{-10,20},{-10,-86}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(pMSM_bc.support, fixed.flange) annotation (Line(
      points={{-30,48},{-10,48},{-10,-86}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(ground1.p, pMSM_ab.a1) annotation (Line(
      points={{-82,10},{-82,93.6},{-50,93.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_bc.b1, pMSM_bc.c1) annotation (Line(
      points={{-50,57.6},{-66,57.6},{-66,49.6},{-50,49.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_bc.b1, ground1.p) annotation (Line(
      points={{-50,57.6},{-82,57.6},{-82,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_ac.a1, ground1.p) annotation (Line(
      points={{-50,37.6},{-82,37.6},{-82,10}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_ac.c1, pMSM_ac.a1) annotation (Line(
      points={{-50,21.6},{-66,21.6},{-66,37.6},{-50,37.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_bc.flange, constantSpeed.flange) annotation (Line(
      points={{-30,56},{0,56},{0,-22},{-42,-22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(pMSM_ac.flange, constantSpeed.flange) annotation (Line(
      points={{-30,28},{0,28},{0,-22},{-42,-22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(pMSM_run.a2,pMSM_run. b2)
                            annotation (Line(
      points={{-50,-63.6},{-58,-63.6},{-58,-71.6},{-50,-71.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_run.c2,pMSM_run. b2)
                            annotation (Line(
      points={{-50,-79.6},{-58,-79.6},{-58,-71.6},{-50,-71.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_run.support, fixed.flange) annotation (Line(
      points={{-30,-78},{-10,-78},{-10,-86}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(pMSM_run.flange, constantSpeed.flange) annotation (Line(
      points={{-30,-70},{0,-70},{0,-22},{-42,-22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(inverter3ph.p_a, pMSM_run.a1) annotation (Line(
      points={{-80,-66},{-66,-66},{-66,-60.4},{-50,-60.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph.p_b, pMSM_run.b1) annotation (Line(
      points={{-80,-70},{-66,-70},{-66,-68.4},{-50,-68.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph.p_c, pMSM_run.c1) annotation (Line(
      points={{-80,-74},{-66,-74},{-66,-76.4},{-50,-76.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ground2.p, battery.n) annotation (Line(
      points={{-130,-88},{-130,-80}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(ground2.p, inverter3ph.p_n) annotation (Line(
      points={{-130,-88},{-116,-88},{-116,-74},{-100,-74}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(battery.p, inverter3ph.p_p) annotation (Line(
      points={{-130,-60},{-116,-60},{-116,-66},{-100,-66}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(testCtrl3ph.lCtrl, inverter3ph.ctrl_l) annotation (Line(
      points={{-100,-36},{-88,-36},{-88,-59.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(testCtrl3ph.hCtrl, inverter3ph.ctrl_h) annotation (Line(
      points={{-100,-24},{-92,-24},{-92,-59.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(hallDecode.y[1], testCtrl3ph.angle) annotation (Line(
      points={{74,-22},{82,-22},{82,-110},{-152,-110},{-152,-30},{-120,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{100,100}}), graphics), Documentation(info="<html>
<p>This model demonstrates how to do the placement of the hall sensors with the induced phase current.</p>
</html>"));
end HallCalibration;
