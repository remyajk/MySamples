using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web.Mvc;
using VckWebPortal.Models;

namespace VckWebPortal.Controllers
{
    public class VckController : Controller
    {
        private Entities entities = new Entities();
        //
        // GET: /Vck/Portal

        public ActionResult Portal(string returnUrl)
        {
            ViewBag.Message = "Value Card Kiosk Portal - Status";

            ViewBag.ReturnUrl = returnUrl;

            return View();
        }

        //
        // POST: /Vck/Portal

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Portal(vouchercard_log model, string returnUrl)
        {
            return View(model);
        }

        //
        // GET: /Vck/ZAbschlag

        public ActionResult ZAbschlag()
        {
            VckModels endOfShift = new VckModels();
            endOfShift.HwDispenserTrays = entities.hw_dispenser_trays.ToList();
            string unitid = entities.vouchercard_log.FirstOrDefault().unit_id;
            endOfShift.EndOfShiftReportResult = entities.EndOfShiftReport(unitid).FirstOrDefault();


            ViewBag.Message = DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss");

            ViewBag.Exported = false;

            return View(endOfShift);
        }

        //
        // POST: /Vck/ZAbschlag

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ZAbschlag(string returnUrl)
        {
            ViewBag.Message = "erfolgreich";

            //TODO END OF SHIFT

            ViewBag.Exported = false;

            ViewBag.ReturnUrl = returnUrl;

            return View();
        }

        //
        // GET: /Vck/XAbschlag

        public ActionResult XAbschlag()
        {
            VckModels xAbschlag = new VckModels();
            xAbschlag.VoucherCardLogs = entities.vouchercard_log.Where(x => x.exported == false).ToList();
            xAbschlag.HwDispenserTrays = entities.hw_dispenser_trays.ToList();

            ViewBag.Message = DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss");

            ViewBag.Exported = false;

            return View(xAbschlag);
        }

        //
        // POST: /Vck/XAbschlag

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult XAbschlag(string returnUrl)
        {
            ViewBag.Message = "erfolgreich";

            //TODO END OF SHIFT

            ViewBag.Exported = false;

            ViewBag.ReturnUrl = returnUrl;

            return View();
        }

        //
        // GET: /Vck/Transaktionssuche

        public ActionResult Transaktionssuche(string sdate, string bdate, string stime, string btime, string sccnumber, string bccnumber, string stransnumber, string btransnumber)
        {
            ViewBag.Message = "";

            VckModels vckLog = new VckModels();

            vckLog.VoucherCardLogs = entities.vouchercard_log.ToList();

            if(bdate.Equals("true"))
            {
                string datestring = Convert.ToDateTime(sdate, new CultureInfo("de-DE")).ToString("yyyyMMdd");
                vckLog.VoucherCardLogs = vckLog.VoucherCardLogs.Where(x => x.time.Substring(0, 8).Equals(datestring)).ToList();
            }

            if (btime.Equals("true"))
            {
                string timestring = Convert.ToDateTime(stime).ToString("HH:mm");
                vckLog.VoucherCardLogs = vckLog.VoucherCardLogs.Where(x => x.time.Substring(9, 5).Equals(timestring)).ToList();
            }

            if (bccnumber.Equals("true"))
            {
                vckLog.VoucherCardLogs = vckLog.VoucherCardLogs.Where(x => x.printablecardnumber.EndsWith(sccnumber)).ToList();
            }

            if (btransnumber.Equals("true"))
            {
                vckLog.VoucherCardLogs = vckLog.VoucherCardLogs.Where(x => x.trxrefnum.Equals(stransnumber)).ToList();
            }

            vckLog.VoucherCardLogs.OrderBy(x => x.time);

            return View(vckLog);
        }

        //
        // POST: /Vck/Transaktionssuche

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Transaktionssuche(VckModels model, string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;

            return View(model);
        }

        //
        // GET: /Vck/Tagesstatistik

        public ActionResult Tagesstatistik(string sDateVon, string sDateBis, string bDetails)
        {
            ViewBag.Message = sDateVon + " - " + sDateBis;

            VckModels vckLog = new VckModels();

            vckLog.IncludeDetails = Convert.ToBoolean(bDetails);

            string datestringvon = Convert.ToDateTime(sDateVon, new CultureInfo("de-DE")).ToString("yyyyMMdd");
            string datestringbis = Convert.ToDateTime(sDateBis, new CultureInfo("de-DE")).ToString("yyyyMMdd");

            //Das Datenmodell ist kaputt (Warum macht man Time = string!?), deswegen wird mit schleife und parsing durchgedödelt
            string datestring = datestringvon;
            vckLog.VoucherCardLogs = new List<vouchercard_log>();

            while (DateTime.ParseExact(datestring, "yyyyMMdd", new CultureInfo("de-DE")) <= Convert.ToDateTime(sDateBis, new CultureInfo("de-DE")))
            {
                vckLog.VoucherCardLogs.AddRange(entities.vouchercard_log.Where(x => x.time.Substring(0, 8).Equals(datestring)).ToList());
                datestring = DateTime.ParseExact(datestring, "yyyyMMdd", new CultureInfo("de-DE")).AddDays(1).ToString("yyyyMMdd");
            }

            return View(vckLog);
        }

        //
        // POST: /Vck/Tagesstatistik

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Tagesstatistik(VckModels model, string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;

            return View(model);
        }

        //
        // GET: /Vck/Traymanager

        public void Traymanager(string trayID, string numOfCards)
        {
            if (trayID == null || trayID.Trim().Equals(""))
            {
                trayID = "0";
            }

            int itrayId = Int32.Parse(trayID);

            if (numOfCards == null || numOfCards.Trim().Equals(""))
            {
                numOfCards = "0";
            }

            int inumOfCards = Int32.Parse(numOfCards);

            if (itrayId == 0)
            {
                entities.hw_dispenser_trays.ToList().ForEach(x => x.number_of_cards = inumOfCards);
            }
            else
            {
                entities.hw_dispenser_trays.Find(itrayId).number_of_cards = inumOfCards;
            }

            entities.SaveChanges();

            return;
        }

        public ActionResult SetTrays(string trayID, string numOfCards)
        {
            if (trayID == null || trayID.Trim().Equals(""))
            {
                trayID = "0";
            }

            int itrayId = Int32.Parse(trayID);

            if (numOfCards == null || numOfCards.Trim().Equals(""))
            {
                numOfCards = "0";
            }

            int inumOfCards = Int32.Parse(numOfCards);

            if (itrayId == 0)
            {
                entities.hw_dispenser_trays.ToList().ForEach(x => x.number_of_cards = inumOfCards);
            }
            else
            {
                entities.hw_dispenser_trays.Find(itrayId).number_of_cards = inumOfCards;
            }

            entities.SaveChanges();

            return View();
        }
    }
}
