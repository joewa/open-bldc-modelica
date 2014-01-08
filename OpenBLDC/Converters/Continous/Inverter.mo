within OpenBLDC.Converters.Continous;
model Inverter "Universal m-phase inverter (continous)"
extends OpenBLDC.Interfaces.PartialInverter;
  parameter Modelica.SIunits.Current IphaseMax = 1000 "Max phase current";
  replaceable OpenBLDC.Converters.Continous.PowerConverterVSk powerConverter[m](each
      IConverterMax=IphaseMax)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Interfaces.RealInput cmd[m] "Commmand" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
equation
  connect(plugH.pin, powerConverter.pSupply);
  connect(plugL.pin, powerConverter.nSupply);
  connect(plug_p.pin, powerConverter.pLoad);
  connect(powerConverter.nSupply, powerConverter.nLoad);
  connect(cmd, powerConverter.kRef) annotation (Line(
      points={{0,100},{0,10},{-20.4,10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics));
end Inverter;
