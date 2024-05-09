﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ClinicManagementSystem
{
    public partial class DoctorPanel : Form
    {
        int account_id;
        public DoctorPanel(int id)
        {
            InitializeComponent();
            account_id = id;
        }

        private void DoctorPanel_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Hide();  //To hide this form.
            EditProfile editProfile = new EditProfile(account_id);
            editProfile.ShowDialog();  //To call edit profile form
            Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Hide();
            ViewReservations viewReservations = new ViewReservations(account_id);
            viewReservations.ShowDialog();
            Show();
        }
    }
}
