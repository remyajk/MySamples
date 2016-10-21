using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using GamePlanningApp.Models;

namespace GamePlanningApp.Controllers
{
    public class TeamPairsController : Controller
    {
        private TeamsDBEntities1 db = new TeamsDBEntities1();

        // GET: TeamPairs
        public ActionResult Index()
        {
            var teamPairs = db.TeamPairs.Include(t => t.Team).Include(t => t.Team1);
            return View(teamPairs.ToList());
        }

        // GET: TeamPairs/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TeamPair teamPair = db.TeamPairs.Find(id);
            if (teamPair == null)
            {
                return HttpNotFound();
            }
            return View(teamPair);
        }

        // GET: TeamPairs/Create
        public ActionResult Create()
        {
            ViewBag.Pair1 = new SelectList(db.Teams, "TeamId", "Name");
            ViewBag.Pair2 = new SelectList(db.Teams, "TeamId", "Name");
            return View();
        }

        // POST: TeamPairs/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "PairId,Catogory,Pair1,Pair2")] TeamPair teamPair)
        {
            if (ModelState.IsValid)
            {
                db.TeamPairs.Add(teamPair);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Team1 = new SelectList(db.Teams, "TeamId", "Name", teamPair.Team1);
            ViewBag.Team2 = new SelectList(db.Teams, "TeamId", "Name", teamPair.Team2);
            return View(teamPair);
        }

        // GET: TeamPairs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TeamPair teamPair = db.TeamPairs.Find(id);
            if (teamPair == null)
            {
                return HttpNotFound();
            }
            ViewBag.Team1 = new SelectList(db.Teams, "TeamId", "Name", teamPair.Team1);
            ViewBag.Team2 = new SelectList(db.Teams, "TeamId", "Name", teamPair.Team2);
            return View(teamPair);
        }

        // POST: TeamPairs/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "PairId,Catogory,Pair1,Pair2")] TeamPair teamPair)
        {
            if (ModelState.IsValid)
            {
                db.Entry(teamPair).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Team1 = new SelectList(db.Teams, "TeamId", "Name", teamPair.Team1);
            ViewBag.Team2 = new SelectList(db.Teams, "TeamId", "Name", teamPair.Team2);
            return View(teamPair);
        }

        // GET: TeamPairs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TeamPair teamPair = db.TeamPairs.Find(id);
            if (teamPair == null)
            {
                return HttpNotFound();
            }
            return View(teamPair);
        }

        // POST: TeamPairs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            TeamPair teamPair = db.TeamPairs.Find(id);
            db.TeamPairs.Remove(teamPair);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
