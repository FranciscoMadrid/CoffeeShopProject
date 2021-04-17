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
using System.Threading;

namespace CoffeeShopProject
{
    /// <summary>
    /// Lógica de interacción para FormProductos.xaml
    /// </summary>
    public partial class FormProductos : Window
    {
        private Productos productos = new Productos();
        int TypeOfProducto = 0;

        ProductosBebidas Bebidas = new ProductosBebidas();
        ProductosComidas Comidas = new ProductosComidas();
        public FormProductos()
        {
            InitializeComponent();
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
            if (tbProductos.SelectedIndex == 0)
            {
                SetUpProductos();
            }
            if (tbProductos.SelectedIndex == 1)
            {
                SetUpBebidas();
            }
            if (tbProductos.SelectedIndex == 2)
            {
                SetUpComidas();
            }
        }

        private void txtbuscar_TextChanged(object sender, TextChangedEventArgs e)
        {
            switch(TypeOfProducto)
            {
                case 0:
                    dgProductoGenerales.ItemsSource = productos.SearchProducto(txtbuscar.Text).DefaultView;
                    break;

                case 1:
                    dgBebidas.ItemsSource = Bebidas.ShowProducto(txtbuscar.Text).DefaultView;
                    break;
                case 2:
                    dgComidas.ItemsSource = Comidas.ShowProducto(txtbuscar.Text).DefaultView;
                    break;
            }
        }

        private void SetUpProductos() 
        {
            gbProductoGeneral.Visibility = Visibility.Visible;
            gbBebidas.Visibility = Visibility.Hidden;
            gbComidas.Visibility = Visibility.Hidden;

            TypeOfProducto = 0;
            dgProductoGenerales.ItemsSource = productos.SearchProducto(txtbuscar.Text).DefaultView;
            cmbCategoria.ItemsSource = productos.GetCategory().DefaultView;

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

        private void SetUpComidas ()
        {
            gbProductoGeneral.Visibility = Visibility.Hidden;
            gbBebidas.Visibility = Visibility.Hidden;
            gbComidas.Visibility = Visibility.Visible;

            TypeOfProducto = 2;
            dgComidas.ItemsSource = Comidas.ShowProducto(txtbuscar.Text).DefaultView;
            cmbCategoriac.ItemsSource = Comidas.GetCategory().DefaultView;
        }

        private void btnIngresar_Click(object sender, RoutedEventArgs e)
        {
            switch(TypeOfProducto)
            {
                case 0:
                    InsertProductos();
                    ClearProductos();
                    break;
                case 1:
                    InsertBebida();
                    ClearBebidas();
                    break;
                case 2:
                    InsertComida();
                    ClearComida();
                    break;
            } 
        }

        private void btnModificar_Click(object sender, RoutedEventArgs e)
        {
            switch (TypeOfProducto)
            {
                case 0:
                    UpdateProductos();
                    ClearProductos();
                    break;

                case 1:
                    UpdateBebida();
                    ClearBebidas();
                    break;
                case 2:
                    UpdateComida();
                    ClearComida();
                    break;
            }
        }

        private void btnLimpiar_Click(object sender, RoutedEventArgs e)
        {
            switch(TypeOfProducto)
            {
                case 0:
                    ClearProductos();
                    break;
                case 1:
                    ClearBebidas();
                    break;
                case 2:
                    ClearComida();
                    break;
            }
            txtbuscar.Clear();
        }
        private void InsertProductos() 
        {
            if (CheckProductoData()) 
            {
                GetProductoData();
                productos.InsertProducto();
            }
        }

        private void UpdateProductos()
        {
            GetProductoData();
            productos.UpdateProducto(productos.Id);
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

        private void GetProductoData() 
        {
            if (!string.IsNullOrEmpty(txtId.Text))
            {
                productos.Id = int.Parse(txtId.Text);
            }
            productos.ProductoNombre = txtNombre.Text;
            productos.ProductoDesc = txtDescripcion.Text;

            if (cmbCategoria.SelectedIndex != -1)
            {
                productos.FKCategoria = int.Parse(cmbCategoria.SelectedValue.ToString());
            }
            
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

        private void ClearProductos() 
        {
            foreach (Control ctr in GridgbProducto.Children)
            {
                if (ctr.GetType() == typeof(TextBox))
                    ((TextBox)ctr).Text = string.Empty;
                if (ctr.GetType() == typeof(ComboBox))
                    ((ComboBox)ctr).SelectedIndex = -1;
            }
            dgProductoGenerales.ItemsSource = productos.SearchProducto(txtbuscar.Text).DefaultView;
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

        private void InsertComida()
        {
            if (CheckComidaData())
            {
                GetComidaData();
                Comidas.InsertProducto();
            }
        }

        private void UpdateComida()
        {
            GetComidaData();
            Comidas.UpdateProducto(Comidas.Id);
        }

        private bool CheckComidaData()
        {
            if (string.IsNullOrEmpty(txtNombreProductoc.Text) || string.IsNullOrEmpty(txtDescripcionc.Text) || string.IsNullOrEmpty(txtcostoc.Text))
            {
                MessageBox.Show("Por favor, llene todas las cajas con su informacion");
                return false;
            }
            if (cmbCategoriac.SelectedIndex == -1)
            {
                MessageBox.Show("Por favor, selecione la categoria del producto");
                return false;
            }
            return true;
        }
        private void GetComidaData()
        {
            if (!string.IsNullOrEmpty(txtIdc.Text))
            {
                Comidas.Id = int.Parse(txtIdc.Text);
            }
            Comidas.ProductoNombre = txtNombreProductoc.Text;
            Comidas.ProductoDesc = txtDescripcionc.Text;

            if (cmbCategoriac.SelectedIndex != -1)
            {
                Comidas.FKCategoria = int.Parse(cmbCategoriac.SelectedValue.ToString());
            }

            Comidas.Ingredientes = txtIngredientesc.Text;
            Comidas.Costo = float.Parse(txtcostoc.Text);
        }

        private void btnCancelar_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void ClearComida ()
        {
            foreach (Control ctr in GridgbComidas.Children)
            {
                if (ctr.GetType() == typeof(TextBox))
                    ((TextBox)ctr).Text = string.Empty;
                if (ctr.GetType() == typeof(ComboBox))
                    ((ComboBox)ctr).SelectedIndex = -1;
            }
            dgComidas.ItemsSource = Comidas.ShowProducto(txtbuscar.Text).DefaultView;
        }

        private void dgComidas_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataRowView dataRow = (DataRowView)dgComidas.SelectedItem;

            if (dataRow != null)
            {
                txtIdc.Text = dataRow[0].ToString();
                txtNombreProductoc.Text = dataRow[1].ToString();
                txtDescripcionc.Text = dataRow[2].ToString();

                txtcostoc.Text = dataRow[4].ToString();
            }
        }

        private void dgProductoGenerales_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DataRowView dataRow = (DataRowView)dgProductoGenerales.SelectedItem;
            if (dataRow != null)
            {
                txtId.Text = dataRow[0].ToString();
                txtNombre.Text = dataRow[1].ToString();
                txtDescripcion.Text = dataRow[2].ToString();
            }

        }

        private void btnRegresar_Click(object sender, RoutedEventArgs e)
        {
            FormMenu n2 = new FormMenu();
            n2.Show();
            this.Close();
        }
    }
}
