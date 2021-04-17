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
    }

        private void BtnE_Click(object sender, RoutedEventArgs e)
        {
             n2 = new FormInventario();
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
    }
}
