using proyecto;
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
    /// Lógica de interacción para FormMenu.xaml
    /// </summary>
    public partial class FormMenu : Window
    {
        public FormMenu()
        {
            InitializeComponent();
            CheckUser(InfoLogin.TipoUsuario);
            SetWelcome();
        }
        private void CheckUser(int UserId)
        {
            switch(UserId)
            {
                case 1:
                    LoginUser();
                    break;
                default:
                    break;
            }
        }

        private void SetWelcome()
        {
            tbBievenida.Text = "Bievenido/a, " + InfoLogin.EmpApellido + " " + InfoLogin.EmpNombre + ".";
        }
        private void LoginUser()
        {
            BtnE.IsEnabled = false;
            BtnInventario.IsEnabled = false;
            BtnProductos.IsEnabled = false;
        }
        private void BtnE_Click(object sender, RoutedEventArgs e)
        {
            Empleados n2 = new Empleados();
            n2.Show();
            this.Close();
        }

        private void BtnInventario_Click(object sender, RoutedEventArgs e)
        {
            FormInventario n2 = new FormInventario();
            n2.Show();
            this.Close();
        }

        private void btLogout_Click(object sender, RoutedEventArgs e)
        {
            FormLogin n2 = new FormLogin();
            n2.Show();
            this.Close();
        }

        private void BtnClientes_Click(object sender, RoutedEventArgs e)
        {
            FormClientes n2 = new FormClientes();
            n2.Show();
            this.Close();
        }

        private void BtnProductos_Click(object sender, RoutedEventArgs e)
        {
            FormProductos n2 = new FormProductos();
            n2.Show();
            this.Close();
        }
    }
}
