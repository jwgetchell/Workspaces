using System.Runtime.InteropServices;

namespace Ax_islTofRegDrv
{
    [ClassInterface(ClassInterfaceType.AutoDual)
    , Guid("DBEFB787-EBF6-49AB-B875-CD199297C46B")
    , ProgId("Ax_islTofRegDrv.islTofRegDrv")]

    unsafe partial class dll
    {
        const string tofDll = @"islTofRegDrv.dll";

        [DllImport(tofDll)]
        public static extern void cSetDrvApi(int fpApi);
        [DllImport(tofDll)]
        public static extern void cReadField(int a, byte s, byte m, byte* d);
        [DllImport(tofDll)]
        public static extern void cWriteField(int a, byte s, byte m, byte d);
        [DllImport(tofDll)]
        public static extern void cReadByte(int a, byte* d);
        [DllImport(tofDll)]
        public static extern void cWriteByte(int a, byte d);
        [DllImport(tofDll)]
        public static extern void cReadWord(int a, int* d);
        [DllImport(tofDll)]
        public static extern void cWriteWord(int a, int d);
    }

    unsafe public class islTofRegDrv : IAx_islTofRegDrv
    {
        private readonly Iprim _prim;
        private readonly Iio _io;
        private readonly Iui _ui;

        public islTofRegDrv()
        {
            _io =   new Cio();
            _prim = new Cprim(_io);
            _ui =   new Cui(_prim);
        }

        public Iprim prim { get { return _prim; } }
        public Iio   io   { get { return _io;   } }
        public Iui   UI   { get { return _ui; } }
    }

}

unsafe class junk
{
    junk()
    {
        double c1,c2;
        Ax_islTofRegDrv.islTofRegDrv tof;
        tof = new Ax_islTofRegDrv.islTofRegDrv();
        tof.prim.openLoopCorrection.getPhaseOffsetAmbientCoef(&c1, &c2);
        tof.prim.analogControl.setAFEgain(5);

        int ambientAdc=tof.prim.lightSampleStatus.getAmbient();

    }
}