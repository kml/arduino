/*
 * Created by SharpDevelop.
 * User: kml
 * Date: 2009-03-28
 * Time: 13:05
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
namespace SerialPort
{
	partial class MainForm
	{
		/// <summary>
		/// Designer variable used to keep track of non-visual components.
		/// </summary>
		private System.ComponentModel.IContainer components = null;
		
		/// <summary>
		/// Disposes resources used by the form.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing) {
				if (components != null) {
					components.Dispose();
				}
			}
			base.Dispose(disposing);
		}
		
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent()
		{
			this.components = new System.ComponentModel.Container();
			this.serialPort1 = new System.IO.Ports.SerialPort(this.components);
			this.button1 = new System.Windows.Forms.Button();
			this.button2 = new System.Windows.Forms.Button();
			this.button3 = new System.Windows.Forms.Button();
			this.colorDialog1 = new System.Windows.Forms.ColorDialog();
			this.button6 = new System.Windows.Forms.Button();
			this.label1 = new System.Windows.Forms.Label();
			this.hex = new System.Windows.Forms.Label();
			this.comboBox1 = new System.Windows.Forms.ComboBox();
			this.SuspendLayout();
			// 
			// button1
			// 
			this.button1.Location = new System.Drawing.Point(12, 126);
			this.button1.Name = "button1";
			this.button1.Size = new System.Drawing.Size(75, 23);
			this.button1.TabIndex = 0;
			this.button1.Text = "Ustaw kolor";
			this.button1.UseVisualStyleBackColor = true;
			this.button1.Click += new System.EventHandler(this.Button1Click);
			// 
			// button2
			// 
			this.button2.Location = new System.Drawing.Point(12, 184);
			this.button2.Name = "button2";
			this.button2.Size = new System.Drawing.Size(178, 23);
			this.button2.TabIndex = 2;
			this.button2.Text = "Rozłącz";
			this.button2.UseVisualStyleBackColor = true;
			this.button2.Click += new System.EventHandler(this.Button2Click);
			// 
			// button3
			// 
			this.button3.Location = new System.Drawing.Point(12, 155);
			this.button3.Name = "button3";
			this.button3.Size = new System.Drawing.Size(75, 23);
			this.button3.TabIndex = 3;
			this.button3.Text = "Połącz";
			this.button3.UseVisualStyleBackColor = true;
			this.button3.Click += new System.EventHandler(this.Button3Click);
			// 
			// button6
			// 
			this.button6.Location = new System.Drawing.Point(93, 126);
			this.button6.Name = "button6";
			this.button6.Size = new System.Drawing.Size(98, 23);
			this.button6.TabIndex = 6;
			this.button6.Text = "Wybierz kolor...";
			this.button6.UseVisualStyleBackColor = true;
			this.button6.Click += new System.EventHandler(this.Button6Click);
			// 
			// label1
			// 
			this.label1.BackColor = System.Drawing.Color.Red;
			this.label1.Location = new System.Drawing.Point(16, 18);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(174, 84);
			this.label1.TabIndex = 7;
			// 
			// hex
			// 
			this.hex.Location = new System.Drawing.Point(122, 102);
			this.hex.Name = "hex";
			this.hex.Size = new System.Drawing.Size(85, 21);
			this.hex.TabIndex = 8;
			// 
			// comboBox1
			// 
			this.comboBox1.FormattingEnabled = true;
			this.comboBox1.Items.AddRange(new object[] {
									"COM1",
									"COM2",
									"COM3",
									"COM4"});
			this.comboBox1.Location = new System.Drawing.Point(94, 157);
			this.comboBox1.Name = "comboBox1";
			this.comboBox1.Size = new System.Drawing.Size(96, 21);
			this.comboBox1.TabIndex = 9;
			this.comboBox1.SelectedIndexChanged += new System.EventHandler(this.ComboBox1SelectedIndexChanged);
			// 
			// MainForm
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(208, 210);
			this.Controls.Add(this.comboBox1);
			this.Controls.Add(this.hex);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.button6);
			this.Controls.Add(this.button3);
			this.Controls.Add(this.button2);
			this.Controls.Add(this.button1);
			this.Name = "MainForm";
			this.Text = "LED Kolor";
			this.ResumeLayout(false);
		}
		private System.Windows.Forms.ComboBox comboBox1;
		private System.Windows.Forms.Label hex;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Button button6;
		private System.Windows.Forms.ColorDialog colorDialog1;
		private System.Windows.Forms.Button button3;
		private System.Windows.Forms.Button button2;
		private System.Windows.Forms.Button button1;
		private System.IO.Ports.SerialPort serialPort1;
	}
}
