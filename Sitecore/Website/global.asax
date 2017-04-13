<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="WaybackMachine" %>
<script language="C#" runat="server">

    private void Application_Start(object source, EventArgs e)
    {
        Engine.Boot();
    }

    private void Application_BeginRequest(object source, EventArgs e)
    {
        if (Request.Path.IndexOf('\\') >= 0 || Path.GetFullPath(Request.PhysicalPath) != Request.PhysicalPath)
        {
            throw new HttpException(404, "not found");
        }
    }

</script>