using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace GamePlanningApp.Models
{
    public class GamePlan
    {
        [Display(Name = "Round")]
        public int RoundID { get; set; }

        [StringLength(50, MinimumLength = 1)]
        public string Category { get; set; }

        public virtual ICollection<TeamPair> Pairs { get; set; }

        public void SetGamePlan()
        {
            //int gents_count = (from d in _db.Teams
            //                   orderby d.TeamId
            //                   where d.Catogory == "m"
            //                   select d).Count();

            //int ladies_count = (from d in _db.Teams
            //                    orderby d.TeamId
            //                    where d.Catogory == "f"
            //                    select d).Count();

            //ViewBag.Message = "Teams game Plan";

            //if (Catogory == "m")
            //{
            //    if (_db.Teams.Count() < 20 && gents_count < 10)
            //    {

            //        var list = _db.Teams.Select(o => o.TeamId).ToList();
            //        List<int[]>[] rounds = RoundCombinationRule.Rounds(list.ToArray());

            //        foreach (List<int[]> item in rounds)
            //        {
            //            Round round = new Round();
            //            round.Catogory = Catogory;
            //            List<int[]> pairs = item;
            //            foreach (int[] t in pairs)
            //            {
            //                TeamPair teamPair = new TeamPair();
            //                teamPair.Catogory = Catogory;
            //                teamPair.Team1 = t[0];
            //                teamPair.Team2 = t[1];
            //                _db.TeamPairs.Add(teamPair);
            //            }
            //            var pairList = _db.TeamPairs.Select(o => o.PairId).ToList();
            //            switch (pairList.Count)
            //            {
            //                case 1:
            //                    round.Pair1 = pairList[1];
            //                    break;
            //                case 2:
            //                    round.Pair1 = pairList[1];
            //                    round.Pair2 = pairList[2];
            //                    break;
            //                case 3:
            //                    round.Pair1 = pairList[1];
            //                    round.Pair2 = pairList[2];
            //                    round.Pair3 = pairList[3];
            //                    break;
            //                case 4:
            //                    round.Pair1 = pairList[1];
            //                    round.Pair2 = pairList[2];
            //                    round.Pair3 = pairList[3];
            //                    round.Pair4 = pairList[4];
            //                    break;
            //                case 5:
            //                    round.Pair1 = pairList[1];
            //                    round.Pair2 = pairList[2];
            //                    round.Pair3 = pairList[3];
            //                    round.Pair4 = pairList[4];
            //                    round.Pair5 = pairList[5];
            //                    break;

            //            }
            //            _db.Rounds.Add(round);

            //        }

            //        _db.SaveChanges();


            //        // return RedirectToAction("Index");
            //    }
            //    else
            //    {
            //        ModelState.AddModelError("error", "Max limit of teams exceeds.");
            //        return View();
            //    }
            //}

            //if (Catogory == "f")
            //{
            //    if (_db.Teams.Count() < 20 && ladies_count < 10)
            //    {

            //        var list = _db.Teams.Select(o => o.TeamId).ToList();
            //        List<int[]>[] rounds = RoundCombinationRule.Rounds(list.ToArray());

            //        foreach (List<int[]> item in rounds)
            //        {
            //            Round round = new Round();
            //            round.Catogory = Catogory;
            //            List<int[]> pairs = item;
            //            foreach (int[] t in pairs)
            //            {
            //                TeamPair teamPair = new TeamPair();
            //                teamPair.Catogory = Catogory;
            //                teamPair.Team1 = t[0];
            //                teamPair.Team2 = t[1];
            //                _db.TeamPairs.Add(teamPair);
            //            }
            //            var pairList = _db.TeamPairs.Select(o => o.PairId).ToList();
            //            switch (pairList.Count)
            //            {
            //                case 1:
            //                    round.Pair1 = pairList[1];
            //                    break;
            //                case 2:
            //                    round.Pair1 = pairList[1];
            //                    round.Pair2 = pairList[2];
            //                    break;
            //                case 3:
            //                    round.Pair1 = pairList[1];
            //                    round.Pair2 = pairList[2];
            //                    round.Pair3 = pairList[3];
            //                    break;
            //                case 4:
            //                    round.Pair1 = pairList[1];
            //                    round.Pair2 = pairList[2];
            //                    round.Pair3 = pairList[3];
            //                    round.Pair4 = pairList[4];
            //                    break;
            //                case 5:
            //                    round.Pair1 = pairList[1];
            //                    round.Pair2 = pairList[2];
            //                    round.Pair3 = pairList[3];
            //                    round.Pair4 = pairList[4];
            //                    round.Pair5 = pairList[5];
            //                    break;

            //            }
            //            _db.Rounds.Add(round);

            //        }

            //        _db.SaveChanges();

            //    }
            //    else
            //    {
            //        ModelState.AddModelError("error", "Max limit of teams exceeds.");
            //       // return View();
            //    }
            //}
        }
    }
}