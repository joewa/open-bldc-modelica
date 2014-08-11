within OpenBLDC.Blocks;
model PulseControlSelector "Select input 1 when true"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  Modelica.Blocks.Interfaces.BooleanOutput activeOut annotation(Placement(transformation(extent = {{90,-90},{110,-70}})));
  Modelica.Blocks.Interfaces.RealOutput bridgeModeOut[3] annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealOutput dutyCycleOut annotation(Placement(transformation(extent = {{90,70},{110,90}})));
  Modelica.Blocks.Interfaces.RealInput dutyCycleIn1 annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {-60,-100})));
  Modelica.Blocks.Interfaces.BooleanInput select2 annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanInput activeIn1 annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {60,-100})));
  Modelica.Blocks.Interfaces.RealInput bridgeModeIn1[3] annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 90, origin = {0,-100})));
  Modelica.Blocks.Interfaces.RealInput dutyCycleIn2 annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {-60,100})));
  Modelica.Blocks.Interfaces.BooleanInput activeIn2 annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {60,100})));
  Modelica.Blocks.Interfaces.RealInput bridgeModeIn2[3] annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {0,100})));
equation
  activeOut = if select2 then activeIn2 else activeIn1;
  bridgeModeOut = if select2 then bridgeModeIn2 else bridgeModeIn1;
  dutyCycleOut = if select2 then dutyCycleIn2 else dutyCycleIn1;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end PulseControlSelector;
