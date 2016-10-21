using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using GamePlanningApp.Models;
using System.Net;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Data;
using System.Data.Entity.Validation;
using System.Diagnostics;
using GamePlanningApp.Controllers;

namespace GamePlanningApp.Controllers
{
    public class HomeController : Controller
    {
        private TeamsDBEntities1 _db = new TeamsDBEntities1();
        public ActionResult Index()
        {
            
            ViewData["Ladies"] = from d in _db.Teams
                                 orderby d.TeamId
                                 where d.Catogory == "f"
                                 select d;
            ViewData["Gents"] = from d in _db.Teams
                                orderby d.TeamId
                                where d.Catogory == "m"
                                select d;

            return View();
        }

        //

        // GET: /Home/Details/5 

        public ActionResult Details(int? id)

        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Team team = _db.Teams.Find(id);
            if (team == null)
            {
                return HttpNotFound();
            }
            return View(team);

        }
        // GET: /Home/Create 

        public ActionResult Create()

        {

            return View();

        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Exclude = "Id")] Team teamToCreate)
        {
            try

            {
                if (!ModelState.IsValid)

                    return View();

                int gents_count = (from d in _db.Teams
                                   orderby d.TeamId
                                   where d.Catogory == "m"
                                   select d).Count();

                int ladies_count = (from d in _db.Teams
                                   orderby d.TeamId
                                   where d.Catogory == "f"
                                   select d).Count();


                if (teamToCreate.Catogory == "m")
                {
                    if (_db.Teams.Count() < 20 && gents_count < 10)
                    {

                        _db.Teams.Add(teamToCreate);

                        _db.SaveChanges();

                        return RedirectToAction("Index");
                    }
                    else
                    {
                        ModelState.AddModelError("error", "Max limit of teams exceeds.");
                        return View();
                    }
                }

                if (teamToCreate.Catogory == "f")
                {
                    if (_db.Teams.Count() < 20 && ladies_count < 10)
                    {

                        _db.Teams.Add(teamToCreate);

                        _db.SaveChanges();

                        return RedirectToAction("Index");
                    }
                    else
                    {
                        ModelState.AddModelError("error", "Max limit of teams exceeds.");
                        return View();
                    }
                }

                return View();
            }
            //catch (SqlException ex)
            //{
            //    if (ex.Number == 2627)
            //    {
            //        //  throw new InvalidOperationException("Cannot insert duplicate values.", ex);
            //        HttpException exc = new HttpException(ex.ErrorCode, "Safe message for 5xx HTTP codes.", ex);
            //        throw exc;
            //    }
            //    return View();
            //}
            catch (DataException /* dex */)
            {
                //Log the error (uncomment dex variable name after DataException and add a line here to write a log.
                ModelState.AddModelError(string.Empty, "Unable to save changes. Try again, and if the problem persists contact your system administrator.");
                return View();
            }
            catch

            {

                return View();

            }
        }



       
        // GET: /Home/Edit/5 

        public ActionResult Edit(int? id)

        {
            var roundsData = from c in _db.Rounds select c;
            _db.Rounds.RemoveRange(roundsData);
            _db.SaveChanges();

            var pairsData = from c in _db.TeamPairs select c;
            _db.TeamPairs.RemoveRange(pairsData);
            _db.SaveChanges();

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Team team = _db.Teams.Find(id);
            if (team == null)
            {
                return HttpNotFound();
            }
            return View(team);

        }

        //

        // POST: /Home/Edit/5 
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.

        [AcceptVerbs(HttpVerbs.Post)]

        public ActionResult Edit([Bind(Include = "TeamId, Name,Catogory")]Team teamToEdit)
        {

            try
            {
                var roundsData = from c in _db.Rounds select c;
                _db.Rounds.RemoveRange(roundsData);
                _db.SaveChanges();

                var pairsData = from c in _db.TeamPairs select c;
                _db.TeamPairs.RemoveRange(pairsData);
                _db.SaveChanges();

                if (ModelState.IsValid)
                {
                    _db.Entry(teamToEdit).State = EntityState.Modified;
                    _db.SaveChanges();
                    return RedirectToAction("Index");
                }
                
            }
            catch (DbEntityValidationException dbEx)
            {
                foreach (var validationErrors in dbEx.EntityValidationErrors)
                {
                    foreach (var validationError in validationErrors.ValidationErrors)
                    {
                       // ModelState.AddModelError(string.Empty, "Unable to save changes. Try again, and if the problem persists contact your system administrator.");
                        ModelState.AddModelError(string.Empty, "Property: {0} Error: {1}"+ validationError.PropertyName + validationError.ErrorMessage);
                    }
                }
            }
            //catch (DataException /* dex */)
            //{
            //    //Log the error (uncomment dex variable name after DataException and add a line here to write a log.
            //    ModelState.AddModelError(string.Empty, "Unable to save changes. Try again, and if the problem persists contact your system administrator.");
            //}
            return View(teamToEdit);

        }

        // GET: /Movies/Delete/5
        public ActionResult Delete(int? id)
        {
            var roundsData = from c in _db.Rounds select c;
            _db.Rounds.RemoveRange(roundsData);
            _db.SaveChanges();

            var pairsData = from c in _db.TeamPairs select c;
            _db.TeamPairs.RemoveRange(pairsData);
            _db.SaveChanges();

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Team team = _db.Teams.Find(id);
            if (team == null)
            {
                return HttpNotFound();
            }
            return View(team);
        }

        // POST: /Teams/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Team team = _db.Teams.Find(id);
            _db.Teams.Remove(team);
            _db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _db.Dispose();
            }
            base.Dispose(disposing);
        }
        public ActionResult PairingCreate()

        {
            if (!ModelState.IsValid)

                return View();

            int gents_count = (from d in _db.Teams
                               orderby d.TeamId
                               where d.Catogory == "m"
                               select d).Count();

            int ladies_count = (from d in _db.Teams
                                orderby d.TeamId
                                where d.Catogory == "f"
                                select d).Count();

            var roundsData = from c in _db.Rounds select c;
            _db.Rounds.RemoveRange(roundsData);
            _db.SaveChanges();

            var pairsData = from c in _db.TeamPairs select c;
            _db.TeamPairs.RemoveRange(pairsData);
            _db.SaveChanges();



            if (_db.Teams.Count() < 20 && gents_count < 10 && gents_count % 2 == 0)
            {
                List<int> list = _db.Teams.Where(o => o.Catogory == "m").Select(o => o.TeamId).ToList();
                List<int[]> Pairs = RoundCombinationRule.Pairs(list.ToArray());

                foreach (int[] t in Pairs)
                {
                    TeamPair teamPair = new TeamPair();
                    teamPair.Catogory = "m";
                    teamPair.Team1 = t[0];
                    teamPair.Team2 = t[1];
                    _db.TeamPairs.Add(teamPair);
                }
                _db.SaveChanges();

                List<int[]>[] rounds = RoundCombinationRule.Rounds(list.ToArray());


                foreach (List<int[]> item in rounds)
                {
                    List<int> pairList = new List<int>();
                    foreach (int[] pair in item)
                    {
                        int PairId = 0;
                        var p0 = pair[0];
                        var p1 = pair[1];
                        if (_db.TeamPairs.Where(o => o.Team1 == p0 && o.Team2 == p1).Select(o => o.PairId) != null)
                        {
                            var id = _db.TeamPairs.Where(o => o.Team1 == p0 && o.Team2 == p1).Select(o => o.PairId).First();
                            PairId = id;
                            pairList.Add(PairId);
                        }
                    }
                    Round round = new Round();
                    round.Catogory = "m";
                    switch (pairList.Count)
                    {
                        case 1:
                            round.Pair1 = pairList[0];
                            break;
                        case 2:
                            round.Pair1 = pairList[0];
                            round.Pair2 = pairList[1];
                            break;
                        case 3:
                            round.Pair1 = pairList[0];
                            round.Pair2 = pairList[1];
                            round.Pair3 = pairList[2];
                            break;
                        case 4:
                            round.Pair1 = pairList[0];
                            round.Pair2 = pairList[1];
                            round.Pair3 = pairList[2];
                            round.Pair4 = pairList[3];
                            break;
                        case 5:
                            round.Pair1 = pairList[0];
                            round.Pair2 = pairList[1];
                            round.Pair3 = pairList[2];
                            round.Pair4 = pairList[3];
                            round.Pair5 = pairList[4];
                            break;

                    }
                    _db.Rounds.Add(round);
                    _db.SaveChanges();
                }

               
            }

            if (_db.Teams.Count() < 20 && ladies_count < 10 && ladies_count % 2 == 0)
            {

                List<int> list = _db.Teams.Where(o => o.Catogory == "f").Select(o => o.TeamId).ToList();
                List<int[]> Pairs = RoundCombinationRule.Pairs(list.ToArray());

                foreach (int[] t in Pairs)
                {
                    TeamPair teamPair = new TeamPair();
                    teamPair.Catogory = "f";
                    teamPair.Team1 = t[0];
                    teamPair.Team2 = t[1];
                    _db.TeamPairs.Add(teamPair);
                }
                _db.SaveChanges();

                List<int[]>[] rounds = RoundCombinationRule.Rounds(list.ToArray());


                foreach (List<int[]> item in rounds)
                {
                    List<int> pairList = new List<int>();
                    foreach (int[] pair in item)
                    {
                        int PairId = 0;
                        var p0 = pair[0];
                        var p1 = pair[1];
                        if (_db.TeamPairs.Where(o => o.Team1 == p0 && o.Team2 == p1).Select(o => o.PairId) != null)
                        {
                            var id = _db.TeamPairs.Where(o => o.Team1 == p0 && o.Team2 == p1).Select(o => o.PairId).First();
                            PairId = id;
                            pairList.Add(PairId);
                        }
                    }
                    Round round = new Round();
                        round.Catogory = "f";
                        switch (pairList.Count)
                        {
                            case 1:
                                round.Pair1 = pairList[0];
                                break;
                            case 2:
                                round.Pair1 = pairList[0];
                                round.Pair2 = pairList[1];
                                break;
                            case 3:
                                round.Pair1 = pairList[0];
                                round.Pair2 = pairList[1];
                                round.Pair3 = pairList[2];
                                break;
                            case 4:
                                round.Pair1 = pairList[0];
                                round.Pair2 = pairList[1];
                                round.Pair3 = pairList[2];
                                round.Pair4 = pairList[3];
                                break;
                            case 5:
                                round.Pair1 = pairList[0];
                                round.Pair2 = pairList[1];
                                round.Pair3 = pairList[2];
                                round.Pair4 = pairList[3];
                                round.Pair5 = pairList[4];
                                break;

                        }
                        _db.Rounds.Add(round);
                    _db.SaveChanges();

                }

               
            }



            ViewData["Ladies Game Plan"] = from d in _db.Rounds
                                           orderby d.RoundId
                                           where d.Catogory == "f"
                                           select d;
            ViewData["Gents Game Plan"] = from d in _db.Rounds
                                          orderby d.RoundId
                                          where d.Catogory == "m"
                                          select d;

            return View();

        }

          public ActionResult RoundDetails(int? id)

        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Round round = _db.Rounds.Find(id);
            if (round == null)
            {
                return HttpNotFound();
            }
            ViewData["Round"] = from d in _db.Rounds
                                where d.RoundId == round.RoundId
                                select d;
            ViewData["Pair1"] = from d in _db.TeamPairs
                                 where d.PairId == round.Pair1
                                select d;
            ViewData["Pair2"] = from d in _db.TeamPairs
                                where d.PairId == round.Pair2
                                select d;
            ViewData["Pair3"] = from d in _db.TeamPairs
                                where d.PairId == round.Pair3
                                select d;
            ViewData["Pair3"] = from d in _db.TeamPairs
                                where d.PairId == round.Pair3
                                select d;
            ViewData["Pair4"] = from d in _db.TeamPairs
                                where d.PairId == round.Pair4
                                select d;
            ViewData["Pair5"] = from d in _db.TeamPairs
                                where d.PairId == round.Pair5
                                select d;

            return View();

        }

        static IEnumerable<int> Combinations(List<int> Teams, int length)
        {
            for (int i = 0; i < Teams.Count; i++)
            {
                // only want 1 character, just return this one
                if (length == 1)
                    yield return Teams[i];

                // want more than one character, return this one plus all combinations one shorter
                // only use characters after the current one for the rest of the combinations
                else
                    foreach (int next in Combinations(Teams.GetRange(i + 1, Teams.Count - (i + 1)), length - 1))
                        yield return Teams[i] + next;
            }
        }
     

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

       

    }
}