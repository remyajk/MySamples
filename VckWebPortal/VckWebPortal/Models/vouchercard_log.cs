//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Globalization;
namespace VckWebPortal.Models
{

    public partial class vouchercard_log
    {
        public int ID { get; set; }
        public string unit_id { get; set; }
        public string time { get; set; }
        public DateTime ParsedDateTime { get { return DateTime.ParseExact(time, "yyyyMMdd HH:mm:ss", new CultureInfo("de-DE")); } }
        public string applicationname { get; set; }
        public string terminalid { get; set; }
        public string actseq { get; set; }
        public string aid { get; set; }
        public string refnumber { get; set; }
        public string trxrefnum { get; set; }
        public string authcode { get; set; }
        public string encryptedpan { get; set; }
        public int amount { get; set; }
        public string currency { get; set; }
        public decimal paymenttype { get; set; }
        public decimal tray { get; set; }
        public string printablecardnumber { get; set; }
        public bool exported { get; set; }
    }
}