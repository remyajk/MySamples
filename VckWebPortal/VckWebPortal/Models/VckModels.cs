using System.Collections.Generic;
using System.Linq;

namespace VckWebPortal.Models
{
    public class VckModels
    {
        private List<vouchercard_log> _voucherCardLog;
        private List<hw_dispenser_trays> _hw_dispenser_trays;

        public List<vouchercard_log> VoucherCardLogs { get { return _voucherCardLog; } set { _voucherCardLog = value; } }
        public List<hw_dispenser_trays> HwDispenserTrays { get { return _hw_dispenser_trays; } set { _hw_dispenser_trays = value; } }
        public int TrayId { get; set; }
        public int NumOfCards { get; set; }
        public bool IncludeDetails { get; set; }
        public EndOfShiftReport_Result EndOfShiftReportResult { get; set; }
        public string Currency { get { return new Entities().vouchercard_log.FirstOrDefault().currency; } }

        
    }
}