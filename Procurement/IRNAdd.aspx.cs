using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Procurement_BTableAdapters;

public partial class Procurement_IRNAdd : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "Add Inspection Release Note (IRN)";
            txtIRNCreateDate.SelectedDate = System.DateTime.Today;
            txtRev.Text = "0";
        }     
    }

    protected void Unnamed_Click(object sender, EventArgs e)
    {
        Response.Redirect("IRN.aspx");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if(chk4.Checked==true)
            {
                if(txtchk4.Text=="")
                {
                    Master.ShowError("Fill check box 4 text value");
                    return;
                }
            }
            if (chk7.Checked == true)
            {
                if (txtchk7.Text == "")
                {
                    Master.ShowError("Fill check box 7 text value");
                    return;
                }
            }
            string uname = Session["USER_NAME"].ToString().ToUpper();
            string user_id = WebTools.GetExpr("USER_ID", "USERS", " WHERE UPPER(USER_NAME)='" + uname + "'");
            VIEW_PO_IRNTableAdapter irn = new VIEW_PO_IRNTableAdapter();
            string dclient="N";
            if (chkDClient.Checked==true)
            {
                 dclient = "Y";
            }

            string dsupp ="N";
            if (chkDSupp.Checked == true)
            {
                dsupp = "Y";
            }
            string dsubsupp = "N";
            if (chkDSubSup.Checked == true)
            {
                dsubsupp = "Y";
            }
            string dsubcon = "N";
            if (chkDSubcon.Checked == true)
            {
                dsubcon = "Y";
            }



            irn.InsertQuery(decimal.Parse(Session["PROJECT_ID"].ToString()), txtIRNNumber.Text, txtRev.Text, txtIRNCreateDate.SelectedDate, vendorType.SelectedValue,
                poStatus.SelectedValue, decimal.Parse(ddlVendor.SelectedValue), vendorReport.SelectedValue, txtRemarks.Text, decimal.Parse(user_id), ddlInspResult.SelectedValue, decimal.Parse(ddlPO.SelectedValue),
                txtPOContact.Text, txtPOEmail.Text, txtPOPhone.Text, txtVendorContactName.Text, txtVendorPhone.Text, dclient, dsupp, dsupp, dsubcon,txtPreparedBy.Text,txtReviewedBy.Text,txtApprovedBy.Text,ddlVO.SelectedValue);

            //register RFI
            var collection = ddlRFINo.CheckedItems;
            string irn_id = WebTools.GetExpr("IRN_ID", "PIP_PO_IRN", " WHERE IRN_NO='" + txtIRNNumber.Text + "'");
            foreach (var item in collection)
            {
                string q = "INSERT INTO PIP_PO_IRN_RFI VALUES(" + decimal.Parse(irn_id) + ",'" + item.Value + "')";
                WebTools.ExeSql(q);
                
            }

            //marjor irn reports
            var major = MajorIReports.CheckedItems;     
            foreach (var item in major)
            {
                string q = "INSERT INTO PIP_PO_IRN_MAJOR_REPORT VALUES(" + decimal.Parse(irn_id) + ",'" + item.Value + "')";
                WebTools.ExeSql(q);

            }

            //irn result checkboxes need to move to for loop 
            if(chk1.Checked==true)
            {
                string q = "INSERT INTO PIP_PO_IRN_RESULT(IRN_ID, RESULT_TEXT, REMARKS, IRN_RESULT_ID) VALUES(" + decimal.Parse(irn_id) + ",+'"+lb1.Text+"',null,1)";
                WebTools.ExeSql(q);
            }
            if (chk2.Checked == true)
            {
                string q = "INSERT INTO PIP_PO_IRN_RESULT(IRN_ID, RESULT_TEXT, REMARKS, IRN_RESULT_ID) VALUES(" + decimal.Parse(irn_id) + ",+'" + lb2.Text + "',null,2)";
                WebTools.ExeSql(q);
            }
            if (chk3.Checked == true)
            {
                string q = "INSERT INTO PIP_PO_IRN_RESULT(IRN_ID, RESULT_TEXT, REMARKS, IRN_RESULT_ID) VALUES(" + decimal.Parse(irn_id) + ",+'" + lb3.Text + "',null,3)";
                WebTools.ExeSql(q);
            }
            if (chk4.Checked == true)
            {
                string q = "INSERT INTO PIP_PO_IRN_RESULT(IRN_ID, RESULT_TEXT, REMARKS, IRN_RESULT_ID) VALUES(" + decimal.Parse(irn_id) + ",+'" + lb4.Text+txtchk4.Text + "','"+ txtchk4.Text+ "',4)";
                WebTools.ExeSql(q);
            }
            if (chk5.Checked == true)
            {
                string q = "INSERT INTO PIP_PO_IRN_RESULT(IRN_ID, RESULT_TEXT, REMARKS, IRN_RESULT_ID) VALUES(" + decimal.Parse(irn_id) + ",+'" + lb5.Text + "',null,5)";
                WebTools.ExeSql(q);
            }

            if (chk6.Checked == true)
            {
                string q = "INSERT INTO PIP_PO_IRN_RESULT(IRN_ID, RESULT_TEXT, REMARKS, IRN_RESULT_ID) VALUES(" + decimal.Parse(irn_id) + ",+'" + lb6.Text + "',null,6)";
                WebTools.ExeSql(q);
            }
            if (chk7.Checked == true)
            {
                string q = "INSERT INTO PIP_PO_IRN_RESULT(IRN_ID, RESULT_TEXT, REMARKS, IRN_RESULT_ID) VALUES(" + decimal.Parse(irn_id) + ",+'" + txtchk7.Text + "','"+ txtchk7.Text + "',7)";
                WebTools.ExeSql(q);
            }

            //if (chk7.Checked == true)
            //{

            //    string[] chk7items = new string[txtchk7.Entries.Count];

            //    for (int i = 0; i < txtchk7.Entries.Count; i++)
            //    {
            //        chk7items[i] = txtchk7.Entries[i].Text;
            //        string q = "INSERT INTO PIP_PO_IRN_RESULT(IRN_ID, RESULT_TEXT, REMARKS, IRN_RESULT_ID) VALUES(" + decimal.Parse(irn_id) + ",+'" + txtchk7.Entries[i].Text + "','"+ txtchk7.Entries[i].Text+"',7)";
            //        WebTools.ExeSql(q);
            //    }
            //}
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////-------

            string irn_no = WebTools.GetExpr("IRN_NO", "PIP_PO_IRN", " WHERE IRN_ID='" + irn_id + "'");
            string proj_id = Session["PROJECT_ID"].ToString();
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if (txtFileUpload1.HasFile)
            {
                string Extension = Path.GetExtension(txtFileUpload1.PostedFile.FileName);

                string u_file_name = Path.GetFileName(txtFileUpload1.PostedFile.FileName);

                string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIR_ID=6");

                string maxdoc = WebTools.CountExpr("IRN_ID", "PIP_PO_IR_DOCS", " WHERE IRN_ID=" + irn_id);
                int doccnt = 0;
                if (maxdoc == "")
                {
                    doccnt = 1;
                }
                else
                {
                    doccnt = int.Parse(maxdoc) + 1;
                }
                string irn_no2 = irn_no.Replace("/", "-");
                u_file_name = u_file_name.Replace("'", "");
                string Filename = irn_no2 + "_" + doccnt + Extension;
                string FilePath = FolderPath + Filename;

                txtFileUpload1.SaveAs(FilePath);
                string date1 = txtRepDate1.SelectedDate.ToString();
                DateTime dt = DateTime.Parse(txtRepDate1.SelectedDate.ToString());
                string query = "INSERT INTO PIP_PO_IR_DOCS(IRN_ID,DOC_NAME,DOC_EXT,DIR_ID,U_FILE_NAME,REPORT_NO,REP_DATE) VALUES(" + irn_id + ",'" + Filename + "','" + Extension + "','" + 6 + "','" + u_file_name + "','" + txtRep1.Text + "','" + dt.ToString("dd-MMM-yyyy") + "')";
                WebTools.ExeSql(query);

            }

            /////////2
            if (txtFileUpload2.HasFile)
            {
                string Extension = Path.GetExtension(txtFileUpload2.PostedFile.FileName);

                string u_file_name = Path.GetFileName(txtFileUpload2.PostedFile.FileName);

                string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIR_ID=6");

                string maxdoc = WebTools.CountExpr("IRN_ID", "PIP_PO_IR_DOCS", " WHERE IRN_ID=" + irn_id);
                int doccnt = 0;
                if (maxdoc == "")
                {
                    doccnt = 1;
                }
                else
                {
                    doccnt = int.Parse(maxdoc) + 1;
                }
                string irn_no2 = irn_no.Replace("/", "-");
                u_file_name = u_file_name.Replace("'", "");
                string Filename = irn_no2 + "_" + doccnt + Extension;
                string FilePath = FolderPath + Filename;

                txtFileUpload2.SaveAs(FilePath);
                string date1 = txtRepDate2.SelectedDate.ToString();
                DateTime dt = DateTime.Parse(txtRepDate2.SelectedDate.ToString());
                string query = "INSERT INTO PIP_PO_IR_DOCS(IRN_ID,DOC_NAME,DOC_EXT,DIR_ID,U_FILE_NAME,REPORT_NO,REP_DATE) VALUES(" + irn_id + ",'" + Filename + "','" + Extension + "','" + 6 + "','" + u_file_name + "','" + txtRep2.Text + "','" + dt.ToString("dd-MMM-yyyy") + "')";
                WebTools.ExeSql(query);

            }
            //////3
            if (txtFileUpload3.HasFile)
            {
                string Extension = Path.GetExtension(txtFileUpload3.PostedFile.FileName);

                string u_file_name = Path.GetFileName(txtFileUpload3.PostedFile.FileName);

                string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIR_ID=6");

                string maxdoc = WebTools.CountExpr("IRN_ID", "PIP_PO_IR_DOCS", " WHERE IRN_ID=" + irn_id);
                int doccnt = 0;
                if (maxdoc == "")
                {
                    doccnt = 1;
                }
                else
                {
                    doccnt = int.Parse(maxdoc) + 1;
                }
                string irn_no2 = irn_no.Replace("/", "-");
                u_file_name = u_file_name.Replace("'", "");
                string Filename = irn_no2 + "_" + doccnt + Extension;
                string FilePath = FolderPath + Filename;

                txtFileUpload3.SaveAs(FilePath);
                string date1 = txtRepDate3.SelectedDate.ToString();
                DateTime dt = DateTime.Parse(txtRepDate3.SelectedDate.ToString());
                string query = "INSERT INTO PIP_PO_IR_DOCS(IRN_ID,DOC_NAME,DOC_EXT,DIR_ID,U_FILE_NAME,REPORT_NO,REP_DATE) VALUES(" + irn_id + ",'" + Filename + "','" + Extension + "','" + 6 + "','" + u_file_name + "','" + txtRep3.Text + "','" + dt.ToString("dd-MMM-yyyy") + "')";
                WebTools.ExeSql(query);

            }
            //////4
            if (txtFileUpload4.HasFile)
            {
                string Extension = Path.GetExtension(txtFileUpload4.PostedFile.FileName);

                string u_file_name = Path.GetFileName(txtFileUpload4.PostedFile.FileName);

                string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIR_ID=6");

                string maxdoc = WebTools.CountExpr("IRN_ID", "PIP_PO_IR_DOCS", " WHERE IRN_ID=" + irn_id);
                int doccnt = 0;
                if (maxdoc == "")
                {
                    doccnt = 1;
                }
                else
                {
                    doccnt = int.Parse(maxdoc) + 1;
                }
                string irn_no2 = irn_no.Replace("/", "-");
                u_file_name = u_file_name.Replace("'", "");
                string Filename = irn_no2 + "_" + doccnt + Extension;
                string FilePath = FolderPath + Filename;

                txtFileUpload4.SaveAs(FilePath);
                string date1 = txtRepDate4.SelectedDate.ToString();
                DateTime dt = DateTime.Parse(txtRepDate4.SelectedDate.ToString());
                string query = "INSERT INTO PIP_PO_IR_DOCS(IRN_ID,DOC_NAME,DOC_EXT,DIR_ID,U_FILE_NAME,REPORT_NO,REP_DATE) VALUES(" + irn_id + ",'" + Filename + "','" + Extension + "','" + 6 + "','" + u_file_name + "','" + txtRep4.Text + "','" + dt.ToString("dd-MMM-yyyy") + "')";
                WebTools.ExeSql(query);

            }

            //5
            if (txtFileUpload5.HasFile)
            {
                string Extension = Path.GetExtension(txtFileUpload5.PostedFile.FileName);

                string u_file_name = Path.GetFileName(txtFileUpload5.PostedFile.FileName);

                string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIR_ID=6");

                string maxdoc = WebTools.CountExpr("IRN_ID", "PIP_PO_IR_DOCS", " WHERE IRN_ID=" + irn_id);
                int doccnt = 0;
                if (maxdoc == "")
                {
                    doccnt = 1;
                }
                else
                {
                    doccnt = int.Parse(maxdoc) + 1;
                }
                string irn_no2 = irn_no.Replace("/", "-");
                u_file_name = u_file_name.Replace("'", "");
                string Filename = irn_no2 + "_" + doccnt + Extension;
                string FilePath = FolderPath + Filename;

                txtFileUpload5.SaveAs(FilePath);
                string date1 = txtRepDate5.SelectedDate.ToString();
                DateTime dt = DateTime.Parse(txtRepDate5.SelectedDate.ToString());
                string query = "INSERT INTO PIP_PO_IR_DOCS(IRN_ID,DOC_NAME,DOC_EXT,DIR_ID,U_FILE_NAME,REPORT_NO,REP_DATE) VALUES(" + irn_id + ",'" + Filename + "','" + Extension + "','" + 6 + "','" + u_file_name + "','" + txtRep5.Text + "','" + dt.ToString("dd-MMM-yyyy") + "')";
                WebTools.ExeSql(query);

            }

            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////          
            Master.ShowSuccess("IRN Created");

        }
        catch(Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }



    protected void ddlRFINo_DataBinding(object sender, EventArgs e)
    {
        //ddlRFINo.Items.Add(new Telerik.Web.UI.DropDownListItem("Select", "-1"));
    }

    protected void ddlRFINo_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {

       
    }

    protected void ddlRFINo_SelectedIndexChanged1(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        txtIRNNumber.Text = "";
        int pock = 0;
        string rfi_id = "";
        if (ddlRFINo.CheckedItems.Count > 0)
        {
            var collection = ddlRFINo.CheckedItems;
            string check_po = "";
            foreach (var item in collection)
            {
                 rfi_id = item.Value;
                string check_po_id = WebTools.GetExpr("PO_ID", "PIP_PO_INSP_REQUEST", " WHERE RFI_ID='" + rfi_id + "'");
                if (check_po == "")
                {
                    check_po = check_po_id;
                }
                else
                {
                    if (check_po != check_po_id)
                    {
                        pock = 1;
                        Master.ShowError("RFI of Multiple PO's cannot be selected");
                        ddlRFINo.ClearCheckedItems();
                    }
                }

            
        }
            if (pock == 0)
            {
                string po_id = WebTools.GetExpr("PO_ID", "PIP_PO_INSP_REQUEST", " WHERE RFI_ID='" + rfi_id + "'");
                ddlPO.SelectedValue = po_id;
                ddlPO.Enabled = false;
                string vend_code = WebTools.GetExpr("PO_VEND_CODE", "PIP_PO", " WHERE PO_ID='" + po_id + "'");
                string vend_id = WebTools.GetExpr("VENDOR_ID", "VENDOR_MASTER", " WHERE VENDOR_CODE='" + vend_code + "'");
                ddlVendor.SelectedValue = vend_id;
            }
            else
            {
                ddlPO.Enabled = true;
            }
            set_IRN_Seq();
        }
        else
        {
            ddlPO.Enabled = true;
        }
     
    }

    protected void btnPlus_Click(object sender, EventArgs e)
    {
        //TableRow row = new TableRow();
        //TableCell cell1 = new TableCell();
        //cell1.Text = "blah blah blah";
        //row.Cells.Add(cell1);
        //myTable.Rows.Add(row);
    }

    protected void ddlPO_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        string vend_code = WebTools.GetExpr("PO_VEND_CODE", "PIP_PO", " WHERE PO_ID='" + ddlPO.SelectedValue + "'");    
        string vend_id = WebTools.GetExpr("VENDOR_ID", "VENDOR_MASTER", " WHERE VENDOR_CODE='" + vend_code + "'");
        ddlVendor.SelectedValue = vend_id;
        ddlVO.DataBind();
        set_IRN_Seq();
    }
    protected void set_IRN_Seq()
    {
        string prefix = "IRN-";
        prefix += WebTools.GetExpr("JOB_CODE", "PROJECT_INFORMATION", " WHERE PROJECT_ID='" + Session["PROJECT_ID"].ToString() + "'");
        prefix += "-"+ ddlPO.SelectedItem.Text + "-";
        if(ddlVO.SelectedValue!="")
        {
            prefix = prefix + ddlVO.SelectedValue + "-";
        }
        txtIRNNumber.Text = WebTools.NextSerialNo("PIP_PO_IRN", "IRN_NO", prefix, 3, " WHERE PO_ID="+ddlPO.SelectedValue.ToString());
      
        
    }

    protected void ddlVO_SelectedIndexChanged(object sender, Telerik.Web.UI.DropDownListEventArgs e)
    {
        set_IRN_Seq();
    }

    protected void ddlVO_DataBinding(object sender, EventArgs e)
    {
        ddlVO.Items.Clear();
        ddlVO.Items.Add(new Telerik.Web.UI.DropDownListItem("-(Select VO)-", ""));
    }
}