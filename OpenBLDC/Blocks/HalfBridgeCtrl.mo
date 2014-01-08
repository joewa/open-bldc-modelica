within OpenBLDC.Blocks;
block HalfBridgeCtrl "Activates half bridge gates"

  Modelica.Blocks.Interfaces.BooleanOutput hCtrl
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput lCtrl
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Blocks.Interfaces.RealInput val "0 or > 0 or < 0"
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
equation
  if (val > 0.5) then
    hCtrl = true;
    lCtrl = false;
  elseif (val < -0.5) then
    hCtrl = false;
    lCtrl = true;
  else
    hCtrl = false;
    lCtrl = false;
  end if;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HalfBridgeCtrl;
