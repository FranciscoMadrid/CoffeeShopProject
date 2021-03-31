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
        }

        //Checkers para validar la entrada de datos validos en nuestros textbox

        private bool CheckInventarioData()
        {
            if ( txtCantidad.Text == string.Empty || txtcosto.Text == string.Empty)
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
                inventario.InsertInventario();
            }
        }
    }
}
