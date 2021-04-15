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
            CheckProductoData();
        }

        private bool CheckProductoData() 
        {
            if (txtNombre.Text == string.Empty || txtDescripcion.Text == string.Empty || cmbCategoria.Text == string.Empty)
            {
                MessageBox.Show("Porfavor Ingresar los datos necesarios en las cajas de texto");
                return false;
            }
            return true;
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

        private void GetDatosProducto() 
        {
            productos.Id = int.Parse(txtId.Text);
            productos.ProductoNombre = txtNombre.Text;
            productos.ProductoDesc = txtDescripcion.Text;

        }

        private void FillProductoData() 
        {
            DataRow dataRow = (DataRow)dgProductoGenerales.SelectedItem;
            if (dataRow != null)
            {
                txtId.Text = (dataRow[0].ToString());
                txtNombre.Text = (dataRow[1].ToString());
                txtDescripcion.Text = (dataRow[2].ToString());


            }
        }

        private void btnIngresar_Click(object sender, RoutedEventArgs e)
        {
            if (CheckProductoData())
            {
                productos.Id = int.Parse(txtId.Text);
                productos.ProductoNombre = txtNombre.Text;
                productos.FKCategoria = int.Parse(cmbCategoria.Text);

                productos.InsertProducto();

            }
            else 
            {
                MessageBox.Show("No es posible");
            }
        }

        private void btnModificar_Click(object sender, RoutedEventArgs e)
        {
            if (CheckProductoData())
            {
                productos.Id = int.Parse(txtId.Text);
                productos.ProductoNombre = txtNombre.Text;
                productos.ProductoDesc = txtDescripcion.Text;

                productos.UpdateProducto();

            }
            else 
            {
                MessageBox.Show("No es posible");   
            }
        }

        private void dgProductoGenerales_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            FillProductoData();
        }
    }
}
