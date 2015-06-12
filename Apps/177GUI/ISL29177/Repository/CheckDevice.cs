/**********************************************************************
 Module     : Repository
 Created On : 1-sep-2013      
 Class file : DeviceUtil.cs
 This class provides :
 1) The methods to communicate with the device
 2) Work as a middle layer between APPLication and harware
 
 **************************************************************************/


using IntersilLib;
using System;
using System.Windows;
using System.Windows.Controls;

namespace Inersil_WPFV2.Repository
{
    /// <summary>
    /// This class works as an interface between application and harware.
    /// </summary>
    class DeviceUtil
    {
        /// <summary>
        /// Check device is connected or not
        /// </summary>
        /// <returns></returns>
        public static HIDStatus CheckDeviceStatus()
        {
            return HIDClass.CheckHIDConnStatus();
        }

        /// <summary>
        /// Search for the HID device.
        /// </summary>
        /// <returns>return true if HID device is detected</returns>
        public static bool SearchDevice()
        {
            HIDStatus hidStatus = DeviceUtil.Connect();
            //if device is not fount show the retry message box
            if (hidStatus == HIDStatus.Disconnect)
            {
                return ShowRetryMsgBox();
            }
            else
                return true;
        }

       
        #region Private Methods
        private static bool ShowRetryMsgBox()
        {
            string message = "Device is not connected.\n     Want to Retry ?";
            string caption = "Retry Again";
            MessageBoxButton buttons = MessageBoxButton.YesNo;
            MessageBoxImage icon = MessageBoxImage.Information;
            if (MessageBox.Show(message, caption, buttons, icon) == MessageBoxResult.Yes)
            {
                if (DeviceUtil.Connect() == HIDStatus.Pass)
                {
                    return true;
                }
                else
                    return ShowRetryMsgBox();
            }
            else
            {
                return false;
            }
        }



        /// <summary>
        /// Check for the HID device is connected to the system.
        /// If connected create a handle for the device
        /// </summary>
        /// <returns></returns>
        static HIDStatus Connect()
        {
            try
            {
                return HIDClass.Connect();

            }
            catch (Exception ex) { throw ex; }
        }
        #endregion


    }
}