using System.Runtime.InteropServices;

namespace Ax_islTofRegDrv
{
    unsafe partial class dll
    {
        //analogControl
        [DllImport(tofDll)]
        public static extern void getIRDR(double* irdr);
        [DllImport(tofDll)]
        public static extern void setIRDR(double irdr);
        [DllImport(tofDll)]
        public static extern void getAFEgain(int* irdr);
        [DllImport(tofDll)]
        public static extern void setAFEgain(int irdr);

        //openLoopCorrection
        [DllImport(tofDll)]
        public static extern void getPhaseOffsetAmbientCoef(double* c1, double* c2);
        [DllImport(tofDll)]
        public static extern void setPhaseOffsetAmbientCoef(double c1, double c2);
        [DllImport(tofDll)]
        public static extern void getPhaseOffsetVGAcoef(int vga, double* c1, double* c2);
        [DllImport(tofDll)]
        public static extern void setPhaseOffsetVGAcoef(int vga, double c1, double c2);

        //lightSampleStatus
        [DllImport(tofDll)]
        public static extern void getDistance(double* c1);
    }
}