using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace CoffeeShopProject
{
    class ProductosComidas : Productos
    {
        public string Ingredientes { get; set; }
        public float Costo { get; set; }

        /*Esta clase se encarga en insertar y actualizar los datos en la tabla Productos y Comidas*/
        public ProductosComidas()
        {
            Id = 0;
            ProductoNombre = null;
            ProductoDesc = null;
            FKCategoria = 0;
            Ingredientes = null;
            Costo = 0;
        }

        public ProductosComidas(int id,string productoNombre, string productoDesc, int fKCategoria, string ingredientes, float costo)
                                : base(id ,productoNombre, productoDesc, fKCategoria)
        {
            Ingredientes = ingredientes;
            Costo = costo;
        }

        /*Llama el SP que se encarga de insertar los datos en la tabla*/
        public override void InsertProducto()
        {
            try
            {
                string spNombre = @"[dbo].[sp_Productos_Comidas_Insert]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProductoNombre", ProductoNombre);
                cmd.Parameters.AddWithValue("@ProductoDesc", ProductoDesc);
                cmd.Parameters.AddWithValue("@FKCategoriaID", FKCategoria);
                cmd.Parameters.AddWithValue("@Ingredientes", Ingredientes);
                cmd.Parameters.AddWithValue("@Costo", Costo);

                sqlConnection.Open();
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
        /*Funcion update para la tabla Producto. Requiere del ID que se puede obtener a traves de un datagrid y sacar el productoID que se desea actualizar.
          El SP lo hize de tal manera que si se ingresa null en algun campo lo ignora. Si da error por favor avisarme.
          -FFMS*/

        public virtual void UpdateProducto(int id)
        {
            try
            {
                string spNombre = @"[dbo].[sp_Productos_Comidas_Update]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProductoID", id);
                cmd.Parameters.AddWithValue("@ProductoNombre", ProductoNombre);
                cmd.Parameters.AddWithValue("@ProductoDesc", ProductoDesc);
                cmd.Parameters.AddWithValue("@Ingredientes", Ingredientes);
                cmd.Parameters.AddWithValue("@Costo", Costo);

                if (FKCategoria != 0)
                {
                    cmd.Parameters.AddWithValue("@FKCategoriaID", FKCategoria);
                }

                sqlConnection.Open();
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

        public DataTable ShowProducto(string search)
        {
            DataTable dt = new DataTable();

            try
            {
                string spNombre = @"[dbo].[sp_Productos_Comidas_Show]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@NombreProducto", search);

                sqlConnection.Open();
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
    }
}
