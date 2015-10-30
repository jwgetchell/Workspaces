namespace Ax_islTofRegDrv
{
    unsafe public partial interface Iio
    {
        void setDrvApi(int fpApi);
        void readField(int a, byte s, byte m, byte* d);
        void writeField(int a, byte s, byte m, byte d);
        void readByte(int a, byte* d);
        void writeByte(int a, byte d);
        void readWord(int a, int* d);
        void writeWord(int a, int d);
    }
}
