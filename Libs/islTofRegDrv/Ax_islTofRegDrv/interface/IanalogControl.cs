namespace Ax_islTofRegDrv
{
    unsafe public partial interface IanalogControl
    {
        double getIRDR();
        void setIRDR(double irdr);
        int getAFEgain();
        void setAFEgain(int gain);
    }

}