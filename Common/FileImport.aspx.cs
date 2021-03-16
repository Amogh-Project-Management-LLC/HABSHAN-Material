using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Common_FileImport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Import Files");
        }
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        try
        {
            if (RadAsyncUpload1.UploadedFiles.Count == 0 && RadAsyncUpload2.UploadedFiles.Count == 0)
            {
                Master.show_error("Please Upload File to proceed.");
                return;
            }
            if(Request.QueryString["REF_ID"]=="")
            {
                Master.show_error("Select Transmittal");
                return;
            }
            ///////////////////////////////////////////////////////////////////////////////////////////////////////
            if (RadAsyncUpload1.UploadedFiles.Count > 0)
            {
                int type_id = int.Parse(Request.QueryString["TYPE_ID"]);
                int ref_id = int.Parse(Request.QueryString["REF_ID"].ToString());
                string proj_id = Session["PROJECT_ID"].ToString();

                string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
                string f_name = "";
                string dir_obj = "";
                string dir_id = "";
                string delquery = "";
                // string irn_id = itemsGrid.SelectedValue.ToString();
                switch (type_id)
                {
                    case 8:
                        f_name = WebTools.GetExpr("MR_NO", "PIP_MAT_REQUISITION", " WHERE MR_ID='" + ref_id + "'");
                        dir_obj = "REQUISITION";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 9:
                        f_name = WebTools.GetExpr("PO_NO", "PIP_PO", " WHERE PO_ID='" + ref_id + "'");
                        dir_obj = "PO_MASTER";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 10:
                        f_name = WebTools.GetExpr("RFI_NO", "PIP_PO_INSP_REQUEST", " WHERE RFI_ID='" + ref_id + "'");
                        dir_obj = "PO_RFI";
                         delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 11:
                        f_name = WebTools.GetExpr("MAT_RCV_NO", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + ref_id + "'");
                        dir_obj = "MRR";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 12:
                        f_name = WebTools.GetExpr("RFI_NO", "PIP_MAT_INSP_REQUEST", " WHERE RFI_ID='" + ref_id + "'");
                        dir_obj = "MAT_RFI";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 13:
                            f_name = WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " WHERE MIR_ID='" + ref_id + "'");
                            dir_obj = "MRIR";
                            delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" +type_id+" AND REF_ID="+ref_id;
                            WebTools.ExeSql(delquery);
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 14:
                        f_name = WebTools.GetExpr("MAT_REQ_NO", "MATERIAL_REQUEST", " WHERE MAT_REQ_ID='" + ref_id + "'");
                        dir_obj = "MAT_REQUEST";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 15:
                        f_name = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID='" + ref_id + "'");
                        dir_obj = "MAT_ISSUE";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 16:
                        f_name = WebTools.GetExpr("TRANSF_NO", "PIP_MAT_TRANSF", " WHERE TRANSF_ID='" + ref_id + "'");
                        dir_obj = "MAT_TRANSFER";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 17:
                        f_name = WebTools.GetExpr("RCV_NUMBER", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID='" + ref_id + "'");
                        dir_obj = "TRANSF_RCV";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 28:
                        f_name = WebTools.GetExpr("RETURN_NO", "PIP_MAT_RETURN", " WHERE MAT_RET_ID='" + ref_id + "'");
                        dir_obj = "MAT_RETURN";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 30:
                        f_name = WebTools.GetExpr("VO_NO", "PIP_PO_VARIATION", " WHERE VO_ID='" + ref_id + "'");
                        dir_obj = "PO_VO";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 31:
                        f_name = WebTools.GetExpr("REP_NO", "PIP_MAT_EXCEPTION_REP", " WHERE EXCP_ID='" + ref_id + "'");
                        dir_obj = "ESD";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;
                    case 32:
                        f_name = WebTools.GetExpr("QRNTINE_NO", "PIP_QUARANTINE", " WHERE QRNTINE_ID='" + ref_id + "'");
                        dir_obj = "MAT_QUARANTINE";
                        delquery = "DELETE FROM PIP_FILE_UPLOAD WHERE type_id=" + type_id + " AND REF_ID=" + ref_id;
                        WebTools.ExeSql(delquery);
                        dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                        break;

                }
                f_name = f_name.Replace("/", "-");
                string Extension = Path.GetExtension(RadAsyncUpload1.UploadedFiles[0].GetExtension());
                string FileName = f_name + Extension;
                string u_file_name = Path.GetFileName(RadAsyncUpload1.UploadedFiles[0].GetNameWithoutExtension());
              
                string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIR_OBJ='"+dir_obj+"'");
                string FilePath = FolderPath + FileName;
                System.IO.File.Delete(FilePath);
                RadAsyncUpload1.UploadedFiles[0].SaveAs(FilePath);
               
                string query = "INSERT INTO PIP_FILE_UPLOAD(TYPE_ID,REF_ID,DOC_NAME,DOC_EXT,DIR_ID,U_FILE_NAME,CREATED_BY) VALUES(" + type_id + "," + ref_id + ",'"+FileName+"','" + Extension + "','" + dir_id + "','" + u_file_name + "',"+decimal.Parse(user_id)+")";
                WebTools.ExeSql(query);
                Master.show_success("File Uploaded");
            }

            if(RadAsyncUpload2.UploadedFiles.Count>0)
            {

                int type_id = int.Parse(Request.QueryString["TYPE_ID"]);
                int ref_id = int.Parse(Request.QueryString["REF_ID"].ToString());
                string proj_id = Session["PROJECT_ID"].ToString();

                string user_id = WebTools.GetExpr("USER_ID", "USERS", " USER_NAME ='" + Session["USER_NAME"] + "'");
                int filecount = RadAsyncUpload2.UploadedFiles.Count;

                string maxdoc = WebTools.CountExpr("REF_ID", "PIP_SUPP_FILE_UPLOAD", " WHERE TYPE_ID = " +type_id+" AND REF_ID = "+ref_id);
                int doccnt = 0;
                if (maxdoc == "")
                {
                    doccnt = 1;
                }
                else
                {
                    doccnt = int.Parse(maxdoc)+1;
                }
                for (int i=0;i<filecount;i++)
                {
                    string f_name = "";
                    string dir_obj = "";
                    string dir_id = "";
                    // string irn_id = itemsGrid.SelectedValue.ToString();
                    switch (type_id)
                    {

                        case 8:
                            f_name = WebTools.GetExpr("MR_NO", "PIP_MAT_REQUISITION", " WHERE MR_ID='" + ref_id + "'");
                            dir_obj = "MR_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                        case 9:
                            f_name = WebTools.GetExpr("PO_NO", "PIP_PO", " WHERE PO_ID='" + ref_id + "'");
                            dir_obj = "PO_MASTER_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                        case 10:
                            f_name = WebTools.GetExpr("RFI_NO", "PIP_PO_INSP_REQUEST", " WHERE RFI_ID='" + ref_id + "'");
                            dir_obj = "PO_RFI_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                        case 11:
                            f_name = WebTools.GetExpr("MAT_RCV_NO", "PIP_MAT_RECEIVE", " WHERE MAT_RCV_ID='" + ref_id + "'");
                            dir_obj = "MRR_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                        case 12:
                            f_name = WebTools.GetExpr("RFI_NO", "PIP_MAT_INSP_REQUEST", " WHERE RFI_ID='" + ref_id + "'");
                            dir_obj = "MAT_RFI_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                        case 13:
                            f_name = WebTools.GetExpr("MIR_NO", "PRC_MAT_INSP", " WHERE MIR_ID='" + ref_id + "'");
                            dir_obj = "MRIR_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                        case 14:
                            f_name = WebTools.GetExpr("MAT_REQ_NO", "MATERIAL_REQUEST", " WHERE MAT_REQ_ID='" + ref_id + "'");
                            dir_obj = "MAT_REQ_SUPP";                          
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                        case 15:
                            f_name = WebTools.GetExpr("ISSUE_NO", "PIP_MAT_ISSUE_ADD", " WHERE ADD_ISSUE_ID='" + ref_id + "'");
                            dir_obj = "MAT_ISSUE_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                        case 16:
                            f_name = WebTools.GetExpr("TRANSF_NO", "PIP_MAT_TRANSF", " WHERE TRANSF_ID='" + ref_id + "'");
                            dir_obj = "MAT_TRANSF_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                        case 17:
                            f_name = WebTools.GetExpr("RCV_NUMBER", "PIP_MAT_TRANSFER_RCV", " WHERE RCV_ID='" + ref_id + "'");
                            dir_obj = "TRANSF_RCV_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;

                        case 28:
                            f_name = WebTools.GetExpr("RETURN_NO", "PIP_MAT_RETURN", " WHERE MAT_RET_ID='" + ref_id + "'");
                            dir_obj = "MAT_RETURN_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                        case 30:
                            f_name = WebTools.GetExpr("VO_NO", "PIP_PO_VARIATION", " WHERE VO_ID='" + ref_id + "'");
                            dir_obj = "PO_VO_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                        case 31:
                            f_name = WebTools.GetExpr("REP_NO", "PIP_MAT_EXCEPTION_REP", " WHERE EXCP_ID='" + ref_id + "'");
                            dir_obj = "ESD_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;
                        case 32:
                            f_name = WebTools.GetExpr("QRNTINE_NO", "PIP_QUARANTINE", " WHERE QRNTINE_ID='" + ref_id + "'");
                            dir_obj = "MAT_QRTINE_SUPP";
                            dir_id = WebTools.GetExpr("DIR_ID", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                            break;

                    }
                    f_name = f_name.Replace("/", "-");
                    
                    string Extension = Path.GetExtension(RadAsyncUpload2.UploadedFiles[i].GetExtension());
                    string FileName = f_name+"_"+ doccnt++ + Extension;
                    string u_file_name = Path.GetFileName(RadAsyncUpload2.UploadedFiles[i].GetNameWithoutExtension());
                    u_file_name = u_file_name.Replace("'", "");
                    string FolderPath = WebTools.GetExpr("PATH", "DIR_OBJECTS", " WHERE DIR_OBJ='" + dir_obj + "'");
                    string FilePath = FolderPath + FileName;
        
                    RadAsyncUpload2.UploadedFiles[i].SaveAs(FilePath);

                    string query = "INSERT INTO PIP_SUPP_FILE_UPLOAD(TYPE_ID,REF_ID,DOC_NAME,DOC_EXT,DIR_ID,U_FILE_NAME,CREATED_BY) VALUES(" + type_id + "," + ref_id + ",'" + FileName + "','" + Extension + "','" + dir_id + "','" + u_file_name + "'," + decimal.Parse(user_id) + ")";
                    WebTools.ExeSql(query);
                    Master.show_success("Files Uploaded");
                }
            }         
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }

   
       
    
}