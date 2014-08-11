within OpenBLDC.Icons;
partial model Converter "Icon for an electrical converter model"

  annotation(Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics={  Text(extent = {{150,80},{-150,120}}, textString = "%name", lineColor = {0,0,255}),Polygon(points = {{-90,-90},{90,-90},{90,90},{-90,-90}}, lineColor = {0,0,255}, fillColor = {210,210,210},
            fillPattern =                                                                                                    FillPattern.Solid),Polygon(points = {{-90,90},{90,90},{-90,-90},{-90,90}}, lineColor = {255,255,255}, fillColor = {241,241,241},
            fillPattern =                                                                                                    FillPattern.Solid),Polygon(points = {{-90,-90},{-90,90},{90,90},{-90,-90}}, lineColor = {0,0,255})}), Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}, grid = {1,1}), graphics), Documentation(revisions = "<html>
    </html>"));
end Converter;
