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

    unsafe class dll
    {
        const string tofDll = @"islTofRegDrv.dll";

        [DllImport(tofDll)]
        public static extern void cSetDrvApi(int fpApi);
        [DllImport(tofDll)]
        public static extern void cReadField(int a, byte s, byte m, byte* d);

        //analogControlRegisters
        [DllImport(tofDll)]
        public static extern void getIRDR(double* irdr);
        [DllImport(tofDll)]
        public static extern void setIRDR(double irdr);
        [DllImport(tofDll)]
        public static extern void getAFEgain(int* irdr);
        [DllImport(tofDll)]
        public static extern void setAFEgain(int irdr);

        //openLoopCorrectionRegisters
        [DllImport(tofDll)]
        public static extern void getPhaseOffsetAmbientCoef(double* c1, double* c2);
        [DllImport(tofDll)]
        public static extern void setPhaseOffsetAmbientCoef(double c1, double c2);
        [DllImport(tofDll)]
        public static extern void getPhaseOffsetVGAcoef(int vga, double* c1, double* c2);
        [DllImport(tofDll)]
        public static extern void setPhaseOffsetVGAcoef(int vga, double c1, double c2);
    }

    unsafe public class CanalogControlRegisters : IanalogControlRegisters
    {
        public double getIRDR() { double irdr; dll.getIRDR(&irdr); return irdr; }
        public void setIRDR(double irdr) { dll.setIRDR(irdr); }
        public int getAFEgain() { int gain; dll.getAFEgain(&gain); return gain; }
        public void setAFEgain(int gain) { dll.setAFEgain(gain); }
    }

    unsafe public class CopenLoopCorrectionRegisters : IopenLoopCorrectionRegisters
    {
        public void getPhaseOffsetAmbientCoef(double* c1, double* c2) { dll.getPhaseOffsetAmbientCoef(c1, c2); }
        public void setPhaseOffsetAmbientCoef(double c1, double c2) { dll.setPhaseOffsetAmbientCoef(c1, c2); }
        public void getPhaseOffsetVGAcoef(int vga, double* c1, double* c2) { dll.getPhaseOffsetVGAcoef(vga, c1, c2); }
        public void setPhaseOffsetVGAcoef(int vga, double c1, double c2) { dll.setPhaseOffsetVGAcoef(vga, c1, c2); }
    }

    unsafe public class islTofRegDrv : IAx_islTofRegDrv
    {
        private readonly IanalogControlRegisters      _analogControlRegisters;
        private readonly IopenLoopCorrectionRegisters _openLoopCorrectionRegisters;

        public islTofRegDrv()
        {
            _analogControlRegisters      = new CanalogControlRegisters();
            _openLoopCorrectionRegisters = new CopenLoopCorrectionRegisters();
        }

        public IanalogControlRegisters analogControlRegisters
        {
            get { return _analogControlRegisters; }
        }

        public IopenLoopCorrectionRegisters openLoopCorrectionRegisters
        {
            get { return _openLoopCorrectionRegisters; }
        }

        public void setDrvApi(int fpApi) { dll.cSetDrvApi(fpApi); }
        public void readField(int a, byte s, byte m, byte* d) { dll.cReadField(a, s, m, d); }

    }

}

unsafe class junk
{
    junk()
    {
        double c1,c2;
        Ax_islTofRegDrv.islTofRegDrv tof;
        tof = new Ax_islTofRegDrv.islTofRegDrv();
        tof.openLoopCorrectionRegisters.getPhaseOffsetAmbientCoef(&c1, &c2);
        tof.analogControlRegisters.setAFEgain(5);
    }
}