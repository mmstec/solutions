using System;
using System.Globalization;
using System.Threading;
using System.Resources;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;
using System.Reflection;
using System.Text;
using System.Management;

namespace eventos.LIB
{

    public class FingerPrint
    {

        ///<sumary>
        /// Autor: Marcos
        /// Mostra impressao digital da maquina. Abaixo possíveis opções
        /// Win32_DiskDrive
        /// Win32_OperatingSystem
        /// Win32_Processor
        /// Win32_ComputerSystem
        /// Win32_StartupCommand
        /// Win32_ProgramGroup
        /// Win32_SystemDevices
        /// Exemplo: datagrid1.DataSource = GetStuff("Win32_DiskDrive");
        /// </summary> 
        /// <param name="string">Mostra impres</param>
        /// <returns>array</returns>
        public ArrayList GetStuff(string queryObject)
		{
			ManagementObjectSearcher searcher;
			int i = 0;
			ArrayList hd = new ArrayList();
			try
			{
				searcher = new ManagementObjectSearcher("SELECT * FROM " + queryObject);
				foreach(ManagementObject wmi_HD in searcher.Get())
				{
					i++;
					PropertyDataCollection searcherProperties = wmi_HD.Properties;
					foreach (PropertyData sp in searcherProperties) 
					{
						hd.Add(sp);
					}
				}
			}
			catch(Exception ex)
			{
				MessageBox.Show(ex.ToString());
			}
			return hd;
		}
    }
}