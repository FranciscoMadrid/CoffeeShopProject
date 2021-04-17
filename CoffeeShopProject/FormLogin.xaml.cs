﻿using System;
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
    /// Interaction logic for FormLogin.xaml
    /// </summary>
    public partial class FormLogin : Window
    {
        Logins logins = new Logins();

        public FormLogin()
        {
            InitializeComponent();
        }

        private void txtUsuario_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void btnLogging_Click(object sender, RoutedEventArgs e)
        {
            if(CheckLoginData())
            {
                GetLoginData();
                if(CheckEmpleadoID(logins.CheckCuenta().Id))
                {
                    InfoLogin.EmpleadoID = logins.CheckCuenta().Id;
                    InfoLogin.EmpNombre = logins.CheckCuenta().PrimerNombre;
                    InfoLogin.EmpApellido = logins.CheckCuenta().UltimoNombre;
                    InfoLogin.TipoUsuario = logins.GetTipoUsuario(InfoLogin.EmpleadoID);

                    FormMenu n2 = new FormMenu();
                    n2.Show();
                    this.Close();
                }
                else
                {
                    MessageBox.Show("El usuario o la contraseña ingresada estan incorrectas.");
                }
                Clear();
            }
        }

        private bool CheckEmpleadoID (int id)
        {
            if (id != 0)
                return true;
            else
                return false;
        }

        private bool CheckLoginData ()
        {
            if (string.IsNullOrEmpty(txtUsuario.Text) || string.IsNullOrEmpty(txtContrasena.Text))
            {
                MessageBox.Show("Por favor, llene todas las casillas.");
                return false;
            }
            else
                return true;
        }

        private void GetLoginData ()
        {
            logins.Usuario = txtUsuario.Text;
            logins.Contrasena = txtContrasena.Text;
        }

        private void btnSalir_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void Clear()
        {
            txtContrasena.Clear();
            txtUsuario.Clear();
        }

        private void txtContrasena_TextChanged(object sender, TextChangedEventArgs e)
        {

        }
    }
}
