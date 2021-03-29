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
    /// Interaction logic for FormClientes.xaml
    /// </summary>
    public partial class FormClientes : Window
    {
        private Clientes clientes = new Clientes();

        private int id = 0;

        private bool InsertType = true;
        public FormClientes()
        {
            InitializeComponent();

            ShowClientes();
        }

        /*Checkers - Revisan que los datos sean validos*/
        private bool CheckClienteData ()
        {
            if (txtPrimerNombre.Text == string.Empty || txtApellido.Text == string.Empty)
            {
                MessageBox.Show("Por favor, ingrese valores en las cajas de textos.");
                return false;
            }
            if (cmbEstado.SelectedIndex == -1)
            {
                MessageBox.Show("Por favor, selecione un estado.");
                return false;
            }
            return true;
        }

        private bool CheckDatagridSelect()
        {
            if (dgDetallesClientes.SelectedIndex < 0)
            {
                MessageBox.Show("Por favor, selecione el cliente a modificar en la tabla.");
                return false;
            }
            else
            {
                return true;
            }
        }

        private bool CheckBusquedadData()
        {
            if (cmbTipoFiltro.SelectedIndex == 3 && cmbBusquedad.SelectedIndex == -1)
            {
                MessageBox.Show("Por favor, selecione el tipo de estado a buscar");
                return false;
            }
            else
            {
                return true;
            }

            if (txtBusqueda.Text == string.Empty || cmbTipoFiltro.SelectedIndex == -1)
            {
                MessageBox.Show("Por favor, ingrese todos los parametros necesarios para realizar la busquedad");
                return false;
            }
            else
            {
                return true;
            }
        }



        /*Show - Muestran los resultados en el datagrid*/
        private void ShowClientes()
        {
            dgDetallesClientes.ItemsSource = clientes.ShowCliente().DefaultView;
        }
       
        /*Get & Fill - Get: Agarra los datos y los guarda en el objecto Fill: Llena los textboxs con los datos selecionados*/
        private void GetDatosClientes()
        {
            clientes.Id = id;
            clientes.PrimerNombre = txtPrimerNombre.Text;
            clientes.UltimoNombre = txtApellido.Text;
            clientes.Estado = cmbEstado.SelectedIndex;
        }

        private void FillClienteData()
        {
            DataRowView dataRow = (DataRowView)dgDetallesClientes.SelectedItem;

            if (dataRow != null)
            {
                id = int.Parse(dataRow[0].ToString());
                txtPrimerNombre.Text = dataRow[1].ToString();
                txtApellido.Text = dataRow[2].ToString();

                /*Convierte el string a su valor segun el Enum Estados - Clase Clientes*/
                Clientes.Estados v = (Clientes.Estados)Enum.Parse(typeof(Clientes.Estados), dataRow[3].ToString());
                cmbEstado.SelectedIndex = ((int)v);
            }
        }

        /*Cleaner - Limpia los textboxes, comboboxes y variables*/
        private void Cleaner()
        {
            foreach (Control ctr in gridGBInfoCliente.Children)
            {
                if (ctr.GetType() == typeof(TextBox))
                    ((TextBox)ctr).Text = string.Empty;
                if (ctr.GetType() == typeof(ComboBox))
                    ((ComboBox)ctr).SelectedIndex = -1;
            }

            foreach (Control ctr in gridGBBusquedadClientes.Children)
            {
                if (ctr.GetType() == typeof(TextBox))
                    ((TextBox)ctr).Text = string.Empty;
                if (ctr.GetType() == typeof(ComboBox))
                    ((ComboBox)ctr).SelectedIndex = -1;
            }
            id = 0;
        }
        /*Select - Seleciona el case*/

        private void SelectBusquedad ()
        {
            int Select = cmbTipoFiltro.SelectedIndex;
            switch (Select)
            {
                case 0:
                    clientes.Id = int.Parse(txtBusqueda.Text);
                    break;
                case 1:
                    clientes.PrimerNombre = txtBusqueda.Text;
                    break;
                case 2:
                    clientes.UltimoNombre = txtBusqueda.Text;
                    break;
                case 3:
                    clientes.Estado = cmbBusquedad.SelectedIndex;
                    break;
            }
            dgDetallesClientes.ItemsSource = clientes.SearchCliente(Select).DefaultView;
        }

        /*Buttons--------------------------------------------------------------------------------------------*/
        private void btAgregar_Click(object sender, RoutedEventArgs e)
        {
           if(CheckClienteData())
            {
                if(InsertType)
                {
                    GetDatosClientes();
                    clientes.InsertCliente();
                }
                else
                {
                    GetDatosClientes();
                    clientes.UpdateCliente(clientes.Id);
                    btModificar.IsEnabled = true;
                    InsertType = true;
                }
                Cleaner();
                ShowClientes();
            }
        }

        private void btModificar_Click(object sender, RoutedEventArgs e)
        {
            if (CheckDatagridSelect())
            {
                FillClienteData();
                btModificar.IsEnabled = false;
                InsertType = false;
            }
        }

        private void btRegresar_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void btBuscar_Click(object sender, RoutedEventArgs e)
        {
            if (CheckBusquedadData())
            {
                SelectBusquedad();
            }
        }

        private void cmbTipoFiltro_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cmbTipoFiltro.SelectedIndex != 3)
            {
                txtBusqueda.Visibility = System.Windows.Visibility.Visible;
                cmbBusquedad.Visibility = System.Windows.Visibility.Hidden;
            }
            else
            {
                txtBusqueda.Visibility = System.Windows.Visibility.Hidden;
                cmbBusquedad.Visibility = System.Windows.Visibility.Visible;
            }
        }

        private void cmbEstado_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void btLimpiarC_Click(object sender, RoutedEventArgs e)
        {
            Cleaner();
        }

        private void dgDetallesClientes_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (!InsertType)
            {
                FillClienteData();
            }
        }

        private void btCancelar_Click(object sender, RoutedEventArgs e)
        {
            Cleaner();
            InsertType = true;
            btModificar.IsEnabled = true;
            ShowClientes();
        }
    }
}
