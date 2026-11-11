using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Xml.Xsl;

namespace sugupuuRakendusXML.Pages
{
    public class OmasugupuuModel : PageModel
    {
        private readonly IWebHostEnvironment _env;

        public string HtmlSisu { get; set; } = "";

        public OmasugupuuModel(IWebHostEnvironment env)
        {
            _env = env;
        }

        public void OnGet()
        {
            string xmlPath = Path.Combine(
                _env.WebRootPath, "minusugupuu.xml");

            string xsltPath = Path.Combine(
                _env.WebRootPath, "sugupuuParing.xslt");

            XslCompiledTransform xslt = new XslCompiledTransform();
            xslt.Load(xsltPath);

            using StringWriter writer = new StringWriter();
            xslt.Transform(xmlPath, null, writer);

            HtmlSisu = writer.ToString();
        }
    }
}
