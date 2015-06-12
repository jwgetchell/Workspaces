
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IntersilLib
{
    public class HIDDeviceIO
    {


        #region Private Data member
        dynamic api_status;
        #endregion

        public Int16 ReadRegister(HIDRegRead oReg)
        {
            List<byte> reg = new List<byte>();
            Int16 status = 0;
            for (int i = 0; i <= oReg.NumRegBytes - 1; i++)
            {
                reg.Add(Convert.ToByte(oReg.StartRegRD));
                //reg(i) = CByte("&H" & txtStartRegRD.Text)
            }
            // byte[] data = new byte[1];
            List<byte> data = new List<byte>();
            if ((status=ReadI2C(oReg, data, reg)) == Status.I2C_SUCCESS)
            {
                int j = 0;
                if (reg[0] < 64)
                {
                    for (var i = reg[0]; i <= ((reg[0] + oReg.NumDataBytes > 63) ? 63 : reg[0] + oReg.NumDataBytes - 1); i++)
                    {
                        oReg.RegRdBuffer[i] = data[j];
                        j++;
                    }
                }
            }
            return status;
            
        }


        /// <summary>
        ///Check if I2C write was really succesful or a NACK occurred, since this is independent of USB success
        ///This function also reads all the data from the report. If NACK occured, the data is invalid.
        /// </summary>
        /// <param name="rHandle"></param>
        /// <param name="report_size"></param>
        /// <param name="IOBuf"></param>
        /// <param name="eventObj"></param>
        /// <param name="data"></param>
        /// <param name="HIDOverlapped"></param>
        /// <returns></returns>
        public Int16 CheckNACK(IntPtr rHandle, uint report_size, byte[] IOBuf, IntPtr eventObj, OVERLAPPED HIDOverlapped)
        {
            Int16 tempcheckNACK = 0;
            uint bytesSucceed = 0;
            api_status = CommonPInvoke.ReadFile(rHandle, IOBuf, report_size, out bytesSucceed, ref HIDOverlapped);
            api_status = CommonPInvoke.WaitForSingleObject(eventObj, 6000);
            CommonPInvoke.ResetEvent(eventObj);
            // cannot check for api_status = API_FAIL since we're using overlapped IO
            if (api_status != Status.Wait_Object_0)
            {
                api_status = CommonPInvoke.CancelIo(rHandle);
                GlobalVariables.Global_API_Status = api_status;
                return Status.USB_Read_Error;
            }

            if (IOBuf[1] != 0) //NACK occurred
            {
                tempcheckNACK = Status.I2C_Nack_Error; //USB write success, but I2C transaction failed due to bad I2C address
            }
            else
            {
                tempcheckNACK = Status.I2C_SUCCESS;
            }

            GlobalVariables.Global_I2C_NAK_Status = tempcheckNACK;
            GlobalVariables.Global_API_Status = (Int16)api_status;
            
            return tempcheckNACK;
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="oReg">HIDRegRead type</param>
        /// <param name="data"></param>
        /// <param name="reg"></param>
        /// <returns></returns>
        public Int16 ReadI2C(HIDRegRead oReg, List<byte> data, List<byte> reg)
        {

            uint bytesSucceed = 0;
            Int16 result = Status.I2C_SUCCESS;
            HIDDevInfo.IOBuf[1] = 6; //I2C transaction
            HIDDevInfo.IOBuf[2] = (byte)(oReg.I2CSlaveAddress + 1); //set read bit
            HIDDevInfo.IOBuf[3] = oReg.NumDataBytes;// numDataBytes;
            HIDDevInfo.IOBuf[4] = oReg.NumRegBytes;
            if (oReg.NumRegBytes > 0)
            {
                for (int i = 0; i <= Convert.ToByte(oReg.NumRegBytes) - 1; i++) //if stop index is less than start index, VB6 errors, so we need to use a flag
                {
                    HIDDevInfo.IOBuf[i + 5] = reg[i];
                }
            }
            try
            {
                api_status = CommonPInvoke.WriteFile(HIDDevInfo.HIDWriteHandleArr[0], HIDDevInfo.IOBuf, HIDDevInfo.Report_Size, out bytesSucceed, IntPtr.Zero);

                if (api_status == Status.API_Fail)
                {
                    result = Status.USB_WRITE_ERROR;
                    GlobalVariables.Global_API_Status = result;
                    return result;
                }
                result = CheckNACK(HIDDevInfo.HIDReadHandleArr[0], HIDDevInfo.Report_Size, HIDDevInfo.IOBuf, oReg.EventPtr, oReg.HidOverlapped);
                if (result == Status.I2C_SUCCESS)
                {
                    for (int i = 0; i <= oReg.NumDataBytes - 1; i++)
                    {
                        data.Add(HIDDevInfo.IOBuf[i + 2]);
                        int a = Convert.ToInt32(reg[0]);
                        GlobalVariables.WriteRegs[a] = (byte)data[1];
                    }
                }
                return result;
            }
            catch (StackOverflowException ex)
            {
                throw new Exception(ex.Message);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            
        }


        public void CheckI2Cstatus(int status, bool ignoreNACK)
        {
            string msg = null;

            if ((status == Status.USB_WRITE_ERROR) || (status == Status.USB_Read_Error)) //USB error; this section must come before I2C_NACK_ERROR section
            {
                if (status == Status.USB_WRITE_ERROR)
                {
                    msg = "WriteFile";
                }
                else
                {
                    msg = "ReadFile";
                }
                //msgBoxVal = MsgBox("Please check USB connection." + Environment.NewLine + "USB " + msg + " error.", Microsoft.VisualBasic.Constants.vbRetryCancel,, msgBoxTitle); //Grist
            }
            else if (status == Status.I2C_Nack_Error) //NACK error
            {
                if (ignoreNACK == false) //don't ignore NACK error (ignore when scanning I2C address); USB success
                {
                    //msgBoxVal = MessageBox.Show("Invalid I2C address. Press Retry to return to GUI and enter valid address or Cancel to close GUI.", string.Empty, MessageBoxButtons.RetryCancel);
                    //if (msgBoxVal == DialogResult.Cancel)
                    //{
                    //    Unload frmMain;
                    //}
                }
            }
        }

        /// <summary>
        /// Write the byte array to the file
        /// Byte array values represent the different command.
        /// E.g : Command for adc convertor change
        /// </summary>
        /// <param name="oReg">This object provides the values to be copied into  the byte array</param>
        /// <param name="data">byte arrray</param>
        /// <param name="reg">byte arrray</param>
        /// <returns>return a integer code value </returns>
        internal Int16 WriteI2C(HIDRegRead oReg, List<byte> data, List<byte> reg)
        {

            uint bytesSucceed = 0;
            Int16 result = 0;
            HIDDevInfo.IOBuf[1] = 6; //For I2C transaction
            HIDDevInfo.IOBuf[2] = oReg.I2CSlaveAddress; //set read bit
            HIDDevInfo.IOBuf[3] = oReg.NumDataBytes;// numDataBytes;
            HIDDevInfo.IOBuf[4] = oReg.NumRegBytes;
            if (oReg.NumRegBytes > 0)
            {
                for (int i = 0; i <= oReg.NumRegBytes - 1; i++)
                {
                    HIDDevInfo.IOBuf[i + 5] = reg[i];
                }
            }

            for (int i = 0; i <= oReg.NumDataBytes - 1; i++)
            {
                HIDDevInfo.IOBuf[i + 5 + oReg.NumDataBytes] = data[i];
            }
            api_status = CommonPInvoke.WriteFile(HIDDevInfo.HIDWriteHandleArr[0], HIDDevInfo.IOBuf, HIDDevInfo.Report_Size, out bytesSucceed, IntPtr.Zero);

            if (api_status == Status.API_Fail)
            {
                result = Status.USB_WRITE_ERROR;
                return result;
            }
            result = CheckNACK(HIDDevInfo.HIDReadHandleArr[0], HIDDevInfo.Report_Size, HIDDevInfo.IOBuf, oReg.EventPtr, oReg.HidOverlapped);
            return result;
        }

        private Int16 ReadI2Cvalidate(HIDRegRead oReg, List<byte> data, List<byte> reg)
        {
            Int16 result = 0;
            result = ReadI2C(oReg, data, reg);
            //CheckI2Cstatus(api_status, false);
            //if ((result == Status.USB_Read_Error) | (result == Status.USB_WRITE_ERROR))
            //{
            //    // repeat the read because the USB handle was not valid, 
            //    //and now it is (otherwise we would still be in checkI2Cstatus), but there may still be an I2C address error
            //    result = ReadI2Cvalidate(oReg, data, reg);
            //}
            return result;
        }


      


    }


}
