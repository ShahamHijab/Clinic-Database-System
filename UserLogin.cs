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
    public partial class UserLogin : Form
    {
        public UserLogin()
        {
            InitializeComponent();
            textBox2.PasswordChar = '*';
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string connectionString = ClinicManagementSystem.Properties.Resources.connectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand command = con.CreateCommand();  //For writing SQL Commands.
            command.CommandText = "SELECT user_id FROM [User] WHERE user_username=@username AND user_password=@password";
            command.Parameters.AddWithValue("@username", textBox1.Text);
            command.Parameters.AddWithValue("@password", textBox2.Text);
            //Utils.hashPassword(textBox2.Text);
            con.Open();
            var result = command.ExecuteScalar();
            //Returns values of first column and first row. We're using single attributes here.
            con.Close();

            if(result != null)
            {
                //Authenticated
                if (textBox1.Text == "admin")
                {
                    //Admin Panel displayed here
                    Hide();
                    AdminPanel adminPanel = new AdminPanel();
                    adminPanel.ShowDialog();
                    Show();
                }
                else
                {
                    command.Parameters.Clear();
                    con.Open();
                    command.CommandText = "SELECT account_id, account_type FROM accounts_clinic WHERE account_user_id=@user_id";
                    //To get record where there's match between account_user_id and user_id from our last query
                    command.Parameters.AddWithValue("@user_id", result.ToString());
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        int account_id = reader.GetInt32(0);
                        int account_type = reader.GetInt32(1);

                        //To check our account type:
                        if(account_type == 0)
                        {
                            //Open Secretary Panel
                            Hide();
                            SecretaryPanel secretaryPanel = new SecretaryPanel(account_id);
                            secretaryPanel.ShowDialog();
                            Show();
                        }
                        else if (account_type == 1)
                        {
                            //Open Doctor Panel
                            Hide();
                            DoctorPanel doctorPanel = new DoctorPanel(account_id);
                            doctorPanel.ShowDialog();
                            Show();
                        }
                    }
                    con.Close();
                }
            }
            else
            {
                //Authentication Error
                MessageBox.Show("Authentication Failed.");
            }
        }

        private void UserLogin_Load(object sender, EventArgs e)
        {
            Utils.CreateAdmin("123");
        }
    }
}
