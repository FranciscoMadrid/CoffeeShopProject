using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data;
using System.Data.SqlClient;

namespace CoffeeShopProject
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private Inventario inventario = new Inventario();
        private int id = 0;
        public MainWindow()
        {
            InitializeComponent();
            ShowInventario();
            ShowProducto();
            //BDConnection connection = new BDConnection();
            //connection.CheckConnection();

        }

        

        //Checkers para validar la entrada de datos validos en nuestros textbox

        private bool CheckInventarioData()
        {
            if ( txtCantidad.Text == string.Empty || txtcosto.Text == string.Empty )
            {
                MessageBox.Show("Porfavor Ingrese los datos necesarios en las cajas de texto");
                return false;
            }
            return true;
        }



        private void btnIngresar_Click(object sender, RoutedEventArgs e)
        {
            if (CheckInventarioData())
            {
                inventario.Id = int.Parse(txtId.Text);
                inventario.Cantidad = double.Parse(txtCantidad.Text);
                inventario.Costo = double.Parse(txtcosto.Text);
                inventario.Fecha =  dtFecha.ToString(); 

                inventario.InsertInventario();
                
            }
            else 
            {
                MessageBox.Show("No es posible");
            }
        
        
        }

        //Esto nos muestra los productos en el datagridview
        private void ShowInventario() 
        {
            
                dgproductos.ItemsSource = inventario.ShowProducto().DefaultView;
            
            
                //dgproductos.ItemsSource = inventario.ShowInventario().DefaultView;
           
            
        }
        //Esto nos muestra la tabla Inventario
        private void ShowProducto() 
        {
            dgInventario.ItemsSource = inventario.ShowInventario().DefaultView;
        }

        private void GetDatosInventario() 
        {
            inventario.Id = int.Parse(txtId.Text);
            //inventario.Cantidad = txtCantidad.Text;
            inventario.Costo = double.Parse(txtcosto.Text);
        
        }

        private void FillProductoData() 
        {
            DataRowView dataRow = (DataRowView)dgproductos.SelectedItem;
            if (dataRow != null)
            {
                txtId.Text    = (dataRow[0].ToString());
                txtcosto.Text = (dataRow[4].ToString());


            }

        }
        private void FillInventarioData() 
        {
            DataRowView dataRow = (DataRowView)dgInventario.SelectedItem;
            if (dataRow != null)
            {
                lblInventarioID.Content = (dataRow[0].ToString());
                txtId.Text = (dataRow[1].ToString());
                txtCantidad.Text = (dataRow[2].ToString());
                txtcosto.Text = (dataRow[3].ToString());
                
            }
        }

        private void dgproductos_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            FillProductoData();
            
        }

        private void dgInventario_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            FillInventarioData();
        }

        private void btnModificar_Click(object sender, RoutedEventArgs e)
        {
            if (CheckInventarioData())
            {
                inventario.Id = int.Parse(txtId.Text);
                inventario.InvID = int.Parse(lblInventarioID.Content.ToString());
                inventario.Cantidad = double.Parse(txtCantidad.Text);
                inventario.Costo = double.Parse(txtcosto.Text);
                inventario.Fecha = dtFecha.ToString();

                inventario.UpdateInventario();

            }
            else 
            {
                MessageBox.Show("Something is wrong");
            }

            
           
        }

        private void ClearInventario() 
        {
            txtId.Text = "";
            txtcosto.Text ="";
            txtCantidad.Text = "";
          
        }

        private void btnLimpiar_Click(object sender, RoutedEventArgs e)
        {
            ClearInventario();
        }
    }
}
