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
    public partial class AdminPanel : Form
    {
        public AdminPanel()
        {
            InitializeComponent();
        }

        private void UpdateList(string query)
        {
            SqlConnection con = new SqlConnection(Properties.Resources.connectionString);
            SqlCommand command = con.CreateCommand();
            con.Open();
            command.CommandText = "SELECT account_id, account_name, account_type FROM accounts_clinic WHERE account_type IN (0, 1) AND (account_name LIKE @query OR account_phone LIKE @query) ORDER BY account_type";
            command.Parameters.AddWithValue("query", query + "%");

            SqlDataReader reader = command.ExecuteReader();

            listBox1.Items.Clear();
            while (reader.Read())
                listBox1.Items.Add(new Account(reader.GetInt32(0), reader.GetString(1), reader.GetInt32(2)));

            con.Close();
        }

        private void AdminPanel_Load(object sender, EventArgs e)
        {
            UpdateList("");
        }

        //
        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
        //
        private void textBox10_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {
            UpdateList(textBox4.Text);
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int account_id;
            try
            {
                account_id = ((Account)listBox1.SelectedItem).getID();
            }
            catch (Exception)
            {
                return;
            }

            SqlConnection con = new SqlConnection(Properties.Resources.connectionString);
            SqlCommand command = con.CreateCommand();
            command.CommandText = "SELECT user_username, account_name, account_dob, account_phone, account_type, account_notes, account_creation_date FROM [User], accounts_clinic WHERE user_id=account_user_id AND account_id=@id";
            command.Parameters.AddWithValue("@id", account_id);
            con.Open();

            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                textBox5.Text = account_id.ToString();
                textBox6.Text = reader.GetValue(0).ToString();
                textBox7.Text = reader.GetValue(1).ToString();
                textBox8.Text = reader.GetValue(2).ToString();
                textBox9.Text = reader.GetValue(3).ToString();

                if (reader.GetInt32(4) == 0)
                {
                    textBox10.Text = "Secretary";
                }
                else
                {
                    textBox10.Text = "Doctor";
                }

                richTextBox2.Text = reader.IsDBNull(5) ? string.Empty : reader.GetString(5);
                textBox11.Text = reader.GetValue(6).ToString();

            }

            con.Close();
        }

        //
        private void richTextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private bool ValidateInputs()
        {
            if (textBox1.Text == "" || textBox2.Text == "" || textBox3.Text == "") return false;
            if (comboBox1.SelectedIndex < 0) return false;

            return true;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (!ValidateInputs())
            {
                MessageBox.Show("Please recheck your input fields.");
                return;
            }

            SqlConnection con = new SqlConnection(Properties.Resources.connectionString);
            SqlCommand command = con.CreateCommand();

            //Creating account for a user:
            command.CommandText = "INSERT INTO [User] (user_username, user_password) VALUES (@username, @password)";
            command.Parameters.AddWithValue("@username", textBox1.Text);
            command.Parameters.AddWithValue("@password", textBox2.Text);
            con.Open();

            if (command.ExecuteNonQuery() > 0)
            {
                //We created record in user table
                command.CommandText = "SELECT user_id FROM [User] WHERE user_username=@username";
                int user_id = (int)command.ExecuteScalar();
                //We use ExecuteScalar() to fetch only one value

                command.CommandText = "INSERT INTO accounts_clinic (account_user_id, account_name, account_type, account_dob, account_phone, account_notes, account_creation_date) VALUES (@user_id, @name, @type, @dob, @phone, @notes, @date)";
                command.Parameters.Clear();
                command.Parameters.AddWithValue("@user_id", user_id);
                command.Parameters.AddWithValue("@name", textBox3.Text);
                command.Parameters.AddWithValue("@type", comboBox1.SelectedIndex);
                command.Parameters.AddWithValue("@dob", SqlDbType.DateTime).Value = dateTimePicker1.Value.Date;
                command.Parameters.AddWithValue("@phone", textBox13.Text);
                command.Parameters.AddWithValue("@notes", richTextBox1.Text);
                command.Parameters.AddWithValue("@date", DateTime.Now);

                if (command.ExecuteNonQuery() > 0)
                {
                    //Account created
                    MessageBox.Show("Account created successfully");
                }
                else
                {
                    MessageBox.Show("Error while creating account");
                }
            }
            else
            {
                MessageBox.Show("Error while creating account");
            }
            con.Close();
            UpdateList("");
        }

        //
        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
