within OpenBLDC.Converters.Continous;

model Inverter3ph
  extends OpenBLDC.Converters.SwitchingIdeal.Inverter3ph(
      redeclare InverterNph inverterNph, redeclare Modelica.Blocks.Interfaces.RealInput ctrl_h
      );
equation

end Inverter3ph;