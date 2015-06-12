using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace IntersilLib
{
    class CustomEx : Exception
    {
        public Int16 DeviceNotConn()
        {
            return Status.USB_Disconnec;
        }

        public override string Message
        {
            get
            {
                return "Device is not connected";
            }
        }
    }

    class CustomEx2 : Exception
    {
        public Int16 DeviceNotConn()
        {
            return Status.USB_Disconnec;
        }

        
        public override string Message
        {
            get
            {
                return "Device is not connected";
            }
        }
    }


}
