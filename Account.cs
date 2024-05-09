using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ClinicManagementSystem
{
    public class Account
    {
        int id, type;
        string name;

        public Account(int id, string name, int type)
        {
            this.id = id;
            this.name = name;
            this.type = type;
        }

        public override string ToString()
        {
            string account_type;
            if (type == 0)
            {
                account_type = "Secretary";
            }
            else if (type == 1)
            {
                account_type = "Doctor";
            }
            else
                account_type = "Patient";

            return account_type + ": " + id.ToString() + " - " + name;
        }

        public int getID()
        {
            return id;
        }
    }
}