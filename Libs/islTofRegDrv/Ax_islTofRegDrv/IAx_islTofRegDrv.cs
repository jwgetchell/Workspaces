using System.Runtime.InteropServices;

namespace Ax_islTofRegDrv
{
    [InterfaceType(ComInterfaceType.InterfaceIsDual)
    , Guid("A0847C7C-CD90-444C-83FE-E19712280064")]

    unsafe public interface IAx_islTofRegDrv
    {
        Iio   io   { get; } // IO
        Iprim prim { get; } // primatives
        Iui   UI   { get; } // User Interface
    }

}
