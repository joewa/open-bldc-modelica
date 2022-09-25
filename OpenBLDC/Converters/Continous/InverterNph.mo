within OpenBLDC.Converters.Continous;

model InverterNph "m-phase continuous inverter (wrapper)"
  extends OpenBLDC.Converters.Partial.InverterNph;
  Modelica.Blocks.Interfaces.RealInput ctrl_h[m] annotation(
      Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 270, origin = {-20,106})));
  Inverter inverter(m = m) annotation(Placement(transformation(extent = {{-22,-10},{0,10}})));
equation
  connect(ctrl_l,inverter.ctrl_l) annotation(
      Line(points = {{20,106},{20,80},{-8.800000000000001,80},{-8.800000000000001,10.6}},
      color = {255,0,255},
      smooth = Smooth.None));
  connect(ctrl_h,inverter.ctrl_h) annotation(
      Line(points = {{-20, 106}, {-20, 80}, {-13, 80}, {-13, 11}},
      color = {0, 0, 127},
      thickness = 0.5));
  connect(star_p.plug_p,inverter.plugH) annotation(
      Line(points = {{-60,40},{-42,40},{-42,4},{-22,4}},
      color = {0,0,255},
      smooth = Smooth.None));
  connect(star_n.plug_p,inverter.plugL) annotation(
      Line(points = {{-62,-40},{-46,-40},{-46,-4},{-22,-4}},
      color = {0,0,255},
      smooth = Smooth.None));
  connect(inverter.v,v) annotation(Line(
      points = {{-15.4,-10},{-16,-10},{-16,-70},{0,-70},{0,-100}},
      color = {0,0,127},
      smooth = Smooth.None));
  connect(inverter.i,i) annotation(Line(
      points = {{-6.6,-10},{-6,-10},{-6,-60},{40,-60},{40,-100}},
      color = {0,0,127},
      smooth = Smooth.None));
  connect(inverter.plug_p, plug_m) annotation (Line(
      points={{0,0},{100,0}},
      color={0,0,255},
      smooth=Smooth.None));
end InverterNph;