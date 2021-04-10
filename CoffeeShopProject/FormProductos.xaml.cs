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
    /// Lógica de interacción para FormProductos.xaml
    /// </summary>
    public partial class FormProductos : Window
    {
        public FormProductos()
        {
            InitializeComponent();
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
    }
}
