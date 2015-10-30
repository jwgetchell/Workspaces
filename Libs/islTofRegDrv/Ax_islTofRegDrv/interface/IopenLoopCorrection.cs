namespace Ax_islTofRegDrv
{
    unsafe public partial interface IopenLoopCorrection
    {
        void getPhaseOffsetAmbientCoef(double* c1, double* c2);
        void setPhaseOffsetAmbientCoef(double c1, double c2);
        void getPhaseOffsetVGAcoef(int vga, double* c1, double* c2);
        void setPhaseOffsetVGAcoef(int vga, double c1, double c2);
    }
}
