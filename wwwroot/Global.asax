<%@ Import Namespace="System.IdentityModel"%>
<%@ Import Namespace="System.ServiceModel.Security"%>
<%@ Import Namespace="System.Security.Claims"%>
<%@ Import Namespace="System.IdentityModel.Tokens"%>
<%@ Import Namespace="System.IdentityModel.Services"%>
<%@ Application Language="C#" %>

<script RunAt="server">
    string JQueryVer = "2.0.0";
    void Application_Start(object sender, EventArgs e)
    {
        ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition()
        {
            Path = "~/Scripts/jquery/jquery-" + JQueryVer + ".min.js",
            CdnSupportsSecureConnection = true,
            LoadSuccessExpression = "window.jQuery"
        });

        FederatedAuthentication.WSFederationAuthenticationModule.SignedIn += WSFederationAuthenticationModule_SignedIn;
    }
    protected void WSFederationAuthenticationModule_SignedIn(object sender, EventArgs e)
    {
        System.Diagnostics.Debug.WriteLine(" WSFederationAuthenticationModule_SignedIn ");
    }
    void WSFederationAuthenticationModule_SecurityTokenReceived(object sender, SecurityTokenReceivedEventArgs e)
    {
        //Augment token validation with your cusotm validation checks without invalidating the token.
        System.Diagnostics.Debug.WriteLine("WSFederationAuthenticationModule_SecurityTokenReceived event");
    }
</script>
