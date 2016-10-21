using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ncR
{
    public static class ncr
    {
        // public static IEnumerable<int> CombinationsImpl(List<int> characters, int length)
        //{
        //    for (int i = 0; i < characters.Count; i++)
        //    {
        //        if (length == 1)
        //        {
        //            yield return characters[1];
        //        }
        //        else
        //        {
        //            foreach (int next in CombinationsImpl(characters.GetRange(i + 1, characters.Count - (i + 1)), length - 1))
        //                yield return characters[i] + next;
        //        }
        //    }
        //}

        public static IEnumerable<IEnumerable<T>>
            GetKCombs<T>(IEnumerable<T> list, int length) where T : IComparable
        {
            if (length == 1) return list.Select(t => new T[] { t });
            return GetKCombs(list, length - 1)
                .SelectMany(t => list.Where(o => o.CompareTo(t.Last()) > 0),
                    (t1, t2) => t1.Concat(new T[] { t2 }));
        }
    }
}
