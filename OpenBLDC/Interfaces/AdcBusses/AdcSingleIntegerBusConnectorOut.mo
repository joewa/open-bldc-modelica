within OpenBLDC.Interfaces.AdcBusses;
expandable connector AdcSingleIntegerBusConnectorOut
  "Bus connector for a single channel analog digital converter (integer type)"
  extends OpenBLDC.Icons.BusOut;
  parameter Integer ADC_SQR_L(final min=1) = 1 "Regular channel sequence length";
  parameter Integer BufDepth(final min=1) = ADC_SQR_L "ADC buffer depth";
  output Integer buffer[BufDepth];
  //input Integer adc_sqr[ADC_SQR_L] "ADC regular sequence register";
  input Boolean active "Activates the ADC conversion";
  output Boolean cbStart
    "Triggers the callback function to evaluate the buffer";
end AdcSingleIntegerBusConnectorOut;
