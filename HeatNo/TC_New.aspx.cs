using dsGeneralTableAdapters;
using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.OracleClient;
using System.Web.Hosting;
using System.IO;

public partial class HeatNo_TC_New : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("MM_INSERT"))
        {
            btnSubmit.Enabled = false;
            return;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string po_id = WebTools.GetExpr("PO_ID", "PIP_PO", "PROJECT_ID=" + Session["PROJECT_ID"].ToString() + " AND PO_NO='" + PO_NO_HiddenField.Value + "'");

        if (po_id.Length == 0)
        {
            Master.ShowWarn("PO Number not found!");
            return;
        }

        string FileName = WebTools.SessionDataPath() + txtTC_No.Text.Replace("/", "-") + ".pdf";

        if (File.Exists(FileName))
        {
            System.IO.File.Delete(FileName);
        }
        if (PDF_Upload.HasFile == true)
        {
            PDF_Upload.SaveAs(FileName);
        }

        //Saving to Oracle

        byte[] byteArray = null;

        if (PDF_Upload.HasFile == true)
        {
            using (FileStream fs = new FileStream
                (FileName, FileMode.Open, FileAccess.Read, FileShare.Read))
            {

                byteArray = new byte[fs.Length];

                int iBytesRead = fs.Read(byteArray, 0, (int)fs.Length);
            }
        }

        string sql = " INSERT INTO PIP_TEST_CARDS (PROJECT_ID, TC_CODE, REMARKS, PO_ID, MTC_BLOB) VALUES (:PROJECT_ID, :TC_CODE, :REMARKS, :PO_ID, :MTC_BLOB)";

        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
            //conn.Open();

            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                cmd.Parameters.Add("PROJECT_ID", OracleType.Number);
                cmd.Parameters[0].Value = Session["PROJECT_ID"].ToString();

                cmd.Parameters.Add("TC_CODE", OracleType.VarChar);
                cmd.Parameters[1].Value = txtTC_No.Text;

                cmd.Parameters.Add("REMARKS", OracleType.VarChar);
                cmd.Parameters[2].Value = txtRemarks.Text;

                cmd.Parameters.Add("PO_ID", OracleType.Number);
                cmd.Parameters[3].Value = po_id;

                cmd.Parameters.Add("MTC_BLOB", OracleType.Blob);
                if (byteArray != null)
                {
                    cmd.Parameters[4].Value = byteArray;
                }
                else
                {
                    cmd.Parameters[4].Value = DBNull.Value;
                }

                cmd.ExecuteNonQuery();
            }
            Master.ShowMessage(txtTC_No.Text + " Saved!");
        }
    }

    protected void btnTC_Index_Click(object sender, EventArgs e)
    {
        Response.Redirect("TC_Index.aspx");
    }

    protected void txtSearch_Search(object sender, Telerik.Web.UI.SearchBoxEventArgs e)
    {
        PO_NO_HiddenField.Value = txtSearch.Text;
    }
}