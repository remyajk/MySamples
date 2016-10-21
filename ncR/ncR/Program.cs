using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ncR
{
    class Program
    {
        static void Main(string[] args)
        {
            List<int> teams = new List<int>() { 1, 2, 3, 4 };
            IEnumerable<IEnumerable<int>> result = ncr.GetKCombs(Enumerable.Range(1, 4), 2);
            //var result = ncr.CombinationsImpl(teams, 2);

            //Console.WriteLine(result);

            foreach (IEnumerable<int> item in result)
            {
                foreach (int n in item.ToList())
                {
                    Console.WriteLine(n);
                }



                Console.ReadLine();
            }


        }
    }
}
