﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Windows;

namespace CoffeeShopProject
{
    class BDConnection
    {
        private static string SQLConnectionString = @"server = (local); Initial Catalog = CoffeeShopDB; Integrated Security = True;";

        protected SqlConnection sqlConnection = new SqlConnection (SQLConnectionString);

        public BDConnection()
        {

        }

        public void CheckConnection() 
        {
            try
            {

                sqlConnection.Open();
                MessageBox.Show("all good  " + sqlConnection.Database.ToString());
               
            }
            catch (Exception ex)
            {
                sqlConnection.Close();
                MessageBox.Show(ex.Message);


            }

            finally 
            {
                sqlConnection.Close();
            }
        }


    }
}
