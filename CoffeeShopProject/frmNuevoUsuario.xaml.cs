using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace CoffeeShopProject
{
    /// <summary>
    /// Interaction logic for frmNuevoUsuario.xaml
    /// </summary>
    public partial class frmNuevoUsuario : Window
    {
        public frmNuevoUsuario()
        {
            InitializeComponent();
            cmbtipousuario.Items.Add("Administrativo");
            cmbtipousuario.Items.Add("Vendedor");

        }
        clsEmpleados emp = new clsEmpleados();
        int tipo;
        public Boolean Validar()
        {
            if (txtusuario.Text != "")
            {
                if (txtclave.Password.ToString() !="" && txtconfirmarclave.Password.ToString() !="" && txtclave.Password.ToString() == txtconfirmarclave.Password.ToString())
                {
                   
                    if (cmbtipousuario.SelectedIndex == 0)
                    {
                        tipo = 1;

                    }
                    else
                    {
                        tipo = 2;
                    }
                    return true;
                }
                return false;
            }
            return false;
        }

        private void btnregistrar_Click(object sender, RoutedEventArgs e)
        {
            if (Validar())
            {
                
                emp.InsertEmpleadoUsuario( clsEmpleados.idUser, tipo, txtusuario.Text, txtclave.Password.ToString());
                this.Close();
            }
            else
            {
                MessageBox.Show("No se pudo registrar");
            }
        }
    }
}
