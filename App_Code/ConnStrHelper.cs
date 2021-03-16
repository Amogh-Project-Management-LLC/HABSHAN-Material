using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class ConnStrHelper
{
    public ConnStrHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string Excel03ConString()
    {
        return @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source={0};Extended Properties = 'Excel 8.0;HDR={1};IMEX=1;'";
    }

    public static string Excel07ConString()
    {
        return @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties='Excel 8.0;HDR={1};IMEX=1;'";
    }
}