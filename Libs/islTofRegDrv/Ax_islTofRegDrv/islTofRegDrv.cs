using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Permissions;
using System.Threading.Tasks;

using System.Runtime.InteropServices;


namespace Ax_islTofRegDrv
{
    [ClassInterface(ClassInterfaceType.AutoDual), Guid("DBEFB787-EBF6-49AB-B875-CD199297C46B"), ProgId("Ax_islTofRegDrv.islTofRegDrv")]
    //[Guid("DBEFB787-EBF6-49AB-B875-CD199297C46B"),ClassInterface(ClassInterfaceType.None)]

    unsafe public class islTofRegDrv : IAx_islTofRegDrv
    {
        const string tofDll = @"islTofRegDrv.dll";

        [DllImport(tofDll)] public static extern void cSetDrvApi(int fpApi);
        public void setDrvApi(int fpApi) { cSetDrvApi(fpApi); }

        [DllImport(tofDll)] public static extern void cReadField(int a, byte s, byte m, byte* d);
        public void readField(int a, byte s, byte m, byte* d) { cReadField(a, s, m, d); }

    }
}
