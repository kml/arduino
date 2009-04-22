/*
 * Created by SharpDevelop.
 * User: kml
 * Date: 2009-03-28
 * Time: 13:05
 * 
 */

using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
using System.IO.Ports;

namespace SerialPort
{
	/// <summary>
	/// Description of MainForm.
	/// </summary>
	public partial class MainForm : Form
	{
		public MainForm()
		{
			//
			// The InitializeComponent() call is required for Windows Forms designer support.
			//
			InitializeComponent();
			
			button1.Enabled = false;
			button2.Enabled = false;
			
			//System.Drawing.Color c = new System.Drawing.Color();
			//c.
			
			//label1.BackColor = Color.FromName("red");
			hex.Text = "#FF0000";
			
			comboBox1.SelectedIndex = 0;
			//
			// TODO: Add constructor code after the InitializeComponent() call.
			//
		}
		
		// Ustaw kolor
		void Button1Click(object sender, EventArgs e)
		{
			serialPort1.Write(hex.Text);
		}
		
		// Rozłącz
		void Button2Click(object sender, EventArgs e)
		{
			serialPort1.Close();
			
			button1.Enabled = false;
			button2.Enabled = false;
			button3.Enabled = true;
		}
		
		// Połącz
		void Button3Click(object sender, EventArgs e)
		{
			serialPort1.PortName = comboBox1.Text;
			serialPort1.BaudRate = 9600;
			serialPort1.DataBits = 8;
			serialPort1.Parity = Parity.None;
			serialPort1.StopBits = StopBits.One;
			
			try {
				serialPort1.Open();
				button3.Enabled = false;
				button1.Enabled = true;
				button2.Enabled = true;
			} catch (System.IO.IOException) {
				MessageBox.Show("Nie można otworzyć podanego portu.", "Błąd");//, MessageBoxButtons::OK, MessageBoxIcon::Exclamation);
			}
		}
		
		// Wybierz kolor
		void Button6Click(object sender, EventArgs e)
		{
			colorDialog1.AllowFullOpen = false;
			colorDialog1.FullOpen = false;
			
			if(colorDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK){
				this.label1.BackColor = colorDialog1.Color;
				hex.Text = color2hex(colorDialog1.Color);
			}
		}
		
		string color2hex(System.Drawing.Color color){
			// use .ToString ("X2") to get the leading 0 where necessary
			return "#"+color.R.ToString("X2")+color.G.ToString("X2")+color.B.ToString("X2");
		}
		
		void ComboBox1SelectedIndexChanged(object sender, EventArgs e)
		{
			
		}
	}
}
