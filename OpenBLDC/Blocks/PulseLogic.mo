within OpenBLDC.Blocks;
model PulseLogic "Generates PWM signal depending on commutation and speed"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  Modelica.Blocks.Interfaces.RealInput dutyCycle annotation(Placement(transformation(extent = {{-120,60},{-80,100}})));
  Modelica.Blocks.Interfaces.RealInput bridgeModeIn[3] annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanInput active annotation(Placement(transformation(extent = {{-120,-100},{-80,-60}})));
  Modelica.Blocks.Interfaces.BooleanOutput y "PWM output" annotation(Placement(transformation(extent = {{90,70},{110,90}})));
  Modelica.Blocks.Interfaces.RealOutput bridgeModeOut[3] annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  PulseWidthVar pulseWidth annotation(Placement(transformation(extent = {{8,48},{28,68}})));
  Modelica.Blocks.Sources.Constant const2(each k = 2.5e-005) annotation(Placement(transformation(extent = {{-46,40},{-26,60}})));
equation
  connect(const2.y,pulseWidth.periodTime) annotation(Line(points = {{-25,50},{-8,50},{-8,58},{8,58}}, color = {0,0,127}, smooth = Smooth.None));
  connect(pulseWidth.y,y) annotation(Line(points = {{28,58},{62,58},{62,80},{100,80}}, color = {255,0,255}, smooth = Smooth.None));
  connect(dutyCycle,pulseWidth.dutyCycle) annotation(Line(points = {{-100,80},{-46,80},{-46,66},{8,66}}, color = {0,0,127}, smooth = Smooth.None));
  connect(bridgeModeIn,bridgeModeOut) annotation(Line(points = {{-100,0},{100,0}}, color = {0,0,127}, smooth = Smooth.None));
  connect(active,pulseWidth.active) annotation(Line(points = {{-100,-80},{-4,-80},{-4,50},{8,50}}, color = {255,0,255}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end PulseLogic;
