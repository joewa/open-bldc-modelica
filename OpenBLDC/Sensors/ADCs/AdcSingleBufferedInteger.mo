within OpenBLDC.Sensors.ADCs;
model AdcSingleBufferedInteger
  "Single channel analog digital converter with circular buffer and integer output"
  extends OpenBLDC.Icons.Sensor;
  parameter Real VMax = 3 "Maximum voltage";
  parameter Integer m = 1 "Number of multiplexed signals";
  parameter Integer Resolution(final min=2) = 4096 "ADC resolution";
  parameter Integer ADC_SQR_L(final min=1) = 1 "Regular channel sequence length";
  parameter Integer BufDepth(final min=1) = 50*ADC_SQR_L "Buffer depth";
  parameter Integer adc_sqr[ADC_SQR_L] = ones(ADC_SQR_L)"ADC regular sequence register";
  parameter Modelica.Units.SI.Time Ts = 1e-6 "Sample rate";
  Interfaces.AdcBusses.AdcSingleIntegerBusConnectorOut
    adcSingleIntegerBus(ADC_SQR_L=ADC_SQR_L, BufDepth=BufDepth)
    annotation (Placement(transformation(extent={{-10,-108},{10,-88}})));
  Modelica.Blocks.Nonlinear.Limiter limiter[m](each uMax=VMax, each uMin=0)
    annotation (Placement(visible = true, transformation(origin = {2, 0}, extent = {{-72, -40}, {-52, -20}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain[m](each k=Resolution/VMax)
    annotation (Placement(transformation(extent={{-42,-40},{-22,-20}})));
  Modelica.Blocks.Math.RealToInteger sampledValue "Sampled value in integer"
    annotation (Placement(visible = true, transformation(origin = {24, 0}, extent = {{18, -40}, {38, -20}}, rotation = 0)));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler[m]
    annotation (Placement(transformation(extent={{-12,-40},{8,-20}})));
  Blocks.PulseWidthVar pulseWidthVar
    "TODO: replace by a block that generates samples only"
    annotation (Placement(transformation(extent={{-32,-70},{-12,-50}})));
  Modelica.Blocks.Sources.Constant period(k=Ts) "Sample time"
    annotation (Placement(transformation(extent={{-54,-66},{-42,-54}})));
  OpenBLDC.Sensors.ADCs.CircularBufferInteger circularBufferInteger(BufDepth=BufDepth)
    annotation (Placement(visible = true, transformation(origin = {22, 0}, extent = {{48, -40}, {68, -20}}, rotation = 0)));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{0,-78},{12,-66}})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(m = m)  annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n(m = m)  annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Polyphase.Sensors.VoltageSensor voltageSensor(m = m)  annotation(
    Placement(visible = true, transformation(origin = {-75, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OpenBLDC.Blocks.Extractor extractor(nin = m)  annotation(
    Placement(visible = true, transformation(origin = {24, -30}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
  Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout = m)  annotation(
    Placement(visible = true, transformation(origin = {-2.5, -52}, extent = {{-5.5, -5}, {5.5, 5}}, rotation = 90)));
equation
  pulseWidthVar.dutyCycle = 0.5;
  extractor.index = if m > 1 then adc_sqr[mod(circularBufferInteger.buf_ptr - 1, ADC_SQR_L) + 1] else 1;
  //extractor.index = if m > 1 then mod(circularBufferInteger.buf_ptr - 1, ADC_SQR_L) + 1 else 1;
  connect(period.y, pulseWidthVar.periodTime) annotation(
    Line(points = {{-41.4, -60}, {-32, -60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(pulseWidthVar.active, adcSingleIntegerBus.active) annotation(
    Line(points = {{-32, -68}, {-36, -68}, {-36, -98}, {0, -98}}, color = {255, 0, 255}, smooth = Smooth.None),
    Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}));
  connect(not1.u, adcSingleIntegerBus.active) annotation(
    Line(points = {{-1.2, -72}, {-8, -72}, {-8, -98}, {0, -98}}, color = {255, 0, 255}, smooth = Smooth.None),
    Text(string = "%second", index = 1, extent = {{6, 3}, {6, 3}}));
  connect(sampledValue.y, circularBufferInteger.u) annotation(
    Line(points = {{63, -30}, {70, -30}}, color = {255, 127, 0}));
  connect(not1.y, circularBufferInteger.reset) annotation(
    Line(points = {{12.6, -72}, {65, -72}, {65, -38}, {70, -38}}, color = {255, 0, 255}));
  connect(pulseWidthVar.y, circularBufferInteger.trigger) annotation(
    Line(points = {{-12, -60}, {80, -60}, {80, -40}}, color = {255, 0, 255}));
  connect(circularBufferInteger.y, adcSingleIntegerBus.buffer) annotation(
    Line(points = {{90, -30}, {95, -30}, {95, -85}, {0, -85}, {0, -98}}, color = {255, 127, 0}));
  connect(circularBufferInteger.cb, adcSingleIntegerBus.cbStart) annotation(
    Line(points = {{80, -20}, {80, -12}, {100, -12}, {100, -98}, {0, -98}}, color = {255, 0, 255}));
  connect(adcSingleIntegerBus.active, pulseWidthVar.reset) annotation(
    Line(points = {{0, -98}, {-22, -98}, {-22, -70.2}}, color = {0, 0, 127}, smooth = Smooth.None),
    Text(string = "%first", index = -1, extent = {{-6, 3}, {-6, 3}}));
  connect(plug_p, voltageSensor.plug_p) annotation(
    Line(points = {{-100, 0}, {-93, 0}, {-93, 30}, {-85, 30}}, color = {0, 0, 255}));
  connect(voltageSensor.plug_n, plug_n) annotation(
    Line(points = {{-65, 30}, {80, 30}, {80, 0}, {100, 0}}, color = {0, 0, 255}));
  connect(voltageSensor.v, limiter.u) annotation(
    Line(points = {{-75, 19}, {-75, -30}, {-72, -30}}, color = {0, 0, 127}, thickness = 0.5));
  connect(triggeredSampler.y, extractor.u) annotation(
    Line(points = {{9, -30}, {12, -30}}, color = {0, 0, 127}, thickness = 0.5));
  connect(gain.y, triggeredSampler.u) annotation(
    Line(points = {{-21, -30}, {-14, -30}}, color = {0, 0, 127}, thickness = 0.5));
  connect(limiter.y, gain.u) annotation(
    Line(points = {{-49, -30}, {-44, -30}}, color = {0, 0, 127}, thickness = 0.5));
  connect(pulseWidthVar.y, booleanReplicator.u) annotation(
    Line(points = {{-12, -60}, {-2, -60}, {-2, -59}}, color = {255, 0, 255}));
  connect(booleanReplicator.y, triggeredSampler.trigger) annotation(
    Line(points = {{-2, -46}, {-2, -42}}, color = {255, 0, 255}, thickness = 0.5));
  connect(extractor.y, sampledValue.u) annotation(
    Line(points = {{35, -30}, {40, -30}}, color = {0, 0, 127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end AdcSingleBufferedInteger;