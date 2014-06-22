within OpenBLDC.Blocks;
block HallDecode "Hall look up table"
  Modelica.Blocks.Interfaces.RealInput u[3] "Hall sensor vals (0 or 1)" annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}})));
  Modelica.Blocks.Interfaces.RealOutput y[1] "decoded angle" annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Blocks.Math.Add3 add3_1 annotation(Placement(transformation(extent = {{0, -10}, {20, 10}})));
  Modelica.Blocks.Math.Gain gain(k = 1) annotation(Placement(transformation(extent = {{-50, -40}, {-30, -20}})));
  Modelica.Blocks.Math.Gain gain1(k = 2) annotation(Placement(transformation(extent = {{-50, -10}, {-30, 10}})));
  Modelica.Blocks.Math.Gain gain2(k = 4) annotation(Placement(transformation(extent = {{-50, 20}, {-30, 40}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table = [1, 4; 2, 2; 3, 3; 4, 6; 5, 5; 6, 1]) annotation(Placement(transformation(extent = {{40, -10}, {60, 10}})));
equation
  connect(gain.u, u[1]) annotation(Line(points = {{-52, -30}, {-76, -30}, {-76, -13.3333}, {-100, -13.3333}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(gain1.u, u[2]) annotation(Line(points = {{-52, 0}, {-100, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(gain2.u, u[3]) annotation(Line(points = {{-52, 30}, {-74, 30}, {-74, 13.3333}, {-100, 13.3333}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(gain2.y, add3_1.u1) annotation(Line(points = {{-29, 30}, {-16, 30}, {-16, 8}, {-2, 8}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(gain1.y, add3_1.u2) annotation(Line(points = {{-29, 0}, {-2, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(gain.y, add3_1.u3) annotation(Line(points = {{-29, -30}, {-16, -30}, {-16, -8}, {-2, -8}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(combiTable1D.u[1], add3_1.y) annotation(Line(points = {{38, 0}, {21, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(combiTable1D.y[1], y[1]) annotation(Line(points = {{61, 0}, {100, 0}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end HallDecode;

