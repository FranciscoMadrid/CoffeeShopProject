using System;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media;

namespace proyecto
{
    /// <summary>
    /// Interaction logic for Empleados.xaml
    /// </summary>
    public partial class Empleados : Window
    {
        public Empleados()
        {
            InitializeComponent();
            System.Windows.Media.BrushConverter bc = new BrushConverter();
            Brush brush = (Brush)bc.ConvertFrom("#C7DFFC");
            brush.Freeze();
            panel1.Background = brush;
            cmbcargo.SelectedIndex = 0;
            cmbestado.SelectedIndex = 0;
            
        }
        string nombre, apellido, email, usuario, direccion, cargo, estado, clave;

        private void txtnombre_KeyDown(object sender, KeyEventArgs e)
        {

        }

        private void txtnombre_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int character = Convert.ToInt32(Convert.ToChar(e.Text));
            if ((character >= 65 && character <= 90) || (character >= 97 && character <= 122))
                e.Handled = false;
            else
                e.Handled = true;
        }

        private void txtapellido_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            int character = Convert.ToInt32(Convert.ToChar(e.Text));
            if ((character >= 65 && character <= 90) || (character >= 97 && character <= 122))
                e.Handled = false;
            else
                e.Handled = true;
        }

        private void txtusuario_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {

        }

        private void btningresar_Click(object sender, RoutedEventArgs e)
        {
            if (txtnombre.Text.Length < 2 )
            {
                MessageBox.Show("Nombre Invalido", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                txtnombre.Clear();
                txtnombre.Focus();
            }
            else if (txtapellido.Text.Length<2)
            {
                MessageBox.Show("Apellido Invalido", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                txtapellido.Clear();
                txtapellido.Focus();
            }
            else if (!txtemail.Text.Contains("@") || txtemail.Text.Length<2) {
                MessageBox.Show("Email Invalido", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                txtemail.Clear();
                txtemail.Focus();
            }
            else if (txtusuario.Text.Length > 8)
            {
                MessageBox.Show("Usuario Invalido, solo 8 caracteres", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                txtusuario.Clear();
                txtusuario.Focus();
            }
            else if (txtclave.ToString().Length < 2)
            {
                MessageBox.Show("Clave Invalida", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                txtclave.Clear();
                txtclave.Focus();
            }
            else
            {
                MessageBox.Show("Registro Exitoso", "Alert", MessageBoxButton.OK, MessageBoxImage.Information);
                //capturar valores
                nombre = txtnombre.Text;
                apellido = txtapellido.Text;
                email = txtemail.Text;
                direccion = txtdireccion.Text;
                cargo = cmbcargo.SelectedValue.ToString();
                estado = cmbestado.SelectedValue.ToString();
                clave = txtclave.ToString();
            }
        }
    }
}
