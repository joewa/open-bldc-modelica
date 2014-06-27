within OpenBLDC.Converters.Continous;
model PowerConverterVSk "Sets output voltage whilst keeping in- and output power equal"
  extends OpenBLDC.Interfaces.SupplyPort;
  extends OpenBLDC.Interfaces.LoadPort;
  Modelica.Blocks.Interfaces.RealInput ref "Gain of input voltage" annotation(Placement(transformation(extent = {{-20,-20},{20,20}}, rotation = 180, origin = {106,0}), iconTransformation(extent = {{-20,-20},{20,20}}, rotation = 180, origin = {96,0})));
equation
  vLoad = kRef * vSupply;
  powerSupply = powerLoad;
  annotation(Icon(graphics), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end PowerConverterVSk;