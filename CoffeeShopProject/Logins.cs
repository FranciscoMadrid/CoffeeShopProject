using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace CoffeeShopProject
{
    class Logins : EmpleadosUsuarios
    {
        public Logins()
        {
        }

        public int CheckCuenta()
        {
            int EmpleadoID = 0;
            try
            {
                string spNombre = @"[dbo].[sp_Empleados_EmpleadosUsuarios_Checker]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Usuario", Usuario);
                cmd.Parameters.AddWithValue("@Contrasena", Contrasena);

                cmd.Parameters.Add("@EmpleadoId", SqlDbType.Int);
                cmd.Parameters["@EmpleadoId"].Direction = ParameterDirection.Output;

                sqlConnection.Open();
                cmd.ExecuteNonQuery();

                EmpleadoID = int.Parse(cmd.Parameters["@EmpleadoId"].Value.ToString());
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);
            }
            finally
            {
                sqlConnection.Close();
            }
            return EmpleadoID;
        }

        public int GetTipoUsuario(int id)
        {
            int TipoUsuarioID = 0;
            try
            {
                string spNombre = @"[dbo].[sp_TipoUsuarios_ReturnType]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpleadoId", id);

                cmd.Parameters.Add("@TipoUsuarioID", SqlDbType.Int);
                cmd.Parameters["@TipoUsuarioID"].Direction = ParameterDirection.Output;

                sqlConnection.Open();
                cmd.ExecuteNonQuery();

                TipoUsuarioID = int.Parse(cmd.Parameters["@TipoUsuarioID"].Value.ToString());
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);
            }
            finally
            {
                sqlConnection.Close();
            }
            return TipoUsuarioID;
        }
    }
}
