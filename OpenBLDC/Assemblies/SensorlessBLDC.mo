within OpenBLDC.Assemblies;
model SensorlessBLDC "Application of sensorless BLDC commutation"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m = 3 "Number of phases";
  parameter Integer PPZ = 6 "Motor pairs of poles";
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData annotation(Placement(transformation(extent = {{44,46},{64,66}})));
  Sensors.HallDigitalN   hallDigital123(Ppz = PPZ) annotation(Placement(transformation(extent = {{14,-26},{34,-6}})));
  replaceable Modelica.Mechanics.Rotational.Sources.ConstantSpeed mechanicalLoad(w_fixed=0)
    "Replaceable mechanical attachment"                                                                              annotation(Placement(transformation(extent = {{-92,-26},{-72,-6}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent = {{-20,-96},{0,-76}})));
  Blocks.HallDecode hallDecode annotation(Placement(transformation(extent = {{42,-26},{62,-6}})));
  Machines.PMSM pMSM_run(R_p = 0.33 / 2, L_p = 3.5e-005 / 2, ppz = PPZ, PhaseBEMF = 0.005, Jr = 5e-005) annotation(Placement(transformation(extent = {{-38,-80},{-18,-60}})));
  Converters.SwitchingIdeal.Inverter3ph inverter3ph annotation(Placement(transformation(extent = {{-88,-80},{-68,-60}})));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation(Placement(transformation(extent = {{-128,-108},{-108,-88}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage battery(V = 15) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-118,-70})));
  replaceable Blocks.SensorlessCtrl3phStateGraphNG sensorlessCtrl3phPWM
    "Replacable (sensorless) BLDC controller"                                                                     annotation(Placement(transformation(extent = {{-158,-56},{-138,-36}})));
  replaceable Modelica.Blocks.Sources.Constant motorVoltageCommand(k = 0.85)
    "Replaceable motor voltage command"                                                                          annotation(Placement(transformation(extent = {{-192,-32},{-172,-12}})));
  Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(tau_pos = [0,0.005]) annotation(Placement(transformation(extent = {{-38,-42},{-18,-22}})));
equation
  connect(mechanicalLoad.flange,hallDigital123.flange) annotation(Line(points = {{-72,-16},{14,-16}}, color = {0,0,0}, smooth = Smooth.None));
  connect(hallDigital123.y,hallDecode.u) annotation(Line(points = {{34,-16},{42,-16}}, color = {0,0,127}, smooth = Smooth.None));
  connect(pMSM_run.a2,pMSM_run.b2) annotation(Line(points = {{-38,-63.6},{-46,-63.6},{-46,-71.59999999999999},{-38,-71.59999999999999}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_run.c2,pMSM_run.b2) annotation(Line(points = {{-38,-79.59999999999999},{-46,-79.59999999999999},{-46,-71.59999999999999},{-38,-71.59999999999999}}, color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_run.support,fixed.flange) annotation(Line(points = {{-18,-78},{-10,-78},{-10,-86}}, color = {0,0,0}, smooth = Smooth.None));
  connect(inverter3ph.p_a,pMSM_run.a1) annotation(Line(points = {{-68,-66},{-54,-66},{-54,-60.4},{-38,-60.4}}, color = {0,0,255}, smooth = Smooth.None));
  connect(inverter3ph.p_b,pMSM_run.b1) annotation(Line(points = {{-68,-70},{-54,-70},{-54,-68.40000000000001},{-38,-68.40000000000001}}, color = {0,0,255}, smooth = Smooth.None));
  connect(inverter3ph.p_c,pMSM_run.c1) annotation(Line(points = {{-68,-74},{-54,-74},{-54,-76.40000000000001},{-38,-76.40000000000001}}, color = {0,0,255}, smooth = Smooth.None));
  connect(ground2.p,battery.n) annotation(Line(points = {{-118,-88},{-118,-80}}, color = {0,0,255}, smooth = Smooth.None));
  connect(ground2.p,inverter3ph.p_n) annotation(Line(points = {{-118,-88},{-104,-88},{-104,-74},{-88,-74}}, color = {0,0,255}, smooth = Smooth.None));
  connect(battery.p,inverter3ph.p_p) annotation(Line(points = {{-118,-60},{-104,-60},{-104,-66},{-88,-66}}, color = {0,0,255}, smooth = Smooth.None));
  connect(sensorlessCtrl3phPWM.hCtrl,inverter3ph.ctrl_h) annotation(Line(points={{
          -144.296,-42.6667},{-80,-42.6667},{-80,-59.4}},                                                                           color = {255,0,255}, smooth = Smooth.None));
  connect(sensorlessCtrl3phPWM.lCtrl,inverter3ph.ctrl_l) annotation(Line(points={{
          -144.296,-52.6667},{-76,-52.6667},{-76,-59.4}},                                                                           color = {255,0,255}, smooth = Smooth.None));
  connect(inverter3ph.v_dc,sensorlessCtrl3phPWM.v_dc) annotation(Line(points={{-88,-78},
          {-92,-78},{-92,-112},{-145.407,-112},{-145.407,-56}},                                                                                 color = {0,0,127}, smooth = Smooth.None));
  connect(inverter3ph.v,sensorlessCtrl3phPWM.v) annotation(Line(points={{-78,-80},
          {-78,-120},{-147.63,-120},{-147.63,-56}},                                                                           color = {0,0,127}, smooth = Smooth.None));
  connect(hallDecode.y[1],sensorlessCtrl3phPWM.angle) annotation(Line(points={{62,-16},
          {68,-16},{68,-140},{-170,-140},{-170,-47.6667},{-158,-47.6667}},                                                                                color = {0,0,127}, smooth = Smooth.None));
  connect(motorVoltageCommand.y,sensorlessCtrl3phPWM.dutyCycle) annotation(Line(points = {{-171,-22},{-164,-22},{-164,-41},{-158,-41}}, color = {0,0,127}, smooth = Smooth.None));
  connect(mechanicalLoad.flange,bearingFriction.flange_a) annotation(Line(points = {{-72,-16},{-56,-16},{-56,-32},{-38,-32}}, color = {0,0,0}, smooth = Smooth.None));
  connect(bearingFriction.flange_b,pMSM_run.flange) annotation(Line(points = {{-18,-32},{-10,-32},{-10,-70},{-18,-70}}, color = {0,0,0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200,-200},{100,100}}), graphics), Documentation(info = "<html>
    <p>This model demonstrates how to do the placement of the hall sensors with the induced phase current.</p>
    </html>"));
end SensorlessBLDC;
