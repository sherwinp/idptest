<%@ Page Language="C#"%>
<%@ Import Namespace="System.IdentityModel"%>
<%@ Import Namespace="System.ServiceModel.Security"%>
<%@ Import Namespace="System.Security.Claims"%>
<%@ Import Namespace="System.IdentityModel.Tokens"%>
<%@ Import Namespace="System.IdentityModel.Services"%>
<script RunAt="server">
    string OfficialLocationClaimType;
    void Page_Init(object sender, EventArgs e)
    {
        OfficialLocationClaimType = HttpContext.Current.Request.ApplicationPath;
    }
    void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["wa"] == "wsignin1.0")
            {
                FederatedAuthentication.WSFederationAuthenticationModule.RedirectToIdentityProvider(
                    FederatedAuthentication.WSFederationAuthenticationModule.Issuer,
                    FederatedAuthentication.WSFederationAuthenticationModule.Realm, false);
            }
        }
        else
        {
            WriteToken("appuser");
        }
    }

    private bool WriteToken(String username)
    {
        bool bResult = true;
        Claim[] claims = LoadClaimsForUser(username);
        var id = new ClaimsIdentity(claims, "Forms");
        var cp = new ClaimsPrincipal(id);

        var token = new SessionSecurityToken(cp);
        var sam = FederatedAuthentication.SessionAuthenticationModule;
        sam.WriteSessionTokenToCookie(token);
        return bResult;
    }
    private Claim[] LoadClaimsForUser(string username)
    {
        var claims = new Claim[]
        {
        new Claim(ClaimTypes.Name, username),
        new Claim(ClaimTypes.Email, "givenname.surname@company.com"),
        new Claim(ClaimTypes.Role, "User"),
        new Claim(ClaimTypes.Role, "RoleB"),
        new Claim(OfficialLocationClaimType, "5W-A1"),
        };
        return claims;
    }

</script>
<body runat="server">
<Form ID="tform" runat="server">
<asp:HyperLink ID="lnkCertLogin" NavigateUrl="~/Users/index.aspx?wa=wsignin1.0&wtrealm=." Text="client certificate login instead." runat="server" />
<asp:login ID="ilogin" runat="server">
</asp:login>
</Form>
</body>