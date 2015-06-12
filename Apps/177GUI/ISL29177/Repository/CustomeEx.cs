using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Inersil_WPFV2.Repository
{
    class NoDataAvailEx:Exception
    {
        public override string Message
        {
            get
            {
                return "Data is not Available";
            }
        }
    }

    class InSuffiDataEx : Exception
    {
        public override string Message
        {
            get
            {
                return "Collect more data";
            }
        }
    }
}
