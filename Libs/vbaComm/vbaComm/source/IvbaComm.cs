using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.IO.Ports; // serial port
using System.Runtime.InteropServices;// COM

namespace Ax_vbaComm
{
    [InterfaceType(ComInterfaceType.InterfaceIsDual), Guid("147A2633-A4FA-4AF6-B111-5CC1D44669A9")]

    public interface ILuxMeter
    {
        void Open(int port);
        double read();
    }

    public interface IvbaComm
    {
        void Open(int comN
                 ,int baudRate
                 ,int parity
                 ,int dataBits
                 ,double stopBits
                 ,string newLine
                 );
        void Close();
        void WriteLine(string command);
        string ReadLine();
        string ReadExisting();

        ILuxMeter LM { get; }
    }
}
