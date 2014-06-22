within OpenBLDC.Tests;
model TestPWM "Test function of Blocks.PulseWidth"
  extends Modelica.Icons.Example;
  OpenBLDC.Blocks.PulseWidthVar pulseWidthVar annotation(Placement(transformation(extent = {{-18, 12}, {2, 32}})));
  Real x(start = 0);
  Boolean mysample;
equation
  1 = der(x);
  pulseWidthVar.periodTime = 0.5;
  pulseWidthVar.dutyCycle = 0.25;
  mysample = time > Modelica.Constants.small;
  pulseWidthVar.active = mysample;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end TestPWM;

