namespace Ax_islTofRegDrv
{
    unsafe public partial class CcalibrationStatus : IcalibrationStatus
    {
        private Cio io;

        public CcalibrationStatus(Iio _io)
        {
            io = (Cio)_io;
        }
        public int getZp_mag_exp()
        {
            byte d=0;
            io.readByte(0xF6, &d);
            return d;
        }
        public int getZp_mag()
        {
            int d = 0;
            io.readWord(0xF7, &d);
            return d;
        }
    }
}
