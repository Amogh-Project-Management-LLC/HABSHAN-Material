using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using System.Drawing;
using Spire.Barcode;
using Spire.Pdf;

public partial class Home_Utilities : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Master.HeadingMessage = "System Utilities";
        }
    }

    protected void btnScan_Click(object sender, EventArgs e)
    {
        try
        {
            string SourceDirectory = "C:\\TEMP\\Barcode\\irn_1.pdf";
            string TargetDirectory = "C:\\TEMP\\Barcode\\Rename\\";

            string result = ExtractImages(SourceDirectory);

            string strResult = string.Empty;

            if (result != null && !string.IsNullOrEmpty(result))
            {
                System.IO.File.Move(SourceDirectory, TargetDirectory + result + ".pdf");
                Master.ShowMessage("File Scanned and Moved");
            }
            else
            {
                MessageBox.Show("No Barcode Found!!!");
            }
        }
        catch (Exception ex)
        {
            MessageBox.Show(ex.Message);
        }
    }

    protected string ExtractImages(string PDFPath)
    {
        PdfDocument doc = new PdfDocument();
        doc.LoadFromFile(PDFPath);
        PdfPageBase page;
        List<System.Drawing.Image> ListImage = new List<System.Drawing.Image>();
        string filename = string.Empty;
        for (int i = 0; i < doc.Pages.Count; i++)
        {
            page = doc.Pages[i];
            System.Drawing.Image[] images = page.ExtractImages();

            for (int j = 0; j < images.Length; j++)
            {
                filename = ReadBarcode((Bitmap)images[j]);

                if (filename != null)
                    return filename;
            }
        }

        return "";

    }

    protected string ReadBarcode(Bitmap image)
    {
        string[] datas = Spire.Barcode.BarcodeScanner.Scan(image);
        if (datas.Length > 0)
            return datas[0];
        else
            return "";
    }
}