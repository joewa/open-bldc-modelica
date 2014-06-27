within OpenBLDC.Blocks;
block DetectCommutation "Detects sensorless when commutation is required"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Duration DelayCommutation = 3e-005 "Delay commutation";
  Real intBEMF(start = 0);
  Modelica.Blocks.Interfaces.BooleanInput pulses[3] "PWM signal" annotation(Placement(transformation(extent = {{-120,20},{-80,60}})));
  Modelica.Blocks.Interfaces.RealInput bridgeState[3] annotation(Placement(transformation(extent = {{-120,-60},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealInput v[3] "Voltage per phase" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {-40,-100})));
  Modelica.Blocks.Interfaces.RealInput v_dc "dc link voltage" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {40,-100})));
  Modelica.Blocks.MathBoolean.OnDelay onDelay[3](delayTime = DelayCommutation) annotation(Placement(transformation(extent = {{-40,-44},{-32,-36}})));
  Modelica.Blocks.Logical.And and1[3] annotation(Placement(transformation(extent = {{-62,-46},{-50,-34}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold[3](threshold = -0.5) annotation(Placement(transformation(extent = {{-80,-56},{-68,-44}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold[3](threshold = 0.5) annotation(Placement(transformation(extent = {{-80,-36},{-68,-24}})));
  Modelica.Blocks.Logical.Switch switch1[3] annotation(Placement(transformation(extent = {{12,-66},{24,-54}})));
  Modelica.Blocks.Sources.RealExpression realExpression[3] annotation(Placement(transformation(extent = {{-14,-78},{2,-60}})));
  Modelica.Blocks.Math.Sum goodBEMF(nin = 3) annotation(Placement(transformation(extent = {{32,-66},{44,-54}})));
  Modelica.Blocks.Math.Feedback phaseBEMF[3] "Back EMF of the open phase" annotation(Placement(transformation(extent = {{-36,-66},{-20,-50}})));
  Modelica.Blocks.Math.Gain gain(k = 0.5) annotation(Placement(transformation(extent = {{-5,-5},{5,5}}, rotation = 180, origin = {-3,-83})));
equation
  when onDelay.y then
    reinit(intBEMF, 0);
  end when;
  goodBEMF.y = der(intBEMF);
  connect(bridgeState,lessThreshold.u) annotation(Line(points = {{-100,-40},{-88,-40},{-88,-30},{-81.2,-30}}, color = {0,0,127}, smooth = Smooth.None));
  connect(bridgeState,greaterThreshold.u) annotation(Line(points = {{-100,-40},{-88,-40},{-88,-50},{-81.2,-50}}, color = {0,0,127}, smooth = Smooth.None));
  connect(lessThreshold.y,and1.u1) annotation(Line(points = {{-67.40000000000001,-30},{-63.2,-30},{-63.2,-40}}, color = {255,0,255}, smooth = Smooth.None));
  connect(greaterThreshold.y,and1.u2) annotation(Line(points = {{-67.40000000000001,-50},{-63.2,-50},{-63.2,-44.8}}, color = {255,0,255}, smooth = Smooth.None));
  connect(and1.y,onDelay.u) annotation(Line(points = {{-49.4,-40},{-41.6,-40}}, color = {255,0,255}, smooth = Smooth.None));
  connect(onDelay.y,switch1.u2) annotation(Line(points = {{-31.2,-40},{6,-40},{6,-60},{10.8,-60}}, color = {255,0,255}, smooth = Smooth.None));
  connect(realExpression.y,switch1.u3) annotation(Line(points = {{2.8,-69},{7.4,-69},{7.4,-64.8},{10.8,-64.8}}, color = {0,0,127}, smooth = Smooth.None));
  connect(switch1.y,goodBEMF.u) annotation(Line(points = {{24.6,-60},{30.8,-60}}, color = {0,0,127}, smooth = Smooth.None));
  connect(v_dc,gain.u) annotation(Line(points = {{40,-100},{40,-83},{3,-83}}, color = {0,0,127}, smooth = Smooth.None));
  connect(phaseBEMF.y,switch1.u1) annotation(Line(points = {{-20.8,-58},{-6,-58},{-6,-55.2},{10.8,-55.2}}, color = {0,0,127}, smooth = Smooth.None));
  connect(v,phaseBEMF.u1) annotation(Line(points = {{-40,-100},{-40,-58},{-34.4,-58}}, color = {0,0,127}, smooth = Smooth.None));
  connect(gain.y,phaseBEMF[1].u2) annotation(Line(points = {{-8.5,-83},{-28,-83},{-28,-64.40000000000001}}, color = {0,0,127}, smooth = Smooth.None));
  connect(gain.y,phaseBEMF[2].u2) annotation(Line(points = {{-8.5,-83},{-28,-83},{-28,-64.40000000000001}}, color = {0,0,127}, smooth = Smooth.None));
  connect(gain.y,phaseBEMF[3].u2) annotation(Line(points = {{-8.5,-83},{-28,-83},{-28,-64.40000000000001}}, color = {0,0,127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{200,100}}), graphics), Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics = {Text(extent = {{-76,60},{-12,24}}, lineColor = {0,0,255}, textString = "pulses", fontSize = 48, horizontalAlignment = TextAlignment.Left),Text(extent = {{-76,-20},{36,-56}}, lineColor = {0,0,255}, fontSize = 48, horizontalAlignment = TextAlignment.Left, textString = "bridgeState")}));
end DetectCommutation;