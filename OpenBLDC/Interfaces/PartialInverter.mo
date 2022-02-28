within OpenBLDC.Interfaces;
partial model PartialInverter "Universal m-phase inverter"
  extends OpenBLDC.Icons.Converter;
  import Modelica.Units.SI;
  parameter Integer m(min = 1) = 3 "Number of phases";
  parameter SI.Resistance RonSwitch = 1e-005 "Ron of Switch";
  parameter SI.Conductance GoffSwitch = 1e-005 "Gon of Switch";
  parameter SI.Resistance RonDiode = 1e-005 "Ron of Diode";
  parameter SI.Conductance GoffDiode = 1e-005 "Gon of Diode";
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(m = m) annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plugH(m = m) annotation(Placement(transformation(extent = {{-110,30},{-90,50}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plugL(m = m) annotation(Placement(transformation(extent = {{-110,-50},{-90,-30}})));
protected
  parameter SI.Resistance ronSwitch[:] = fill(RonSwitch, m);
  parameter SI.Conductance goffSwitch[:] = fill(GoffSwitch, m);
  parameter SI.Resistance ronDiode[:] = fill(RonDiode, m);
  parameter SI.Conductance goffDiode[:] = fill(GoffDiode, m);
  parameter SI.Voltage vknee[:] = fill(0, m);
  annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics), DymolaStoredErrors, Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end PartialInverter;
