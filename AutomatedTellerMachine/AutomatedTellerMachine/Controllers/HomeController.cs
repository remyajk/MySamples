using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AutomatedTellerMachine.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
            //return PartialView();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            // ViewBag.Message = "Your contact page.";
            ViewBag.TheMessage = "Do you have a problem?, send us a message";
            return View();
        }
        [HttpPost]
        public ActionResult Contact(String message)
        {
            ViewBag.TheMessage = "Thanks, we got ur message";
            return View();
        }
        public ActionResult foo()
        {
            return View("About");
        }

        public ActionResult Serial(String letterCase)
        {
            var serial = "ASPDONTNETMVC5";
            if(letterCase == "lower")
            {
                return Content(serial.ToLower());
            }
            // return Content(serial);
            // return new HttpStatusCodeResult(403);
            //return Json(new { name = "serial", value = serial }, JsonRequestBehavior.AllowGet);
            return RedirectToAction("Contact");
        }
    }
}