within OpenBLDC.Blocks;
model PulseWidthVar
  "Generates a boolean pulse signal with adjustable pulse width and period"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  Modelica.Blocks.Interfaces.RealInput dutyCycle annotation(Placement(transformation(extent = {{-120,60},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput periodTime annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanInput active annotation(Placement(transformation(extent = {{-120,-100},{-80,-60}})));
  Modelica.Blocks.Interfaces.BooleanOutput y "PWM output" annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
protected
  Boolean doSample;
  discrete Real nextSampling(start = Modelica.Constants.inf);
  discrete Real pulsStart(start = Modelica.Constants.inf);
public
  Modelica.Blocks.Interfaces.BooleanInput reset "Begin new pwm cycle"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-102})));
  Interfaces.PwmControlBusConnectorOut pwmControlBusConnectorOut
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
equation
  doSample = time >= pre(nextSampling);
  //doSample = time >= nextSampling;

  when {doSample,active} then
    if edge(active) then
      nextSampling = time + periodTime;
      pulsStart = time;
    else
      nextSampling = pre(nextSampling) + periodTime;
      pulsStart = pre(nextSampling);
    end if;
  end when;
  y = time >= pulsStart and time < pulsStart + dutyCycle * periodTime and active;

  // Connect the PWM bus
  connect(y, pwmControlBusConnectorOut.pulses);
  connect(dutyCycle, pwmControlBusConnectorOut.dutyCycle) annotation (Line(
      points={{-100,80},{0,80},{0,-60},{100,-60}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(periodTime, pwmControlBusConnectorOut.period) annotation (Line(
      points={{-100,0},{0,0},{0,-60},{100,-60}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(active, pwmControlBusConnectorOut.active) annotation (Line(
      points={{-100,-80},{0,-80},{0,-60},{100,-60}},
      color={255,0,255},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(reset, pwmControlBusConnectorOut.reset) annotation (Line(
      points={{0,-102},{50,-102},{50,-60},{100,-60}},
      color={255,0,255},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics), Icon(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics));
end PulseWidthVar;
