<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="WebMapApp._Default"%>


<%@ Register assembly="ESRI.ArcGIS.ADF.Web.UI.WebControls, Version=10.0.0.0, Culture=neutral, PublicKeyToken=8fc3cc631e44ad86" namespace="ESRI.ArcGIS.ADF.Web.UI.WebControls" tagprefix="esri" %>

<!--
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
-->



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Compare Versar Benthic to CIMS dataset</title>
       
        <style type="text/css">
        #form1
        {
            height: 1366px;
            width: 1600px;
            background-image: url('CBlandsat3.gif')
                   
        }
    </style>
    
</head>
<body>

    <form id="form1" runat="server">

        <p>
        
            <asp:TextBox ID="TextBox4" runat="server">Variable</asp:TextBox>
            <asp:TextBox ID="TextBox5" runat="server">Meters distance</asp:TextBox>
            <asp:TextBox ID="TextBox6" runat="server" ReadOnly="True">Days difference</asp:TextBox>
        

        
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
        

        


        

        
            <asp:HyperLink ID="HyperLink2" runat="server" style="position:absolute; left:500px; top:10px" NavigateUrl="Instructions.htm">Instructions</asp:HyperLink>
        
            <asp:HyperLink ID="HyperLink3" runat="server" style="position:absolute; left:500px; top:30px" NavigateUrl="Science.htm">Science Utility</asp:HyperLink>
        


        

        
        </p>

    <div>
        <asp:DropDownList ID="DropDownList1" runat="server">
            <asp:ListItem Value="DO">Dissolved Oxygen</asp:ListItem>
            <asp:ListItem Value="WTEMP">Water Temperature</asp:ListItem>
            <asp:ListItem Value="SALINITY">Salinity</asp:ListItem>
        </asp:DropDownList>
        <asp:TextBox ID="TextBox1" runat="server" 
        style="position:absolute; top:60px; height:20px; left:160px;">10000</asp:TextBox>
         <!-- <asp:SliderExtender ID="TextBox1_SliderExtender" runat="server" Enabled="True" 
           BoundControlID = "TextBox10"
            Maximum="47478" Minimum="0" TargetControlID="TextBox1">
        </asp:SliderExtender>
        -->
        <asp:TextBox ID="TextBox2" runat="server" 
        style="position:absolute; top: 60px; height: 20px; left: 315px;">100</asp:TextBox>
        <!--
        <asp:SliderExtender ID="TextBox2_SliderExtender" runat="server" Enabled="True" 
            Maximum="21549" Minimum="0" TargetControlID="TextBox2" BoundControlID = "TextBox11">
        </asp:SliderExtender> 
        -->
        <p> 
            <asp:TextBox ID="TextBox10" runat="server" 
                
                
                style="position:absolute; top:90px; height:20px; left:160px; right: 952px;">
            </asp:TextBox>
            <asp:TextBox ID="TextBox11" runat="server" 
            style="position:absolute; top: 90px; height: 20px; left: 315px;">
            </asp:TextBox>
        </p>
        
        <asp:Panel ID="Panel2" runat="server">

        </asp:Panel>
       
        
    </div>

    <asp:Panel ID="Panel1" runat="server" Height="384px" style="margin-top: 0px" 
        Width="540px">
     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
     <ContentTemplate> 
     
             <p>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Make Plot" 
            Width="84px" />


                 <asp:Image ID="Image1" runat="server" Height="352px" Visible="False" 
                     Width="480px" />
                 <asp:HyperLink ID="HyperLink1" runat="server" Visible="False">Data</asp:HyperLink>

                 <p>
                     &nbsp;
                     <p>
                         <asp:TextBox ID="TextBox12" runat="server" Visible="False"> Correlation Coefficient</asp:TextBox>
                     </p>
                     
                     <p>

                     </p>
                     <p>
                         <asp:TextBox ID="TextBox3" runat="server" Visible="False"></asp:TextBox>
                     </p>
                
                 </p>

             </p>
     </ContentTemplate>
    </asp:UpdatePanel> 

    </asp:Panel>
                     <esri:Toc ID="Toc1" runat="server" Height="300px" Width="200px" 
                     style="position:absolute; left:500px; top:150px;" BuddyControl="Map1" />
    
    <esri:Map ID="Map1" runat="server" Height="400px" 
                         MapResourceManager="MapResourceManager2" PrimaryMapResource="VersarCims" 
                         style="position:absolute; left:700px; top:150px; " width="400px" >
                     </esri:Map>
                     
                     <esri:Toolbar ID="Toolbar1" runat="server" Height="50px" Width="400px" 
                         style="position:absolute; left:700px; top:550px;" BuddyControlType="Map" 
                         Group="Toolbar1_Group" ToolbarItemDefaultStyle-BackColor="White" 
                         ToolbarItemDefaultStyle-Font-Names="Arial" 
                         ToolbarItemDefaultStyle-Font-Size="Smaller" 
                         ToolbarItemDisabledStyle-BackColor="White" 
                         ToolbarItemDisabledStyle-Font-Names="Arial" 
                         ToolbarItemDisabledStyle-Font-Size="Smaller" 
                         ToolbarItemDisabledStyle-ForeColor="Gray" 
                         ToolbarItemHoverStyle-BackColor="White" ToolbarItemHoverStyle-Font-Bold="True" 
                         ToolbarItemHoverStyle-Font-Italic="True" 
                         ToolbarItemHoverStyle-Font-Names="Arial" 
                         ToolbarItemHoverStyle-Font-Size="Smaller" 
                         ToolbarItemSelectedStyle-BackColor="White" 
                         ToolbarItemSelectedStyle-Font-Bold="True" 
                         ToolbarItemSelectedStyle-Font-Names="Arial" 
                         ToolbarItemSelectedStyle-Font-Size="Smaller" 
                         WebResourceLocation="/aspnet_client/ESRI/WebADF/">
                         <ToolbarItems>
                             <esri:Tool ClientAction="DragRectangle" DefaultImage="esriZoomIn.gif" 
                                 HoverImage="esriZoomInU.gif" JavaScriptFile="" Name="MapZoomIn" 
                                 SelectedImage="esriZoomInD.gif" 
                                 ServerActionAssembly="ESRI.ArcGIS.ADF.Web.UI.WebControls" 
                                 ServerActionClass="ESRI.ArcGIS.ADF.Web.UI.WebControls.Tools.MapZoomIn" 
                                 Text="Zoom In" ToolTip="Zoom In" />
                             <esri:Tool ClientAction="DragRectangle" DefaultImage="esriZoomOut.gif" 
                                 HoverImage="esriZoomOutU.gif" JavaScriptFile="" Name="MapZoomOut" 
                                 SelectedImage="esriZoomOutD.gif" 
                                 ServerActionAssembly="ESRI.ArcGIS.ADF.Web.UI.WebControls" 
                                 ServerActionClass="ESRI.ArcGIS.ADF.Web.UI.WebControls.Tools.MapZoomOut" 
                                 Text="Zoom Out" ToolTip="Zoom Out" />
                             <esri:Tool ClientAction="DragImage" DefaultImage="esriPan.gif" 
                                 HoverImage="esriPanU.gif" JavaScriptFile="" Name="MapPan" 
                                 SelectedImage="esriPanD.gif" 
                                 ServerActionAssembly="ESRI.ArcGIS.ADF.Web.UI.WebControls" 
                                 ServerActionClass="ESRI.ArcGIS.ADF.Web.UI.WebControls.Tools.MapPan" Text="Pan" 
                                 ToolTip="Pan" />
                             <esri:Command ClientAction="" DefaultImage="esriFullExt.gif" 
                                 HoverImage="esriFullExtU.gif" JavaScriptFile="" Name="MapFullExtent" 
                                 SelectedImage="esriFullExtD.gif" 
                                 ServerActionAssembly="ESRI.ArcGIS.ADF.Web.UI.WebControls" 
                                 ServerActionClass="ESRI.ArcGIS.ADF.Web.UI.WebControls.Tools.MapFullExtent" 
                                 Text="Full Extent" ToolTip="Full Extent" />
                         </ToolbarItems>
                         <BuddyControls>
                             <esri:BuddyControl Name="Map1" />
                         </BuddyControls>
                     </esri:Toolbar>
                      <esri:MapResourceManager ID="MapResourceManager2" runat="server">
                             <ResourceItems>
                                 <esri:MapResourceItem Definition="&lt;Definition DataSourceDefinition=&quot;http://maxim.ucsd.edu/arcgis/services&quot; DataSourceType=&quot;ArcGIS Server Internet&quot; Identity=&quot;&quot; ResourceDefinition=&quot;Layers@VersarCims&quot; /&gt;" 
                                     DisplaySettings="visible=True:transparency=10:mime=False:imgFormat=PNG24:height=100:width=100:dpi=96:color=0:transbg=True:displayInToc=True:dynamicTiling=" 
                                     LayerDefinitions="" Name="Chesapeake Bay" />
                             </ResourceItems>
                         </esri:MapResourceManager>
    <script type="text/javascript">
        function refreshImage() {
            //alert();
            document.getElementById('Image1').src = '~/';
        }
    </script>
                     
    </form>
</body>
</html>
