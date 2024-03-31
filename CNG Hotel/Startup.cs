using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CNG_Hotel.Startup))]
namespace CNG_Hotel
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
