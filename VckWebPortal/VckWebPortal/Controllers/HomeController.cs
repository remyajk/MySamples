using System.Linq;
using System.Web.Mvc;
using VckWebPortal.Models;

namespace VckWebPortal.Controllers
{
    public class HomeController : Controller
    {
        private Entities entities = new Entities();

        public ActionResult Index()
        {
            VckModels vckLog = new VckModels();
            if (!Request.IsAuthenticated)
            {
                ViewBag.Message = "Grüezi und Willkommen im Value Card Kiosk (VCK) Pay APP";
            }
            else
            {
                ViewBag.Message = "Value Card Kiosk Portal - Status";
                vckLog.VoucherCardLogs = entities.vouchercard_log.ToList();
                vckLog.HwDispenserTrays = entities.hw_dispenser_trays.ToList();
                ViewBag.tray_dd = new SelectList(vckLog.HwDispenserTrays, "ID", "trayname");
            }

            return View(vckLog);
        }
        
        //[HttpPost]
        //public ActionResult Index(VckModels model)
        //{
        //    if (model.TrayId == 0)
        //    {
        //        entities.hw_dispenser_trays.ToList().ForEach(x => x.number_of_cards = model.NumOfCards);
        //    }
        //    else
        //    {
        //        entities.hw_dispenser_trays.Find(model.TrayId).number_of_cards = model.NumOfCards;
        //    }

        //    entities.SaveChanges();

        //    model = new VckModels();
        //    if (!Request.IsAuthenticated)
        //    {
        //        ViewBag.Message = "Grüezi und Willkommen in der Value Card Kiosk Web App.";
        //    }
        //    else
        //    {
        //        ViewBag.Message = "Value Card Kiosk Portal - Status";
        //        model.VoucherCardLogs = entities.vouchercard_log.Where(x => x.exported == false).ToList();
        //        model.HwDispenserTrays = entities.hw_dispenser_trays.ToList();
        //        ViewBag.tray_dd = new SelectList(model.HwDispenserTrays, "ID", "trayname");
        //    }

        //    return View(model);
        //}

        public ActionResult About()
        {
            ViewBag.Message = "Über VCK Pay APP";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Kontakt";

            return View();
        }
    }
}
