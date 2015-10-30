namespace Ax_islTofRegDrv
{
    unsafe public partial class CanalogControl : IanalogControl
    {
        public double getIRDR() { double irdr; dll.getIRDR(&irdr); return irdr; }
        public void setIRDR(double irdr) { dll.setIRDR(irdr); }
        public int getAFEgain() { int gain; dll.getAFEgain(&gain); return gain; }
        public void setAFEgain(int gain) { dll.setAFEgain(gain); }
    }

}