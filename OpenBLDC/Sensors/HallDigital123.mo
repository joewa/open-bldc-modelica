within OpenBLDC.Sensors;
model HallDigital123 "3 hall sensors"
  extends OpenBLDC.Icons.Sensor;
  import Modelica.Constants.pi;
  parameter Modelica.Units.SI.Angle hall_angle[3] = {(1 / 2 - 2 / 3) * pi,(1 / 2 + 0) * pi,(1 / 2 + 2 / 3) * pi}
    "Hall sensor is mounted at this electrical angle and outputs true";
  parameter Real Ppz = 1 "Sensor pairs of poles";
  Modelica.Mechanics.Rotational.Components.IdealGear hallGear(ratio = Ppz)
    "Virtual gear to provide the pairs of poles property";
  OpenBLDC.Sensors.HallDigital1 hallA(hall_angle = hall_angle[1]);
  OpenBLDC.Sensors.HallDigital1 hallB(hall_angle = hall_angle[2]);
  OpenBLDC.Sensors.HallDigital1 hallC(hall_angle = hall_angle[3]);
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
    "Flange to be measured"                                                        annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput y[3] annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
equation
  connect(flange,hallGear.flange_b);
  connect(hallGear.flange_a,hallA.flange);
  connect(hallGear.flange_a,hallB.flange);
  connect(hallGear.flange_a,hallC.flange);
  connect(hallA.y,y[1]);
  connect(hallB.y,y[2]);
  connect(hallC.y,y[3]);
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = false), graphics={  Text(extent = {{-150.0,-140.0},{150.0,-110.0}}, fillColor = {0,0,0}, textString = "%3ph Hall sensor")}), Diagram(coordinateSystem(extent = {{-100.0,-100.0},{100.0,100.0}})));
end HallDigital123;
