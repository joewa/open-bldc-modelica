within OpenBLDC.Interfaces.AdcBusses;
expandable connector AdcSingleIntegerBusConnectorOut
  "Bus connector for a single channel analog digital converter (integer type)"
  extends OpenBLDC.Icons.BusOut;
  parameter Integer BufDepth(final min=1) = 1 "ADC buffer depth";
  output Integer buffer[BufDepth];
  input Boolean active "Activates the ADC conversion";
  output Boolean cbStart
    "Triggers the callback function to evaluate the buffer";
end AdcSingleIntegerBusConnectorOut;
