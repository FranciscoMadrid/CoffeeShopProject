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
        public string productoNombre { get; set; }
        public string productoDesc { get; set; }
        public int FKCategoria { get; set; }

        public Productos(string productoNombre, string productoDesc, int fKCategoria)
        {
            this.productoNombre = productoNombre;
            this.productoDesc = productoDesc;
            FKCategoria = fKCategoria;
        }

        public Productos()
        {
            productoNombre = null;
            productoDesc = null;
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

                cmd.Parameters.AddWithValue("@ProductoNombre", productoNombre);
                cmd.Parameters.AddWithValue("@ProductoDesc", productoDesc);
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
                cmd.Parameters.AddWithValue("@ProductoNombre", productoNombre);
                cmd.Parameters.AddWithValue("@ProductoDesc", productoDesc);
                
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
    }
}
