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

namespace CoffeeShopProject
{
    /// <summary>
    /// Lógica de interacción para FormProductos.xaml
    /// </summary>
    public partial class FormProductos : Window
    {
        int TypeOfProducto = 0;

        ProductosBebidas Bebidas = new ProductosBebidas();
        public FormProductos()
        {
            InitializeComponent();
        }

        private void TabControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (tbProductos.SelectedIndex == 0)
            {
                gbProductoGeneral.Visibility = Visibility.Visible;
                gbBebidas.Visibility = Visibility.Hidden;
                gbComidas.Visibility = Visibility.Hidden;

                TypeOfProducto = 0;
            }
            if (tbProductos.SelectedIndex == 1)
            {
                SetUpBebidas();
            }
            if (tbProductos.SelectedIndex == 2)
            {
                gbProductoGeneral.Visibility = Visibility.Hidden;
                gbBebidas.Visibility = Visibility.Hidden;
                gbComidas.Visibility = Visibility.Visible;

                TypeOfProducto = 2;
            }
        }

        private void txtbuscar_TextChanged(object sender, TextChangedEventArgs e)
        {
            switch(TypeOfProducto)
            {
                case 1:
                    dgBebidas.ItemsSource = Bebidas.ShowProducto(txtbuscar.Text).DefaultView;
                    break;
            }
        }

        private void SetUpBebidas ()
        {
            gbProductoGeneral.Visibility = Visibility.Hidden;
            gbBebidas.Visibility = Visibility.Visible;
            gbComidas.Visibility = Visibility.Hidden;

            TypeOfProducto = 1;
            dgBebidas.ItemsSource = Bebidas.ShowProducto(txtbuscar.Text).DefaultView;

            cmbCategoriab.ItemsSource = Bebidas.GetCategory().DefaultView;
            cmbTamano.ItemsSource = Bebidas.GetTamano().DefaultView;
        }

        private void btnIngresar_Click(object sender, RoutedEventArgs e)
        {
            switch(TypeOfProducto)
            {
                case 1:
                    InsertBebida();
                    break;
            }
            ClearBebidas();
        }

        private void btnModificar_Click(object sender, RoutedEventArgs e)
        {
            switch (TypeOfProducto)
            {
                case 1:
                    UpdateBebida();
                    break;
            }
            ClearBebidas();
        }

        private void btnLimpiar_Click(object sender, RoutedEventArgs e)
        {
            ClearBebidas();
            txtbuscar.Clear();
        }
        private void InsertBebida()
        {
            if(CheckBebidaData())
            {
                GetBebidaData();
                Bebidas.InsertProducto();
            }
        }

        private void UpdateBebida()
        {
                GetBebidaData();
                Bebidas.UpdateProducto(Bebidas.Id);
        }
        private void GetBebidaData ()
        {
            if(!string.IsNullOrEmpty(txtIdb.Text))
            {
                Bebidas.Id = int.Parse(txtIdb.Text);
            }

            Bebidas.ProductoNombre = txtNombreb.Text;
            Bebidas.ProductoDesc = txtDescripcionb.Text;

            if (cmbCategoriab.SelectedIndex != -1)
            {
                Bebidas.FKCategoria = int.Parse(cmbCategoriab.SelectedValue.ToString());
            }

            Bebidas.Ingredientes = txtIngredienteb.Text;

            if (cmbTamano.SelectedIndex != -1)
            {
                Bebidas.FKCategoria = int.Parse(cmbCategoriab.SelectedValue.ToString());
            }

            Bebidas.Costo = float.Parse(txtCostob.Text);
        }

        private bool CheckBebidaData ()
        {
            if (string.IsNullOrEmpty(txtNombreb.Text) || string.IsNullOrEmpty(txtDescripcionb.Text) || string.IsNullOrEmpty(txtCostob.Text))
            {
                MessageBox.Show("Por favor, llene todas las cajas con su informacion");
                return false;
            }
            if (cmbCategoriab.SelectedIndex == -1)
            {
                MessageBox.Show("Por favor, selecione la categoria del producto");
                return false;
            }

            return true;
        }

        private void dgBebidas_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataRowView dataRow = (DataRowView)dgBebidas.SelectedItem;

            if(dataRow != null)
            {
                txtIdb.Text = dataRow[0].ToString();
                txtNombreb.Text = dataRow[1].ToString();
                txtDescripcionb.Text = dataRow[2].ToString();

                txtCostob.Text = dataRow[5].ToString();
            }
        }

        private void ClearBebidas()
        {
            foreach (Control ctr in GridgbBebidas.Children)
            {
                if (ctr.GetType() == typeof(TextBox))
                    ((TextBox)ctr).Text = string.Empty;
                if (ctr.GetType() == typeof(ComboBox))
                    ((ComboBox)ctr).SelectedIndex = -1;
            }
            dgBebidas.ItemsSource = Bebidas.ShowProducto(txtbuscar.Text).DefaultView;
        }

        private void btnCancelar_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
