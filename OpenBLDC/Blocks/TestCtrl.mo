within OpenBLDC.Blocks;
block TestCtrl
  Modelica.Blocks.Interfaces.BooleanOutput hCtrl annotation(Placement(transformation(extent = {{90, 70}, {110, 90}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  OpenBLDC.Blocks.Triangular triangular(amplitude = 1, period(displayUnit = "ms") = 0.01) annotation(Placement(transformation(extent = {{-80, 50}, {-60, 70}})));
  Modelica.Blocks.Logical.Not not1 annotation(Placement(transformation(extent = {{20, 50}, {40, 70}})));
  Modelica.Blocks.Logical.Greater greater annotation(Placement(transformation(extent = {{-20, 50}, {0, 70}})));
  Modelica.Blocks.Sources.Constant const(k = 0) annotation(Placement(transformation(extent = {{-82, 22}, {-62, 42}})));
  Modelica.Blocks.Interfaces.RealInput angle "Decoded hall" annotation(Placement(transformation(extent = {{-120, -20}, {-80, 20}})));
equation
  connect(triangular.y, greater.u1) annotation(Line(points = {{-59.4, 64}, {-40.7, 64}, {-40.7, 60}, {-22, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(greater.y, not1.u) annotation(Line(points = {{1, 60}, {18, 60}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(not1.y, lCtrl) annotation(Line(points = {{41, 60}, {70, 60}, {70, 0}, {100, 0}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(greater.y, hCtrl) annotation(Line(points = {{1, 60}, {10, 60}, {10, 80}, {100, 80}}, color = {255, 0, 255}, smooth = Smooth.None));
  connect(const.y, greater.u2) annotation(Line(points = {{-61, 32}, {-42, 32}, {-42, 52}, {-22, 52}}, color = {0, 0, 127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end TestCtrl;

