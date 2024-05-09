using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace ClinicManagementSystem
{
    public partial class EditReservation : Form
    {
        SqlConnection con = new SqlConnection(Properties.Resources.connectionString);
        SqlCommand command;

        public EditReservation(Reservation res)
        {
            InitializeComponent();

            dateTimePicker1.Value = res.visit_date;

            textBox1.Text = res.id.ToString();
            textBox2.Text = res.patient.ToString();
            textBox3.Text = res.secretary.ToString();
            textBox4.Text = res.date.ToString();

            dateTimePicker1.MinDate = DateTime.Today;
            UpdateCombo(res.slot);
        }

        private void UpdateCombo(int visit_slot)
        {
            Dictionary<int, string> slots = Utils.GetSlots();

            command = con.CreateCommand();
            command.CommandText = "SELECT reservation_visit_slot FROM Reservation_clinic WHERE reservation_visit_Date=@date AND reservation_id <> @id";
            command.Parameters.AddWithValue("@date", dateTimePicker1.Value.ToString("yyyy-MM-dd"));
            command.Parameters.AddWithValue("@id", textBox1.Text);

            con.Open();

            SqlDataReader reader = command.ExecuteReader();

            while (reader.Read()) slots.Remove(reader.GetInt32(0));

            comboBox1.Items.Clear();

            foreach (KeyValuePair<int, string> slot in slots)
            {
                comboBox1.Items.Add(slot);
                if (slot.Key == visit_slot) comboBox1.SelectedItem = slot;
            }

            con.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            command = con.CreateCommand();
            command.CommandText = "Update Reservation_clinic SET reservation_visit_date=@visit_date, reservation_visit_slot=@visit_slot WHERE reservation_id=@id";
            command.Parameters.AddWithValue("@id", textBox1.Text);
            command.Parameters.AddWithValue("@visit_date", dateTimePicker1.Value.ToString("yyyy-MM-dd"));
            command.Parameters.AddWithValue("@visit_slot", ((KeyValuePair<int, string>)comboBox1.SelectedItem).Key);


            con.Open();
            if (command.ExecuteNonQuery() > 0) MessageBox.Show("Reservation updated successfully");
            else MessageBox.Show("Failed to update the reservation");

            con.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            command = con.CreateCommand();
            command.CommandText = "DELETE FROM Reservation_clinic WHERE reservation_id=@id";
            command.Parameters.AddWithValue("@id", textBox1.Text);

            con.Open();
            if (command.ExecuteNonQuery() > 0) MessageBox.Show("Reservation deleted successfully");
            else MessageBox.Show("Failed to delete the reservation");

            con.Close();
        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {
            UpdateCombo(1);
        }
    }
}
