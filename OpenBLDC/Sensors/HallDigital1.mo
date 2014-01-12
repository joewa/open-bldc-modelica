within OpenBLDC.Sensors;
model HallDigital1 "Digital hall sensor"
  extends OpenBLDC.Icons.Sensor;
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Angle hall_angle = 0
    "Hall sensor is mounted at this electrical angle and outputs true";
  Modelica.SIunits.Angle phi_el;
  Real y_inside;
  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange
    "Flange to be measured"                                                        annotation(Placement(transformation(extent = {{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput y annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
equation
  phi_el = flange.phi;
  0 = flange.tau;
  //y_inside = if sin( phi_el + hall_angle - pi/2) > 0 then 1 else 0; // funzt nicht
  y_inside = sin(phi_el + hall_angle + pi / 2);
  y = if y_inside <= 0.0 then 1 else 0;
  // funzt
  annotation(Icon(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = false), graphics = {Text(extent=  {{-150.0,-140.0},{150.0,-110.0}}, fillColor=  {0,0,0}, textString=  "%Hall sensor")}), Diagram(coordinateSystem(extent = {{-100,-100},{100,100}}, preserveAspectRatio = false), graphics));
end HallDigital1;

