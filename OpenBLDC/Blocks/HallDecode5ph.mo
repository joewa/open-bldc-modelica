within OpenBLDC.Blocks;
block HallDecode5ph "Hall look up table"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput u[5] "Hall sensor vals (0 or 1)" annotation(Placement(transformation(extent = {{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput y[1] "decoded angle" annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Modelica.Blocks.Math.Add3 add3_1 annotation(Placement(transformation(extent = {{0,-10},{20,10}})));
  Modelica.Blocks.Math.Gain gain(k = 1) annotation(Placement(transformation(extent={{-60,-70},
            {-40,-50}})));
  Modelica.Blocks.Math.Gain gain1(k = 2) annotation(Placement(transformation(extent={{-60,-40},
            {-40,-20}})));
  Modelica.Blocks.Math.Gain gain2(k = 4) annotation(Placement(transformation(extent={{-60,-10},
            {-40,10}})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(table=[3,6; 6,4; 7,5; 12,2;
        14,3; 17,8; 19,7; 24,10; 25,9; 28,1])                                         annotation(Placement(transformation(extent = {{40,-10},{60,10}})));
  Modelica.Blocks.Math.Gain gain3(k=8)   annotation(Placement(transformation(extent={{-60,20},
            {-40,40}})));
  Modelica.Blocks.Math.Add3 add3_2 annotation(Placement(transformation(extent={{0,24},{
            20,44}})));
  Modelica.Blocks.Math.Gain gain4(k=16)  annotation(Placement(transformation(extent={{-60,50},
            {-40,70}})));
equation
  connect(gain.u,u[1]) annotation(Line(points={{-62,-60},{-76,-60},{-76,-16},{
          -100,-16}},                                                                                 color = {0,0,127}, smooth = Smooth.None));
  connect(gain1.u,u[2]) annotation(Line(points={{-62,-30},{-76,-30},{-76,-8},{
          -100,-8}},                                                 color = {0,0,127}, smooth = Smooth.None));
  connect(gain2.u,u[3]) annotation(Line(points={{-62,0},{-100,0}},                                 color = {0,0,127}, smooth = Smooth.None));
  connect(gain1.y,add3_1.u2) annotation(Line(points={{-39,-30},{-14,-30},{-14,0},
          {-2,0}},                                                      color = {0,0,127}, smooth = Smooth.None));
  connect(gain.y,add3_1.u3) annotation(Line(points={{-39,-60},{-10,-60},{-10,-8},
          {-2,-8}},                                                                          color = {0,0,127}, smooth = Smooth.None));
  connect(combiTable1D.u[1],add3_1.y) annotation(Line(points = {{38,0},{21,0}}, color = {0,0,127}, smooth = Smooth.None));
  connect(combiTable1D.y[1],y[1]) annotation(Line(points = {{61,0},{100,0}}, color = {0,0,127}, smooth = Smooth.None));
  connect(add3_2.y, add3_1.u1) annotation (Line(
      points={{21,34},{22,34},{22,18},{-2,18},{-2,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain3.u, u[4]) annotation (Line(
      points={{-62,30},{-78,30},{-78,8},{-100,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain4.u, u[5]) annotation (Line(
      points={{-62,60},{-80,60},{-80,16},{-100,16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain2.y, add3_2.u3) annotation (Line(
      points={{-39,0},{-22,0},{-22,26},{-2,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain3.y, add3_2.u2) annotation (Line(
      points={{-39,30},{-20,30},{-20,34},{-2,34}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain4.y, add3_2.u1) annotation (Line(
      points={{-39,60},{-22,60},{-22,42},{-2,42}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics));
end HallDecode5ph;
