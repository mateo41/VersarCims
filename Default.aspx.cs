using System;
using System.Diagnostics;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;

using ESRI.ArcGIS.ADF.Web.UI.WebControls.Tools;
using ESRI.ArcGIS.ADF.Web.UI.WebControls;
using ESRI.ArcGIS.ADF.Web.SpatialReference;
using ESRI.ArcGIS.ADF.Web.Geometry;
using ESRI.ArcGIS.Geometry;

namespace WebMapApp
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["submitted"] == null)
            {
                Session.Add("submitted", 0);
            }

            if (Session["plotnumber"] == null)
            {

                Session.Add("plotnumber", 0);
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String param = this.DropDownList1.SelectedValue;
            SqlConnection conn = new SqlConnection("server=KYLE;database=cbeo_benthic;User ID=cbeo;Password=NiceTry:);");
            conn.Open();
            String meters = this.TextBox1.Text;
            String days = this.TextBox2.Text;
            
            double[] coords = getBoundingBoxCoords();
            string[] coordsString = new string[4];
            for (int i = 0; i < coords.Length; i++)
            {
                coordsString[i] = coords[i].ToString();
            }
            

            String coordsSepString = String.Join(",",coordsString);

            String cmdText = " EXEC  sp_cims_versar_filter3 " + param + "," + days + "," + meters + "," + coordsSepString;
            SqlCommand cmd = new SqlCommand(cmdText, conn);

            String rootDirectory = HttpContext.Current.Request.MapPath("") + "\\";
            String directory = rootDirectory + Session.SessionID + '-' + Session["submitted"].ToString();
            Directory.CreateDirectory(directory);

            generateCSV(cmd, directory);

            ProcessStartInfo psi = new ProcessStartInfo();
            psi.FileName = "\"C:\\Program Files\\R\\R-2.12.1\\bin\\Rscript.exe\"";
            String outputfile = directory + "\\output.csv";
            String plotnumber = Session["plotnumber"].ToString();
            String args = "plotcc.R " + outputfile + " " + directory + " " + param + " " + plotnumber;
            psi.WorkingDirectory = rootDirectory + "\\App_Data\\";
            psi.Arguments = args;
            psi.UseShellExecute = true;
            Process p = Process.Start(psi);
            p.WaitForExit();

            String relativeDirectory = Session.SessionID + '-' + Session["submitted"].ToString();

            String plotfile = "/plots" + plotnumber + ".jpg";
            String url = HttpContext.Current.Request.ApplicationPath + "/" + relativeDirectory + plotfile;
            this.Image1.ImageUrl = url;
            this.Image1.Visible = true;

            this.TextBox3.Visible = true;
            this.TextBox12.Visible = true;

            StreamReader reader = new StreamReader(directory + "//cc.txt");
            reader.ReadLine();
            String line = reader.ReadLine();
            String cc = line.Split(',')[1];
            this.TextBox12.Visible = true;
            this.TextBox3.Visible = true;
            this.TextBox3.Text = cc;

            reader.Close();

            this.HyperLink1.Visible = true;
            this.HyperLink1.NavigateUrl = "~/" + relativeDirectory + "/output.csv";
            int pn = Convert.ToInt32(plotnumber) + 1;

            Session["plotnumber"] = pn;
        }

        private static void generateCSV(SqlCommand cmd, String directory)
        {
            SqlDataReader reader = cmd.ExecuteReader();
            StreamWriter sw = new StreamWriter(directory + "//output.csv");
            sw.WriteLine("cimslat,cimslong,versarlat,versarlong,cimsdate,versardate,parameter,ddiff, dist,cimsvalue,versarvalue");
            while (reader.Read())
            {
                sw.Write(reader["cimslat"]);
                sw.Write(",");
                sw.Write(reader["cimslong"]);
                sw.Write(",");
                sw.Write(reader["versarlat"]);
                sw.Write(",");
                sw.Write(reader["versarlong"]);
                sw.Write(",");
                sw.Write(reader["cimsdate"]);
                sw.Write(",");
                sw.Write(reader["versardate"]);
                sw.Write(",");
                sw.Write(reader["parameter"]);
                sw.Write(",");
                sw.Write(reader["daysdiff"]);
                sw.Write(",");
                sw.Write(reader["meterdist"]);
                sw.Write(",");
                sw.Write(reader["cimsvalue"]);
                sw.Write(",");
                sw.Write(reader["versarvalue"]);
                sw.WriteLine();
            }
            sw.Close();
        }

        private double[] getBoundingBoxCoords()
        {
            /*Coords are Xmin, Xmax, Ymin, Ymax
             * longMin, longMax, latMin, latMax
            */ 
            double[] coords = new double[4];
            ESRI.ArcGIS.ADF.Web.Geometry.Envelope adfEnvelope = this.Map1.Extent;


            coords[0] = adfEnvelope.XMin;
            coords[1] = adfEnvelope.XMax;
            coords[2] = adfEnvelope.YMin;
            coords[3] = adfEnvelope.YMax;

            return coords;


        }

}

}

