within OpenBLDC.MCUs;

model STM32F4pwmadcdma
  extends Modelica.Icons.Example;
  // Definitions from mcuconf.h
  parameter Modelica.Units.SI.Period t_s = F_ADCCLK*ADC_FRT_DEFAULT_PERIOD_CYCLES "Sample period";
  parameter Integer STM32_PLLSAIN_VALUE = 192;
  //Overclock288 96
  parameter Integer STM32_PLLSAIP_VALUE = 8;
  //Overclock288 4
  parameter Integer STM32_PLLM_VALUE = 4 "AHB prescaler -> HCLK 144MHz";
  parameter Integer STM32_PLLN_VALUE = 144 "APB1 prescaler -> PCLK1 36MHz (72MHz for TIM2, TIM3, TIM4, TIM5, TIM6, TIM7 and TIM12) Overclock288 STM32_PPRE1_DIV8";
  parameter Integer STM32_PLLP_VALUE = 2;
  parameter Real STM32_HPRE = 1.0;
  parameter Real STM32_PPRE1 = 0.25;
  parameter Real STM32_PPRE2 = 0.5;
  // ADC driver system settings.
  parameter Real STM32_ADC_ADCPRE = 0.5;
  // Additional definitions for ChibiESC Clock-Tree
  parameter Real f_HSE = 8000000 "HSE clock frequency";
  parameter Real f_STM32_SYSCLK = f_HSE/STM32_PLLM_VALUE*STM32_PLLN_VALUE/STM32_PLLP_VALUE;
  parameter Integer Ks_ADC_samplehold = 3 "ADC sampling (hold) cycles (see ADC_SMPRx registers)";
  parameter Integer Ks_ADC_conversion = 12 "ADC resolution / ADCCLK cycles for conversion";
  parameter Integer Ks_ADC = Ks_ADC_samplehold + Ks_ADC_conversion;
  parameter Real STM32_ADC_ADCPRESCALER = 2 + (2*STM32_ADC_ADCPRE);
  parameter Real F_ADCCLK = f_STM32_SYSCLK/2/STM32_ADC_ADCPRESCALER "Only when STM32_PPRE2_DIV2";
  // PWM configuration (see pwmadcdma.h)
  parameter Real ADC_PWM_DIVIDER = Ks_ADC*STM32_ADC_ADCPRESCALER "ADC_CCR_ADCPRE_DIV2 When f_TIM1 == f_TIM2 (*STM32_PPRE2 for f_TIM1 = f_SYSCLK)";
  parameter Real PWM_CLOCK_FREQUENCY = f_STM32_SYSCLK/2 "Low speed periph clock APB1! TIM1 connected to APB1!";
  // Define cycles!
  parameter Integer ADC_COMMUTATE_NUM_CHANNELS = 1 "Number of channels per ADC for (6-step mode)";
  parameter Integer ADC_FRT_DEFAULT_PERIOD_CYCLES = 100 "Fastest FRT cycle period in ADC cycles";
  parameter Integer PWM_ADC_DEFAULT_PERIOD_CYCLES = 20 "Choose a default number of ADC samples in a PWM period";
  parameter Integer PWM_ADC_MAXIMUM_PERIOD_CYCLES = 200 "Choose a maximum number of ADC samples in a PWM period (determines maximum PWM period)";
  parameter Integer ADC_COMMUTATE_BUF_DEPTH = ADC_COMMUTATE_NUM_CHANNELS*PWM_ADC_MAXIMUM_PERIOD_CYCLES*4;
  parameter Real PWM_FRT_DEFAULT_PERIOD_CYCLES = ADC_COMMUTATE_NUM_CHANNELS*ADC_PWM_DIVIDER*ADC_FRT_DEFAULT_PERIOD_CYCLES;
  parameter Real PWM_DEFAULT_PERIOD_CYCLES = ADC_COMMUTATE_NUM_CHANNELS*ADC_PWM_DIVIDER*PWM_ADC_DEFAULT_PERIOD_CYCLES;
  parameter Real PWM_MAXIMUM_PERIOD_CYCLES = ADC_COMMUTATE_NUM_CHANNELS*ADC_PWM_DIVIDER*PWM_ADC_MAXIMUM_PERIOD_CYCLES;
  //FRT_DEFAULT_FREQUENCY = PWM_CLOCK_FREQUENCY / PWM_FRT_DEFAULT_PERIOD_CYCLES
  parameter Real PWM_DEFAULT_FREQUENCY = PWM_CLOCK_FREQUENCY/PWM_DEFAULT_PERIOD_CYCLES;
  //PWM_MINIMUM_FREQUENCY = (PWM_CLOCK_FREQUENCY / PWM_MAXIMUM_PERIOD_CYCLES)
  // Fuer die Pulsmustererzeugung
  parameter Integer N_PWM_CHANNELS = 3;
  parameter Integer N_PWM_MAX_EDGES = 16;
  parameter Integer PWM_DMA_MAX_EDGES = 4*N_PWM_CHANNELS*N_PWM_MAX_EDGES "Number of pwm-channels * max number of edges per period (>=2, even number)";
  //Integer pwm_dma_timer_buffer[PWM_DMA_MAX_EDGES] "Buffer for the duration to the next pulse";
  //Integer pwm_dma_GPIOs_buffer[PWM_DMA_MAX_EDGES] "Buffer for a frame";
  // Timer 2 - internal registers
  // In upcounting mode, the counter counts from 0 to the auto-reload value (content of the
  // TIMx_ARR register), then restarts from 0 and generates a counter overflow event.
  // TODO (idea for later): Check if the "repetition counter" can help to reduce DMA load,
  // e.g. when the duty cycle is constant within a FRT period.
  // Real TIM2_CNT;
  // Real TIM2_ARR;// Auto reload register
  // Boolean UEV;  // Update event
  inner Modelica_DeviceDrivers.Blocks.Communication.TCPIPServerConfig tcpipserverconfig(maxClients = 1, port = 10002, useNonblockingMode = false) annotation(
    Placement(visible = true, transformation(origin = {-70, -70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetInteger getPwmDmaTimerBuffer(n = PWM_DMA_MAX_EDGES, nu = 1) annotation(
    Placement(visible = true, transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Communication.TCPIPServerSend tCPIPSend(autoBufferSize = false, blockUntilConnected = true, enableExternalTrigger = true, userBufferSize = 8) annotation(
    Placement(visible = true, transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica_DeviceDrivers.Blocks.Communication.TCPIPServerReceive tCPIPReceive(autoBufferSize = true, blockUntilConnected = true, clientIndex = 1, enableExternalTrigger = true, showAdvancedOutputs = true) annotation(
    Placement(visible = true, transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.BooleanExpression trigger(y = sample(0, t_s)) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-62, 20}, {-34, 40}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.Packager packager(enableExternalTrigger = true, useBackwardPropagatedBufferSize = false, useBackwardSampleTimePropagation = true, userBufferSize = 8) annotation(
    Placement(visible = true, transformation(origin = {-10, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddFloat addFloat(n = 2, nu = 1) annotation(
    Placement(visible = true, transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression pre_trigger(y = pre(trigger.y)) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{18, 20}, {46, 40}}, rotation = 0)));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetInteger getPwmDmaGPIOsBuffer(n = PWM_DMA_MAX_EDGES) annotation(
    Placement(visible = true, transformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
//  when initial() then
// TODO: consider reading these constants from the header files to avoid copy&pasting.
// PWM configuration
// ADC_CCR_ADCPRE_DIV2 When f_TIM1 == f_TIM2 (*STM32_PPRE2 for f_TIM1 = f_SYSCLK)
// Low speed periph clock APB1! TIM1 connected to APB1!
//  end when;
//pwm_dma_timer_buffer = getPwmDmaTimerBuffer.y;
//pwm_dma_GPIOs_buffer = getPwmDmaGPIOsBuffer.y;
  connect(tCPIPReceive.pkgOut, getPwmDmaTimerBuffer.pkgIn) annotation(
    Line(points = {{70, 20}, {70, 10}}));
  connect(trigger.y, tCPIPSend.trigger) annotation(
    Line(points = {{-32, 30}, {-28, 30}, {-28, -30}, {-22, -30}}, color = {255, 0, 255}));
  connect(addFloat.pkgOut[1], tCPIPSend.pkgIn) annotation(
    Line(points = {{-10, -10.8}, {-10, -20.8}}));
  connect(packager.pkgOut, addFloat.pkgIn) annotation(
    Line(points = {{-10, 19.2}, {-10, 9.2}}));
  connect(pre_trigger.y, tCPIPReceive.trigger) annotation(
    Line(points = {{48, 30}, {58, 30}}, color = {255, 0, 255}));
  connect(trigger.y, packager.trigger) annotation(
    Line(points = {{-32, 30}, {-22, 30}}, color = {255, 0, 255}));
  connect(getPwmDmaTimerBuffer.pkgOut[1], getPwmDmaGPIOsBuffer.pkgIn) annotation(
    Line(points = {{70, -10}, {70, -20}}));
  annotation(
    defaultComponentName = "stm32f4",
    defaultComponentPrefixes = "inner",
    missingInnerMessage = "No \"stm32f4\" component is defined. Cannot access MCU
    internal behavior.",
    Documentation(info = "<html><head></head><body><p>
Model <strong>STM32F4</strong> represents some of the peripherals of the STM32F4
MCU that are used in this project. This model serves several purposes:
</p>
<ul>
<li> It provides some parts the <strong>clock tree</strong> of the MCU which keeps e.g.
     the timers, ADC's and the DMA subsystem in sync.</li>
</ul>
<p>
Since the STM32F4 model is required from all subsystems such as timers and ADC's
and DMA. The basic declaration
needs to be:
</p>

<blockquote><pre><strong>inner</strong> OpenBLDC.MCUs.STM32F4 stm32f4
</pre></blockquote>

<p>
Note, it must be an <strong>inner</strong> declaration with instance name <strong>stm32f4</strong>
in order that this MCU object can be accessed from all objects in the
model. When dragging the \"STM32F4\" object from the package browser into
the diagram layer, this declaration is automatically generated
(this is defined via annotations).
</p><p>TODO: Send servoterm command strings via Modelica.</p>
</body></html>"),
    Diagram(graphics = {Text(origin = {89, 155}, textColor = {28, 108, 200}, extent = {{-147, -99}, {-27, -107}}, textString = "Ensure that receive is called before  send is called")}));
end STM32F4pwmadcdma;