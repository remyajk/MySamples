using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using NorthwindClient.ServiceReference1;

namespace NorthwindClient
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            northwindEntities proxy = new northwindEntities(new Uri("http://localhost:55003/NorthwindCustomers.svc/"));
            this.customersBindingSource.DataSource = proxy.Customers;


        }
    }
}
