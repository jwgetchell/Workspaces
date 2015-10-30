namespace Ax_islTofRegDrv
{
    unsafe public partial class CopenLoopCorrection : IopenLoopCorrection
    {
        public void getPhaseOffsetAmbientCoef(double* c1, double* c2) { dll.getPhaseOffsetAmbientCoef(c1, c2); }
        public void setPhaseOffsetAmbientCoef(double c1, double c2) { dll.setPhaseOffsetAmbientCoef(c1, c2); }
        public void getPhaseOffsetVGAcoef(int vga, double* c1, double* c2) { dll.getPhaseOffsetVGAcoef(vga, c1, c2); }
        public void setPhaseOffsetVGAcoef(int vga, double c1, double c2) { dll.setPhaseOffsetVGAcoef(vga, c1, c2); }
    }
}
