within OpenBLDC.Blocks;
block TestCtrl3phPWM "Commutation applying PWM"
  extends OpenBLDC.Icons.ControlLaw;
  Modelica.Blocks.Interfaces.BooleanOutput hCtrl[3] annotation(Placement(transformation(extent = {{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl[3] annotation(Placement(transformation(extent = {{90,-70},{110,-50}})));
  Modelica.Blocks.Interfaces.RealInput angle "Decoded hall" annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table = [1,1,-1,0;2,0,-1,1;3,-1,0,1;4,-1,1,0;5,0,1,-1;6,1,0,-1]) annotation(Placement(transformation(extent = {{-60,-10},{-40,10}})));
  PulseWidthVar pulseWidth[3] annotation(Placement(transformation(extent = {{-30,74},{-10,94}})));
  Modelica.Blocks.Sources.Constant const[3](each k = 0.9) annotation(Placement(transformation(extent = {{-90,78},{-70,98}})));
  Modelica.Blocks.Sources.Constant const2[3](each k = 5e-005) annotation(Placement(transformation(extent = {{-90,48},{-70,68}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression[3](each y = 1) annotation(Placement(transformation(extent = {{-32,-24},{-12,-4}})));
  HalfBridgeLogic halfBridgeLogic[3] annotation(Placement(transformation(extent = {{20,-10},{40,10}})));
equation
  connect(angle,combiTable1Ds.u) annotation(Line(points = {{-100,0},{-62,0}}, color = {0,0,127}, smooth = Smooth.None));
  connect(const.y,pulseWidth.dutyCycle) annotation(Line(points = {{-69,88},{-48,88},{-48,92},{-30,92}}, color = {0,0,127}, smooth = Smooth.None));
  connect(const2.y,pulseWidth.periodTime) annotation(Line(points = {{-69,58},{-54,58},{-54,84},{-30,84}}, color = {0,0,127}, smooth = Smooth.None));
  connect(combiTable1Ds.y,halfBridgeLogic.val) annotation(Line(points = {{-39,0},{20,0}}, color = {0,0,127}, smooth = Smooth.None));
  connect(pulseWidth.y,halfBridgeLogic.pulses) annotation(Line(points = {{-10,84},{6,84},{6,7.8},{20,7.8}}, color = {255,0,255}, smooth = Smooth.None));
  connect(integerExpression.y,halfBridgeLogic.pwm_Mode) annotation(Line(points = {{-11,-14},{0,-14},{0,-8},{20,-8}}, color = {255,127,0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end TestCtrl3phPWM;
