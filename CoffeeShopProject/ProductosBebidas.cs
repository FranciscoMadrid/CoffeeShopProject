using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace CoffeeShopProject
{
    class ProductosBebidas : Productos
    {
        public string Ingredientes { get; set; }
        public int FKBebidatamano { get; set; }
        public float Costo { get; set; }

        /*Esta clase se encarga en insertar y actualizar los contenidos en la tabla Productos y Bebidas*/

        public ProductosBebidas()
        {
            Id = 0;
            ProductoNombre = null;
            ProductoDesc = null;
            FKCategoria = 0;
            Ingredientes = null;
            FKBebidatamano = 0;
            Costo = 0;
        }

        public ProductosBebidas(int id, string productoNombre, string productoDesc, int fKCategoria, string ingredientes, int fkBebidatamano, float costo) 
                                : base(id, productoNombre, productoDesc, fKCategoria)
        {
            Ingredientes = ingredientes;
            FKBebidatamano = fkBebidatamano;
            Costo = costo;
        }


        /*Llama el SP que se encarga de insertar los datos en la tabla*/
        public override void InsertProducto()
        {
            try
            {
                string spNombre = @"[dbo].[sp_Productos_Bebidas_Insert]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProductoNombre", ProductoNombre);
                cmd.Parameters.AddWithValue("@ProductoDesc", ProductoDesc);
                cmd.Parameters.AddWithValue("@FKCategoriaID", FKCategoria);

                cmd.Parameters.AddWithValue("@Costo", Costo);

                if (!string.IsNullOrEmpty(Ingredientes))
                {
                    cmd.Parameters.AddWithValue("@Ingredientes", Ingredientes);
                }

                if (FKBebidatamano != 0)
                {
                    cmd.Parameters.AddWithValue("@TamanoBebida", FKBebidatamano);
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
        /*Funcion update para la tabla Producto. Requiere del ID que se puede obtener a traves de un datagrid y sacar el productoID que se desea actualizar.
            El SP lo hize de tal manera que si se ingresa null en algun campo lo ignora. Si da error por favor avisarme.
            -FFMS*/

        public override void UpdateProducto(int id)
        {
            try
            {
                string spNombre = @"[dbo].[sp_Productos_Bebidas_Update]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ProductoID", id);
                cmd.Parameters.AddWithValue("@ProductoNombre", ProductoNombre);
                cmd.Parameters.AddWithValue("@ProductoDesc", ProductoDesc);
                

                cmd.Parameters.AddWithValue("@Ingredientes", Ingredientes);
                cmd.Parameters.AddWithValue("@Costo", Costo);

                if (FKBebidatamano != 0)
                {
                    cmd.Parameters.AddWithValue("@FKBebidaTamanoID", FKBebidatamano);
                }

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
