using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Xml;
using System.Xml.Xsl;

public class PrivacyModel : PageModel
{
    private readonly IWebHostEnvironment _env;

    public string HtmlSisu { get; set; } = "";

    public PrivacyModel(IWebHostEnvironment env)
    {
        _env = env;
    }

    public void OnGet()
    {
        string xmlPath = Path.Combine(_env.WebRootPath, "reisid.xml");
        string xsltPath = Path.Combine(_env.WebRootPath, "reisidParing.xslt");

        XslCompiledTransform xslt = new XslCompiledTransform();
        xslt.Load(xsltPath);

        using StringWriter writer = new StringWriter();
        xslt.Transform(xmlPath, null, writer);

        HtmlSisu = writer.ToString();
    }
}
