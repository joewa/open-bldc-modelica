within OpenBLDC.Assemblies;
model MotorComparisonLDQ2
  "Test setup to compare the effect of different L_q and L_d"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m = 3 "Number of phases";
  parameter Integer ppz = 6 "Motor pairs of poles";
  parameter Modelica.SIunits.Resistance R_p = 0.33/2
    "Motor per phase resistance";
  parameter Modelica.SIunits.Inductance L_p = 3.5e-5/2
    "Motor per phase inductance";
  parameter Real m_k(min=0, max=0.999) = 0 "Mutual coupling coefficient";
  parameter Modelica.SIunits.Duration T_PWM = 50e-6;
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData annotation(Placement(transformation(extent = {{44,46},{64,66}})));
  Sensors.HallDigital123 hallDigital123(Ppz=ppz)
                                        annotation(Placement(transformation(extent={{46,-32},
            {66,-12}})));
  Modelica.Mechanics.Rotational.Sources.ConstantSpeed constantSpeed(w_fixed=
        1500*2*Modelica.Constants.pi/60)                                                   annotation(Placement(transformation(extent={{-20,-32},
            {0,-12}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation(Placement(transformation(extent={{20,-178},
            {40,-158}})));
  Blocks.HallDecode hallDecode annotation(Placement(transformation(extent={{74,-32},
            {94,-12}})));
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation(Placement(transformation(extent={{-86,
            -188},{-66,-168}})));
  Machines.PMSMdq_3ph
                 pMSM_run(
    R_p=R_p,
    ppz=ppz,
    PhaseBEMF=5/1000,
    L_md=L_p - L_p*0.2,
    L_mq=L_p + L_p*0.2)                                                       annotation(Placement(transformation(extent={{0,-80},
            {20,-60}})));

  Machines.SM_PermanentMagnet_WRP sM_PermanentMagnet_WRP1(
    fsNominal=1000,
    R_p=R_p,
    ppz=ppz,
    VsOpenCircuit=5/sqrt(2)*2*pi/ppz,
    PhaseBEMF=5/1000,
    m_k=0.4,
    L_md=L_p - L_p*0.2,
    L_mq=L_p + L_p*0.2)
    annotation (Placement(transformation(extent={{0,-140},{20,-120}})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=10)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-92,-150})));
  Converters.SwitchingIdeal.Inverter3ph inverter3ph_1(GoffSwitch=1e-3,
      GoffDiode=1e-3)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Converters.SwitchingIdeal.Inverter3ph inverter3ph_2(GoffSwitch=1e-3,
      GoffDiode=1e-3)
    annotation (Placement(transformation(extent={{-60,-140},{-40,-120}})));
  Blocks.PulseWidthVar pulseWidthVar[3]
    annotation (Placement(transformation(extent={{-166,-40},{-146,-20}})));
  Blocks.HalfBridgeLogicBLDC halfBridgeDriver[3]
    annotation (Placement(transformation(extent={{-96,-48},{-76,-28}})));
  Modelica.Blocks.Sources.BooleanStep startPWM[3](startTime=0.001e-3)
    annotation (Placement(transformation(extent={{-200,-70},{-180,-50}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant[3](k=false)
    annotation (Placement(transformation(extent={{-200,-100},{-180,-80}})));
  Modelica.Blocks.Sources.Constant period[3](k=T_PWM) "PWM period"
    annotation (Placement(transformation(extent={{-200,-40},{-180,-20}})));
  Modelica.Blocks.Sources.Constant dutyCycle[3](k=0.6) "PWM duty cycle"
    annotation (Placement(transformation(extent={{-200,-10},{-180,10}})));
  Modelica.Blocks.Sources.Constant mode_a(k=1) "Fixed bridge mode"
    annotation (Placement(transformation(extent={{-140,-44},{-130,-34}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (Placement(transformation(extent={{-122,-60},{-112,-50}})));
  Modelica.Blocks.Sources.Constant mode_b(k=-1) "Fixed bridge mode"
    annotation (Placement(transformation(extent={{-140,-60},{-130,-50}})));
  Modelica.Blocks.Sources.Constant mode_c(k=0) "Fixed bridge mode"
    annotation (Placement(transformation(extent={{-140,-76},{-130,-66}})));
  Modelica.Blocks.Sources.IntegerConstant pwmMode[3](k=1)
    annotation (Placement(transformation(extent={{-122,-78},{-112,-68}})));
equation
  connect(constantSpeed.flange,hallDigital123.flange) annotation(Line(points={{0,-22},
          {46,-22}},                                                                                 color = {0,0,0}, smooth = Smooth.None));
  connect(hallDigital123.y,hallDecode.u) annotation(Line(points={{66,-22},{74,-22}},   color = {0,0,127}, smooth = Smooth.None));
  connect(pMSM_run.a2,pMSM_run.b2) annotation(Line(points={{0,-63.6},{-8,-63.6},
          {-8,-71.6},{0,-71.6}},                                                                                                    color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_run.c2,pMSM_run.b2) annotation(Line(points={{0,-79.6},{-8,-79.6},
          {-8,-71.6},{0,-71.6}},                                                                                                    color = {0,0,255}, smooth = Smooth.None));
  connect(pMSM_run.support,fixed.flange) annotation(Line(points={{20,-78},{30,-78},
          {30,-168}},                                                                              color = {0,0,0}, smooth = Smooth.None));
  connect(pMSM_run.flange,constantSpeed.flange) annotation(Line(points={{20,-70},
          {40,-70},{40,-22},{0,-22}},                                                                           color = {0,0,0}, smooth = Smooth.None));
  connect(sM_PermanentMagnet_WRP1.support, fixed.flange) annotation (Line(
      points={{20,-138},{30,-138},{30,-168}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sM_PermanentMagnet_WRP1.flange, constantSpeed.flange) annotation (
      Line(
      points={{20,-130},{40,-130},{40,-22},{0,-22}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sM_PermanentMagnet_WRP1.c2, sM_PermanentMagnet_WRP1.b2) annotation (
      Line(
      points={{0,-139.6},{-4,-139.6},{-4,-140},{-8,-140},{-8,-131.6},{0,-131.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sM_PermanentMagnet_WRP1.a2, sM_PermanentMagnet_WRP1.b2) annotation (
      Line(
      points={{0,-123.6},{-4,-123.6},{-4,-124},{-8,-124},{-8,-131.6},{0,-131.6}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage.n, ground1.p) annotation (Line(
      points={{-92,-160},{-76,-160},{-76,-168}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph_1.p_a, pMSM_run.a1) annotation (Line(
      points={{-40,-66},{-30,-66},{-30,-60.4},{0,-60.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph_1.p_b, pMSM_run.b1) annotation (Line(
      points={{-40,-70},{-30,-70},{-30,-68.4},{0,-68.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph_1.p_c, pMSM_run.c1) annotation (Line(
      points={{-40,-74},{-30,-74},{-30,-76.4},{0,-76.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph_2.p_a, sM_PermanentMagnet_WRP1.a1) annotation (Line(
      points={{-40,-126},{-30,-126},{-30,-120.4},{0,-120.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph_2.p_b, sM_PermanentMagnet_WRP1.b1) annotation (Line(
      points={{-40,-130},{-30,-130},{-30,-128.4},{0,-128.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph_2.p_c, sM_PermanentMagnet_WRP1.c1) annotation (Line(
      points={{-40,-134},{-30,-134},{-30,-136.4},{0,-136.4}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph_2.p_n, constantVoltage.n) annotation (Line(
      points={{-60,-134},{-76,-134},{-76,-160},{-92,-160}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(inverter3ph_1.p_n, constantVoltage.n) annotation (Line(
      points={{-60,-74},{-76,-74},{-76,-160},{-92,-160}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage.p, inverter3ph_2.p_p) annotation (Line(
      points={{-92,-140},{-92,-126},{-60,-126}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(constantVoltage.p, inverter3ph_1.p_p) annotation (Line(
      points={{-92,-140},{-92,-66},{-60,-66}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(halfBridgeDriver.hCtrl, inverter3ph_1.ctrl_h) annotation (Line(
      points={{-76,-32},{-52,-32},{-52,-59.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(halfBridgeDriver.lCtrl, inverter3ph_1.ctrl_l) annotation (Line(
      points={{-76,-44},{-48,-44},{-48,-59.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(halfBridgeDriver.hCtrl, inverter3ph_2.ctrl_h) annotation (Line(
      points={{-76,-32},{-66,-32},{-66,-96},{-52,-96},{-52,-119.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(halfBridgeDriver.lCtrl, inverter3ph_2.ctrl_l) annotation (Line(
      points={{-76,-44},{-70,-44},{-70,-100},{-48,-100},{-48,-119.4}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(startPWM.y, pulseWidthVar.active) annotation (Line(
      points={{-179,-60},{-172,-60},{-172,-38},{-166,-38}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(period.y, pulseWidthVar.periodTime) annotation (Line(
      points={{-179,-30},{-166,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dutyCycle.y, pulseWidthVar.dutyCycle) annotation (Line(
      points={{-179,0},{-172,0},{-172,-22},{-166,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(booleanConstant.y, pulseWidthVar.reset) annotation (Line(
      points={{-179,-90},{-156,-90},{-156,-40.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pulseWidthVar.y, halfBridgeDriver.pulses) annotation (Line(
      points={{-146,-30},{-102,-30},{-102,-30.2},{-96,-30.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(mode_a.y, multiplex3_1.u1[1]) annotation (Line(
      points={{-129.5,-39},{-126.75,-39},{-126.75,-51.5},{-123,-51.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex3_1.y, halfBridgeDriver.val) annotation (Line(
      points={{-111.5,-55},{-108,-55},{-108,-38},{-96,-38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mode_b.y, multiplex3_1.u2[1]) annotation (Line(
      points={{-129.5,-55},{-123,-55}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(mode_c.y, multiplex3_1.u3[1]) annotation (Line(
      points={{-129.5,-71},{-126,-71},{-126,-58.5},{-123,-58.5}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pwmMode.y, halfBridgeDriver.pwm_Mode) annotation (Line(
      points={{-111.5,-73},{-104,-73},{-104,-46},{-96,-46}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-200,
            -200},{100,100}}),                                                                        graphics), Documentation(info="<html>
<p>This model is used to compare the stator frame PMSM model with the model from the MSL.</p>
<p>The connectors a and b are operated in 2-leg PWM mode. Observe the voltage on the open connector c of inverter3ph_2 and the torque of the motor.</p>
</html>"),
    experiment(StopTime=0.01));
end MotorComparisonLDQ2;
