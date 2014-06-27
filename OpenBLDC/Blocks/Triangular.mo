within OpenBLDC.Blocks;
block Triangular
  //extends Interfaces.SO;
  parameter Real amplitude = 1 "Amplitude of triangle";
  parameter Modelica.SIunits.Time period(final min = Modelica.Constants.small, start = 1) "Time for one period";
  parameter Modelica.SIunits.Time startTime = 0 "Output = offset for time < startTime";
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{96,30},{116,50}})));
protected
  Modelica.SIunits.Time T0(final start = startTime) "Start time of current period";
equation
  when sample(startTime, period) then
    T0 = time;
  end when;
  if time < startTime then
    y = 0;
  elseif time - T0 < period / 2 then
    y = 2 * amplitude / period * (time - T0);
  else
    y = 2 * amplitude - 2 * amplitude / period * (time - T0);
  end if;
  // Rise
  annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics));
end Triangular;