using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace CoffeeShopProject
{
    class BDConnection
    {
        private static string SQLConnectionString = @"server = (local)\SQLEXPRESS; Initial Catalog = CoffeeShopDB; Integrated Security = True";

        protected SqlConnection sqlConnection = new SqlConnection(SQLConnectionString);

        public BDConnection()
        {
            
        }

        public void CheckConnection ()
        {
            try
            {
                sqlConnection.Open();
            }
            catch (Exception ex)
            {
                sqlConnection.Close();
                Console.WriteLine("Error: {0} {1}", ex.Message, ex.StackTrace);
            }
            finally
            {
                sqlConnection.Close();
            }
        }
        
    }
}
