using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.VisualBasic;

using System.IO.Ports; // serial port
using System.Runtime.InteropServices;// FieldOffset

//#pragma warning disable 649
unsafe internal struct LMShortCommand
{
    public byte STX;
    public fixed byte Receptor[2];
    public fixed byte Command[2];
    public fixed byte DATA4[4];
    public byte ETX;
    public fixed byte BCC[2];
    public byte CR;
    public byte LF;
    public byte NULL;
    public byte* sCmd;
}
//#pragma warning restore 649

namespace Ax_vbaComm
{
    public class LuxMeter : ILuxMeter 
    {
        vbaComm serialPort = null;

        public LuxMeter(vbaComm serialPortIn)
        {
            serialPort = serialPortIn;
        }

        public void Open(int port)
        {
            serialPort.Open(port, 9600, 1, 7, 1, '\r'.ToString());
            InitLuxMeter();
            EnableLuxMeter();
        }
        public double read()
        {
            string sBuf;
            double ret;

            GetLux();
            Thread.Sleep(200);
            
            sBuf = serialPort.ReadExisting();
            if (sBuf.Length >= 16)
            {
                sBuf = sBuf.Substring(sBuf.IndexOf("+"), 6);// zero based
                ret = Convert.ToDouble(sBuf.Substring(1, 4));// Mantissa
                ret *= Math.Pow(10, Convert.ToDouble(sBuf.Substring(5, 1)) - 4);// Exponent
            }
            else
                ret = 0;

            return ret;
        }

        // wierd stuff...
        unsafe internal string calcBCC(LMShortCommand command)
        {
            int bcc = command.Receptor[0] ^ command.Receptor[1];
            bcc ^= command.Command[0] ^ command.Command[1];
            bcc ^= command.DATA4[0] ^ command.DATA4[1] ^ command.DATA4[2] ^ command.DATA4[3];
            bcc ^= command.ETX;

            // convert 
            string sBCC = bcc.ToString("X2");
            byte[] bArr = Encoding.ASCII.GetBytes(sBCC);
            command.BCC[0] = bArr[0]; command.BCC[1] = bArr[1];
            //Marshal.Copy((IntPtr)command.BCC, bArr, 0, 2);

            // create string from struct (much easier in C/C++)
            byte[] arr = new byte[sizeof(LMShortCommand)];
            Marshal.Copy((IntPtr)command.sCmd, arr, 0, sizeof(LMShortCommand));
            string sBuf = Encoding.UTF8.GetString(arr);                     

            return sBuf;
        }
        unsafe internal void InitLuxMeter()
        {
            LMShortCommand command;
            command.STX         = 0x02;
            command.Receptor[0] = 0x30;
            command.Receptor[1] = 0x30;
            command.Command[0] = 0x35;
            command.Command[1] = 0x34;
            command.DATA4[0] = 0x31;
            command.DATA4[1] = 0x20;
            command.DATA4[2] = 0x20;
            command.DATA4[3] = 0x20;
            command.ETX = 0x03;
            command.CR = 0x0d;
            command.LF = 0x0a;
            command.BCC[0] = (byte)'1';
            command.BCC[1] = (byte)'3';
            command.NULL = 0x00;
            command.sCmd = &command.STX;
            serialPort.WriteLine(calcBCC(command));
        }
        unsafe internal void EnableLuxMeter()
        {
            LMShortCommand command;
            command.STX = 0x02;
            command.Receptor[0] = 0x39;
            command.Receptor[1] = 0x39;
            command.Command[0]  = 0x35;
            command.Command[1]  = 0x35;
            command.DATA4[0]    = 0x30;
            command.DATA4[1]    = 0x20;
            command.DATA4[2]    = 0x20;
            command.DATA4[3]    = 0x30;
            command.ETX         = 0x03;
            command.CR          = 0x0d;
            command.LF          = 0x0a;
            command.BCC[0] = (byte)'0';
            command.BCC[1] = (byte)'3';
            command.NULL = 0x00;
            command.sCmd = &command.STX;
            serialPort.WriteLine(calcBCC(command));
        }
        unsafe internal void GetLux()
        {
            LMShortCommand command;
            command.STX = 0x02;
            command.Receptor[0] = 0x30;
            command.Receptor[1] = 0x30;
            command.Command[0]  = 0x31;
            command.Command[1]  = 0x30;
            command.DATA4[0]    = 0x30;
            command.DATA4[1]    = 0x32;
            command.DATA4[2]    = 0x30;
            command.DATA4[3]    = 0x30;
            command.ETX         = 0x03;
            command.CR          = 0x0d;
            command.LF          = 0x0a;
            command.BCC[0] = (byte)'0';
            command.BCC[1] = (byte)'0';
            command.NULL = 0x00;
            command.sCmd = &command.STX;
            serialPort.WriteLine(calcBCC(command));
        }
    }
}
