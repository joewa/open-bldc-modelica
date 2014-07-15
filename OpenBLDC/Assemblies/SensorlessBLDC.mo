within OpenBLDC.Assemblies;
model SensorlessBLDC "Application of sensorless BLDC commutation"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m = 3 "Number of phases";
  parameter Integer PPZ = 6 "Motor pairs of poles";
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData annotation(Placement(transformation(extent = {{44,46},{64,66}})));
  Sensors.HallDigital123 hallDigital123(Ppz = PPZ) annotation(Placement(transformation(extent = {{12,-32},{32,-12}})));
  replaceable Modelica.Mechanics.Rotational.Sources.ConstantSpeed mechanicalLoad(w_fixed=
        10000*2*pi/60) "Replaceable mechanical attachment"
    annotation (Placement(transformation(extent={{-50,-32},{-30,-12}})));

  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent = {{-20,-96},{0,-76}})));
  Blocks.HallDecode hallDecode annotation(Placement(transformation(extent={{40,-32},
            {60,-12}})));
  Machines.PMSM pMSM_run(R_p = 0.33 / 2, L_p = 3.5e-005 / 2, ppz = PPZ, PhaseBEMF = 0.005) annotation(Placement(transformation(extent={{-38,-80},
            {-18,-60}})));
  Converters.SwitchingIdeal.Inverter3ph inverter3ph annotation(Placement(transformation(extent={{-88,-80},
            {-68,-60}})));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation(Placement(transformation(extent={{-128,
            -108},{-108,-88}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage battery(V = 15) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin={-118,-70})));
  replaceable Blocks.SensorlessCtrl3phStateGraphNG
                                     sensorlessCtrl3phPWM
    "Replacable (sensorless) BLDC controller"             annotation(Placement(transformation(extent={{-158,
            -56},{-138,-36}})));
  replaceable Modelica.Blocks.Sources.Constant motorVoltageCommand(k=0.85)
    "Replaceable motor voltage command"
    annotation (Placement(transformation(extent={{-192,-32},{-172,-12}})));
equation
  connect(mechanicalLoad.flange, hallDigital123.flange) annotation (Line(
      points={{-30,-22},{12,-22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(hallDigital123.y,hallDecode.u) annotation(Line(points={{32,-22},{40,
          -22}},                                                                       color = {0,0,127}, smooth = Smooth.None));
  connect(pMSM_run.a2,pMSM_run.b2) annotation(Line(points={{-38,-63.6},{-46,
          -63.6},{-46,-71.6},{-38,-71.6}},                                                                                               color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_run.c2,pMSM_run.b2) annotation(Line(points={{-38,-79.6},{-46,
          -79.6},{-46,-71.6},{-38,-71.6}},                                                                                                    color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_run.support,fixed.flange) annotation(Line(points={{-18,-78},{-10,
          -78},{-10,-86}},                                                                         color = {0,0,0}, smooth = Smooth.None));
  connect(pMSM_run.flange, mechanicalLoad.flange) annotation (Line(
      points={{-18,-70},{-6,-70},{-6,-22},{-30,-22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(inverter3ph.p_a,pMSM_run.a1) annotation(Line(points={{-68,-66},{-54,
          -66},{-54,-60.4},{-38,-60.4}},                                                                       color = {0,0,255}, smooth = Smooth.None));
  connect(inverter3ph.p_b,pMSM_run.b1) annotation(Line(points={{-68,-70},{-54,
          -70},{-54,-68.4},{-38,-68.4}},                                                                                                 color = {0,0,255}, smooth = Smooth.None));
  connect(inverter3ph.p_c,pMSM_run.c1) annotation(Line(points={{-68,-74},{-54,
          -74},{-54,-76.4},{-38,-76.4}},                                                                                                 color = {0,0,255}, smooth = Smooth.None));
  connect(ground2.p,battery.n) annotation(Line(points={{-118,-88},{-118,-80}},   color = {0,0,255}, smooth = Smooth.None));
  connect(ground2.p,inverter3ph.p_n) annotation(Line(points={{-118,-88},{-104,
          -88},{-104,-74},{-88,-74}},                                                                        color = {0,0,255}, smooth = Smooth.None));
  connect(battery.p,inverter3ph.p_p) annotation(Line(points={{-118,-60},{-104,
          -60},{-104,-66},{-88,-66}},                                                                        color = {0,0,255}, smooth = Smooth.None));
  connect(sensorlessCtrl3phPWM.hCtrl,inverter3ph.ctrl_h) annotation(Line(points={{
          -143.769,-40},{-80,-40},{-80,-59.4}},                                                                           color = {255,0,255}, smooth = Smooth.None));
  connect(sensorlessCtrl3phPWM.lCtrl,inverter3ph.ctrl_l) annotation(Line(points={{
          -143.769,-52},{-76,-52},{-76,-59.4}},                                                                           color = {255,0,255}, smooth = Smooth.None));
  connect(inverter3ph.v_dc,sensorlessCtrl3phPWM.v_dc) annotation(Line(points={{-88,-78},
          {-92,-78},{-92,-112},{-144.923,-112},{-144.923,-56}},                                                                                    color = {0,0,127}, smooth = Smooth.None));
  connect(inverter3ph.v,sensorlessCtrl3phPWM.v) annotation(Line(points={{-78,-80},
          {-78,-120},{-147.231,-120},{-147.231,-56}},                                                                           color = {0,0,127}, smooth = Smooth.None));
  connect(hallDecode.y[1],sensorlessCtrl3phPWM.angle) annotation(Line(points={{60,-22},
          {68,-22},{68,-140},{-170,-140},{-170,-46},{-158,-46}},                                                                                color = {0,0,127}, smooth = Smooth.None));
  connect(motorVoltageCommand.y, sensorlessCtrl3phPWM.dutyCycle) annotation (
      Line(
      points={{-171,-22},{-164,-22},{-164,-38},{-158,-38}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-200,
            -200},{100,100}}),                                                                        graphics), Documentation(info = "<html>
    <p>This model demonstrates how to do the placement of the hall sensors with the induced phase current.</p>
    </html>"));
end SensorlessBLDC;
