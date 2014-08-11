within OpenBLDC.Blocks;
block PhaseDiffVoltage "Calculates real terminal voltages"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput u[3] annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[3] annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
equation
  y[1] = u[2] - u[1];
  y[2] = u[3] - u[2];
  y[3] = u[1] - u[3];
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end PhaseDiffVoltage;
