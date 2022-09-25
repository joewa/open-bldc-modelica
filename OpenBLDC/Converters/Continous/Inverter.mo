within OpenBLDC.Converters.Continous;
model Inverter "Universal m-phase inverter (continous)"
  extends OpenBLDC.Interfaces.PartialInverter;
  parameter Modelica.Units.SI.Current IphaseMax = 1000 "Max phase current";
  replaceable OpenBLDC.Converters.Continous.PowerConverterVSk powerConverter[m](each IConverterMax = IphaseMax) annotation(Placement(visible = true, transformation(extent = {{-50, 0}, {-30, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput ctrl_h[m] "Commmand" annotation(Placement(visible = true, transformation(origin = {-20, 106}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(extent = {{-40, 86}, {0, 126}}, rotation = 270)));
  Modelica.Blocks.Interfaces.BooleanInput ctrl_l[m] annotation(
    Placement(visible = true, transformation(origin = {20, 106}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(extent = {{0, 86}, {40, 126}}, rotation = 270)));
  OpenBLDC.Converters.SwitchingIdeal.Inverter inverterSwitching annotation(
    Placement(visible = true, transformation(origin = {10, -9}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant lowSideSwitchAwaysOff[m](each k = false)  annotation(
    Placement(visible = true, transformation(origin = {40, 21}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput v[m] annotation(
    Placement(visible = true, transformation(origin = {-40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 270), iconTransformation(extent = {{-50, -110}, {-30, -90}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealOutput i[m] annotation(
    Placement(visible = true, transformation(origin = {40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 270), iconTransformation(extent = {{30, -110}, {50, -90}}, rotation = 270)));
equation
  connect(plugH.pin,powerConverter.pSupply);
  connect(plugL.pin,powerConverter.nSupply);
  connect(inverterSwitching.plugH.pin,powerConverter.pLoad);
  connect(powerConverter.nSupply,powerConverter.nLoad);
  connect(ctrl_h,powerConverter.ref) annotation(Line(points = {{-20, 106}, {-20, 10}, {-30, 10}}, color = {0,0,127}));
  connect(ctrl_l, inverterSwitching.ctrl_h) annotation(
    Line(points = {{20, 106}, {20, 50}, {8, 50}, {8, 2}}, color = {255, 0, 255}, thickness = 0.5));
  connect(inverterSwitching.plug_p, plug_p) annotation(
    Line(points = {{20, -9}, {49, -9}, {49, 0}, {100, 0}}, color = {0, 0, 255}));
  connect(inverterSwitching.plugL, plugL) annotation(
    Line(points = {{0, -13}, {-50, -13}, {-50, -40}, {-100, -40}}, color = {0, 0, 255}));
  connect(lowSideSwitchAwaysOff.y, inverterSwitching.ctrl_l) annotation(
    Line(points = {{29, 21}, {12, 21}, {12, 2}}, color = {255, 0, 255}, thickness = 0.5));
  connect(inverterSwitching.v, v) annotation(
    Line(points = {{6, -19}, {6, -70}, {-40, -70}, {-40, -100}}, color = {0, 0, 127}, thickness = 0.5));
  connect(inverterSwitching.i, i) annotation(
    Line(points = {{14, -19}, {14, -70}, {40, -70}, {40, -100}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(Diagram(graphics),
    Icon(graphics = {Text(lineColor = {0, 0, 255}, extent = {{-50, -60}, {-30, -90}}, textString = "v"), Text(lineColor = {0, 0, 255}, extent = {{30, -60}, {50, -90}}, textString = "i")}));
end Inverter;