using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(GamePlanningApp.Startup))]
namespace GamePlanningApp
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
