within OpenBLDC.Tests;
model ConstantSpeed_Hall "Constant speed demonstrate hall sensor commutation - MSL4-OK"
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  constant Integer m = 3 "Number of phases";
  Modelica.Electrical.Machines.BasicMachines.SynchronousMachines.SM_PermanentMagnet
                                                                                             smpm annotation(Placement(transformation(extent = {{-36,-12},{-16,8}})));
  parameter Modelica.Electrical.Machines.Utilities.SynchronousMachineData smeeData annotation(Placement(transformation(extent = {{-44,-50},{-24,-30}})));
  Sensors.HallDigital123 hallDigital123_1 annotation(Placement(transformation(extent = {{12,-38},{32,-18}})));
equation
  connect(smpm.flange,hallDigital123_1.flange) annotation(Line(points = {{-16,-2},{-2,-2},{-2,-28},{12,-28}}, color = {0,0,0}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end ConstantSpeed_Hall;
