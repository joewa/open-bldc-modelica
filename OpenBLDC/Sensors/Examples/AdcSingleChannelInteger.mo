within OpenBLDC.Sensors.Examples;
model AdcSingleChannelInteger "Analog digital converter example"
  extends Modelica.Icons.Example;
  parameter Integer bufdepth = 50;
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
  Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(
    V=1,
    f=5000,
    offset=1.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-10})));
  ADCs.AdcSingleBufferedInteger adcSingleBufferedInteger(BufDepth=bufdepth)
    annotation (Placement(transformation(extent={{-30,6},{-10,26}})));
  Modelica.Blocks.Sources.BooleanStep startADC(startTime=1e-3)
    annotation (Placement(transformation(extent={{-58,-24},{-38,-4}})));
equation
  adcSingleBufferedInteger.adcSingleIntegerBus.active = startADC.y;
  connect(ground.p, sineVoltage.n) annotation (Line(
      points={{-80,-30},{-80,-20}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(sineVoltage.p, adcSingleBufferedInteger.pin_p) annotation (Line(
      points={{-80,0},{-80,16},{-30,16}},
      color={0,0,255},
      smooth=Smooth.None));
  connect(adcSingleBufferedInteger.pin_n, ground.p) annotation (Line(
      points={{-10,16},{0,16},{0,-30},{-80,-30}},
      color={0,0,255},
      smooth=Smooth.None));
  annotation(experiment(StopTime = 0.003), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics),
    Documentation(info="<html>
<p>This example demonstrates the operation of the analog digital converter model with circular buffer.</p>
<p>Inspect the circular buffer in the adcSingleIntegerBus. Each time the callback function (cb) is triggered, the buffer can be evaluated.</p>
</html>"));
end AdcSingleChannelInteger;
