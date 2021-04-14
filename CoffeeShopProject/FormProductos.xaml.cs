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
using System.Data;
using System.Data.SqlClient;

namespace CoffeeShopProject
{
    /// <summary>
    /// Lógica de interacción para FormProductos.xaml
    /// </summary>
    public partial class FormProductos : Window
    {
        private Productos productos = new Productos();
        public FormProductos()
        {
            InitializeComponent();
            ShowProductoGeneral();  
        }

        private void TabControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (tbProductos.SelectedIndex == 1)
            {
                gbProductoGeneral.Visibility = Visibility.Hidden;
            }
            if (tbProductos.SelectedIndex == 0) 
            {
                gbProductoGeneral.Visibility = Visibility.Visible;
            }

        }

        private void ShowProductoGeneral() 
        {
            dgProductoGenerales.ItemsSource = productos.ShowProductoGeneral().DefaultView;
        }


    }
}
