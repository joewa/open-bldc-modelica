within OpenBLDC.Interfaces;
expandable connector PwmControlBusConnectorOut "Bus connector for a pwm block"
  extends OpenBLDC.Icons.BusOut;
  output Real dutyCycle;
  output Real period;
  output Boolean pulses;
  output Boolean active;
  output Boolean reset;
end PwmControlBusConnectorOut;
