within OpenBLDC.Blocks;
block TestCtrl3ph
  Modelica.Blocks.Interfaces.BooleanOutput hCtrl[3] annotation(Placement(transformation(extent = {{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl[3] annotation(Placement(transformation(extent = {{90,-70},{110,-50}})));
  Modelica.Blocks.Interfaces.RealInput angle "Decoded hall" annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  HalfBridgeCtrl halfBridgeCtrl_a annotation(Placement(transformation(extent = {{40,40},{60,60}})));
  HalfBridgeCtrl halfBridgeCtrl_b annotation(Placement(transformation(extent = {{40,-10},{60,10}})));
  HalfBridgeCtrl halfBridgeCtrl_c annotation(Placement(transformation(extent = {{40,-70},{60,-50}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(table = [1,1,-1,0;2,0,-1,1;3,-1,0,1;4,-1,1,0;5,0,1,-1;6,1,0,-1]) annotation(Placement(transformation(extent = {{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Constant const annotation(Placement(transformation(extent = {{-56,60},{-36,80}})));
equation
  connect(halfBridgeCtrl_a.hCtrl,hCtrl[1]) annotation(Line(points = {{60,56},{78,56},{78,53.3333},{100,53.3333}}, color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeCtrl_b.hCtrl,hCtrl[2]) annotation(Line(points = {{60,6},{78,6},{78,60},{100,60}}, color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeCtrl_c.hCtrl,hCtrl[3]) annotation(Line(points = {{60,-54},{76,-54},{76,66.66670000000001},{100,66.66670000000001}}, color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeCtrl_a.lCtrl,lCtrl[1]) annotation(Line(points = {{60,44},{84,44},{84,-66.66670000000001},{100,-66.66670000000001}}, color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeCtrl_b.lCtrl,lCtrl[2]) annotation(Line(points = {{60,-6},{84,-6},{84,-60},{100,-60}}, color = {255,0,255}, smooth = Smooth.None));
  connect(halfBridgeCtrl_c.lCtrl,lCtrl[3]) annotation(Line(points = {{60,-66},{76,-66},{76,-53.3333},{100,-53.3333}}, color = {255,0,255}, smooth = Smooth.None));
  connect(angle,combiTable1Ds.u) annotation(Line(points = {{-100,0},{-62,0}}, color = {0,0,127}, smooth = Smooth.None));
  connect(combiTable1Ds.y[1],halfBridgeCtrl_a.val) annotation(Line(points = {{-39,-0.666667},{0,-0.666667},{0,50},{40,50}}, color = {0,0,127}, smooth = Smooth.None));
  connect(combiTable1Ds.y[2],halfBridgeCtrl_b.val) annotation(Line(points = {{-39,0},{40,0}}, color = {0,0,127}, smooth = Smooth.None));
  connect(combiTable1Ds.y[3],halfBridgeCtrl_c.val) annotation(Line(points = {{-39,0.666667},{0,0.666667},{0,-60},{40,-60}}, color = {0,0,127}, smooth = Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end TestCtrl3ph;