using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GamePlanningApp.Models
{
    public class RoundCombinationRule
    {
        public static List<int[]>[] Rounds(int[] teamArray)
        {
            var ennum = Ex.DifferentCombinations(teamArray, 2);
            Dictionary<int, int[]> dictionary = new Dictionary<int, int[]>();

            int index = 0;
            foreach (var item in ennum)
                dictionary[index++] = item.ToArray();

            List<int> pairList = new List<int>();
            foreach (KeyValuePair<int, int[]> item in dictionary)
                pairList.Add(item.Key);

            var rounds = Ex.DifferentCombinations(pairList.ToArray(), teamArray.Count() / 2);
            List<int[]> roundsList = new List<int[]>();
            foreach (var item in rounds)
                roundsList.Add(new List<int>(item).ToArray());

            var myArray = new List<int[]>[teamArray.Length - 1];
            int j = 0;
            foreach (int[] round in roundsList)
            {
                List<int[]> roundValid = new List<int[]>();
                foreach (int foo in round)
                {
                    foreach (KeyValuePair<int, int[]> item in dictionary)
                    {
                        if (item.Key == foo)
                        {
                            roundValid.Add(item.Value);
                        }
                    }
                }
                List<int[]> checkedList = new List<int[]>();
                foreach (int[] team in roundValid)
                {
                    if (checkedList.Count == 0)
                    {
                        checkedList.Add(team);
                    }
                    else
                    {
                        if (!CheckDuplicateTeam(checkedList, team))
                        {
                            checkedList.Add(team);
                        }
                        else
                        {
                            checkedList.Clear();
                            break;
                        }

                    }
                    if (checkedList.Count() == teamArray.Count() / 2)
                    {
                        if (!checkEmpty(myArray))
                        {
                            if (!CheckDuplicateRound(myArray, checkedList))
                            {
                                myArray[j] = checkedList;
                                j++;
                            }
                        }
                        else
                        {
                            myArray[j] = checkedList;
                            j++;
                        }
                    }
                }


            }
            return myArray;
        }
        public static List<int[]> Pairs(int[] teamArray)
        {
            var ennum = Ex.DifferentCombinations(teamArray, 2);
            List<int[]> pairs = new List<int[]>();
            foreach (var item in ennum)
                pairs.Add(new List<int>(item).ToArray());
            return pairs;
        }
       
        private static bool CheckDuplicateTeam(List<int[]> teams, int[] pair)
        {
            foreach (int[] t in teams)
            {
                foreach (int i in t)
                {
                    foreach (int p in pair)
                    {
                        if (p == i)
                        {
                            return true;
                        }
                    }

                }


            }
            return false;
        }

        private static bool CheckDuplicateRound(List<int[]>[] teams, List<int[]> pair)
        {
            foreach (var r in teams)
            {
                if (r != null)
                {
                    foreach (int[] p in pair)
                    {
                        if (r.Contains(p))
                        {
                            return true;
                        }
                    }
                }

            }
            return false;
        }

         public static bool checkEmpty(List<int[]>[] array)
        {
            foreach (List<int[]> item in array)
            {
                if ((item != null))
                {
                    return false;
                }
            }
            return true;

        }



    }

    public static class Ex
    {
        public static IEnumerable<IEnumerable<T>> DifferentCombinations<T>(this IEnumerable<T> elements, int k)
        {
            return k == 0 ? new[] { new T[0] } :
              elements.SelectMany((e, i) =>
                elements.Skip(i + 1).DifferentCombinations(k - 1).Select(c => (new[] { e }).Concat(c)));
        }
    }
}