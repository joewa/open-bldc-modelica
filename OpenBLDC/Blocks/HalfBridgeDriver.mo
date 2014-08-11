within OpenBLDC.Blocks;
block HalfBridgeDriver "Half bridge driver, e.g. IR2184"
  extends Modelica.Blocks.Icons.BooleanBlock;
  Modelica.Blocks.Interfaces.BooleanOutput hCtrl annotation(Placement(transformation(extent = {{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl annotation(Placement(transformation(extent = {{90,-70},{110,-50}})));
  Modelica.Blocks.Interfaces.BooleanInput pin_IN
    "Pulses from the PWM generator"                                              annotation(Placement(transformation(extent = {{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.BooleanInput pin_SD "Shutdown inverted" annotation(Placement(transformation(extent = {{-120,-80},{-80,-40}})));
equation
  hCtrl = pin_IN and pin_SD;
  lCtrl = not pin_IN and pin_SD;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end HalfBridgeDriver;
