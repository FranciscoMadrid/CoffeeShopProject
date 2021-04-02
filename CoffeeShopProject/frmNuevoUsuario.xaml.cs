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
    }
}
