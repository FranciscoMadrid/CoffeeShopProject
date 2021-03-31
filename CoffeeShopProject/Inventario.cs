using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Windows;
using System.Dynamic;
using System.Security.Cryptography.X509Certificates;

namespace CoffeeShopProject
{
    class Inventario : BDConnection
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public string Categoria { get; set; }
        public double Costo { get; set; }
        public double Cantidad { get; set; }
        public DateTime Fecha { get; set; }


        //Clase para ingresar datos en la tabla empleado

        public Inventario(int id, string nombre, string categoria,double cantidad, double costo, DateTime fecha)
        {
            Id = id;
            Nombre = nombre;
            Categoria = categoria;
            Cantidad = cantidad;
            Costo = costo;
            Fecha = fecha;

        
        }
        public Inventario() 
        {
            Id = 0;
            Nombre = null;
            Categoria = null;
            Cantidad = 0;
            Costo = 0;
           

        }

        public virtual void InsertEmpleado() 
        {
            try
            {
                string spInventario = @"[dbo].[sp_Inventario_Insert]";

                SqlCommand cmd = new SqlCommand(spInventario, sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Nombre", Nombre);
                cmd.Parameters.AddWithValue("@Categoria", Categoria);
                cmd.Parameters.AddWithValue("@Cantidad", Cantidad);
                cmd.Parameters.AddWithValue("@Precio", Costo);
                cmd.Parameters.AddWithValue("@FechaInicial", Fecha);


                sqlConnection.Open();
                cmd.ExecuteNonQuery();
                MessageBox.Show("exitoso");


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
        //Funcion Update para la tabla Inventario
        public virtual void UpdateInventario(int id)
        {
            try
            {
                string spInventario = @"[dbo].[sp_Inventario_Update]";
                SqlCommand cmd = new SqlCommand(spInventario, sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@InventarioID", id);
                cmd.Parameters.AddWithValue("Nombre", Nombre);
                cmd.Parameters.AddWithValue("@Categoria", Categoria);
                cmd.Parameters.AddWithValue("@Cantidad", Cantidad);
                cmd.Parameters.AddWithValue("@Precio", Costo);
                cmd.Parameters.AddWithValue("@FechaInicial", Fecha);

                sqlConnection.Open();
                cmd.ExecuteNonQuery();
                MessageBox.Show("exitoso");

            }
            catch (Exception ex)
            {

                sqlConnection.Close();
                MessageBox.Show(ex.Message);
            }
        }
    }
}
