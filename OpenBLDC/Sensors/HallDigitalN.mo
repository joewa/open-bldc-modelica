within OpenBLDC.Sensors;
model HallDigitalN "m hall sensors"
  extends OpenBLDC.Icons.Sensor;
  import Modelica.Constants.pi;
  parameter Integer m = 3 "Number of phases";
  parameter Modelica.SIunits.Angle hall_angle[m] = {(1 / 2 - 2 / 3) * pi,(1 / 2 + 0) * pi,(1 / 2 + 2 / 3) * pi}
    "Hall sensor is mounted at this electrical angle and outputs true";
  parameter Real Ppz = 1 "Sensor pairs of poles";
  Modelica.Mechanics.Rotational.Components.IdealGear hallGear(ratio = Ppz)
    "Virtual gear to provide the pairs of poles property";
  OpenBLDC.Sensors.HallDigital1 hallSensors[m](hall_angle = hall_angle);

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
    "Flange to be measured"                                                        annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput y[m] annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
equation
  connect(flange,hallGear.flange_b);
  for i in 1:m loop
    connect(hallGear.flange_a,hallSensors[i].flange);
    connect(hallSensors[i].y,y[i]);
  end for;
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = false), graphics={  Text(extent = {{-150.0,-140.0},{150.0,-110.0}}, fillColor = {0,0,0}, textString = "%3ph Hall sensor")}), Diagram(coordinateSystem(extent={{-100,
            -100},{100,100}}, preserveAspectRatio=false), graphics));
end HallDigitalN;
