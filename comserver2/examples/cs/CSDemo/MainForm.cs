using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace CSDemo
{
	/// <summary>
	/// Zusammenfassung für MainForm.
	/// </summary>
	public class MainForm : System.Windows.Forms.Form {
		private System.ComponentModel.IContainer components;

		private Foobar2000Helper.ApplicationHelper07 helper;
		private Foobar2000.Application07 application;
		private Foobar2000.Playback07 playback;
		private System.Windows.Forms.Button buttonConnect;
		private System.Windows.Forms.Label labelConnectState;
		private Foobar2000.PlaybackSettings07 playbackSettings;
		private System.Windows.Forms.GroupBox groupBoxReplaygain;
		private System.Windows.Forms.CheckBox checkBoxApplyGain;
		private System.Windows.Forms.CheckBox checkBoxPreventClipping;
		private System.Windows.Forms.TrackBar trackBarPreampRG;
		private System.Windows.Forms.TrackBar trackBarPreampNoRG;
		private System.Windows.Forms.GroupBox groupBoxPreamp;
		private System.Windows.Forms.Label labelPreampRG;
		private System.Windows.Forms.Label labelPreampNoRG;
		private System.Windows.Forms.ComboBox comboBoxSourceMode;
		private System.Windows.Forms.Label labelSourceMode;
		private System.Windows.Forms.Button buttonClose;
		private System.Windows.Forms.Label labelPreampRGValue;
		private System.Windows.Forms.Label labelPreampNoRGValue;
		private System.Windows.Forms.GroupBox groupBoxVolume;
		private System.Windows.Forms.Label labelVolumeValue;
		private System.Windows.Forms.TrackBar trackBarVolume;
		private System.Windows.Forms.GroupBox groupBoxServer;
		private System.Windows.Forms.Label labelVersion;
		private System.Windows.Forms.TextBox textBoxVersion;
		private System.Windows.Forms.Label labelPath;
		private System.Windows.Forms.TextBox textBoxPath;
		private System.Windows.Forms.Label labelProfile;
		private System.Windows.Forms.TextBox textBoxProfile;
		private System.Windows.Forms.Button buttonRGUpate;
		private Foobar2000.ReplaygainSettings07 replaygainSettings;

		public MainForm() {
			//
			// Erforderlich für die Windows Form-Designerunterstützung
			//
			InitializeComponent();

			//
			// TODO: Fügen Sie den Konstruktorcode nach dem Aufruf von InitializeComponent hinzu
			//
			try {
				helper = new Foobar2000Helper.ApplicationHelper07Class();
				helper.ServerStateChanged += new Foobar2000Helper._IClientHelperEvents07_ServerStateChangedEventHandler(helper_ServerStateChanged);
				if (helper.Running)
					Connect();
			}
			catch (System.Runtime.InteropServices.COMException) {
				// ignore
			}
		}

		/// <summary>
		/// Die verwendeten Ressourcen bereinigen.
		/// </summary>
		protected override void Dispose( bool disposing ) {
			if( disposing ) {
				if (components != null) {
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Vom Windows Form-Designer generierter Code
		/// <summary>
		/// Erforderliche Methode für die Designerunterstützung. 
		/// Der Inhalt der Methode darf nicht mit dem Code-Editor geändert werden.
		/// </summary>
		private void InitializeComponent() {
			this.buttonConnect = new System.Windows.Forms.Button();
			this.labelConnectState = new System.Windows.Forms.Label();
			this.groupBoxReplaygain = new System.Windows.Forms.GroupBox();
			this.labelSourceMode = new System.Windows.Forms.Label();
			this.comboBoxSourceMode = new System.Windows.Forms.ComboBox();
			this.checkBoxPreventClipping = new System.Windows.Forms.CheckBox();
			this.checkBoxApplyGain = new System.Windows.Forms.CheckBox();
			this.groupBoxPreamp = new System.Windows.Forms.GroupBox();
			this.labelPreampNoRGValue = new System.Windows.Forms.Label();
			this.labelPreampRGValue = new System.Windows.Forms.Label();
			this.labelPreampNoRG = new System.Windows.Forms.Label();
			this.labelPreampRG = new System.Windows.Forms.Label();
			this.trackBarPreampRG = new System.Windows.Forms.TrackBar();
			this.trackBarPreampNoRG = new System.Windows.Forms.TrackBar();
			this.buttonClose = new System.Windows.Forms.Button();
			this.groupBoxVolume = new System.Windows.Forms.GroupBox();
			this.labelVolumeValue = new System.Windows.Forms.Label();
			this.trackBarVolume = new System.Windows.Forms.TrackBar();
			this.groupBoxServer = new System.Windows.Forms.GroupBox();
			this.labelVersion = new System.Windows.Forms.Label();
			this.textBoxVersion = new System.Windows.Forms.TextBox();
			this.labelPath = new System.Windows.Forms.Label();
			this.textBoxPath = new System.Windows.Forms.TextBox();
			this.labelProfile = new System.Windows.Forms.Label();
			this.textBoxProfile = new System.Windows.Forms.TextBox();
			this.buttonRGUpate = new System.Windows.Forms.Button();
			this.groupBoxReplaygain.SuspendLayout();
			this.groupBoxPreamp.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.trackBarPreampRG)).BeginInit();
			((System.ComponentModel.ISupportInitialize)(this.trackBarPreampNoRG)).BeginInit();
			this.groupBoxVolume.SuspendLayout();
			((System.ComponentModel.ISupportInitialize)(this.trackBarVolume)).BeginInit();
			this.groupBoxServer.SuspendLayout();
			this.SuspendLayout();
			// 
			// buttonConnect
			// 
			this.buttonConnect.Location = new System.Drawing.Point(328, 400);
			this.buttonConnect.Name = "buttonConnect";
			this.buttonConnect.TabIndex = 0;
			this.buttonConnect.Text = "Connect";
			this.buttonConnect.Click += new System.EventHandler(this.buttonConnect_Click);
			// 
			// labelConnectState
			// 
			this.labelConnectState.Location = new System.Drawing.Point(16, 400);
			this.labelConnectState.Name = "labelConnectState";
			this.labelConnectState.Size = new System.Drawing.Size(304, 16);
			this.labelConnectState.TabIndex = 1;
			this.labelConnectState.Text = "Not connected.";
			// 
			// groupBoxReplaygain
			// 
			this.groupBoxReplaygain.Controls.Add(this.buttonRGUpate);
			this.groupBoxReplaygain.Controls.Add(this.labelSourceMode);
			this.groupBoxReplaygain.Controls.Add(this.comboBoxSourceMode);
			this.groupBoxReplaygain.Controls.Add(this.checkBoxPreventClipping);
			this.groupBoxReplaygain.Controls.Add(this.checkBoxApplyGain);
			this.groupBoxReplaygain.Controls.Add(this.groupBoxPreamp);
			this.groupBoxReplaygain.Enabled = false;
			this.groupBoxReplaygain.Location = new System.Drawing.Point(8, 128);
			this.groupBoxReplaygain.Name = "groupBoxReplaygain";
			this.groupBoxReplaygain.Size = new System.Drawing.Size(496, 200);
			this.groupBoxReplaygain.TabIndex = 1;
			this.groupBoxReplaygain.TabStop = false;
			this.groupBoxReplaygain.Text = "Replaygain (does not automatically reflect changes made in foobar2000)";
			// 
			// labelSourceMode
			// 
			this.labelSourceMode.Location = new System.Drawing.Point(16, 24);
			this.labelSourceMode.Name = "labelSourceMode";
			this.labelSourceMode.Size = new System.Drawing.Size(100, 16);
			this.labelSourceMode.TabIndex = 6;
			this.labelSourceMode.Text = "Source mode:";
			// 
			// comboBoxSourceMode
			// 
			this.comboBoxSourceMode.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.comboBoxSourceMode.Items.AddRange(new object[] {
																	"None",
																	"Track",
																	"Album"});
			this.comboBoxSourceMode.Location = new System.Drawing.Point(152, 16);
			this.comboBoxSourceMode.Name = "comboBoxSourceMode";
			this.comboBoxSourceMode.Size = new System.Drawing.Size(121, 21);
			this.comboBoxSourceMode.TabIndex = 0;
			this.comboBoxSourceMode.SelectedIndexChanged += new System.EventHandler(this.comboBoxSourceMode_SelectedIndexChanged);
			// 
			// checkBoxPreventClipping
			// 
			this.checkBoxPreventClipping.Location = new System.Drawing.Point(16, 72);
			this.checkBoxPreventClipping.Name = "checkBoxPreventClipping";
			this.checkBoxPreventClipping.Size = new System.Drawing.Size(240, 24);
			this.checkBoxPreventClipping.TabIndex = 1;
			this.checkBoxPreventClipping.Text = "Use peak information to prevent clipping";
			this.checkBoxPreventClipping.CheckedChanged += new System.EventHandler(this.checkBoxPreventClipping_CheckedChanged);
			// 
			// checkBoxApplyGain
			// 
			this.checkBoxApplyGain.Location = new System.Drawing.Point(16, 48);
			this.checkBoxApplyGain.Name = "checkBoxApplyGain";
			this.checkBoxApplyGain.TabIndex = 0;
			this.checkBoxApplyGain.Text = "Apply gain";
			this.checkBoxApplyGain.CheckedChanged += new System.EventHandler(this.checkBoxApplyGain_CheckedChanged);
			// 
			// groupBoxPreamp
			// 
			this.groupBoxPreamp.Controls.Add(this.labelPreampNoRGValue);
			this.groupBoxPreamp.Controls.Add(this.labelPreampRGValue);
			this.groupBoxPreamp.Controls.Add(this.labelPreampNoRG);
			this.groupBoxPreamp.Controls.Add(this.labelPreampRG);
			this.groupBoxPreamp.Controls.Add(this.trackBarPreampRG);
			this.groupBoxPreamp.Controls.Add(this.trackBarPreampNoRG);
			this.groupBoxPreamp.Location = new System.Drawing.Point(16, 104);
			this.groupBoxPreamp.Name = "groupBoxPreamp";
			this.groupBoxPreamp.Size = new System.Drawing.Size(464, 80);
			this.groupBoxPreamp.TabIndex = 4;
			this.groupBoxPreamp.TabStop = false;
			this.groupBoxPreamp.Text = "Preamp";
			// 
			// labelPreampNoRGValue
			// 
			this.labelPreampNoRGValue.Location = new System.Drawing.Point(360, 48);
			this.labelPreampNoRGValue.Name = "labelPreampNoRGValue";
			this.labelPreampNoRGValue.Size = new System.Drawing.Size(88, 16);
			this.labelPreampNoRGValue.TabIndex = 7;
			this.labelPreampNoRGValue.Text = "N/A";
			// 
			// labelPreampRGValue
			// 
			this.labelPreampRGValue.Location = new System.Drawing.Point(360, 16);
			this.labelPreampRGValue.Name = "labelPreampRGValue";
			this.labelPreampRGValue.Size = new System.Drawing.Size(88, 16);
			this.labelPreampRGValue.TabIndex = 6;
			this.labelPreampRGValue.Text = "N/A";
			// 
			// labelPreampNoRG
			// 
			this.labelPreampNoRG.Location = new System.Drawing.Point(16, 56);
			this.labelPreampNoRG.Name = "labelPreampNoRG";
			this.labelPreampNoRG.Size = new System.Drawing.Size(100, 16);
			this.labelPreampNoRG.TabIndex = 5;
			this.labelPreampNoRG.Text = "Without RG info:";
			// 
			// labelPreampRG
			// 
			this.labelPreampRG.Location = new System.Drawing.Point(16, 24);
			this.labelPreampRG.Name = "labelPreampRG";
			this.labelPreampRG.Size = new System.Drawing.Size(100, 16);
			this.labelPreampRG.TabIndex = 4;
			this.labelPreampRG.Text = "With RG info:";
			// 
			// trackBarPreampRG
			// 
			this.trackBarPreampRG.AutoSize = false;
			this.trackBarPreampRG.LargeChange = 10;
			this.trackBarPreampRG.Location = new System.Drawing.Point(128, 16);
			this.trackBarPreampRG.Maximum = 120;
			this.trackBarPreampRG.Minimum = -120;
			this.trackBarPreampRG.Name = "trackBarPreampRG";
			this.trackBarPreampRG.Size = new System.Drawing.Size(232, 24);
			this.trackBarPreampRG.TabIndex = 2;
			this.trackBarPreampRG.TickFrequency = 10;
			this.trackBarPreampRG.Scroll += new System.EventHandler(this.trackBarPreampRG_Scroll);
			// 
			// trackBarPreampNoRG
			// 
			this.trackBarPreampNoRG.AutoSize = false;
			this.trackBarPreampNoRG.LargeChange = 10;
			this.trackBarPreampNoRG.Location = new System.Drawing.Point(128, 48);
			this.trackBarPreampNoRG.Maximum = 120;
			this.trackBarPreampNoRG.Minimum = -120;
			this.trackBarPreampNoRG.Name = "trackBarPreampNoRG";
			this.trackBarPreampNoRG.Size = new System.Drawing.Size(232, 24);
			this.trackBarPreampNoRG.TabIndex = 3;
			this.trackBarPreampNoRG.TickFrequency = 10;
			this.trackBarPreampNoRG.Scroll += new System.EventHandler(this.trackBarPreampNoRG_Scroll);
			// 
			// buttonClose
			// 
			this.buttonClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.buttonClose.Location = new System.Drawing.Point(424, 400);
			this.buttonClose.Name = "buttonClose";
			this.buttonClose.TabIndex = 2;
			this.buttonClose.Text = "&Close";
			this.buttonClose.Click += new System.EventHandler(this.buttonClose_Click);
			// 
			// groupBoxVolume
			// 
			this.groupBoxVolume.Controls.Add(this.labelVolumeValue);
			this.groupBoxVolume.Controls.Add(this.trackBarVolume);
			this.groupBoxVolume.Enabled = false;
			this.groupBoxVolume.Location = new System.Drawing.Point(8, 336);
			this.groupBoxVolume.Name = "groupBoxVolume";
			this.groupBoxVolume.Size = new System.Drawing.Size(496, 56);
			this.groupBoxVolume.TabIndex = 3;
			this.groupBoxVolume.TabStop = false;
			this.groupBoxVolume.Text = "Volume control";
			// 
			// labelVolumeValue
			// 
			this.labelVolumeValue.Location = new System.Drawing.Point(376, 24);
			this.labelVolumeValue.Name = "labelVolumeValue";
			this.labelVolumeValue.Size = new System.Drawing.Size(88, 16);
			this.labelVolumeValue.TabIndex = 9;
			this.labelVolumeValue.Text = "N/A";
			// 
			// trackBarVolume
			// 
			this.trackBarVolume.AutoSize = false;
			this.trackBarVolume.LargeChange = 10;
			this.trackBarVolume.Location = new System.Drawing.Point(24, 24);
			this.trackBarVolume.Maximum = 0;
			this.trackBarVolume.Minimum = -1000;
			this.trackBarVolume.Name = "trackBarVolume";
			this.trackBarVolume.Size = new System.Drawing.Size(352, 24);
			this.trackBarVolume.TabIndex = 8;
			this.trackBarVolume.TickFrequency = 10;
			this.trackBarVolume.Scroll += new System.EventHandler(this.trackBarVolume_Scroll);
			// 
			// groupBoxServer
			// 
			this.groupBoxServer.Controls.Add(this.textBoxProfile);
			this.groupBoxServer.Controls.Add(this.labelProfile);
			this.groupBoxServer.Controls.Add(this.textBoxPath);
			this.groupBoxServer.Controls.Add(this.labelPath);
			this.groupBoxServer.Controls.Add(this.textBoxVersion);
			this.groupBoxServer.Controls.Add(this.labelVersion);
			this.groupBoxServer.Enabled = false;
			this.groupBoxServer.Location = new System.Drawing.Point(8, 8);
			this.groupBoxServer.Name = "groupBoxServer";
			this.groupBoxServer.Size = new System.Drawing.Size(496, 112);
			this.groupBoxServer.TabIndex = 4;
			this.groupBoxServer.TabStop = false;
			this.groupBoxServer.Text = "Server information";
			// 
			// labelVersion
			// 
			this.labelVersion.Location = new System.Drawing.Point(16, 24);
			this.labelVersion.Name = "labelVersion";
			this.labelVersion.Size = new System.Drawing.Size(56, 16);
			this.labelVersion.TabIndex = 0;
			this.labelVersion.Text = "Version:";
			// 
			// textBoxVersion
			// 
			this.textBoxVersion.Location = new System.Drawing.Point(80, 16);
			this.textBoxVersion.Name = "textBoxVersion";
			this.textBoxVersion.ReadOnly = true;
			this.textBoxVersion.Size = new System.Drawing.Size(400, 20);
			this.textBoxVersion.TabIndex = 1;
			this.textBoxVersion.Text = "N/A";
			// 
			// labelPath
			// 
			this.labelPath.Location = new System.Drawing.Point(16, 56);
			this.labelPath.Name = "labelPath";
			this.labelPath.Size = new System.Drawing.Size(56, 16);
			this.labelPath.TabIndex = 2;
			this.labelPath.Text = "Path:";
			// 
			// textBoxPath
			// 
			this.textBoxPath.Location = new System.Drawing.Point(80, 48);
			this.textBoxPath.Name = "textBoxPath";
			this.textBoxPath.ReadOnly = true;
			this.textBoxPath.Size = new System.Drawing.Size(400, 20);
			this.textBoxPath.TabIndex = 3;
			this.textBoxPath.Text = "N/A";
			// 
			// labelProfile
			// 
			this.labelProfile.Location = new System.Drawing.Point(16, 88);
			this.labelProfile.Name = "labelProfile";
			this.labelProfile.Size = new System.Drawing.Size(56, 16);
			this.labelProfile.TabIndex = 4;
			this.labelProfile.Text = "Profile:";
			// 
			// textBoxProfile
			// 
			this.textBoxProfile.Location = new System.Drawing.Point(80, 80);
			this.textBoxProfile.Name = "textBoxProfile";
			this.textBoxProfile.ReadOnly = true;
			this.textBoxProfile.Size = new System.Drawing.Size(400, 20);
			this.textBoxProfile.TabIndex = 5;
			this.textBoxProfile.Text = "N/A";
			// 
			// buttonRGUpate
			// 
			this.buttonRGUpate.Location = new System.Drawing.Point(408, 16);
			this.buttonRGUpate.Name = "buttonRGUpate";
			this.buttonRGUpate.TabIndex = 7;
			this.buttonRGUpate.Text = "Refresh";
			this.buttonRGUpate.Click += new System.EventHandler(this.buttonRGUpate_Click);
			// 
			// MainForm
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 13);
			this.CancelButton = this.buttonClose;
			this.ClientSize = new System.Drawing.Size(512, 429);
			this.Controls.Add(this.groupBoxServer);
			this.Controls.Add(this.groupBoxVolume);
			this.Controls.Add(this.buttonClose);
			this.Controls.Add(this.groupBoxReplaygain);
			this.Controls.Add(this.buttonConnect);
			this.Controls.Add(this.labelConnectState);
			this.Name = "MainForm";
			this.Text = "C# Demo for foobar2000 automation server";
			this.groupBoxReplaygain.ResumeLayout(false);
			this.groupBoxPreamp.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.trackBarPreampRG)).EndInit();
			((System.ComponentModel.ISupportInitialize)(this.trackBarPreampNoRG)).EndInit();
			this.groupBoxVolume.ResumeLayout(false);
			((System.ComponentModel.ISupportInitialize)(this.trackBarVolume)).EndInit();
			this.groupBoxServer.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// Der Haupteinstiegspunkt für die Anwendung.
		/// </summary>
		[STAThread]
		static void Main() {
			Application.Run(new MainForm());
		}

		private void buttonConnect_Click(object sender, System.EventArgs e) {
			try {
				if (IsConnected) {
					Disconnect();
				} else {
					Connect();
				}
			} catch (Exception exc) {
				labelConnectState.Text = "Error: " + exc;
				MessageBox.Show(this, exc.ToString(), "Error");
			}
		}

		/// <summary>
		/// Get references to foobar2000 COM objects and update GUI.
		/// </summary>
		/// <remarks>
		/// This method will start foobar2000, if it is not running already.
		/// </remarks>
		private void Connect() {
			if (application == null) {
				if (helper != null) {
					application = (Foobar2000.Application07) helper.Server;
				}
				if (application == null)
					application = new Foobar2000.Application07Class();
				playback = application.Playback;
				playbackSettings = playback.Settings;
				replaygainSettings = playback.Replaygain;

				UpdateSettings();
			}
		}

		/// <summary>
		/// Release all references to foobar2000 COM objects and update GUI.
		/// </summary>
		private void Disconnect() {
			application = null;
			playback = null;
			playbackSettings = null;
			replaygainSettings = null;

			UpdateSettings();
		}

		/// <summary>
		/// Release all references to foobar2000 COM objects and update GUI.
		/// </summary>
		/// <param name="reason">Reason for disconnecting</param>
		private void Disconnect(string reason) {
			Disconnect();

			if (reason != null) {
				MessageBox.Show(this, reason, "Error");
			}
		}

		/// <summary>
		/// Release all references to foobar2000 COM objects and update GUI.
		/// </summary>
		/// <param name="reason">Exception that triggered disconnecting</param>
		private void Disconnect(System.Runtime.InteropServices.COMException exc) {
			Disconnect(exc.Message);
		}

		/// <summary>
		/// Convert RepaygainMode constant to index for combo box.
		/// </summary>
		/// <param name="mode">mode constant</param>
		/// <returns>combo box index</returns>
		private static int ToIndex(Foobar2000.fbReplaygainMode mode) {
			return (int)mode;
		}

		/// <summary>
		/// Convert combo box index to ReplaygainMode contant.
		/// </summary>
		/// <param name="index">combo box index</param>
		/// <returns>mode constant</returns>
		private static Foobar2000.fbReplaygainMode ToReplaygainMode(int index) {
			return (Foobar2000.fbReplaygainMode)index;
		}

		/// <summary>
		/// Convert preamp value in dB to track bar value.
		/// </summary>
		/// <param name="preamp">preamp value in dB</param>
		/// <returns>track bar value (clamped to -120 ... 120)</returns>
		private static int PreampToInt(double preamp) {
			return Math.Max(-120, Math.Min(120, (int)(preamp * 10)));
		}

		/// <summary>
		/// Convert track bar value to preamp value in dB
		/// </summary>
		/// <param name="value">track bar value</param>
		/// <returns>preamp value in dB</returns>
		private static double IntToPreamp(int value) {
			return value * 0.1;
		}

		/// <summary>
		/// Convert volume in dB to track bar value.
		/// </summary>
		/// <param name="volume">volumne in dB</param>
		/// <returns>track bar value (clamped to -1000 .. 0)</returns>
		private static int VolumeToInt(double volume) {
			return Math.Max(-1000, Math.Min(0, (int)(volume * 10)));
		}

		/// <summary>
		/// Convert track bar value to volume in dB.
		/// </summary>
		/// <param name="value">track bar value</param>
		/// <returns>volume in dB</returns>
		private static double IntToVolume(int value) {
			return value * 0.1;
		}

		/// <summary>
		/// Update GUI.
		/// </summary>
		private void UpdateSettings() {
			groupBoxServer.Enabled = IsConnected;
			groupBoxReplaygain.Enabled = IsConnected;
			groupBoxVolume.Enabled = IsConnected;

			if (IsConnected) {
				labelConnectState.Text = "Connected.";
				buttonConnect.Text = "Disconnect";
				try {
					textBoxVersion.Text = application.Name;
					textBoxPath.Text = application.ApplicationPath;
					textBoxProfile.Text = application.ProfilePath;
				} catch (System.Runtime.InteropServices.COMException exc) {
					Disconnect(exc);
					return;
				}
			} else {
				labelConnectState.Text = "Not connected.";
				buttonConnect.Text = "Connect";
				textBoxVersion.Text = "N/A";
				textBoxPath.Text = "N/A";
				textBoxProfile.Text = "N/A";
			}

			// Replaygain
			UpdateReplaygainSettings();

			// Volume control
			if (IsConnected) {
				try {
					trackBarVolume.Value = VolumeToInt(playbackSettings.Volume);
					UpdateVolumeValue(trackBarVolume, labelVolumeValue);

					playbackSettings.VolumeChanged += new Foobar2000._IVBPlaybackSettingsEvents_VolumeChangedEventHandler(this.playbackSettings_VolumeChanged);
				} catch (System.Runtime.InteropServices.COMException exc) {
					Disconnect(exc);
					return;
				}
			} else {
				trackBarVolume.Value = 0;
				labelVolumeValue.Text = "N/A";
			}
		}

		/// <summary>
		/// Update Replaygain section of GUI.
		/// </summary>
		private void UpdateReplaygainSettings() {
			if (IsConnected) {
				try {
					comboBoxSourceMode.SelectedIndex = ToIndex(replaygainSettings.Mode);
					checkBoxApplyGain.Checked = replaygainSettings.ApplyGain;
					checkBoxPreventClipping.Checked = replaygainSettings.PreventClipping;
					trackBarPreampRG.Value = PreampToInt(replaygainSettings.PreampWithRGInfo);
					UpdatePreampValue(trackBarPreampRG, labelPreampRGValue);
					trackBarPreampNoRG.Value = PreampToInt(replaygainSettings.PreampWithoutRGInfo);
					UpdatePreampValue(trackBarPreampNoRG, labelPreampNoRGValue);
				} catch (System.Runtime.InteropServices.COMException exc) {
					Disconnect(exc);
				}
			} else {
				comboBoxSourceMode.SelectedIndex = -1;
				checkBoxApplyGain.Checked = false;
				checkBoxPreventClipping.Checked = false;
				trackBarPreampRG.Value = 0;
				labelPreampRGValue.Text = "N/A";
				trackBarPreampNoRG.Value = 0;
				labelPreampNoRGValue.Text = "N/A";
			}
		}

		private static void UpdatePreampValue(System.Windows.Forms.TrackBar trackBar, System.Windows.Forms.Label label) {
			label.Text = IntToPreamp(trackBar.Value).ToString("+0.0;-0.0") + "dB";
		}

		private static void UpdateVolumeValue(System.Windows.Forms.TrackBar trackBar, System.Windows.Forms.Label label) {
			label.Text = IntToVolume(trackBar.Value).ToString("0.0;-0.0") + "dB";
		}

		private void buttonClose_Click(object sender, System.EventArgs e) {
			this.Close();
		}

		private void comboBoxSourceMode_SelectedIndexChanged(object sender, System.EventArgs e) {
			if (IsConnected) {
				try {
					replaygainSettings.Mode = ToReplaygainMode(comboBoxSourceMode.SelectedIndex);
				} catch (System.Runtime.InteropServices.COMException exc) {
					Disconnect(exc);
				}
			}
		}

		private void checkBoxApplyGain_CheckedChanged(object sender, System.EventArgs e) {
			if (IsConnected) {
				try {
					replaygainSettings.ApplyGain = checkBoxApplyGain.Checked;
				} catch (System.Runtime.InteropServices.COMException exc) {
					Disconnect(exc);
				}
			}
		}

		private void checkBoxPreventClipping_CheckedChanged(object sender, System.EventArgs e) {
			if (IsConnected) {
				try {
					replaygainSettings.PreventClipping = checkBoxPreventClipping.Checked;
				} catch (System.Runtime.InteropServices.COMException exc) {
					Disconnect(exc);
				}
			}
		}

		private void trackBarPreampRG_Scroll(object sender, System.EventArgs e) {
			if (IsConnected) {
				try {
					replaygainSettings.PreampWithRGInfo = IntToPreamp(trackBarPreampRG.Value);
					UpdatePreampValue(trackBarPreampRG, labelPreampRGValue);
				} catch (System.Runtime.InteropServices.COMException exc) {
					Disconnect(exc);
				}
			}
		}

		private void trackBarPreampNoRG_Scroll(object sender, System.EventArgs e) {
			if (IsConnected) {
				try {
					replaygainSettings.PreampWithoutRGInfo = IntToPreamp(trackBarPreampNoRG.Value);
					UpdatePreampValue(trackBarPreampNoRG, labelPreampNoRGValue);
				} catch (System.Runtime.InteropServices.COMException exc) {
					Disconnect(exc);
				}
			}
		}

		private void trackBarVolume_Scroll(object sender, System.EventArgs e) {
			if (IsConnected) {
				try {
					playbackSettings.Volume = IntToPreamp(trackBarVolume.Value);
					UpdateVolumeValue(trackBarVolume, labelVolumeValue);
				} catch (System.Runtime.InteropServices.COMException exc) {
					Disconnect(exc);
				}
			}
		}

		private void playbackSettings_VolumeChanged(double volume) {
			trackBarVolume.Value = VolumeToInt(volume);
			UpdateVolumeValue(trackBarVolume, labelVolumeValue);
		}

		private void buttonRGUpate_Click(object sender, System.EventArgs e) {
			UpdateReplaygainSettings();
		}

		private bool IsConnected {
			get {
				return application != null;
			}
		}

		private void helper_ServerStateChanged(bool running) {
			if (running)
				Connect();
			else
				Disconnect();
		}
	}
}
