using CoffeeShopProject;
using System;
using System.Windows;
using System.Windows.Input;
using System.Data.SqlClient;
using System.Windows.Media;
using System.Data;

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

            //
            loadTable();
            //
            btnmodificar.IsEnabled = false;
            btnregresar.IsEnabled = false;
            btnNewUser.IsEnabled = false;

        }

        public void loadTable()
        {
            SqlConnection conec = new SqlConnection(@"server = (local)\SQLEXPRESS; Initial Catalog = CoffeeShopDB; Integrated Security = True");

            string query = "Select * from Empleados";
            SqlCommand comando = new SqlCommand(query, conec);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = comando;
            DataTable tabla = new DataTable();
            adapter.Fill(tabla);
            dtempleados.ItemsSource = tabla.DefaultView;
        }
        string nombre, apellido, email, usuario, direccion, clave;
        int cargo, estado,id=0;

        private void dtempleados_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            DataRowView dataRow = (DataRowView)dtempleados.SelectedItem;
            
                
            if (dataRow != null)
            {
                id = Convert.ToInt32(dataRow[0].ToString());
                txtnombre.Text = dataRow[1].ToString();
                txtapellido.Text = dataRow[2].ToString();
                txtemail.Text = dataRow[3].ToString();
                txtdireccion.Text = dataRow[4].ToString();

                if (dataRow[5].ToString() == "1")
                {
                    cmbcargo.SelectedIndex = 0;
                }
                else
                {
                    cmbcargo.SelectedIndex = 2;
                }

                if (dataRow[5].ToString() == "1")
                {

                }
                //
                btningresar.IsEnabled = false;
                btnmodificar.IsEnabled = true;
                btnregresar.IsEnabled = true;
                btnNewUser.IsEnabled = true;

            }
            
        }

        private void btnmodificar_Click(object sender, RoutedEventArgs e)
        {
            if (validarCampos() == 1)
            {
                nombre = txtnombre.Text;
                apellido = txtapellido.Text;
                email = txtemail.Text;
                direccion = txtdireccion.Text;
                //cargo = cmbcargo.SelectedIndex;
                // clave = txtclave.ToString();

                if (cmbcargo.SelectedIndex == 0)
                {
                    cargo = 1;
                }
                else
                {
                    cargo = 2;
                }

                if (cmbestado.SelectedIndex == 0)
                {
                    estado = 1;
                }
                else
                {
                    estado = 0;
                }

                clsEmpleados data = new clsEmpleados(1, nombre, apellido, email, direccion, cargo, estado);
                data.UpdateEmpleado(id);
                loadTable();
                LimpiarForm();
                btnmodificar.IsEnabled = false;
                btnregresar.IsEnabled = false;
                btningresar.IsEnabled = true;


            }
        }

        private void dtempleados_Selected(object sender, RoutedEventArgs e)
        {
            //tnombre.Text= this.dtempleados.Items.oString();
        }

        private void btnregresar_Click(object sender, RoutedEventArgs e)
        {
            if (id != 0)
            {
                clsEmpleados data = new clsEmpleados(1, nombre, apellido, email, direccion, cargo, estado);
                data.EliminarEmpleado(id);
                loadTable();
                LimpiarForm();

                btnmodificar.IsEnabled = false;
                btnregresar.IsEnabled = false;
                btningresar.IsEnabled = true;
            }

            
        }

        private void btnNewUser_Click(object sender, RoutedEventArgs e)
        {
            new frmNuevoUsuario().Show();
        }

        private void LimpiarForm()
        {

            txtnombre.Text = "";
            txtapellido.Text = "";
            txtemail.Text = "";
            txtdireccion.Text = "";
            cmbcargo.SelectedIndex = 0;
            cmbestado.SelectedIndex = 0;
        }
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
        public int validarCampos( )
        {
            if (txtnombre.Text.Length < 2)
            {
                MessageBox.Show("Nombre Invalido", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                txtnombre.Clear();
                txtnombre.Focus();
                return 0;
            }
            else if (txtapellido.Text.Length < 2)
            {
                MessageBox.Show("Apellido Invalido", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                txtapellido.Clear();
                txtapellido.Focus();
                return 0;
            }
            else if (!txtemail.Text.Contains("@") || txtemail.Text.Length < 2)
            {
                MessageBox.Show("Email Invalido", "Alert", MessageBoxButton.OK, MessageBoxImage.Error);
                txtemail.Clear();
                txtemail.Focus();
                return 0;
            }
            else
            {
                return 1;
            }

        }

        private void btningresar_Click(object sender, RoutedEventArgs e)
        {
            if( validarCampos()==1)
            {
                //MessageBox.Show("Registro Exitoso", "Alert", MessageBoxButton.OK, MessageBoxImage.Information);
                //capturar valores
                nombre = txtnombre.Text;
                apellido = txtapellido.Text;
                email = txtemail.Text;
                direccion = txtdireccion.Text;
                cargo = cmbcargo.SelectedIndex;
                // clave = txtclave.ToString();

                if (cmbestado.SelectedIndex == 0)
                {

                }

                clsEmpleados data = new clsEmpleados(1, nombre, apellido, email, direccion, cargo, estado);
                data.InsertEmpleado();
                loadTable();
                LimpiarForm();
            }
        }
    }
}
