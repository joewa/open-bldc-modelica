within OpenBLDC.Blocks;
block PhaseDiffVoltageNph "Calculates real terminal voltages"
  extends Modelica.Blocks.Icons.Block;
  parameter Integer m = 3 "Number of phases";
  Modelica.Blocks.Interfaces.RealInput u[m] annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[m] annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
equation
  for i in 1:(m-1) loop
    y[i] = u[i+1] - u[i];
  end for;
  y[m] = u[1] - u[m];
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics));
end PhaseDiffVoltageNph;
