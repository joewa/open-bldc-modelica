within OpenBLDC.Icons;
expandable connector BusOut "Icon for a bus adaptor (read from the bus)"
  extends Modelica.Icons.SignalSubBus;

  annotation (Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={Polygon(
          points={{40,10},{40,-10},{40,-20},{10,-20},{-10,-40},{-40,-40},{-40,
              40},{-10,40},{10,20},{40,20},{40,10}},
          lineColor={0,0,127},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid), Text(
          extent={{-148,81},{152,41}},
          lineColor={0,0,255},
          textString="%name")}),
    Documentation(revisions="<html>
<table border=\"1\" rules=\"groups\">
<thead>
<tr><td>Version</td>  <td>Date</td>  <td>Comment</td></tr>
</thead>
<tbody>
<tr><td>1.0.0</td>  <td>2006-03-13</td>  <td> </td></tr>
</tbody>
</table>
</html>"));
end BusOut;
