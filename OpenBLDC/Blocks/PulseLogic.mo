within OpenBLDC.Blocks;
model PulseLogic "Generates PWM signal depending on commutation and speed"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  Modelica.Blocks.Interfaces.RealInput dutyCycle annotation(Placement(transformation(extent = {{-120,60},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput bridgeModeIn[3] annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanInput active annotation(Placement(transformation(extent = {{-120,-100},{-80,-60}})));
  Modelica.Blocks.Interfaces.BooleanOutput y "PWM output" annotation(Placement(transformation(extent = {{90,70},{110,90}})));
  Modelica.Blocks.Interfaces.RealOutput bridgeModeOut[3] annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  PulseWidthVar pulseWidth annotation(Placement(transformation(extent={{34,48},{
            54,68}})));
  Modelica.Blocks.Sources.Constant const2(each k = 2.5e-005) annotation(Placement(transformation(extent = {{-46,40},{-26,60}})));
  Modelica.Blocks.Logical.Change changeBridgeMode[3]
    "Indicate if bridge mode has changed"
    annotation (Placement(transformation(extent={{0,14},{12,26}})));
  Modelica.Blocks.MathBoolean.Or or1(nu=3)
    annotation (Placement(transformation(extent={{26,14},{38,26}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean[3]
    annotation (Placement(transformation(extent={{-32,14},{-20,26}})));
  Interfaces.PwmControlBusConnectorOut pwmControlBusConnectorOut
    annotation (Placement(transformation(extent={{-10,-108},{10,-88}})));
  Modelica.Blocks.Logical.Switch activate[3] "Activate the bridges"
    annotation (Placement(transformation(extent={{-40,-18},{-20,2}})));
  Modelica.Blocks.Sources.Constant constZeros[3](each k=0)
    annotation (Placement(transformation(extent={{-60,-22},{-48,-10}})));
equation
  pulseWidth.reset = false;
  connect(const2.y,pulseWidth.periodTime) annotation(Line(points={{-25,50},{-16,
          50},{-16,58},{34,58}},                                                                      color = {0,0,127}, smooth = Smooth.None));
  connect(pulseWidth.y,y) annotation(Line(points={{54,58},{62,58},{62,80},{100,80}},   color = {255,0,255}, smooth = Smooth.None));
  connect(dutyCycle,pulseWidth.dutyCycle) annotation(Line(points={{-100,80},{
          -64,80},{-64,66},{34,66}},                                                                     color = {0,0,127}, smooth = Smooth.None));
  connect(active,pulseWidth.active) annotation(Line(points={{-100,-80},{-8,-80},
          {-8,50},{34,50}},                                                                        color = {255,0,255}, smooth = Smooth.None));
  connect(changeBridgeMode.y, or1.u[1:3]) annotation (Line(
      points={{12.6,20},{22,20},{22,17.2},{26,17.2}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(realToBoolean.y, changeBridgeMode.u) annotation (Line(
      points={{-19.4,20},{-1.2,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(bridgeModeIn, realToBoolean.u) annotation (Line(
      points={{-100,0},{-54,0},{-54,20},{-33.2,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dutyCycle, pwmControlBusConnectorOut.dutyCycle) annotation (Line(
      points={{-100,80},{-64,80},{-64,-98},{0,-98}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(active, pwmControlBusConnectorOut.active) annotation (Line(
      points={{-100,-80},{0,-80},{0,-98}},
      color={255,0,255},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const2.y, pwmControlBusConnectorOut.period) annotation (Line(
      points={{-25,50},{-16,50},{-16,-98},{0,-98}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(or1.y, pwmControlBusConnectorOut.reset) annotation (Line(
      points={{38.9,20},{44,20},{44,-98},{0,-98}},
      color={255,0,255},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pulseWidth.y, pwmControlBusConnectorOut.pulses) annotation (Line(
      points={{54,58},{62,58},{62,-98},{0,-98}},
      color={255,0,255},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(bridgeModeIn, activate.u1) annotation (Line(
      points={{-100,0},{-42,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(active, activate[1].u2) annotation (Line(
      points={{-100,-80},{-74,-80},{-74,-8},{-42,-8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(active, activate[2].u2) annotation (Line(
      points={{-100,-80},{-74,-80},{-74,-8},{-42,-8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(active, activate[3].u2) annotation (Line(
      points={{-100,-80},{-74,-80},{-74,-8},{-42,-8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(activate.y, bridgeModeOut) annotation (Line(
      points={{-19,-8},{36,-8},{36,0},{100,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(activate.u3, constZeros.y) annotation (Line(
      points={{-42,-16},{-47.4,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics));
end PulseLogic;
