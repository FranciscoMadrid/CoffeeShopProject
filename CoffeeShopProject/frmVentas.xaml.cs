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
using System.Data.SqlClient;
using System.Windows.Media;
using System.Data;


namespace CoffeeShopProject
{
    /// <summary>
    /// Interaction logic for frmVentas.xaml
    /// </summary>
    public partial class frmVentas : Window
    {
        //private const string V = "";

        public frmVentas()
        {
            InitializeComponent();
            txtfecha.Text=DateTime.Now.ToString("dd-MM-yyyy");
        }

        List<datos> dat = new List<datos>();

        private void txtdato_KeyUp(object sender, KeyEventArgs e)
        {
            loadTableCliente(txtdato.Text);
        }
        public void loadTableCliente(string dato)
        {
            SqlConnection conec = new SqlConnection(@"server = (local)\SQLEXPRESS; Initial Catalog = CoffeeShopDB; Integrated Security = True");

            string query = "Select * from Clientes Where PrimerNombre Like '%"+dato+"%' or IdClientre ="+dato+"";
            SqlCommand comando = new SqlCommand(query, conec);
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = comando;
            DataTable tabla = new DataTable();
            adapter.Fill(tabla);
            dtcliente.ItemsSource = tabla.DefaultView;
        }

        private void btnaddProd_Click(object sender, RoutedEventArgs e)
        {
            dat.Add(new datos {fact=txtfactura.Text ,id = int.Parse(txtidProd.Text), prod=txtproducto.Text , precio=double.Parse(txtprecio.Text), cant = int.Parse(txtcant.Text), total= double.Parse(txtneto.Text)});
            dtresumen.ItemsSource = dat;
        }

       class datos
        {
           public string fact { get; set;}
            public int id { get; set;}
            public string prod { get; set; }
            public double precio { get; set;}
            public int cant { get; set;}
            public double total { get; set;}
   
        }

        public void LoadProd(string dato)
        {
            try {
                SqlConnection conec = new SqlConnection(@"server = (local)\SQLEXPRESS; Initial Catalog = CoffeeShopDB; Integrated Security = True");

                string query = "select a.ProductoID,a.ProductoNombre,b.Precio from Productos as a join Inventario as b on a.ProductoID=b.FKProductoID WHERE a.ProductoID =" + dato+"";
                SqlCommand comando = new SqlCommand(query, conec);
                SqlDataAdapter adapter = new SqlDataAdapter();
                adapter.SelectCommand = comando;
                SqlDataAdapter da = new SqlDataAdapter(comando);
                DataTable dt = new DataTable();
                da.Fill(dt);
                conec.Open();
                SqlDataReader reader = comando.ExecuteReader();
                if (reader.Read()) {
                    txtproducto.Text = Convert.ToString(reader["ProductoNombre"]);
                    txtprecio.Text = Convert.ToString(reader["Precio"]);
                }
                

            } catch (Exception e) {
                MessageBox.Show(e.ToString());
            };
        }

        private void txtidProd_KeyUp(object sender, KeyEventArgs e)
        {
            LoadProd(txtidProd.Text);
        }

        private void txtcant_KeyUp(object sender, KeyEventArgs e)
        {
            double total;
            total = (Convert.ToDouble(txtcant.Text) * Convert.ToDouble(txtprecio.Text));
            txtneto.Text = Convert.ToString(total);
        }

        private void dtcliente_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

   

      




    }
}
