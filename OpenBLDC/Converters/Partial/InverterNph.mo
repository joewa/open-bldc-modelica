within OpenBLDC.Converters.Partial;

partial model InverterNph "m-phase inverter (wrapper)"
  extends Inverter;
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_m(m=m)
    "m-phase motor plug"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  connect(plug_m, r_sense_H.plug_p) annotation(
    Line(points = {{100, 0}, {6, 0}, {6, -14}}, color = {0, 0, 255}));
  annotation(Diagram(coordinateSystem(preserveAspectRatio=false,   extent={{-100,
            -100},{100,100}}),                                                                        graphics), DymolaStoredErrors, Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100,-100},{100,100}}), graphics));
end InverterNph;