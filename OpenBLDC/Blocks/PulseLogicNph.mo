within OpenBLDC.Blocks;
model PulseLogicNph "Generates PWM signal depending on commutation and speed"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  parameter Integer m = 5 "Number of phases";
  parameter Real PwmClockFrequency = 1e6 "PWM clock frequency [Hz]";
  parameter Integer DefaultPeriodPsc = 25
    "Default PWM period prescaler = f_clock / f_PWM";
  parameter Boolean PwmVarFrequency = true "Apply variable frequency method?";
  Integer periodPsc(start=DefaultPeriodPsc);
  discrete Real dutyCycle_d(start=0);
  Modelica.Blocks.Interfaces.RealInput dutyCycle annotation(Placement(transformation(extent = {{-120,60},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput bridgeModeIn[m] annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanInput active annotation(Placement(transformation(extent = {{-120,-100},{-80,-60}})));
  Modelica.Blocks.Interfaces.BooleanOutput y "PWM output" annotation(Placement(transformation(extent = {{90,70},{110,90}})));
  Modelica.Blocks.Interfaces.RealOutput bridgeModeOut[m] annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  PulseWidthVar pulseWidth annotation(Placement(transformation(extent={{34,48},{
            54,68}})));
  Modelica.Blocks.Logical.Change changeBridgeMode[m]
    "Indicate if bridge mode has changed"
    annotation (Placement(transformation(extent={{0,14},{12,26}})));
  Modelica.Blocks.MathBoolean.Or or1(nu=5)
    annotation (Placement(transformation(extent={{26,14},{38,26}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean[m]
    annotation (Placement(transformation(extent={{-32,14},{-20,26}})));
  Interfaces.PwmControlBusConnectorOut pwmControlBusConnectorOut
    annotation (Placement(transformation(extent={{-10,-108},{10,-88}})));
  Modelica.Blocks.Logical.Switch activate[m] "Activate the bridges"
    annotation (Placement(transformation(extent={{-40,-18},{-20,2}})));
  Modelica.Blocks.Sources.Constant constZeros[m](each k=0)
    annotation (Placement(transformation(extent={{-60,-22},{-48,-10}})));
equation
  pulseWidth.reset = false;

  pulseWidth.dutyCycle = dutyCycle_d;
  pwmControlBusConnectorOut.dutyCycle = dutyCycle_d;
  when active and pwmControlBusConnectorOut.reset then
    dutyCycle_d = dutyCycle;
  end when;

  pulseWidth.periodTime = periodPsc / PwmClockFrequency;
  pwmControlBusConnectorOut.period = periodPsc / PwmClockFrequency;
  when PwmVarFrequency and pwmControlBusConnectorOut.reset then
    periodPsc = integer( DefaultPeriodPsc / ( 4 * dutyCycle_d * (1 - dutyCycle_d)));
  end when;

  connect(pulseWidth.y,y) annotation(Line(points={{54,58},{62,58},{62,80},{100,80}},   color = {255,0,255}, smooth = Smooth.None));
  connect(active,pulseWidth.active) annotation(Line(points={{-100,-80},{-8,-80},
          {-8,50},{34,50}},                                                                        color = {255,0,255}, smooth = Smooth.None));
  connect(realToBoolean.y, changeBridgeMode.u) annotation (Line(
      points={{-19.4,20},{-1.2,20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(bridgeModeIn, realToBoolean.u) annotation (Line(
      points={{-100,0},{-54,0},{-54,20},{-33.2,20}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(active, pwmControlBusConnectorOut.active) annotation (Line(
      points={{-100,-80},{0,-80},{0,-98}},
      color={255,0,255},
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
  for i in 1:m loop
    connect(active, activate[i].u2) annotation (Line(
      points={{-100,-80},{-74,-80},{-74,-8},{-42,-8}},
      color={255,0,255},
      smooth=Smooth.None));
  end for;
  connect(activate.y, bridgeModeOut) annotation (Line(
      points={{-19,-8},{36,-8},{36,0},{100,0}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(activate.u3, constZeros.y) annotation (Line(
      points={{-42,-16},{-47.4,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(changeBridgeMode.y, or1.u[1:m]) annotation (Line(
      points={{12.6,20},{26,20}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics),
      Documentation(info="<html>
<p>This block implements some logic for appropriate PWM signal generation for the three half bridges of the motor controller. The actual dutyCycle is updated only when <code>bridgeModeIn[3]</code> changes, i.e. the motor commutates or an active event occurs.</p>
<p>The PWM period can be either fixed <code>pulseWidth.periodTime&nbsp;=&nbsp;periodPsc&nbsp;/&nbsp;PwmClockFrequency</code> or variable by setting the parameter <code>PwmVarFrequency</code> to false or true. When the variable PWM frequency method is selected, the PWM period is calculated by <code>periodPsc&nbsp;=<font style=\"color: #ff0000; \">&nbsp;</font>DefaultPeriodPsc&nbsp;/&nbsp;(&nbsp;4&nbsp;*&nbsp;dutyCycle&nbsp;*&nbsp;(1&nbsp;-&nbsp;dutyCycle))</code>. So the PWM period is increased when very high or very low duty cycles are applied keeping the current ripple constant at all duty cycles</p>
</html>"));
end PulseLogicNph;
