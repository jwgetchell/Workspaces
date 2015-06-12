using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Runtime.InteropServices;

namespace Ax_islTofRegDrv
{
    [InterfaceType(ComInterfaceType.InterfaceIsDual), Guid("A0847C7C-CD90-444C-83FE-E19712280064")]
    //[ Guid("A0847C7C-CD90-444C-83FE-E19712280064")]//
    unsafe public interface IAx_islTofRegDrv
    {
        void setDrvApi(int fpApi);
        void readField(int a, byte s, byte m, byte* d);
    }
}
