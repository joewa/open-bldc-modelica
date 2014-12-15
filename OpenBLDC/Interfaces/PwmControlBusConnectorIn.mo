within OpenBLDC.Interfaces;
expandable connector PwmControlBusConnectorIn "Bus connector for the pwm block"
  extends OpenBLDC.Icons.BusIn;
  input Real dutyCycle;
  input Real period;
  input Boolean pulses;
  input Boolean active;
  input Boolean reset;
end PwmControlBusConnectorIn;
