using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace CoffeeShopProject
{
    class EmpleadosUsuarios : Empleados
    {
        public int FKTipoUsuario { get; set; }
        public string Usuario { get; set; }
        public string Contrasena { get; set; }

        
        public EmpleadosUsuarios()
        {
            PrimerNombre = null;
            UltimoNombre = null;
            Correo = null;
            Direccion = null;
            FKCargo = 0;
            Estado = 2;
            FKTipoUsuario = 0;
            Usuario = null;
            Contrasena = null;
        }

        public EmpleadosUsuarios(string primerNombre, string ultimoNombre, string correo, string direccion, int fKCargo, int estado, int fKTipoUsuario, string usuario, string contrasena) 
                                 : base(primerNombre, ultimoNombre, correo, direccion, fKCargo, estado)
        {
            FKTipoUsuario = fKTipoUsuario;
            Usuario = usuario;
            Contrasena = contrasena;
        }

        public override void InsertEmpleado()
        {
            try
            {
                string spNombre = @"[dbo].[sp_Empleados_EmpleadosUsuarios_Insert]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@PrimerNombre", PrimerNombre);
                cmd.Parameters.AddWithValue("@UltimoNombre", UltimoNombre);
                cmd.Parameters.AddWithValue("@Correo", Correo);
                cmd.Parameters.AddWithValue("@Direccion", Direccion);
                cmd.Parameters.AddWithValue("@FKCargo", FKCargo);
                cmd.Parameters.AddWithValue("@Estado", Estado);

                cmd.Parameters.AddWithValue("@FKTipoUsuario", FKTipoUsuario);
                cmd.Parameters.AddWithValue("@Usuario", Usuario);
                cmd.Parameters.AddWithValue("@Contrasena", Contrasena);

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
        public override void UpdateEmpleado(int id)
        {
            try
            {
                string spNombre = @"[dbo].[sp_Empleados_EmpleadosUsuarios_Update]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@EmpleadoID", id);
                cmd.Parameters.AddWithValue("@PrimerNombre", PrimerNombre);
                cmd.Parameters.AddWithValue("@UltimoNombre", UltimoNombre);
                cmd.Parameters.AddWithValue("@Correo", Correo);
                cmd.Parameters.AddWithValue("@Direccion", Direccion);

                if(Estado != 2)
                {
                    cmd.Parameters.AddWithValue("@Estado", Estado);
                }

                if(FKCargo != 0)
                {
                    cmd.Parameters.AddWithValue("@FKCargoID", FKCargo);
                }

                if(FKTipoUsuario != 0)
                {
                    cmd.Parameters.AddWithValue("@FKTipoUsuario", FKTipoUsuario);
                }

                cmd.Parameters.AddWithValue("@Usuario", Usuario);
                cmd.Parameters.AddWithValue("@Contrasena", Contrasena);

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
