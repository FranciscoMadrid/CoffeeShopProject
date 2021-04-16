﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace CoffeeShopProject
{
    class Productos : BDConnection
    {
        public int Id { get; set; }
        public string ProductoNombre { get; set; }
        public string ProductoDesc { get; set; }
        public int FKCategoria { get; set; }

        public Productos(int id, string productoNombre, string productoDesc, int fKCategoria)
        {
            Id = id;
            ProductoNombre = productoNombre;
            ProductoDesc = productoDesc;
            FKCategoria = fKCategoria;
        }

        public Productos()
        {
            Id = 0;
            ProductoNombre = null;
            ProductoDesc = null;
            FKCategoria = 0;
        }

        /*Clase para ingresar datos en la tabla Productos. SOLO LA TABLA Productos. Solo seria usada cuando solo se quieran alterar los datos en Productos.
          EJE: productoNombre, productoDesc y FKCategoria. Para hacer cambios en bebidas o comidas ir a ProductosComidas o ProductosBebidas*/
        public virtual void InsertProducto()
        {
            try
            {
                string spNombre = @"[dbo].[sp_Productos_Insert]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProductoNombre", ProductoNombre);
                cmd.Parameters.AddWithValue("@ProductoDesc", ProductoDesc);
                cmd.Parameters.AddWithValue("@FKCategoriaID", FKCategoria);

                sqlConnection.Open();
                cmd.ExecuteNonQuery();

                MessageBox.Show("All good");
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

        public virtual void UpdateProducto(int id)
        {
            try
            {
                string spNombre = @"[dbo].[sp_Productos_Update]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProductoID", id);
                cmd.Parameters.AddWithValue("@ProductoNombre", ProductoNombre);
                cmd.Parameters.AddWithValue("@ProductoDesc", ProductoDesc);
                
                if (FKCategoria != 0)
                {
                    cmd.Parameters.AddWithValue("@FKCategoria", FKCategoria);
                }

                sqlConnection.Open();
                cmd.ExecuteNonQuery();

                MessageBox.Show("All good");
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

        //public DataTable SearchProducto(int tipo)
        //{
        //    DataTable dt = new DataTable();

        //    try
        //    {
        //        sqlConnection.Open();
        //        string
        //    }
        //    catch { }
        //    finally { }

        //}



        //Query para mostrar los productos generales en el datashow
        public DataTable ShowProductoGeneral() 
        {
            DataTable dt = new DataTable();

            try
            {
                sqlConnection.Open();
                string spProductoGeneral = @"[dbo].[sp_Productos_Show]";
                SqlCommand cmd = new SqlCommand(spProductoGeneral,sqlConnection);
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

        public DataTable GetCategory()
        {
            DataTable dt = new DataTable();

            try
            {
                sqlConnection.Open();
                string spNombre = "SELECT CategoriaID, CategoriaDesc FROM Categorias";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);

                sda.Fill(dt);
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
    }
}
