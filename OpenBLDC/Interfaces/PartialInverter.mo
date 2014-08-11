within OpenBLDC.Interfaces;
partial model PartialInverter "Universal m-phase inverter"
  extends OpenBLDC.Icons.Converter;
  parameter Integer m(min = 1) = 3 "Number of phases";
  parameter Modelica.SIunits.Resistance RonSwitch = 1e-005 "Ron of Switch";
  parameter Modelica.SIunits.Conductance GoffSwitch = 1e-005 "Gon of Switch";
  parameter Modelica.SIunits.Resistance RonDiode = 1e-005 "Ron of Diode";
  parameter Modelica.SIunits.Conductance GoffDiode = 1e-005 "Gon of Diode";
  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plug_p(m = m) annotation(Placement(transformation(extent = {{90,-10},{110,10}})));
  Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plugH(m = m) annotation(Placement(transformation(extent = {{-110,30},{-90,50}})));
  Modelica.Electrical.MultiPhase.Interfaces.NegativePlug plugL(m = m) annotation(Placement(transformation(extent = {{-110,-50},{-90,-30}})));
protected
  parameter Modelica.SIunits.Resistance ronSwitch[:] = fill(RonSwitch, m);
  parameter Modelica.SIunits.Conductance goffSwitch[:] = fill(GoffSwitch, m);
  parameter Modelica.SIunits.Resistance ronDiode[:] = fill(RonDiode, m);
  parameter Modelica.SIunits.Conductance goffDiode[:] = fill(GoffDiode, m);
  parameter Modelica.SIunits.Voltage vknee[:] = fill(0, m);
  annotation(Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics), DymolaStoredErrors, Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end PartialInverter;
