within OpenBLDC.Sensors.ADCs;
model AdcSingleBufferedInteger
  "Single channel analog digital converter with circular buffer and integer output"
  extends OpenBLDC.Icons.Sensor;
  parameter Real VMax = 3 "Maximum voltage";
  parameter Integer Resolution(final min=2) = 4096 "ADC resolution";
  parameter Integer BufDepth(final min=1) = 50 "Buffer depth";
  parameter Modelica.Units.SI.Time Ts = 1e-6 "Sample rate";

  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  Interfaces.AdcBusses.AdcSingleIntegerBusConnectorOut
    adcSingleIntegerBus(BufDepth=BufDepth)
    annotation (Placement(transformation(extent={{-10,-108},{10,-88}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=VMax, uMin=0)
    annotation (Placement(transformation(extent={{-72,-40},{-52,-20}})));
  Modelica.Blocks.Math.Gain gain(k=Resolution/VMax)
    annotation (Placement(transformation(extent={{-42,-40},{-22,-20}})));
  Modelica.Blocks.Math.RealToInteger sampledValue "Sampled value in integer"
    annotation (Placement(transformation(extent={{18,-40},{38,-20}})));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler
    annotation (Placement(transformation(extent={{-12,-40},{8,-20}})));
  Blocks.PulseWidthVar pulseWidthVar
    "TODO: replace by a block that generates samples only"
    annotation (Placement(transformation(extent={{-32,-70},{-12,-50}})));
  Modelica.Blocks.Sources.Constant period(k=Ts) "Sample time"
    annotation (Placement(transformation(extent={{-54,-66},{-42,-54}})));
  CircularBufferInteger circularBufferInteger(BufDepth=BufDepth)
    annotation (Placement(transformation(extent={{48,-40},{68,-20}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{0,-78},{12,-66}})));
equation
  pulseWidthVar.dutyCycle = 0.5;
  connect(pin_p, voltageSensor.p) annotation (Line(
      points={{-100,0},{-88,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(pin_n, voltageSensor.n) annotation (Line(
      points={{100,0},{-68,0}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(voltageSensor.v, limiter.u) annotation (Line(
      points={{-78,-10},{-78,-30},{-74,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(limiter.y, gain.u) annotation (Line(
      points={{-51,-30},{-44,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, triggeredSampler.u) annotation (Line(
      points={{-21,-30},{-14,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(triggeredSampler.y, sampledValue.u) annotation (Line(
      points={{9,-30},{16,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(period.y, pulseWidthVar.periodTime) annotation (Line(
      points={{-41.4,-60},{-32,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pulseWidthVar.y, triggeredSampler.trigger) annotation (Line(
      points={{-12,-60},{-2,-60},{-2,-41.8}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pulseWidthVar.active, adcSingleIntegerBus.active) annotation (Line(
      points={{-32,-68},{-36,-68},{-36,-98},{0,-98}},
      color={255,0,255},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(not1.u, adcSingleIntegerBus.active) annotation (Line(
      points={{-1.2,-72},{-8,-72},{-8,-98},{0,-98}},
      color={255,0,255},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sampledValue.y, circularBufferInteger.u) annotation (Line(
      points={{39,-30},{48,-30}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(not1.y, circularBufferInteger.reset) annotation (Line(
      points={{12.6,-72},{42,-72},{42,-38},{48,-38}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(pulseWidthVar.y, circularBufferInteger.trigger) annotation (Line(
      points={{-12,-60},{58,-60},{58,-40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(circularBufferInteger.y, adcSingleIntegerBus.buffer) annotation (Line(
      points={{68,-30},{72,-30},{72,-86},{0,-86},{0,-98}},
      color={255,127,0},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(circularBufferInteger.cb, adcSingleIntegerBus.cbStart) annotation (
      Line(
      points={{58,-20},{58,-12},{82,-12},{82,-98},{0,-98}},
      color={255,0,255},
      smooth=Smooth.None), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));

  connect(adcSingleIntegerBus.active, pulseWidthVar.reset) annotation (Line(
      points={{0,-98},{-22,-98},{-22,-70.2}},
      color={0,0,127},
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end AdcSingleBufferedInteger;
