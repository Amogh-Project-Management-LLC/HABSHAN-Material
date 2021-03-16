using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Procurement_POTechnicalSubmission : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage = "PO Technical Submission";

            Master.AddModalPopup("~/Procurement/POTechnicalSubmissionNew.aspx", btnAdd.ClientID, 450, 650);
        }
    }
}