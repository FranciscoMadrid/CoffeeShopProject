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
        public string ingredientes { get; set; }
        public float Costo { get; set; }

        /*Esta clase se encarga en insertar y actualizar los datos en la tabla Productos y Comidas*/
        public ProductosComidas()
        {
            productoNombre = null;
            productoDesc = null;
            FKCategoria = 0;
            this.ingredientes = null;
            Costo = 0;
        }

        public ProductosComidas(string productoNombre, string productoDesc, int fKCategoria, string ingredientes, float costo)
                          : base(productoNombre, productoDesc, fKCategoria)
        {
            this.ingredientes = ingredientes;
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

                cmd.Parameters.AddWithValue("@ProductoNombre", productoNombre);
                cmd.Parameters.AddWithValue("@ProductoDesc", productoDesc);
                cmd.Parameters.AddWithValue("@FKCategoriaID", FKCategoria);
                cmd.Parameters.AddWithValue("@Ingredientes", ingredientes);
                cmd.Parameters.AddWithValue("@Costo", Costo);

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
        /*Funcion update para la tabla Producto. Requiere del ID que se puede obtener a traves de un datagrid y sacar el productoID que se desea actualizar.
          El SP lo hize de tal manera que si se ingresa null en algun campo lo ignora. Si da error por favor avisarme.
          -FFMS*/

        public override void UpdateProducto(int id)
        {
            try
            {
                string spNombre = @"[dbo].[sp_Productos_Comidas_Update]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ProductoID", id);
                cmd.Parameters.AddWithValue("@ProductoNombre", productoNombre);
                cmd.Parameters.AddWithValue("@ProductoDesc", productoDesc);
                cmd.Parameters.AddWithValue("@Ingredientes", ingredientes);
                cmd.Parameters.AddWithValue("@Costo", Costo);

                if (FKCategoria != 0)
                {
                    cmd.Parameters.AddWithValue("@FKCategoriaID", FKCategoria);
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
