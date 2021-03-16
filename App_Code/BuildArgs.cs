using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml;
using OfficeOpenXml;
using OfficeOpenXml.Drawing.Chart;

namespace BuildClass
{
   
    public static class SimpleTypes
    {
        public const int ST_PERCENTAGE = 1000; // 1000th of a percent
        public const int ST_POSITIVE_FIXED_ANGLE = 60000; // 60000th of a degree
    }
    public static class EMUUnits
    {
        public const int EMU_PER_CM = 360000;
        public const int EMU_PER_INCH = 914400;
        public const int EMU_PER_PIXEL = 9525;
        public const int EMU_PER_POINT = 12700;
    }
    public sealed class StringValueAttribute : Attribute
    {
        public StringValueAttribute(string value)
        {
            Value = value;
        }

        public string Value { get; private set; }
    }

    public static partial class EnumExtensions
    {
        public static string StringValue(this Enum enumValue)
        {
            var type = enumValue.GetType();
            var field = type.GetField(enumValue.ToString());
            var attributes = field.GetCustomAttributes(typeof(StringValueAttribute), false);
            return (attributes.Length > 0 ? ((StringValueAttribute)attributes[0]).Value : null);
        }
    }
    public enum BuildAction
    {
        None = 0,
        Merge,
        AutoFilter,
        FreezePanes,
        ColumnClustered,
        PieExploded3D
    }

    public class BuildArgs
    {
        public BuildAction Action { get; set; }
        public ExcelWorksheet Worksheet { get; set; }
        public int FromRow { get; set; }
        public int FromColumn { get; set; }
        public int ToRow { get; set; }
        public int ToColumn { get; set; }
        public BuildChart Chart { get; set; }
    }

    public class BuildChart
    {
        public string Title { get; set; }
        public List<BuildChartSerie> Series { get; set; }
        public int Row { get; set; }
        public int RowOffsetPixels { get; set; }
        public int Column { get; set; }
        public int ColumnOffsetPixels { get; set; }
    }

    public class BuildChartSerie
    {
        public string Header { get; set; }
        public string SerieAddress { get; set; }
        public string XSerieAddress { get; set; }
    }

    public static partial class EPPlusChartExtensions
    {
        public static void EnableChartDataTable(this ExcelChart chart, bool showLegendKeys)
        {
            var xdoc = chart.ChartXml;
            var nsm = new XmlNamespaceManager(xdoc.NameTable);

            // "http://schemas.openxmlformats.org/drawingml/2006/chart"
            var schemaChart = xdoc.DocumentElement.NamespaceURI;
            if (nsm.HasNamespace("c") == false)
                nsm.AddNamespace("c", schemaChart);

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.plotarea.aspx
            var plotArea = xdoc.SelectSingleNode("/c:chartSpace/c:chart/c:plotArea", nsm);

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.datatable.aspx
            var dTable = plotArea.AppendElement(schemaChart, "c:dTable");

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.showkeys.aspx
            var showKeys = dTable.AppendElement(schemaChart, "c:showKeys");
            showKeys.AppendAttribute("val", (showLegendKeys ? "1" : "0"));
        }
        public static void Enable3DChartShadow(this ExcelPieChart chart, int serieIndex, int red, int green, int blue, int sizePer, int blurPt, int distancePt, int angleDgr, int transparencyPer)
        {
            var xdoc = chart.ChartXml;
            var nsm = new XmlNamespaceManager(xdoc.NameTable);

            // "http://schemas.openxmlformats.org/drawingml/2006/chart"
            var schemaChart = xdoc.DocumentElement.NamespaceURI;
            if (nsm.HasNamespace("c") == false)
                nsm.AddNamespace("c", schemaChart);

            var schemaDrawings = "http://schemas.openxmlformats.org/drawingml/2006/main";
            if (nsm.HasNamespace("a") == false)
                nsm.AddNamespace("a", schemaDrawings);

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.plotarea.aspx
            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.pie3dchart.aspx
            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.piechartseries.aspx
            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.index.aspx
            var ser = xdoc.SelectSingleNode("/c:chartSpace/c:chart/c:plotArea/c:pie3DChart/c:ser[c:idx[@val='" + serieIndex + "']]", nsm);

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.chartshapeproperties.aspx
            var spPr = ser.SelectSingleNode("./c:spPr", nsm);
            if (spPr == null)
                spPr = ser.AppendElement(schemaChart, "c:spPr");

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.effectlist.aspx
            var effectLst = spPr.AppendElement(schemaDrawings, "a:effectLst");

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.outershadow.aspx
            var outerShdw = effectLst.AppendElement(schemaDrawings, "a:outerShdw");
            outerShdw.AppendAttribute("sx", (sizePer * SimpleTypes.ST_PERCENTAGE).ToString()); // horizontal scaling factor
            outerShdw.AppendAttribute("sy", (sizePer * SimpleTypes.ST_PERCENTAGE).ToString()); // vertical scaling factor
            outerShdw.AppendAttribute("blurRad", (blurPt * EMUUnits.EMU_PER_POINT).ToString()); // blur
            outerShdw.AppendAttribute("dist", (distancePt * EMUUnits.EMU_PER_POINT).ToString()); // distance
            outerShdw.AppendAttribute("dir", (angleDgr * SimpleTypes.ST_POSITIVE_FIXED_ANGLE).ToString()); // direction

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.rgbcolormodelhex.aspx
            var srgbClr = outerShdw.AppendElement(schemaDrawings, "a:srgbClr");
            srgbClr.AppendAttribute("val", string.Format("{0:X2}{1:X2}{2:X2}", red, green, blue));

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.alpha.aspx
            var alpha = srgbClr.AppendElement(schemaDrawings, "a:alpha");
            alpha.AppendAttribute("val", (100 - transparencyPer) + "%"); // alpha = 100% - transparency
        }

        public static void Enable3DChartFormat(this ExcelPieChart chart, int serieIndex, PresetMaterialTypeValues material, int topBevelWidthPt, int topBevelHeightPt, int bottomBevelWidthPt, int bottomBevelHeightPt)
        {
            var xdoc = chart.ChartXml;
            var nsm = new XmlNamespaceManager(xdoc.NameTable);

            // "http://schemas.openxmlformats.org/drawingml/2006/chart"
            var schemaChart = xdoc.DocumentElement.NamespaceURI;
            if (nsm.HasNamespace("c") == false)
                nsm.AddNamespace("c", schemaChart);

            var schemaDrawings = "http://schemas.openxmlformats.org/drawingml/2006/main";
            if (nsm.HasNamespace("a") == false)
                nsm.AddNamespace("a", schemaDrawings);

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.plotarea.aspx
            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.pie3dchart.aspx
            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.piechartseries.aspx
            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.index.aspx
            var ser = xdoc.SelectSingleNode("/c:chartSpace/c:chart/c:plotArea/c:pie3DChart/c:ser[c:idx[@val='" + serieIndex + "']]", nsm);

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.charts.chartshapeproperties.aspx
            var spPr = ser.SelectSingleNode("./c:spPr", nsm);
            if (spPr == null)
                spPr = ser.AppendElement(schemaChart, "c:spPr");

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.shape3dtype.aspx
            var sp3d = spPr.AppendElement(schemaDrawings, "a:sp3d");
            sp3d.AppendAttribute("prstMaterial", material.StringValue());

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.beveltop.aspx
            var bevelT = sp3d.AppendElement(schemaDrawings, "a:bevelT");
            bevelT.AppendAttribute("w", (topBevelWidthPt * EMUUnits.EMU_PER_POINT).ToString());
            bevelT.AppendAttribute("h", (topBevelHeightPt * EMUUnits.EMU_PER_POINT).ToString());

            // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.bevelbottom.aspx
            var bevelB = sp3d.AppendElement(schemaDrawings, "a:bevelB");
            bevelB.AppendAttribute("w", (bottomBevelWidthPt * EMUUnits.EMU_PER_POINT).ToString());
            bevelB.AppendAttribute("h", (bottomBevelHeightPt * EMUUnits.EMU_PER_POINT).ToString());
        }
         // https://msdn.microsoft.com/en-us/library/documentformat.openxml.drawing.presetmaterialtypevalues.aspx
    public enum PresetMaterialTypeValues
    {
        [StringValue("legacyMatte")]
        LegacyMatte,
        [StringValue("legacyPlastic")]
        LegacyPlastic,
        [StringValue("legacyMetal")]
        LegacyMetal,
        [StringValue("legacyWireframe")]
        LegacyWireframe,
        [StringValue("matte")]
        Matte,
        [StringValue("plastic")]
        Plastic,
        [StringValue("metal")]
        Metal,
        [StringValue("warmMatte")]
        WarmMatte,
        [StringValue("translucentPowder")]
        TranslucentPowder,
        [StringValue("powder")]
        Powder,
        [StringValue("dkEdge")]
        DarkEdge,
        [StringValue("softEdge")]
        SoftEdge,
        [StringValue("clear")]
        Clear,
        [StringValue("flat")]
        Flat,
        [StringValue("softmetal")]
        SoftMetal
    }

    }
    public static partial class XmlExtensions
    {
        public static XmlElement AppendElement(this XmlNode parent, string namespaceURI, string qualifiedName)
        {
            var elm = parent.OwnerDocument.CreateElement(qualifiedName, namespaceURI);
            parent.AppendChild(elm);
            return elm;
        }

        public static XmlAttribute AppendAttribute(this XmlNode parent, string name, string value)
        {
            var att = parent.OwnerDocument.CreateAttribute(name);
            att.Value = value;
            parent.Attributes.Append(att);
            return att;
        }
    }
    public class EqualityComparer<T> : IEqualityComparer<T>
    {
        public bool Equals(T x, T y)
        {
            IDictionary<string, object> xP = x as IDictionary<string, object>;
            IDictionary<string, object> yP = y as IDictionary<string, object>;

            if (xP.Count != yP.Count)
                return false;
            if (xP.Keys.Except(yP.Keys).Any())
                return false;
            if (yP.Keys.Except(xP.Keys).Any())
                return false;
            foreach (var pair in xP)
                if (pair.Value.Equals(yP[pair.Key]) == false)
                    return false;
            return true;

        }

        public int GetHashCode(T obj)
        {
            return obj.ToString().GetHashCode();
        }
    }

}

