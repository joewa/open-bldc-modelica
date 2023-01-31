within OpenBLDC.Sensors.ADCs;
block CircularBufferInteger "Circular buffer e.g. for use in the ADC model"
  extends Modelica.Blocks.Icons.DiscreteBlock;
  parameter Integer BufDepth(final min=1) = 50 "Buffer depth";
  Integer buffer[BufDepth](start=zeros(BufDepth)) "ADC buffer";
  Integer buf_ptr(start=1) "Pointer to sampled value";
  Modelica.Blocks.Interfaces.BooleanOutput cb "True when the buffer is full"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,100})));
  Modelica.Blocks.Interfaces.BooleanInput reset "Reset the buffer"
    annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,-80})));
  Modelica.Blocks.Interfaces.IntegerInput u
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.BooleanInput trigger "Samples new value from u"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100})));

  Modelica.Blocks.Interfaces.IntegerOutput y[BufDepth](start=zeros(BufDepth))
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.IntegerOutput ptr annotation(
    Placement(visible = true, transformation(origin = {-100, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0), iconTransformation(origin = {-100, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
algorithm
  when reset then // Reset ADC when deactivated
    buffer :=zeros(BufDepth);
    buf_ptr :=1;
  end when;

  when trigger then
    buffer[buf_ptr] :=u;
    buf_ptr :=buf_ptr + 1;
    if buf_ptr > BufDepth then
      buf_ptr :=1;
      cb :=true;
      y :=buffer;
    else
      cb :=false;
    end if;
  end when;
  ptr :=buf_ptr;

  annotation (Icon(
      coordinateSystem(preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        initialScale=0.1),
        graphics={
      Ellipse(
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid, extent = {{25, -10}, {45, 10}}),
      Line(points = {{-100, 0}, {-45, 0}},
        color={0,0,127}),
      Line(points = {{45, 0}, {100, 0}},
        color={0,0,127}),
      Line(points = {{0, -100}, {0, -26}},
        color={255,0,255}),
      Line(points = {{-35, 0}, {28, -48}},
        color={0,0,127}),
      Ellipse(
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid, extent = {{-45, -10}, {-25, 10}})}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),       graphics),
    Documentation(info="<html>
<p>This block implements a circular buffer with integer values.</p>
<p>A new value is read from u and written to the buffer each time the trigger rises. When the buffer is full, it is written to the output and can be evaluated by the callback function.</p>
</html>"));
end CircularBufferInteger;