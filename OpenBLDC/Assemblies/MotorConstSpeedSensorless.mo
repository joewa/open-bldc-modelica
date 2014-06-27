within OpenBLDC.Assemblies;
model MotorConstSpeedSensorless
  "Constant speed driven motor to sensorless hall sensor commutation"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m = 3 "Number of phases";
  parameter Integer PPZ = 6 "Motor pairs of poles";
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData annotation(Placement(transformation(extent = {{44,46},{64,66}})));
  Sensors.HallDigital123 hallDigital123(Ppz = PPZ) annotation(Placement(transformation(extent = {{12,-32},{32,-12}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed = 10000 * 2 * pi / 60) annotation(Placement(transformation(extent = {{-62,-32},{-42,-12}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent = {{-20,-96},{0,-76}})));
  Blocks.HallDecode hallDecode annotation(Placement(transformation(extent = {{54,-32},{74,-12}})));
  Machines.PMSM pMSM_run(R_p = 0.33 / 2, L_p = 3.5e-005 / 2, ppz = PPZ, PhaseBEMF = 0.005) annotation(Placement(transformation(extent = {{-50,-80},{-30,-60}})));
  Converters.SwitchingIdeal.Inverter3ph inverter3ph annotation(Placement(transformation(extent = {{-100,-80},{-80,-60}})));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation(Placement(transformation(extent = {{-140,-108},{-120,-88}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage battery(V = 15) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-130,-70})));
  Blocks.SensorlessCtrl3phStateGraph sensorlessCtrl3phPWM annotation(Placement(transformation(extent = {{-170,-56},{-150,-36}})));
  Modelica.Blocks.Sources.Constant const(k=0.85)
    annotation (Placement(transformation(extent={{-204,-32},{-184,-12}})));
equation
  connect(constantSpeed.flange,hallDigital123.flange) annotation(Line(points = {{-42,-22},{12,-22}}, color = {0,0,0}, smooth = Smooth.None));
  connect(hallDigital123.y,hallDecode.u) annotation(Line(points = {{32,-22},{54,-22}}, color = {0,0,127}, smooth = Smooth.None));
  connect(pMSM_run.a2,pMSM_run.b2) annotation(Line(points = {{-50,-63.6},{-58,-63.6},{-58,-71.59999999999999},{-50,-71.59999999999999}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_run.c2,pMSM_run.b2) annotation(Line(points = {{-50,-79.59999999999999},{-58,-79.59999999999999},{-58,-71.59999999999999},{-50,-71.59999999999999}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_run.support,fixed.flange) annotation(Line(points = {{-30,-78},{-10,-78},{-10,-86}}, color = {0,0,0}, smooth = Smooth.None));
  connect(pMSM_run.flange,constantSpeed.flange) annotation(Line(points = {{-30,-70},{0,-70},{0,-22},{-42,-22}}, color = {0,0,0}, smooth = Smooth.None));
  connect(inverter3ph.p_a,pMSM_run.a1) annotation(Line(points = {{-80,-66},{-66,-66},{-66,-60.4},{-50,-60.4}}, color = {0,0,255}, smooth = Smooth.None));
  connect(inverter3ph.p_b,pMSM_run.b1) annotation(Line(points = {{-80,-70},{-66,-70},{-66,-68.40000000000001},{-50,-68.40000000000001}}, color = {0,0,255}, smooth = Smooth.None));
  connect(inverter3ph.p_c,pMSM_run.c1) annotation(Line(points = {{-80,-74},{-66,-74},{-66,-76.40000000000001},{-50,-76.40000000000001}}, color = {0,0,255}, smooth = Smooth.None));
  connect(ground2.p,battery.n) annotation(Line(points = {{-130,-88},{-130,-80}}, color = {0,0,255}, smooth = Smooth.None));
  connect(ground2.p,inverter3ph.p_n) annotation(Line(points = {{-130,-88},{-116,-88},{-116,-74},{-100,-74}}, color = {0,0,255}, smooth = Smooth.None));
  connect(battery.p,inverter3ph.p_p) annotation(Line(points = {{-130,-60},{-116,-60},{-116,-66},{-100,-66}}, color = {0,0,255}, smooth = Smooth.None));
  connect(sensorlessCtrl3phPWM.hCtrl,inverter3ph.ctrl_h) annotation(Line(points={{
          -158.824,-40},{-92,-40},{-92,-59.4}},                                                                           color = {255,0,255}, smooth = Smooth.None));
  connect(sensorlessCtrl3phPWM.lCtrl,inverter3ph.ctrl_l) annotation(Line(points={{
          -158.824,-52},{-88,-52},{-88,-59.4}},                                                                           color = {255,0,255}, smooth = Smooth.None));
  connect(inverter3ph.v_dc,sensorlessCtrl3phPWM.v_dc) annotation(Line(points={{-100,
          -78},{-104,-78},{-104,-112},{-160.588,-112},{-160.588,-56}},                                                                             color = {0,0,127}, smooth = Smooth.None));
  connect(inverter3ph.v,sensorlessCtrl3phPWM.v) annotation(Line(points={{-90,-80},
          {-90,-120},{-164.118,-120},{-164.118,-56}},                                                                           color = {0,0,127}, smooth = Smooth.None));
  connect(hallDecode.y[1],sensorlessCtrl3phPWM.angle) annotation(Line(points = {{74,-22},{80,-22},{80,-140},{-180,-140},{-180,-46},{-170,-46}}, color = {0,0,127}, smooth = Smooth.None));
  connect(const.y, sensorlessCtrl3phPWM.dutyCycle) annotation (Line(
      points={{-183,-22},{-176,-22},{-176,-38},{-170,-38}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-200,
            -200},{100,100}}),                                                                        graphics), Documentation(info = "<html>
    <p>This model demonstrates how to do the placement of the hall sensors with the induced phase current.</p>
    </html>"));
end MotorConstSpeedSensorless;
