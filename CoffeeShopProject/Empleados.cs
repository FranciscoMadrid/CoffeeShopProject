using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace CoffeeShopProject
{
    class Empleados : BDConnection
    {
        public int Id { get; set; }
        public string PrimerNombre { get; set; }
        public string UltimoNombre { get; set; }
        public string Correo { get; set; }
        public string Direccion { get; set; }
        public int FKCargo { get; set; }
        public int Estado { get; set; }

        /*Clase para ingresar datos en la tabla empleado. SOLO LA TABLA EMPLEADO. Solo seria usada cuando solo se quieran alterar los datos en Empleados.
          EJE: Primernombre, ultimo nombre, correo, direcion, cargo o estado. Para hacer cambios en el usuario y la contraseña utilizar EmpleadosUsuarios*/
        public Empleados(int id, string primerNombre, string ultimoNombre, string correo, string direccion, int fKCargo, int estado)
        {
            Id = id;
            PrimerNombre = primerNombre;
            UltimoNombre = ultimoNombre;
            Correo = correo;
            Direccion = direccion;
            FKCargo = fKCargo;
            Estado = estado;
        }

        public Empleados()
        {
            Id = 0;
            PrimerNombre = null;
            UltimoNombre = null;
            Correo = null;
            Direccion = null;
            FKCargo = 0;
            Estado = 2;
        }
        /*Llama el SP que se encarga de insertar los datos en la tabla*/
        public virtual void InsertEmpleado()
        {
            try
            {
                string spNombre = @"[dbo].[sp_Empleados_Insert]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PrimerNombre", PrimerNombre);
                cmd.Parameters.AddWithValue("@UltimoNombre", UltimoNombre);
                cmd.Parameters.AddWithValue("@Correo", Correo);
                cmd.Parameters.AddWithValue("@Direccion", Direccion);
                cmd.Parameters.AddWithValue("@FKCargoID", FKCargo);
                cmd.Parameters.AddWithValue("@Estado", Estado);


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

        /*Funcion update para la tabla empleado. Requiere del ID que se puede obtener a traves de un datagrid y sacar el EmpleadoID que se desea actualizar.
          El SP lo hize de tal manera que si se ingresa null en algun campo lo ignora. Si da error por favor avisarme.
          -FFMS*/
        public virtual void UpdateEmpleado(int id)
        {
            try
            {
                string spNombre = @"[dbo].[sp_Empleados_Update]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@EmpleadoID", id);
                cmd.Parameters.AddWithValue("@PrimerNombre", PrimerNombre);
                cmd.Parameters.AddWithValue("@UltimoNombre", UltimoNombre);
                cmd.Parameters.AddWithValue("@Correo", Correo);
                cmd.Parameters.AddWithValue("@Direccion", Direccion);

                if (Estado != 2)
                {
                    cmd.Parameters.AddWithValue("@Estado", Estado);
                }

                if (FKCargo != 0)
                {
                    cmd.Parameters.AddWithValue("@FKCargoID", FKCargo);
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
