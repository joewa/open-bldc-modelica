within OpenBLDC.Assemblies;
model SensorBLDC5ph "Application of 5 phase hall sensor BLDC commutation"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Integer PPZ = 6 "Motor pairs of poles";
  parameter Modelica.SIunits.Resistance R_p = 0.33/2
    "Motor per phase resistance";
  parameter Modelica.SIunits.Inductance L_p = 3.5e-5/2
    "Motor per phase inductance";
  constant Integer m = 5 "Number of phases";
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData annotation(Placement(transformation(extent = {{44,46},{64,66}})));
  Sensors.HallDigitalN hallDigital12345(Ppz=PPZ, m=5,
    hall_angle={(1/2 - 4/5)*pi,(1/2 - 2/5)*pi,(1/2 + 0)*pi,(1/2 + 2/5)*pi,(1/2
         + 4/5)*pi}) "doch 1/2 statt 3/2??"
    annotation (Placement(transformation(extent={{14,-26},{34,-6}})));
  replaceable Modelica.Mechanics.Rotational.Sources.ConstantSpeed mechanicalLoad(w_fixed=0)
    "Replaceable mechanical attachment"                                                                              annotation(Placement(transformation(extent = {{-92,-26},{-72,-6}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent = {{-20,-96},{0,-76}})));
  Machines.PMSMndq
                pMSM_run(                                    ppz = PPZ, PhaseBEMF = 0.005, Jr = 5e-005,
    R_p=R_p,
    L_md=L_p - L_p*0.2,
    L_mq=L_p + L_p*0.2,
    m=m)                                                                                                annotation(Placement(transformation(extent = {{-38,-80},{-18,-60}})));
  Converters.SwitchingIdeal.InverterNph inverter3ph(m=m)
                                                    annotation(Placement(transformation(extent = {{-88,-80},{-68,-60}})));
  Modelica.Electrical.Analog.Basic.Ground ground2 annotation(Placement(transformation(extent = {{-128,-108},{-108,-88}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage battery(V = 15) annotation(Placement(transformation(extent = {{-10,-10},{10,10}}, rotation = 270, origin = {-118,-70})));
  replaceable Blocks.SensorCtrl5phStateGraphNG sensorCtrlPWM constrainedby
    Blocks.SensorlessCtrl3phStateGraphNG
    "Replacable (sensorless) BLDC controller"
    annotation (Placement(transformation(extent={{-158,-56},{-138,-36}})));
  replaceable Modelica.Blocks.Sources.Constant motorVoltageCommand(k = 0.85)
    "Replaceable motor voltage command"                                                                          annotation(Placement(transformation(extent = {{-192,-32},{-172,-12}})));
  Modelica.Mechanics.Rotational.Components.BearingFriction bearingFriction(tau_pos = [0,0.005]) annotation(Placement(transformation(extent = {{-38,-42},{-18,-22}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
      terminalConnection="Y", m=m)
    annotation (Placement(transformation(extent={{-38,-60},{-18,-40}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-202,-76},{-182,-56}})));
equation
  connect(mechanicalLoad.flange, hallDigital12345.flange) annotation (Line(
      points={{-72,-16},{14,-16}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(pMSM_run.support,fixed.flange) annotation(Line(points = {{-18,-78},{-10,-78},{-10,-86}}, color = {0,0,0}, smooth = Smooth.None));
  connect(ground2.p,battery.n) annotation(Line(points = {{-118,-88},{-118,-80}}, color = {0,0,255}, smooth = Smooth.None));
  connect(ground2.p,inverter3ph.p_n) annotation(Line(points = {{-118,-88},{-104,-88},{-104,-74},{-88,-74}}, color = {0,0,255}, smooth = Smooth.None));
  connect(battery.p,inverter3ph.p_p) annotation(Line(points = {{-118,-60},{-104,-60},{-104,-66},{-88,-66}}, color = {0,0,255}, smooth = Smooth.None));
  connect(sensorCtrlPWM.hCtrl, inverter3ph.ctrl_h) annotation (Line(
      points={{-144.296,-42.6667},{-80,-42.6667},{-80,-59.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(sensorCtrlPWM.lCtrl, inverter3ph.ctrl_l) annotation (Line(
      points={{-144.296,-52.6667},{-76,-52.6667},{-76,-59.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(inverter3ph.v_dc, sensorCtrlPWM.v_dc) annotation (Line(
      points={{-88,-78},{-92,-78},{-92,-112},{-145.407,-112},{-145.407,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(inverter3ph.v, sensorCtrlPWM.v) annotation (Line(
      points={{-78,-80},{-78,-120},{-147.63,-120},{-147.63,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(motorVoltageCommand.y, sensorCtrlPWM.dutyCycle) annotation (Line(
      points={{-171,-22},{-164,-22},{-164,-41},{-158,-41}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mechanicalLoad.flange,bearingFriction.flange_a) annotation(Line(points = {{-72,-16},{-56,-16},{-56,-32},{-38,-32}}, color = {0,0,0}, smooth = Smooth.None));
  connect(bearingFriction.flange_b,pMSM_run.flange) annotation(Line(points = {{-18,-32},{-10,-32},{-10,-70},{-18,-70}}, color = {0,0,0}, smooth = Smooth.None));
  connect(pMSM_run.plug_sn, terminalBox.plug_sn) annotation (Line(
      points={{-34,-60},{-34,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pMSM_run.plug_sp, terminalBox.plug_sp) annotation (Line(
      points={{-22,-60},{-22,-60}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph.plug_m, terminalBox.plugSupply) annotation (Line(
      points={{-68,-70},{-50,-70},{-50,-50},{-28,-50},{-28,-58}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(const.y, sensorCtrlPWM.angle) annotation (Line(
      points={{-181,-66},{-170,-66},{-170,-47.6667},{-158,-47.6667}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-200,
            -200},{100,100}}),                                                                        graphics), Documentation(info = "<html>
    <p>This model demonstrates how to do the placement of the hall sensors with the induced phase current.</p>
    </html>"));
end SensorBLDC5ph;
