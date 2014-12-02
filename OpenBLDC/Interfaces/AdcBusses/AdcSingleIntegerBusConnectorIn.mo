within OpenBLDC.Interfaces.AdcBusses;
expandable connector AdcSingleIntegerBusConnectorIn
  "Bus connector for a single channel analog digital converter (integer type)"
  extends OpenBLDC.Icons.BusIn;
  parameter Integer BufDepth(final min=1) = 1 "ADC buffer depth";
  input Integer buffer[BufDepth];
  output Boolean active "Activates the ADC conversion";
  input Boolean cbStart "Triggers the callback function to evaluate the buffer";
end AdcSingleIntegerBusConnectorIn;
