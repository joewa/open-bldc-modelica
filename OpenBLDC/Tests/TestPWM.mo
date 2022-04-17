within OpenBLDC.Tests;
model TestPWM "Test function of Blocks.PulseWidth - MSL4-OK"
  extends Modelica.Icons.Example;
  OpenBLDC.Blocks.PulseWidthVar pulseWidthVar annotation(Placement(transformation(extent = {{-18,12},{2,32}})));
  parameter Real dutyCycle = 0.25 "duty cycle";
  parameter Real periodTime = 0.5 "period time";
  Real x(start = 0);
  Boolean mysample;
equation
  1 = der(x);
  pulseWidthVar.periodTime = periodTime;
  pulseWidthVar.dutyCycle = dutyCycle;
  mysample = time > Modelica.Constants.small;
  pulseWidthVar.active = mysample;
  pulseWidthVar.reset = mysample;
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end TestPWM;
