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

        public EmpleadosUsuarios CheckCuenta()
        {
            EmpleadosUsuarios Emp = new EmpleadosUsuarios();
            try
            {
                string spNombre = @"[dbo].[sp_Empleados_EmpleadosUsuarios_Checker]";

                SqlCommand cmd = new SqlCommand(spNombre, sqlConnection);

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Usuario", Usuario);
                cmd.Parameters.AddWithValue("@Contrasena", Contrasena);

                cmd.Parameters.Add("@EmpleadoId", SqlDbType.Int);
                cmd.Parameters["@EmpleadoId"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@EmpleadoNombre", SqlDbType.VarChar, 70);
                cmd.Parameters["@EmpleadoNombre"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@EmpleadoApellido", SqlDbType.VarChar, 70);
                cmd.Parameters["@EmpleadoApellido"].Direction = ParameterDirection.Output;

                sqlConnection.Open();
                cmd.ExecuteNonQuery();

                Emp.Id = int.Parse(cmd.Parameters["@EmpleadoId"].Value.ToString());
                Emp.PrimerNombre = cmd.Parameters["@EmpleadoNombre"].Value.ToString();
                Emp.UltimoNombre = cmd.Parameters["@EmpleadoApellido"].Value.ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                sqlConnection.Close();
            }
            return Emp;
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
