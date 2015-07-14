using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.IO.Ports; // serial port
using System.Runtime.InteropServices;// COM

namespace Ax_vbaComm
{
    [ClassInterface(ClassInterfaceType.AutoDual), Guid("4B0048F9-F152-4361-B61E-B7117F695EF6"), ProgId("Ax_vbaComm.vbaComm"), ComVisible(true)]

    public class vbaComm : IvbaComm 
    {
        SerialPort serialPort=null;
        LuxMeter _LM=null;

        public vbaComm()
        {
            serialPort = new SerialPort();
        }
        ~vbaComm()
        {
            Close();
        }
        public void Open(int comN
                        ,int baudRate
                        ,int parity
                        ,int dataBits
                        ,double stopBits
                        ,string newLine
                        )
        {
            if (serialPort == null)
                serialPort = new SerialPort();

            serialPort.Close();

            serialPort.PortName = "COM" + comN.ToString();
            serialPort.BaudRate = baudRate;

            switch (parity)
            {
                case 1: serialPort.Parity = Parity.Even; break;
                case -1: serialPort.Parity = Parity.Odd; break;
                case 0:
                default: serialPort.Parity = Parity.None; break;
            }

            serialPort.DataBits=dataBits;

            switch ((int)stopBits*2)
            {
                case 4: serialPort.StopBits =  StopBits.Two;          break;
                case 3: serialPort.StopBits =  StopBits.OnePointFive; break;
                case 2: serialPort.StopBits =  StopBits.One;          break;
                case 0:
                default: serialPort.StopBits = StopBits.None;         break;
            }

            serialPort.NewLine = newLine;

            serialPort.ReadTimeout  = 500;
            serialPort.WriteTimeout = 500;

            serialPort.Open(); 
        }
        public void Close()
        {
            if (serialPort != null)
            {
                serialPort.Close();
                serialPort.Dispose();
                serialPort = null;
            }
        }
        public void WriteLine(string command)
        {
            serialPort.WriteLine(command);
        }
        public string ReadLine()
        {
            return serialPort.ReadLine();
        }
        public string ReadExisting()
        {
            return serialPort.ReadExisting();
        }

        // Lux Meter Interface
        public ILuxMeter LM
        {
            get
            {
                if (_LM == null)
                    _LM = new LuxMeter(this);
                return _LM;
            }
        }
    }
}

class test
{
    void junk()
    {
        double value;
        Ax_vbaComm.vbaComm KM = new Ax_vbaComm.vbaComm();
        KM.LM.Open(4);
        value=KM.LM.read();
    }
}