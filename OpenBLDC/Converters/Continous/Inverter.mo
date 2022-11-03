within OpenBLDC.Converters.Continous;
model Inverter "Universal m-phase inverter (continous)"
  extends OpenBLDC.Interfaces.PartialInverter;
  parameter Modelica.Units.SI.Current IphaseMax = 1000 "Max phase current";
  replaceable OpenBLDC.Converters.Continous.PowerConverterVSk powerConverter[m](each IConverterMax = IphaseMax) annotation(Placement(visible = true, transformation(extent = {{-50, 0}, {-30, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput ctrl_h[m] "Commmand" annotation(Placement(visible = true, transformation(origin = {-20, 106}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(extent = {{-40, 86}, {0, 126}}, rotation = 270)));
  Modelica.Blocks.Interfaces.BooleanInput ctrl_l[m] annotation(
    Placement(visible = true, transformation(origin = {20, 106}, extent = {{-20, -20}, {20, 20}}, rotation = 270), iconTransformation(extent = {{0, 86}, {40, 126}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealOutput v[m] annotation(
    Placement(visible = true, transformation(origin = {-40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 270), iconTransformation(extent = {{-50, -110}, {-30, -90}}, rotation = 270)));
  Modelica.Blocks.Interfaces.RealOutput i[m] annotation(
    Placement(visible = true, transformation(origin = {40, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 270), iconTransformation(extent = {{30, -110}, {50, -90}}, rotation = 270)));
  OpenBLDC.Converters.Continous.SwitchFreeRunning switchFreeRunning annotation(
    Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(plugH.pin, powerConverter.pSupply);
  connect(plugL.pin, powerConverter.nSupply);
  connect(switchFreeRunning.plugIn.pin, powerConverter.pLoad);
  connect(powerConverter.nSupply, powerConverter.nLoad);
  connect(ctrl_h, powerConverter.ref) annotation(
    Line(points = {{-20, 106}, {-20, 10}, {-30, 10}}, color = {0, 0, 127}));
  connect(switchFreeRunning.plugH, plugH) annotation(
    Line(points = {{10, 4}, {-10, 4}, {-10, 40}, {-100, 40}}, color = {0, 0, 255}));
  connect(switchFreeRunning.plugL, plugL) annotation(
    Line(points = {{10, -4}, {-10, -4}, {-10, -40}, {-100, -40}}, color = {0, 0, 255}));
  connect(switchFreeRunning.plug_p, plug_p) annotation(
    Line(points = {{30, 0}, {100, 0}}, color = {0, 0, 255}));
  connect(switchFreeRunning.v, v) annotation(
    Line(points = {{16, -10}, {16, -80}, {-40, -80}, {-40, -100}}, color = {0, 0, 127}, thickness = 0.5));
  connect(switchFreeRunning.i, i) annotation(
    Line(points = {{24, -10}, {24, -80}, {40, -80}, {40, -100}}, color = {0, 0, 127}, thickness = 0.5));
  connect(ctrl_l, switchFreeRunning.ctrl) annotation(
    Line(points = {{20, 106}, {20, 8}}, color = {255, 0, 255}, thickness = 0.5));
  annotation(Diagram(graphics),
    Icon(graphics = {Text(lineColor = {0, 0, 255}, extent = {{-50, -60}, {-30, -90}}, textString = "v"), Text(lineColor = {0, 0, 255}, extent = {{30, -60}, {50, -90}}, textString = "i")}));
end Inverter;