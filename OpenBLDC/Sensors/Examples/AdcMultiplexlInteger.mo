within OpenBLDC.Sensors.Examples;
model AdcMultiplexlInteger "Analog digital converter example"
  extends Modelica.Icons.Example;
  parameter Integer bufdepth = 30;
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(
    V=1,
    f= 20000,
    offset=1.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-10})));
  OpenBLDC.Sensors.ADCs.AdcSingleBufferedInteger adcSingleBufferedInteger(ADC_SQR_L = 3,BufDepth = bufdepth, Ts = 1e-6, adc_sqr = {1, 1, 2}, m = 2)
    annotation (Placement(visible = true, transformation(origin = {0, -6}, extent = {{-30, 6}, {-10, 26}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanStep startADC(startTime= 1e-4)
    annotation (Placement(transformation(extent={{-58,-24},{-38,-4}})));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_p(k = 1, m = 2)  annotation(
    Placement(visible = true, transformation(origin = {-50, 10}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_n plugToPin_n(k = 1, m = 2)  annotation(
    Placement(visible = true, transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 1)  annotation(
    Placement(visible = true, transformation(origin = {-90, 20}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_p plugToPin_p1(k = 2, m = 2) annotation(
    Placement(visible = true, transformation(origin = {-50, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Polyphase.Basic.PlugToPin_n plugToPin_n1(k = 2, m = 2) annotation(
    Placement(visible = true, transformation(origin = {10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  adcSingleBufferedInteger.adcSingleIntegerBus.active = startADC.y;
  connect(ground.p, sineVoltage.n) annotation (Line(
      points={{-80,-30},{-80,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sineVoltage.p, plugToPin_p.pin_p) annotation(
    Line(points = {{-80, 0}, {-80, 10}, {-52, 10}}, color = {0, 0, 255}));
  connect(plugToPin_p.plug_p, adcSingleBufferedInteger.plug_p) annotation(
    Line(points = {{-48, 10}, {-28, 10}}, color = {0, 0, 255}));
  connect(adcSingleBufferedInteger.plug_n, plugToPin_n.plug_n) annotation(
    Line(points = {{-10, 10}, {8, 10}}, color = {0, 0, 255}));
  connect(ground.p, plugToPin_n.pin_n) annotation(
    Line(points = {{-80, -30}, {12, -30}, {12, 10}}, color = {0, 0, 255}));
  connect(ground.p, constantVoltage.n) annotation(
    Line(points = {{-80, -30}, {-90, -30}, {-90, 10}}, color = {0, 0, 255}));
  connect(constantVoltage.p, plugToPin_p1.pin_p) annotation(
    Line(points = {{-90, 30}, {-52, 30}}, color = {0, 0, 255}));
  connect(ground.p, plugToPin_n1.pin_n) annotation(
    Line(points = {{-80, -30}, {12, -30}, {12, 30}}, color = {0, 0, 255}));
  connect(plugToPin_p1.plug_p, adcSingleBufferedInteger.plug_p) annotation(
    Line(points = {{-48, 30}, {-36, 30}, {-36, 10}, {-28, 10}}, color = {0, 0, 255}));
  connect(plugToPin_n1.plug_n, adcSingleBufferedInteger.plug_n) annotation(
    Line(points = {{8, 30}, {-4, 30}, {-4, 10}, {-10, 10}}, color = {0, 0, 255}));
  annotation(experiment(StopTime = 0.0003), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
    Documentation(info="<html>
<p>This example demonstrates the operation of the analog digital converter model with circular buffer.</p>
<p>Inspect the circular buffer in the adcSingleIntegerBus. Each time the callback function (cb) is triggered, the buffer can be evaluated.</p>
</html>"));
end AdcMultiplexlInteger;