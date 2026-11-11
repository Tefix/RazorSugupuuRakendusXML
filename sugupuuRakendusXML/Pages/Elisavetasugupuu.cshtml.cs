using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Xml.Xsl;

namespace sugupuuRakendusXML.Pages
{
    public class ElisavetasugupuuModel : PageModel
    {
        private readonly IWebHostEnvironment _env;

        public string HtmlSisu { get; set; } = "";

        public ElisavetasugupuuModel(IWebHostEnvironment env)
        {
            _env = env;
        }

        public void OnGet()
        {
            string xmlPath = Path.Combine(
                _env.WebRootPath, "ElisavetaSugupuu.xml");

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
