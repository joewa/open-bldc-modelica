within OpenBLDC.Assemblies;
model HallSensor_Test "Hall sensor mounted on a shaft"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m = 3 "Number of phases";
  Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet smpm annotation(Placement(transformation(extent = {{-36,-12},{-16,8}})));
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData annotation(Placement(transformation(extent = {{-32,-64},{-12,-44}})));
  Sensors.HallDigital123 hallDigital123 annotation(Placement(transformation(extent = {{12,-38},{32,-18}})));
equation
  connect(smpm.flange,hallDigital123.flange) annotation(Line(points = {{-16,-2},{-2,-2},{-2,-28},{12,-28}}, color = {0,0,0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end HallSensor_Test;