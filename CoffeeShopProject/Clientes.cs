using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace CoffeeShopProject
{
    class Clientes : BDConnection
    {
        public enum Estados
        {
            Desactivado = 0,
            Activado = 1
        }

        public int Id { get; set; }
        public string PrimerNombre { get; set; }
        public string UltimoNombre { get; set; }
        public int Estado { get; set; }

        public Clientes(int id, string primerNombre, string ultimoNombre, int estado)
        {
            Id = id;
            PrimerNombre = primerNombre;
            UltimoNombre = ultimoNombre;
            Estado = estado;
        }

        public Clientes ()
        {
            Id = 0;
            PrimerNombre = null;
            UltimoNombre = null;
            Estado = 2;
        }

        public void InsertCliente ()
        {
            try
            {
                sqlConnection.Open();

                string spNombre = @"[dbo].[sp_Clientes_Insert]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PrimerNombre", PrimerNombre);
                cmd.Parameters.AddWithValue("@UltimoNombre", UltimoNombre);
                cmd.Parameters.AddWithValue("@Estado", Estado);
                cmd.ExecuteNonQuery();
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

        public void UpdateCliente(int id)
        {
            try
            {
                sqlConnection.Open();

                string spNombre = @"[dbo].[sp_Clientes_Update]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ClienteID", id);
                cmd.Parameters.AddWithValue("@PrimerNombre", PrimerNombre);
                cmd.Parameters.AddWithValue("@UltimoNombre", UltimoNombre);
                
                if(Estado != 2)
                {
                    cmd.Parameters.AddWithValue("@Estado", Estado);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Estado", System.DBNull.Value);
                }

                cmd.ExecuteNonQuery();
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
        public DataTable ShowCliente()
        {
            DataTable dt = new DataTable();
            try
            {
                sqlConnection.Open();

                string spNombre = @"[dbo].[sp_Clientes_Show]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
                SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);

                dataAdapter.Fill(dt);
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
            return dt;
        }

        public DataTable SearchCliente(int tipo)
        {
            DataTable dt = new DataTable();
            try
            {
                sqlConnection.Open();

                string spNombre = @"[dbo].[sp_Clientes_Search]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@TipoBusquedad", tipo);
                cmd.Parameters.AddWithValue("@PrimerNombre", PrimerNombre);
                cmd.Parameters.AddWithValue("@UltimoNombre", UltimoNombre);
                if (Estado != 2)
                {
                    cmd.Parameters.AddWithValue("@Estado", Estado);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Estado", System.DBNull.Value);
                }

                if (Id != 0)
                {
                    cmd.Parameters.AddWithValue("@ClienteID", Id);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@ClienteID", System.DBNull.Value);
                }

                SqlDataAdapter dataAdapter = new SqlDataAdapter(cmd);
                dataAdapter.Fill(dt);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);
            }
            finally
            {
                sqlConnection.Close();
            }
            return dt;
        }
    }
}
